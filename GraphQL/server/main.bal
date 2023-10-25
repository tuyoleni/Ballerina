import ballerina/graphql;
import ballerinax/mysql;
import ballerinax/mysql.driver as _;

type Department record {
    string name;
};

//  Connecting to the database

final mysql:Client db = check new (
    host = "localhost",
    user = "user", password = "password",
    port = 3306,
    database = "ballerina"
);

@graphql:ServiceConfig {
    graphiql: {
        enabled: true
    }
}

service / on new graphql:Listener(4000) {
    isolated remote function addDepartment(Department department) returns string|error {
        _ = check db->execute(`INSERT INTO department (name) VALUES(${department.name})`);
        return string `${department.name} add successfully`;
    }
    resource function get department() returns error|Dep {
        // stream<Department, sql:Error?> datastream = db->query(`SELECT * FROM department`);
        // return check from Department data in datastream
        //     select data;
        return check get_department();
    }
}

function get_department() returns error|Dep {
    stream<record {}, error?> datastream = db->query(`SELECT * FROM department`);
    var rec = check datastream.next();
    if !(rec is ()) {
        return new Dep(<Department>rec["value"]);
    } else {
        return error(string `Query failed`);
    }

}

service class Dep {

    private Department data;

    function init(Department data) {
        self.data = data;
    }

    // isolated resource function get id() returns int {
    //     return self.data.id;
    // }

    isolated resource function get name() returns string {
        return self.data.name;
    }
}
