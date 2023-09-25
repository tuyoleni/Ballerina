import ballerina/io;
import ballerina/lang.'int;

LibraryServiceClient ep = check new ("http://localhost:9090");

public function main() returns error? {
    io:println("1. Add Book");
    io:println("2. Update Book");
    io:println("3. Delete Book");
    io:println("4. List Available Book");
    io:println("5. Locate Book");
    io:println("6. Borrow Book");
    io:println("7. Create User");
    io:println("8. Quit");
    string choice = io:readln("Enter choice: ");

    while (choice !== "8") {

        if (choice == "1") {
            string isbn = io:readln("Enter ISBN: ");
            string title = io:readln("Enter Book Title: ");
            string author = io:readln("Enter Author: ");
            string location = io:readln("Enter Location");
            string status = io:readln("Enter book status: ");
            AddBookRequest addBookRequest = {book: {isbn: isbn, title: title, author: author, location: location, status: <Book_Status>status}};
            AddBookResponse addBookResponse = check ep->AddBook(addBookRequest);
            io:println(addBookResponse);
        }

        else if (choice == "2") {
            string isbn = io:readln("Enter ISBN: ");
            string title = io:readln("Enter Book Title: ");
            string author = io:readln("Enter Author: ");
            string location = io:readln("Enter Location");
            string status = io:readln("Enter book status: ");
            UpdateBookRequest updateBookRequest = {isbn: isbn, book: {isbn: isbn, title: title, author: author, location: location, status: <Book_Status>status}};
            UpdateBookResponse updateBookResponse = check ep->UpdateBook(updateBookRequest);
            io:println(updateBookResponse);
        }

        else if (choice == "3") {
            string isbn = io:readln("Enter ISBN: ");
            RemoveBookRequest removeBookRequest = {isbn: isbn};
            RemoveBookResponse removeBookResponse = check ep->RemoveBook(removeBookRequest);
            io:println(removeBookResponse);
        }

        else if (choice == "4") {
            ListAvailableBooksRequest listAvailableBooksRequest = {};
            ListAvailableBooksResponse listAvailableBooksResponse = check ep->ListAvailableBooks(listAvailableBooksRequest);
            io:println(listAvailableBooksResponse);
        }

        else if (choice == "5") {
            string isbn = io:readln("Enter ISBN: ");
            LocateBookRequest locateBookRequest = {isbn: isbn};
            LocateBookResponse locateBookResponse = check ep->LocateBook(locateBookRequest);
            io:println(locateBookResponse);
        }

        else if (choice == "6") {
            string isbn = io:readln("Enter ISBN: ");
            string userID = io:readln("Enter userID: ");
            int|error userID_int = int:fromString(userID);
            BorrowBookRequest borrowBookRequest = {userId: check userID_int, isbn: isbn};
            BorrowBookResponse borrowBookResponse = check ep->BorrowBook(borrowBookRequest);
            io:println(borrowBookResponse);
        }

        else if (choice == "7") {

            string users = io:readln("Number of users: ");
            var data = [int:fromString(users)];
            string name = io:readln("Enter Name: ");
            string contact = io:readln("Enter contact: ");
            CreateUsersRequest createUsersRequest = {users: [{userId: 1, name: name, userType: "Student", contact: contact}]};
            CreateUsersStreamingClient createUsersStreamingClient = check ep->CreateUsers();
            check createUsersStreamingClient->sendCreateUsersRequest(createUsersRequest);
            check createUsersStreamingClient->complete();
            CreateUsersResponse? createUsersResponse = check createUsersStreamingClient->receiveCreateUsersResponse();
            io:println(createUsersResponse);
        }
        if (choice == "8") {
            break;
        }
    }
}

