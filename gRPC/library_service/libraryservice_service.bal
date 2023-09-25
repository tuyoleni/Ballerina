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
         _ = check libraryClient->execute(`INSERT INTO Books(ISBN, Title, Author, Location, Status)
             VALUES (${value.book.isbn}, ${value.book.title}, ${value.book.author}, ${value.book.location}, ${value.book.status})`);
            return {isbn: value.book.isbn};
    }
    remote function UpdateBook(UpdateBookRequest value) returns UpdateBookResponse|error {
        // string[] keys = [];
        // string[] values = [];

        var data = {
            ISBN: value.book.isbn,
            Title: value.book.title,
            Author: value.book.author,
            Location: value.book.location,
            Status: value.book.status
        };

        // foreach var item in data {
        //     if (item != "") {
        //         keys.push(data.keys().toString());
        //         values.push(item);
        //     }
        // }
        // foreach var key in keys {
        //     int index = keys.indexOf(key) ?: 0;
        //     if (index >= 0 && index < values.length()) {
        //         string datum = values[index].trim();
        //         _ = check libraryClient->execute(`UPDATE Books SET ${key.trim()} = '${datum}' WHERE ISBN='${data.ISBN}'`);
        //     }
        // }

        _ = check libraryClient->execute(`UPDATE Books SET Title =  ${data.Title}, Author = ${data.Author}, Location = ${data.Location}, Status = ${data.Status} WHERE ISBN=${data.ISBN}`);
        UpdateBookResponse response = {
            updatedBook: value
        };

        return response;
    }
    //remote function RemoveBook(RemoveBookRequest value) returns RemoveBookResponse|error {
    // }
    //remote function ListAvailableBooks(ListAvailableBooksRequest value) returns ListAvailableBooksResponse|error {
    //}
    remote function LocateBook(LocateBookRequest value) returns LocateBookResponse|error {
        LocateBookResponse response = {};
        // while true {
        //     var data = check libraryClient->execute(`SELECT Location, Status FROM Books WHERE ISBN = ${value.isbn}`);

        //     response = {
        //         location: ,
        //         available:
        //     };

        stream<Book, sql:Error?> bookStream = libraryClient->query(`SELECT Location, Status FROM Books WHERE ISBN = ${value.isbn}`);
        check from Book book in bookStream
            do {
                if (book.status == "Available") {
                    response = {
                        location: book.location,
                        available: true
                    };
                }
                if (book.status != "Available") {

                    response = {
                        location: book.location,
                        available: false
                    };
                }
                io:println(book.status);
            };
        return response;
    }
    //remote function BorrowBook(BorrowBookRequest value) returns BorrowBookResponse|error {
    //}
    //remote function CreateUsers(stream<CreateUsersRequest, grpc:Error?> clientStream) returns CreateUsersResponse|error {
    //}
}

