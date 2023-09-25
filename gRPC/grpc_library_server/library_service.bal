import ballerina/grpc;

listener grpc:Listener ep = new (9090);
table<Book> key(ISBN) bookTable = table[];
table<Users>key(userName) userTable = table[]; 

@grpc:Descriptor {value: GRPC_LIBRARY_DESC}
service "Library" on ep {
     

     remote function login(Users value) returns Users|error{
        Users userRecord = userTable.get(value.userName);

        return userRecord;  
    }

    remote function addBook(Book value) returns Responds|error {
        string valueISBN = value.ISBN;
        string isbn_book = from var i in bookTable where i.ISBN == valueISBN select i.ISBN;
        if (valueISBN == isbn_book){
            return {message: "this book has an existing ISBN number of a book in the library"};
        }
        else{
            error? book_add = bookTable.add(value);
            if book_add is error{
                return book_add;
            }
            else{
                return {message: "book added"};
            }
        }        
    }
    remote function updateBook(Book value) returns Responds|error {

            
                        
            error? book_update = bookTable.put(value);
            if book_update is error{
            return book_update;
            }

            else{
            return {message: "book updated"};
            }
        
    }
    remote function borrowBook(Book value) returns Book|error {
        string valueISBN = value.ISBN;
        Book getBook = bookTable.get(valueISBN);
        error? updateBorrowBook = bookTable.put(value);

        if updateBorrowBook is error{
            return updateBorrowBook;
        }
        else{
        getBook = bookTable.get(valueISBN);
        }
        return getBook;
        }
    remote function deleteBook(string value) returns Responds|error {
        Book deleteBook = bookTable.remove(value);
        return {
            message: string `${deleteBook.title} deleted book successfully`
        };
    }
    remote function locateBook(string value) returns Book|error {
        Book getLocation = bookTable.get(value);
        return getLocation;
    }
    remote function addUser(Users value) returns Responds|error {
        string userID = value.userName; 
        string userLogin = from var i in userTable where i.userName == userID select i.userName;
        if (userID == userLogin){
            return{message:"there is an existing user"};
        }
        else {
            error? addNewUser = userTable.add(value);
            if addNewUser is error{
                return addNewUser;
            }
            else {
                return {message: "add User"};
            }
        }
    }
    remote function deleteUser(string value) returns Responds|error {
        Users deleteUser = userTable.remove(value);
        return {
            message: string `${deleteUser.userName} deleted User successfully`
        };
    }
    remote function showAvailableBook() returns stream<Book, error?>|string {
        stream<Book, error?> bookStream = stream from var book in bookTable.toArray() where book.available == "Available"
            select book  ;
       
            return bookStream;
    }
    remote function showBorrowedBook() returns stream<Book, error?>|error {
        stream<Book, error?> bookStream = stream from var book in bookTable.toArray() where book.available == "Unavailable"
            select book  ;
        

        
            return bookStream;
        
        
    }
}

