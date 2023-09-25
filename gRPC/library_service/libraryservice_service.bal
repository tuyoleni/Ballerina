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
    //Adding a book
    remote function AddBook(AddBookRequest value) returns AddBookResponse|error {
<<<<<<< HEAD
        _ = check libraryClient->execute(`INSERT INTO Books(ISBN, Title, Author, Location, Status)
             VALUES (${value.book.isbn}, ${value.book.title}, ${value.book.author}, ${value.book.location}, ${value.book.status})`);
=======
        error? addBook = BookTable.add(value.book);

        if (addBook is error) {
            return "Could not add Book: " + value.book.isbn;
        }
>>>>>>> 67b86cc13e1ed1b8fed1d0b4627fc5efc77de5c4
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

<<<<<<< HEAD
    //Listing all the books available
=======
>>>>>>> 67b86cc13e1ed1b8fed1d0b4627fc5efc77de5c4
    remote function ListAvailableBooks(ListAvailableBooksRequest value) returns ListAvailableBooksResponse|error {
        ListAvailableBooksResponse response = {};
        Book[] availableBooks = [];
        stream<Book, sql:Error?> bookStream = libraryClient->query(`SELECT * FROM Books`);
        check from Book books in bookStream
            do {
                availableBooks.push(books);
                response = {
                    availableBooks: availableBooks
                };
            };

        return response;
    }
<<<<<<< HEAD
=======

>>>>>>> 67b86cc13e1ed1b8fed1d0b4627fc5efc77de5c4
    remote function LocateBook(LocateBookRequest value) returns LocateBookResponse|error {
    }

    //Borrow Book request(Simeon)
    remote function BorrowBook(BorrowBookRequest value) returns BorrowBookResponse|error {
        _ = check libraryClient->execute(`INSERT INTO Borrowed_Books (UserID, ISBN) VALUES (${value.userId}, ${value.isbn})`);
        _ = check libraryClient->execute(`UPDATE Books SET Status = 'CheckedOut' WHERE ISBN = ${value.isbn}`);
        BorrowBookResponse response = {
            borrowedBook: value
        };
        return response;
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








    