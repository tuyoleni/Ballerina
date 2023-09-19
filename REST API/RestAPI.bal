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
type Office record{
    string office_number;
    string location;
    int capcity;
    string lecturer;
};

type Lecturers record{
    string name;
    string course;
    string office_number;
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

    // Retrieve the details of a specific lecturer by their office number.
     resource isolated function get office/[string office_number]() returns Lecturers[]|error{
    
        do{
           stream<Lecturers,sql:Error?> lecturer_office = db->query(`SELECT * FROM Staff WHERE  officeNumber = ${office_number}`);
           return from Lecturers offices in lecturer_office
            select offices;
        }
        on fail var e {
            return error(e.message());
        }
     }   
     //Retrieve all office
        resource isolated function get offices() returns Office[]|error
        {
            stream<Office, sql:Error?> office = db->query(`SELECT * FROM Office`);
            return from Office user in office
                select user;
        }
        
    }

    
     

