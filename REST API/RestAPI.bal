import ballerina/http;
import ballerinax/mysql;
import ballerina/sql;
import ballerinax/mysql.driver as _;

//Records
type Staff record
{
    string staffNumber;
    string officeNumber;
    string staffName;
    string title;
};

final mysql:Client db = check new (
    host = "first-instance.cg4vktva35w7.eu-north-1.rds.amazonaws.com",
    user = "learning", password = "learning-db",
    port = 3306,
    database = "bal_db"
);

isolated service /api on new http:Listener(9090) {
    //Retrieve the details of a specific lecturer by their staff number.
    resource isolated function get lecturers/[string staffNumber]() returns Staff[]|error {
        stream<Staff, sql:Error?> streams = db->query(`select * from Staff where staffNumber = ${staffNumber}`);
        return from Staff staff in streams
            select staff;
    }
}
