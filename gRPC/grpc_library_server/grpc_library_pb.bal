import ballerina/grpc;
import ballerina/protobuf;
import ballerina/protobuf.types.empty;
import ballerina/protobuf.types.wrappers;

public const string GRPC_LIBRARY_DESC = "0A12677270635F6C6962726172792E70726F746F120E4C6962726172794D616E616765721A1E676F6F676C652F70726F746F6275662F77726170706572732E70726F746F1A1B676F6F676C652F70726F746F6275662F656D7074792E70726F746F22C7010A04426F6F6B12140A057469746C6518012001280952057469746C6512190A08617574686F725F311802200128095207617574686F723112230A0D6F7074696F6E5F617574686F72180320012809520C6F7074696F6E417574686F72121A0A086C6F636174696F6E18042001280952086C6F636174696F6E12120A044953424E18052001280952044953424E121C0A09617661696C61626C651806200128095209617661696C61626C65121B0A09626F72726F775F62791807200128095208626F72726F77427922590A055573657273121A0A08757365724E616D651801200128095208757365724E616D65121A0A0870617373576F7264180220012809520870617373576F726412180A07697341646D696E1803200128085207697341646D696E22240A08526573706F6E647312180A076D65737361676518012001280952076D6573736167653286050A074C69627261727912350A056C6F67696E12152E4C6962726172794D616E616765722E55736572731A152E4C6962726172794D616E616765722E557365727312390A07616464426F6F6B12142E4C6962726172794D616E616765722E426F6F6B1A182E4C6962726172794D616E616765722E526573706F6E6473123C0A0A757064617465426F6F6B12142E4C6962726172794D616E616765722E426F6F6B1A182E4C6962726172794D616E616765722E526573706F6E647312380A0A626F72726F77426F6F6B12142E4C6962726172794D616E616765722E426F6F6B1A142E4C6962726172794D616E616765722E426F6F6B12430A1173686F77417661696C61626C65426F6F6B12162E676F6F676C652E70726F746F6275662E456D7074791A142E4C6962726172794D616E616765722E426F6F6B300112420A1073686F77426F72726F776564426F6F6B12162E676F6F676C652E70726F746F6275662E456D7074791A142E4C6962726172794D616E616765722E426F6F6B300112440A0A64656C657465426F6F6B121C2E676F6F676C652E70726F746F6275662E537472696E6756616C75651A182E4C6962726172794D616E616765722E526573706F6E647312400A0A6C6F63617465426F6F6B121C2E676F6F676C652E70726F746F6275662E537472696E6756616C75651A142E4C6962726172794D616E616765722E426F6F6B123A0A076164645573657212152E4C6962726172794D616E616765722E55736572731A182E4C6962726172794D616E616765722E526573706F6E647312440A0A64656C65746555736572121C2E676F6F676C652E70726F746F6275662E537472696E6756616C75651A182E4C6962726172794D616E616765722E526573706F6E6473620670726F746F33";

