import ballerina/grpc;

listener grpc:Listener ep = new (9090);

@grpc:Descriptor {value: LIBRARY_DESC}
service "LibraryService" on ep {
    //Adding a book
    remote function AddBook(AddBookRequest value) returns AddBookResponse|error {
        _ = check libraryClient->execute(`INSERT INTO Books(ISBN, Title, Author, Location, Status)
             VALUES (${value.book.isbn}, ${value.book.title}, ${value.book.author}, ${value.book.location}, ${value.book.status})`);
        return {isbn: value.book.isbn};
    }

    remote function UpdateBook(UpdateBookRequest value) returns UpdateBookResponse|error {
    }
    remote function RemoveBook(RemoveBookRequest value) returns RemoveBookResponse|error {
    }

    //Listing all the books available
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
    remote function LocateBook(LocateBookRequest value) returns LocateBookResponse|error {
    }
    remote function BorrowBook(BorrowBookRequest value) returns BorrowBookResponse|error {
    }
    remote function CreateUsers(stream<CreateUsersRequest, grpc:Error?> clientStream) returns CreateUsersResponse|error {
    }
}








    