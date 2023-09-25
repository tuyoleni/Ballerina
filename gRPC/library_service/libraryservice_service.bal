import ballerina/grpc;

listener grpc:Listener ep = new (9090);

@grpc:Descriptor {value: LIBRARY_DESC}
service "LibraryService" on ep {

    remote function AddBook(AddBookRequest value) returns AddBookResponse|error {
    }
    remote function UpdateBook(UpdateBookRequest value) returns UpdateBookResponse|error {
    }
    remote function RemoveBook(RemoveBookRequest value) returns RemoveBookResponse|error {
    }
    remote function ListAvailableBooks(ListAvailableBooksRequest value) returns ListAvailableBooksResponse|error {
    }
    remote function LocateBook(LocateBookRequest value) returns LocateBookResponse|error {
    }
    remote function BorrowBook(BorrowBookRequest value) returns BorrowBookResponse|error {
    }
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

