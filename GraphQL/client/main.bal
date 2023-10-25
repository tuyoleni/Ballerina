import ballerina/graphql;
import ballerina/io;

type Response record {|
    record {|anydata dt;|} data;
|};

public function main() returns error? {
    graphql:Client graphClient = check new ("localhost:4000/");
    string doc = string `
    mutation addDepartment($name:String!){
        addDepartment(newdep:{name:$name})
    }`;

    Response response = check graphClient->execute(doc, {"name": "Test Department"});

    io:println("Response ", response);
}

