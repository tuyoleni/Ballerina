import ballerina/graphql;
import ballerina/io;

type Response record {|
    record {|anydata dt;|} data;
|};

graphql:Client graphClient = check new ("localhost:4000/");

public function main() returns error? {

    int id = 111;
    string name = "Software";

    //Adding department
    error? departmentResult = addDepartment(id, name);
    if departmentResult is error {
        return departmentResult;
    }

    // Deleting department
    error? deleteDepartmentResult = deleteDepartment(id);
    if (deleteDepartmentResult is error) {
        return deleteDepartmentResult;
    }

    // Adding staff
    error? addstuff = addStaff(123, "John", "Doe", "Software Engineer", "Employee", 456);
    if (addstuff is error) {
        return addstuff;
    }
}

// sends a GraphQL mutation to add a department
function addDepartment(int id, string departmentname) returns error? {
    string addDepartment = string `
    mutation addDepartment($id:Int!, $name:String!){
    addDepartment(newdep:{id:$id, name:$name})
    }`;

    Response response = check graphClient->execute(addDepartment, {"id": id, "name": departmentname});
    io:println("Response ", response);
}

// sends a GraphQL mutation to delete a department by its ID
function deleteDepartment(int departmentID) returns error? {
    string deleteDepartment = string `
    mutation deleteDepartment($id: Int!) {
    deleteDepartment(id: $id)
    }`;

    Response response = check graphClient->execute(deleteDepartment, {id: departmentID});
    io:println("Response ", response);
}

// sends a GraphQL mutation to add a staff
function addStaff(int id, string name, string surname, string title, string role, int supervisor) returns error? {
    string addStaffMutation = string `
    mutation addStaff($newStaff: StaffInput!) {
        addStaff(newstaff: $newStaff)
    }`;

    map<json> staffInput = {
        "id": id,
        "name": name,
        "surname": surname,
        "title": title,
        "role": role,
        "supervisor": supervisor
    };

    Response response = check graphClient->execute(addStaffMutation, {"newStaff": staffInput});
    io:println("Response ", response);
}
