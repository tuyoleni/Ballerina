import ballerina/grpc;
import ballerina/protobuf;

public const string LIBRARY_DESC = "0A0D6C6962726172792E70726F746F12074C69627261727922BB010A04426F6F6B12120A046973626E18012001280952046973626E12140A057469746C6518022001280952057469746C6512160A06617574686F721803200128095206617574686F72121A0A086C6F636174696F6E18042001280952086C6F636174696F6E122C0A0673746174757318052001280E32142E4C6962726172792E426F6F6B2E537461747573520673746174757322270A06537461747573120D0A09417661696C61626C651000120E0A0A436865636B65644F75741001223A0A0C426F72726F776564426F6F6B12160A06757365724964180220012805520675736572496412120A046973626E18032001280952046973626E22A8010A045573657212160A06757365724964180120012805520675736572496412120A046E616D6518022001280952046E616D6512320A08757365725479706518032001280E32162E4C6962726172792E557365722E55736572547970655208757365725479706512180A07636F6E746163741804200128095207636F6E7461637422260A085573657254797065120B0A0753747564656E741000120D0A094C696272617269616E100122330A0E416464426F6F6B5265717565737412210A04626F6F6B18012001280B320D2E4C6962726172792E426F6F6B5204626F6F6B22250A0F416464426F6F6B526573706F6E736512120A046973626E18012001280952046973626E223F0A11426F72726F77426F6F6B5265717565737412160A06757365724964180120012805520675736572496412120A046973626E18022001280952046973626E224F0A12426F72726F77426F6F6B526573706F6E736512390A0C626F72726F776564426F6F6B18012001280B32152E4C6962726172792E426F72726F776564426F6F6B520C626F72726F776564426F6F6B22390A1243726561746555736572735265717565737412230A05757365727318012003280B320D2E4C6962726172792E557365725205757365727322480A134372656174655573657273526573706F6E736512310A05757365727318012001280B321B2E4C6962726172792E43726561746555736572735265717565737452057573657273224A0A11557064617465426F6F6B5265717565737412120A046973626E18012001280952046973626E12210A04626F6F6B18022001280B320D2E4C6962726172792E426F6F6B5204626F6F6B22520A12557064617465426F6F6B526573706F6E7365123C0A0B75706461746564426F6F6B18012001280B321A2E4C6962726172792E557064617465426F6F6B52657175657374520B75706461746564426F6F6B22270A1152656D6F7665426F6F6B5265717565737412120A046973626E18012001280952046973626E22470A1252656D6F7665426F6F6B526573706F6E736512310A0C75706461746564426F6F6B7318012003280B320D2E4C6962726172792E426F6F6B520C75706461746564426F6F6B73221B0A194C697374417661696C61626C65426F6F6B735265717565737422530A1A4C697374417661696C61626C65426F6F6B73526573706F6E736512350A0E617661696C61626C65426F6F6B7318012003280B320D2E4C6962726172792E426F6F6B520E617661696C61626C65426F6F6B7322270A114C6F63617465426F6F6B5265717565737412120A046973626E18012001280952046973626E224E0A124C6F63617465426F6F6B526573706F6E7365121A0A086C6F636174696F6E18012001280952086C6F636174696F6E121C0A09617661696C61626C651802200128085209617661696C61626C653295040A0E4C69627261727953657276696365123C0A07416464426F6F6B12172E4C6962726172792E416464426F6F6B526571756573741A182E4C6962726172792E416464426F6F6B526573706F6E7365124A0A0B4372656174655573657273121B2E4C6962726172792E4372656174655573657273526571756573741A1C2E4C6962726172792E4372656174655573657273526573706F6E7365280112450A0A557064617465426F6F6B121A2E4C6962726172792E557064617465426F6F6B526571756573741A1B2E4C6962726172792E557064617465426F6F6B526573706F6E736512450A0A52656D6F7665426F6F6B121A2E4C6962726172792E52656D6F7665426F6F6B526571756573741A1B2E4C6962726172792E52656D6F7665426F6F6B526573706F6E7365125D0A124C697374417661696C61626C65426F6F6B7312222E4C6962726172792E4C697374417661696C61626C65426F6F6B73526571756573741A232E4C6962726172792E4C697374417661696C61626C65426F6F6B73526573706F6E736512450A0A4C6F63617465426F6F6B121A2E4C6962726172792E4C6F63617465426F6F6B526571756573741A1B2E4C6962726172792E4C6F63617465426F6F6B526573706F6E736512450A0A426F72726F77426F6F6B121A2E4C6962726172792E426F72726F77426F6F6B526571756573741A1B2E4C6962726172792E426F72726F77426F6F6B526573706F6E7365620670726F746F33";

