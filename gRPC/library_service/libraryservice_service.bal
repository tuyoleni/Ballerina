import ballerina/grpc;
import ballerinax/mysql;
import ballerinax/mysql.driver as _;
import ballerina/sql;
import ballerina/io;

final mysql:Client libraryClient = check new (
    host = "first-instance.cg4vktva35w7.eu-north-1.rds.amazonaws.com",
    user = "learning", password = "learning-db",
    port = 3306,
    database = "library"
);

listener grpc:Listener ep = new (9090);

@grpc:Descriptor {value: LIBRARY_DESC}
service "LibraryService" on ep {

    remote function AddBook(AddBookRequest value) returns AddBookResponse|error {
        error? addBook = BookTable.add(value.book);

        if (addBook is error) {
            return "Could not add Book: " + value.book.isbn;
        }
        return {isbn: value.book.isbn};
    }

    remote function UpdateBook(UpdateBookRequest value) returns UpdateBookResponse|error {
    }

    //Remove Books(Linda)
    remote function RemoveBook(RemoveBookRequest value) returns RemoveBookResponse|error {

        _ = check libraryClient->execute(`DELETE FROM Books WHERE ISBN = ${value.isbn}`);

        RemoveBookResponse response = {};
        Book[] updatedBooks = [];
        stream<Book, sql:Error?> bookStream = libraryClient->query(`SELECT * FROM Books`);
        check from Book books in bookStream
            do {
                updatedBooks.push(books);
                response = {
                    updatedBooks: updatedBooks
                };
            };

        return response;
    }

    remote function ListAvailableBooks(ListAvailableBooksRequest value) returns ListAvailableBooksResponse|error {
        table<Book> book = from var books in BookTable
            where books.status === "Available"
            select books;
        table<Book> results = book;
        ListAvailableBooksResponse response = {
            availableBooks: results.toArray()
        };
        return response;
    }

    remote function LocateBook(LocateBookRequest value) returns LocateBookResponse|error {
    }

    remote function BorrowBook(BorrowBookRequest value) returns BorrowBookResponse|error {
    }

    //create users (Linda)

    remote function CreateUsers(stream<CreateUsersRequest, grpc:Error?> clientStream) returns CreateUsersResponse|error {
        CreateUsersRequest[] data = [];
        CreateUsersResponse response = {};
        check clientStream.forEach(function(CreateUsersRequest value) {
            data.push(value);
            foreach CreateUsersRequest item in data {
                foreach var d in item.users {
                    var result = libraryClient->execute(`INSERT INTO Users (UserID, Name, UserType, Contact) VALUES (${d.userId}, ${d.name}, ${d.userType}, ${d.contact})`);
                    if (result is error) {
                        io:println("Error inserting user");
                    }
                }
            }
            response = {
                users: value
            };
        });
        return response;
    }
}

