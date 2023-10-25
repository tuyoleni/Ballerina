import ballerina/graphql;
import ballerina/io;

type Response record {|
    record {|anydata dt;|} data;
|};

graphql:Client graphClient = check new ("localhost:4000/");

public function main() returns error? {

    //all the functions will be used here example the addDepartment function
    //Pass in the parameters from the user input

    string inputdata = "Software Engineering";

    error? department = addDepartment(inputdata);
    if department is error {
        return department;
    }
}

function addDepartment(string departmentname) returns error? {
    string addDepartment = string `
    mutation addDepartment($name:String!){
        addDepartment(newdep:{name:$name})
    }`;

    Response response = check graphClient->execute(addDepartment, {"name": departmentname});
    io:println("Response ", response);
}