public isolated client class LibraryServiceClient {
    *grpc:AbstractClientEndpoint;

    private final grpc:Client grpcClient;

    public isolated function init(string url, *grpc:ClientConfiguration config) returns grpc:Error? {
        self.grpcClient = check new (url, config);
        check self.grpcClient.initStub(self, LIBRARY_DESC);
    }

    isolated remote function AddBook(AddBookRequest|ContextAddBookRequest req) returns AddBookResponse|grpc:Error {
        map<string|string[]> headers = {};
        AddBookRequest message;
        if req is ContextAddBookRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("Library.LibraryService/AddBook", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <AddBookResponse>result;
    }

    isolated remote function AddBookContext(AddBookRequest|ContextAddBookRequest req) returns ContextAddBookResponse|grpc:Error {
        map<string|string[]> headers = {};
        AddBookRequest message;
        if req is ContextAddBookRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("Library.LibraryService/AddBook", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <AddBookResponse>result, headers: respHeaders};
    }

    isolated remote function UpdateBook(UpdateBookRequest|ContextUpdateBookRequest req) returns UpdateBookResponse|grpc:Error {
        map<string|string[]> headers = {};
        UpdateBookRequest message;
        if req is ContextUpdateBookRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("Library.LibraryService/UpdateBook", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <UpdateBookResponse>result;
    }

    isolated remote function UpdateBookContext(UpdateBookRequest|ContextUpdateBookRequest req) returns ContextUpdateBookResponse|grpc:Error {
        map<string|string[]> headers = {};
        UpdateBookRequest message;
        if req is ContextUpdateBookRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("Library.LibraryService/UpdateBook", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <UpdateBookResponse>result, headers: respHeaders};
    }

    isolated remote function RemoveBook(RemoveBookRequest|ContextRemoveBookRequest req) returns RemoveBookResponse|grpc:Error {
        map<string|string[]> headers = {};
        RemoveBookRequest message;
        if req is ContextRemoveBookRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("Library.LibraryService/RemoveBook", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <RemoveBookResponse>result;
    }

    isolated remote function RemoveBookContext(RemoveBookRequest|ContextRemoveBookRequest req) returns ContextRemoveBookResponse|grpc:Error {
        map<string|string[]> headers = {};
        RemoveBookRequest message;
        if req is ContextRemoveBookRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("Library.LibraryService/RemoveBook", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <RemoveBookResponse>result, headers: respHeaders};
    }

    isolated remote function ListAvailableBooks(ListAvailableBooksRequest|ContextListAvailableBooksRequest req) returns ListAvailableBooksResponse|grpc:Error {
        map<string|string[]> headers = {};
        ListAvailableBooksRequest message;
        if req is ContextListAvailableBooksRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("Library.LibraryService/ListAvailableBooks", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <ListAvailableBooksResponse>result;
    }

    isolated remote function ListAvailableBooksContext(ListAvailableBooksRequest|ContextListAvailableBooksRequest req) returns ContextListAvailableBooksResponse|grpc:Error {
        map<string|string[]> headers = {};
        ListAvailableBooksRequest message;
        if req is ContextListAvailableBooksRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("Library.LibraryService/ListAvailableBooks", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <ListAvailableBooksResponse>result, headers: respHeaders};
    }

    isolated remote function LocateBook(LocateBookRequest|ContextLocateBookRequest req) returns LocateBookResponse|grpc:Error {
        map<string|string[]> headers = {};
        LocateBookRequest message;
        if req is ContextLocateBookRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("Library.LibraryService/LocateBook", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <LocateBookResponse>result;
    }

    isolated remote function LocateBookContext(LocateBookRequest|ContextLocateBookRequest req) returns ContextLocateBookResponse|grpc:Error {
        map<string|string[]> headers = {};
        LocateBookRequest message;
        if req is ContextLocateBookRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("Library.LibraryService/LocateBook", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <LocateBookResponse>result, headers: respHeaders};
    }

    isolated remote function BorrowBook(BorrowBookRequest|ContextBorrowBookRequest req) returns BorrowBookResponse|grpc:Error {
        map<string|string[]> headers = {};
        BorrowBookRequest message;
        if req is ContextBorrowBookRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("Library.LibraryService/BorrowBook", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <BorrowBookResponse>result;
    }

    isolated remote function BorrowBookContext(BorrowBookRequest|ContextBorrowBookRequest req) returns ContextBorrowBookResponse|grpc:Error {
        map<string|string[]> headers = {};
        BorrowBookRequest message;
        if req is ContextBorrowBookRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("Library.LibraryService/BorrowBook", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <BorrowBookResponse>result, headers: respHeaders};
    }

    isolated remote function CreateUsers() returns CreateUsersStreamingClient|grpc:Error {
        grpc:StreamingClient sClient = check self.grpcClient->executeClientStreaming("Library.LibraryService/CreateUsers");
        return new CreateUsersStreamingClient(sClient);
    }
}

public client class CreateUsersStreamingClient {
    private grpc:StreamingClient sClient;

    isolated function init(grpc:StreamingClient sClient) {
        self.sClient = sClient;
    }

    isolated remote function sendCreateUsersRequest(CreateUsersRequest message) returns grpc:Error? {
        return self.sClient->send(message);
    }

    isolated remote function sendContextCreateUsersRequest(ContextCreateUsersRequest message) returns grpc:Error? {
        return self.sClient->send(message);
    }

    isolated remote function receiveCreateUsersResponse() returns CreateUsersResponse|grpc:Error? {
        var response = check self.sClient->receive();
        if response is () {
            return response;
        } else {
            [anydata, map<string|string[]>] [payload, _] = response;
            return <CreateUsersResponse>payload;
        }
    }

    isolated remote function receiveContextCreateUsersResponse() returns ContextCreateUsersResponse|grpc:Error? {
        var response = check self.sClient->receive();
        if response is () {
            return response;
        } else {
            [anydata, map<string|string[]>] [payload, headers] = response;
            return {content: <CreateUsersResponse>payload, headers: headers};
        }
    }

    isolated remote function sendError(grpc:Error response) returns grpc:Error? {
        return self.sClient->sendError(response);
    }

    isolated remote function complete() returns grpc:Error? {
        return self.sClient->complete();
    }
}

public client class LibraryServiceCreateUsersResponseCaller {
    private grpc:Caller caller;

    public isolated function init(grpc:Caller caller) {
        self.caller = caller;
    }

    public isolated function getId() returns int {
        return self.caller.getId();
    }

    isolated remote function sendCreateUsersResponse(CreateUsersResponse response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendContextCreateUsersResponse(ContextCreateUsersResponse response) returns grpc:Error? {
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

public client class LibraryServiceUpdateBookResponseCaller {
    private grpc:Caller caller;

    public isolated function init(grpc:Caller caller) {
        self.caller = caller;
    }

    public isolated function getId() returns int {
        return self.caller.getId();
    }

    isolated remote function sendUpdateBookResponse(UpdateBookResponse response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendContextUpdateBookResponse(ContextUpdateBookResponse response) returns grpc:Error? {
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

public client class LibraryServiceAddBookResponseCaller {
    private grpc:Caller caller;

    public isolated function init(grpc:Caller caller) {
        self.caller = caller;
    }

    public isolated function getId() returns int {
        return self.caller.getId();
    }

    isolated remote function sendAddBookResponse(AddBookResponse response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendContextAddBookResponse(ContextAddBookResponse response) returns grpc:Error? {
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

public client class LibraryServiceLocateBookResponseCaller {
    private grpc:Caller caller;

    public isolated function init(grpc:Caller caller) {
        self.caller = caller;
    }

    public isolated function getId() returns int {
        return self.caller.getId();
    }

    isolated remote function sendLocateBookResponse(LocateBookResponse response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendContextLocateBookResponse(ContextLocateBookResponse response) returns grpc:Error? {
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

public client class LibraryServiceListAvailableBooksResponseCaller {
    private grpc:Caller caller;

    public isolated function init(grpc:Caller caller) {
        self.caller = caller;
    }

    public isolated function getId() returns int {
        return self.caller.getId();
    }

    isolated remote function sendListAvailableBooksResponse(ListAvailableBooksResponse response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendContextListAvailableBooksResponse(ContextListAvailableBooksResponse response) returns grpc:Error? {
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

public client class LibraryServiceRemoveBookResponseCaller {
    private grpc:Caller caller;

    public isolated function init(grpc:Caller caller) {
        self.caller = caller;
    }

    public isolated function getId() returns int {
        return self.caller.getId();
    }

    isolated remote function sendRemoveBookResponse(RemoveBookResponse response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendContextRemoveBookResponse(ContextRemoveBookResponse response) returns grpc:Error? {
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

public client class LibraryServiceBorrowBookResponseCaller {
    private grpc:Caller caller;

    public isolated function init(grpc:Caller caller) {
        self.caller = caller;
    }

    public isolated function getId() returns int {
        return self.caller.getId();
    }

    isolated remote function sendBorrowBookResponse(BorrowBookResponse response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendContextBorrowBookResponse(ContextBorrowBookResponse response) returns grpc:Error? {
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

public type ContextCreateUsersRequestStream record {|
    stream<CreateUsersRequest, error?> content;
    map<string|string[]> headers;
|};

public type ContextRemoveBookRequest record {|
    RemoveBookRequest content;
    map<string|string[]> headers;
|};

public type ContextBorrowBookResponse record {|
    BorrowBookResponse content;
    map<string|string[]> headers;
|};

public type ContextListAvailableBooksRequest record {|
    ListAvailableBooksRequest content;
    map<string|string[]> headers;
|};

public type ContextAddBookRequest record {|
    AddBookRequest content;
    map<string|string[]> headers;
|};

public type ContextAddBookResponse record {|
    AddBookResponse content;
    map<string|string[]> headers;
|};

public type ContextRemoveBookResponse record {|
    RemoveBookResponse content;
    map<string|string[]> headers;
|};

public type ContextCreateUsersRequest record {|
    CreateUsersRequest content;
    map<string|string[]> headers;
|};

public type ContextLocateBookRequest record {|
    LocateBookRequest content;
    map<string|string[]> headers;
|};

public type ContextLocateBookResponse record {|
    LocateBookResponse content;
    map<string|string[]> headers;
|};

public type ContextListAvailableBooksResponse record {|
    ListAvailableBooksResponse content;
    map<string|string[]> headers;
|};

public type ContextUpdateBookRequest record {|
    UpdateBookRequest content;
    map<string|string[]> headers;
|};

public type ContextBorrowBookRequest record {|
    BorrowBookRequest content;
    map<string|string[]> headers;
|};

public type ContextUpdateBookResponse record {|
    UpdateBookResponse content;
    map<string|string[]> headers;
|};

public type ContextCreateUsersResponse record {|
    CreateUsersResponse content;
    map<string|string[]> headers;
|};

@protobuf:Descriptor {value: LIBRARY_DESC}
public type User record {|
    int userId = 0;
    string name = "";
    User_UserType userType = Student;
    string contact = "";
|};

public enum User_UserType {
    Student, Librarian
}

@protobuf:Descriptor {value: LIBRARY_DESC}
public type BorrowBookResponse record {|
    BorrowedBook borrowedBook = {};
|};

@protobuf:Descriptor {value: LIBRARY_DESC}
public type RemoveBookRequest record {|
    string isbn = "";
|};

@protobuf:Descriptor {value: LIBRARY_DESC}
public type ListAvailableBooksRequest record {|
|};

@protobuf:Descriptor {value: LIBRARY_DESC}
public type AddBookRequest record {|
    Book book = {};
|};

@protobuf:Descriptor {value: LIBRARY_DESC}
public type AddBookResponse record {|
    string isbn = "";
|};

@protobuf:Descriptor {value: LIBRARY_DESC}
public type RemoveBookResponse record {|
    Book[] updatedBooks = [];
|};

@protobuf:Descriptor {value: LIBRARY_DESC}
public type CreateUsersRequest record {|
    User[] users = [];
|};

@protobuf:Descriptor {value: LIBRARY_DESC}
public type LocateBookRequest record {|
    string isbn = "";
|};

@protobuf:Descriptor {value: LIBRARY_DESC}
public type LocateBookResponse record {|
    string location = "";
    boolean available = false;
|};

@protobuf:Descriptor {value: LIBRARY_DESC}
public type ListAvailableBooksResponse record {|
    Book[] availableBooks = [];
|};

@protobuf:Descriptor {value: LIBRARY_DESC}
public type Book record {|
    string isbn = "";
    string title = "";
    string author = "";
    string location = "";
    Book_Status status = Available;
|};

public enum Book_Status {
    Available, CheckedOut
}

@protobuf:Descriptor {value: LIBRARY_DESC}
public type UpdateBookRequest record {|
    string isbn = "";
    Book book = {};
|};

@protobuf:Descriptor {value: LIBRARY_DESC}
public type BorrowBookRequest record {|
    int userId = 0;
    string isbn = "";
|};

@protobuf:Descriptor {value: LIBRARY_DESC}
public type UpdateBookResponse record {|
    UpdateBookRequest updatedBook = {};
|};

@protobuf:Descriptor {value: LIBRARY_DESC}
public type BorrowedBook record {|
    int userId = 0;
    string isbn = "";
|};

@protobuf:Descriptor {value: LIBRARY_DESC}
public type CreateUsersResponse record {|
    CreateUsersRequest users = {};
|};