public isolated client class LibraryClient {
    *grpc:AbstractClientEndpoint;

    private final grpc:Client grpcClient;

    public isolated function init(string url, *grpc:ClientConfiguration config) returns grpc:Error? {
        self.grpcClient = check new (url, config);
        check self.grpcClient.initStub(self, GRPC_LIBRARY_DESC);
    }

    isolated remote function login(Users|ContextUsers req) returns Users|grpc:Error {
        map<string|string[]> headers = {};
        Users message;
        if req is ContextUsers {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("LibraryManager.Library/login", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <Users>result;
    }

    isolated remote function loginContext(Users|ContextUsers req) returns ContextUsers|grpc:Error {
        map<string|string[]> headers = {};
        Users message;
        if req is ContextUsers {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("LibraryManager.Library/login", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <Users>result, headers: respHeaders};
    }

    isolated remote function addBook(Book|ContextBook req) returns Responds|grpc:Error {
        map<string|string[]> headers = {};
        Book message;
        if req is ContextBook {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("LibraryManager.Library/addBook", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <Responds>result;
    }

    isolated remote function addBookContext(Book|ContextBook req) returns ContextResponds|grpc:Error {
        map<string|string[]> headers = {};
        Book message;
        if req is ContextBook {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("LibraryManager.Library/addBook", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <Responds>result, headers: respHeaders};
    }

    isolated remote function updateBook(Book|ContextBook req) returns Responds|grpc:Error {
        map<string|string[]> headers = {};
        Book message;
        if req is ContextBook {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("LibraryManager.Library/updateBook", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <Responds>result;
    }

    isolated remote function updateBookContext(Book|ContextBook req) returns ContextResponds|grpc:Error {
        map<string|string[]> headers = {};
        Book message;
        if req is ContextBook {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("LibraryManager.Library/updateBook", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <Responds>result, headers: respHeaders};
    }

    isolated remote function borrowBook(Book|ContextBook req) returns Book|grpc:Error {
        map<string|string[]> headers = {};
        Book message;
        if req is ContextBook {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("LibraryManager.Library/borrowBook", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <Book>result;
    }

    isolated remote function borrowBookContext(Book|ContextBook req) returns ContextBook|grpc:Error {
        map<string|string[]> headers = {};
        Book message;
        if req is ContextBook {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("LibraryManager.Library/borrowBook", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <Book>result, headers: respHeaders};
    }

    isolated remote function deleteBook(string|wrappers:ContextString req) returns Responds|grpc:Error {
        map<string|string[]> headers = {};
        string message;
        if req is wrappers:ContextString {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("LibraryManager.Library/deleteBook", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <Responds>result;
    }

    isolated remote function deleteBookContext(string|wrappers:ContextString req) returns ContextResponds|grpc:Error {
        map<string|string[]> headers = {};
        string message;
        if req is wrappers:ContextString {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("LibraryManager.Library/deleteBook", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <Responds>result, headers: respHeaders};
    }

    isolated remote function locateBook(string|wrappers:ContextString req) returns Book|grpc:Error {
        map<string|string[]> headers = {};
        string message;
        if req is wrappers:ContextString {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("LibraryManager.Library/locateBook", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <Book>result;
    }

    isolated remote function locateBookContext(string|wrappers:ContextString req) returns ContextBook|grpc:Error {
        map<string|string[]> headers = {};
        string message;
        if req is wrappers:ContextString {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("LibraryManager.Library/locateBook", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <Book>result, headers: respHeaders};
    }

    isolated remote function addUser(Users|ContextUsers req) returns Responds|grpc:Error {
        map<string|string[]> headers = {};
        Users message;
        if req is ContextUsers {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("LibraryManager.Library/addUser", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <Responds>result;
    }

    isolated remote function addUserContext(Users|ContextUsers req) returns ContextResponds|grpc:Error {
        map<string|string[]> headers = {};
        Users message;
        if req is ContextUsers {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("LibraryManager.Library/addUser", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <Responds>result, headers: respHeaders};
    }

    isolated remote function deleteUser(string|wrappers:ContextString req) returns Responds|grpc:Error {
        map<string|string[]> headers = {};
        string message;
        if req is wrappers:ContextString {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("LibraryManager.Library/deleteUser", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <Responds>result;
    }

    isolated remote function deleteUserContext(string|wrappers:ContextString req) returns ContextResponds|grpc:Error {
        map<string|string[]> headers = {};
        string message;
        if req is wrappers:ContextString {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("LibraryManager.Library/deleteUser", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <Responds>result, headers: respHeaders};
    }

    isolated remote function showAvailableBook() returns stream<Book, grpc:Error?>|grpc:Error {
        empty:Empty message = {};
        map<string|string[]> headers = {};
        var payload = check self.grpcClient->executeServerStreaming("LibraryManager.Library/showAvailableBook", message, headers);
        [stream<anydata, grpc:Error?>, map<string|string[]>] [result, _] = payload;
        BookStream outputStream = new BookStream(result);
        return new stream<Book, grpc:Error?>(outputStream);
    }

    isolated remote function showAvailableBookContext() returns ContextBookStream|grpc:Error {
        empty:Empty message = {};
        map<string|string[]> headers = {};
        var payload = check self.grpcClient->executeServerStreaming("LibraryManager.Library/showAvailableBook", message, headers);
        [stream<anydata, grpc:Error?>, map<string|string[]>] [result, respHeaders] = payload;
        BookStream outputStream = new BookStream(result);
        return {content: new stream<Book, grpc:Error?>(outputStream), headers: respHeaders};
    }

    isolated remote function showBorrowedBook() returns stream<Book, grpc:Error?>|grpc:Error {
        empty:Empty message = {};
        map<string|string[]> headers = {};
        var payload = check self.grpcClient->executeServerStreaming("LibraryManager.Library/showBorrowedBook", message, headers);
        [stream<anydata, grpc:Error?>, map<string|string[]>] [result, _] = payload;
        BookStream outputStream = new BookStream(result);
        return new stream<Book, grpc:Error?>(outputStream);
    }

    isolated remote function showBorrowedBookContext() returns ContextBookStream|grpc:Error {
        empty:Empty message = {};
        map<string|string[]> headers = {};
        var payload = check self.grpcClient->executeServerStreaming("LibraryManager.Library/showBorrowedBook", message, headers);
        [stream<anydata, grpc:Error?>, map<string|string[]>] [result, respHeaders] = payload;
        BookStream outputStream = new BookStream(result);
        return {content: new stream<Book, grpc:Error?>(outputStream), headers: respHeaders};
    }
}

public class BookStream {
    private stream<anydata, grpc:Error?> anydataStream;

    public isolated function init(stream<anydata, grpc:Error?> anydataStream) {
        self.anydataStream = anydataStream;
    }

    public isolated function next() returns record {|Book value;|}|grpc:Error? {
        var streamValue = self.anydataStream.next();
        if (streamValue is ()) {
            return streamValue;
        } else if (streamValue is grpc:Error) {
            return streamValue;
        } else {
            record {|Book value;|} nextRecord = {value: <Book>streamValue.value};
            return nextRecord;
        }
    }

    public isolated function close() returns grpc:Error? {
        return self.anydataStream.close();
    }
}

public client class LibraryUsersCaller {
    private grpc:Caller caller;

    public isolated function init(grpc:Caller caller) {
        self.caller = caller;
    }

    public isolated function getId() returns int {
        return self.caller.getId();
    }

    isolated remote function sendUsers(Users response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendContextUsers(ContextUsers response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendError(grpc:Error response) returns grpc:Error? {
        return self.caller->sendError(response);
    }

    isolated remote function complete() returns grpc:Error? {
        return self.caller->complete();
    }

    public isolated function isCancelled() returns boolean {
        return self.caller.isCancelled();
    }
}

public client class LibraryBookCaller {
    private grpc:Caller caller;

    public isolated function init(grpc:Caller caller) {
        self.caller = caller;
    }

    public isolated function getId() returns int {
        return self.caller.getId();
    }

    isolated remote function sendBook(Book response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendContextBook(ContextBook response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendError(grpc:Error response) returns grpc:Error? {
        return self.caller->sendError(response);
    }

    isolated remote function complete() returns grpc:Error? {
        return self.caller->complete();
    }

    public isolated function isCancelled() returns boolean {
        return self.caller.isCancelled();
    }
}

public client class LibraryRespondsCaller {
    private grpc:Caller caller;

    public isolated function init(grpc:Caller caller) {
        self.caller = caller;
    }

    public isolated function getId() returns int {
        return self.caller.getId();
    }

    isolated remote function sendResponds(Responds response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendContextResponds(ContextResponds response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendError(grpc:Error response) returns grpc:Error? {
        return self.caller->sendError(response);
    }

    isolated remote function complete() returns grpc:Error? {
        return self.caller->complete();
    }

    public isolated function isCancelled() returns boolean {
        return self.caller.isCancelled();
    }
}

public type ContextBookStream record {|
    stream<Book, error?> content;
    map<string|string[]> headers;
|};

public type ContextBook record {|
    Book content;
    map<string|string[]> headers;
|};

public type ContextUsers record {|
    Users content;
    map<string|string[]> headers;
|};

public type ContextResponds record {|
    Responds content;
    map<string|string[]> headers;
|};

@protobuf:Descriptor {value: GRPC_LIBRARY_DESC}
public type Book record {|
    string title = "";
    string author_1 = "";
    string option_author = "";
    string location = "";
    readonly string ISBN = "";
    string available = "";
    string borrow_by = "";
|};

@protobuf:Descriptor {value: GRPC_LIBRARY_DESC}
public type Users record {|
    readonly string userName = "";
    string passWord = "";
    boolean isAdmin = false;
|};

@protobuf:Descriptor {value: GRPC_LIBRARY_DESC}
public type Responds record {|
    string message = "";
|};

