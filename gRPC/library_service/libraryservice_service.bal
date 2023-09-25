import ballerina/grpc;

listener grpc:Listener ep = new (9090);

@grpc:Descriptor {value: LIBRARY_DESC}
service "LibraryService" on ep {

    remote function AddBook(AddBookRequest value) returns AddBookResponse|error {
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

