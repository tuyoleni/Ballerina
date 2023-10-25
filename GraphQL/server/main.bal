import ballerina/graphql;
import ballerinax/mongodb;

type Department record {
    int id;
    string name;
};

type DepartmentDetails record {
    int id;
    string name;
    string? description;
};

type NewDepartment record {
    int id;
    string name;
};

type Staff record {
    int id;
    string name;
    string surname;
    string title;
    string role;
    int supervisor;
};

type KPI record {
    int id;
    int employee_id;
    int peer_recognition;
    int student_progress;
    int target;
    int grade;
};

type EmployeeScore record {
    int employee_id;
    int score;
};

// Connecting to the database
mongodb:ConnectionConfig mongoConfig = {
    connection: {
        host: "localhost",
        port: 27017,
        auth: {
            username: "",
            password: ""
        },
        options: {
            sslEnabled: false,
            serverSelectionTimeout: 5000
        }
    },
    databaseName: "management"
};

mongodb:Client db = check new (mongoConfig);
configurable string departmentCollection = "Department";
configurable string staffCollection = "Staff";
configurable string kpiCollection = "KPI";
configurable string employeeScoreCollection = "EmployeeScore";
configurable string databaseName = "management";

@graphql:ServiceConfig {
    graphiql: {
        enabled: true,
        path: "/management"
    }
}

service / on new graphql:Listener(4000) {

    //-------------------------------Mutation (They are used to modify)--------------------------------------

    // Mutation to add a new department document to the Department collection
    remote function addDepartment(Department newdep) returns error|string {
        map<json> doc = <map<json>>newdep.toJson();
        _ = check db->insert(doc, departmentCollection, "");
        return string `${newdep.name} added successfully`;
    }

    // Mutation to add a new department document to the Department collection
    remote function addStaff(Staff newstaff) returns error|string {
        map<json> doc = <map<json>>newstaff.toJson();
        _ = check db->insert(doc, staffCollection, "");
        return string `${newstaff.name} added successfully`;
    }

    // Mutation to delete a department document from the Department collection
    remote function deleteDepartment(int id) returns error|string {
        mongodb:Error|int deleteItem = db->delete(departmentCollection, "", {id: id}, false);
        if deleteItem is mongodb:Error {
            return error("Failed to delete items");
        } else {
            if deleteItem > 0 {
                return string `${id} deleted successfully`;
            } else {
                return string `department not found`;
            }
        }
    }

    //---------------------------Queries (They are used to retrieve data) ----------------------------------
    // Query to retrieve the departments' information
    resource function get departments() returns DepartmentDetails[]|error {
        stream<DepartmentDetails, error?> datastream = check db->find(departmentCollection, databaseName, {}, {});
        return from DepartmentDetails department in datastream
            select department;
    }
}
