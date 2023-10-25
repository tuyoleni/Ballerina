import ballerina/graphql;
import ballerinax/mongodb;

type Department record {
    string name;
};

type DepartmentDetails record {|
    int id;
    string username;
|};

//  Connecting to the database
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
configurable string databaseName = "management";

@graphql:ServiceConfig {
    graphiql: {
        enabled: true,
        path: "/management"
    }
}

service / on new graphql:Listener(4000) {
    remote function addDepartment(Department newdep) returns error|string {
        map<json> doc = <map<json>>newdep.toJson();
        _ = check db->insert(doc, departmentCollection, "");
        return string `${newdep.name} added successfully`;
    }
    resource function get department(Department x) returns DepartmentDetails[]|error {
        stream<DepartmentDetails, error?> datastream = check db->find(departmentCollection, databaseName, {id: x.name}, {});
        return from DepartmentDetails department in datastream
            select department;
    }
}
