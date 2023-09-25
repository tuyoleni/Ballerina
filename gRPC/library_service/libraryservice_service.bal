import ballerina/grpc;
import ballerinax/mysql;
import ballerinax/mysql.driver as _;
import ballerina/sql;
import ballerina/io;

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
    }
    remote function LocateBook(LocateBookRequest value) returns LocateBookResponse|error {
    }
    remote function BorrowBook(BorrowBookRequest value) returns BorrowBookResponse|error {
    }
    //create users (Linda)

    remote function CreateUsers(stream<CreateUsersRequest, grpc:Error?> clientStream) returns CreateUsersResponse|error {
    }
}

