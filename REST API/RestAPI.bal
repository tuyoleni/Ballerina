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

type Office record {
    string office_number;
    string location;
    int capcity;
    string lecturer;
};

type LecturerAndCourses record {
    string staffNumber;
    string officeNumber;
    string staffName;
};

final mysql:Client db = check new (
    host = "first-instance.cg4vktva35w7.eu-north-1.rds.amazonaws.com",
    user = "learning", password = "learning-db",
    port = 3306,
    database = "bal_db"
);

isolated service /api on new http:Listener(9000) {
    //Retrieve the details of a specific lecturer by their staff number.(Simeon)
    resource isolated function get lecturers/[string staffNumber]() returns Staff[]|error {
        stream<Staff, sql:Error?> staffs = db->query(`select * from Staff where staffNumber = ${staffNumber}`);
        return from Staff staff in staffs
            select staff;
    }

    // Retrieve all the lecturers that sit in the same office.(Barkias)
    resource isolated function get lecturer/[string office_number]() returns Staff[]|error {

        do {
            stream<Staff, sql:Error?> lecturer_office = db->query(`SELECT * FROM Staff WHERE  officeNumber = ${office_number}`);
            return from Staff offices in lecturer_office
                select offices;
        }
        on fail var e {
            return error(e.message());
        }
    }

    // //Retrieve all office
    // resource isolated function get offices() returns Office[]|error
    //     {
    //     stream<Office, sql:Error?> office = db->query(`SELECT * FROM Office`);
    //     return from Office user in office
    //         select user;
    // }

    //Retrieve a list of all lecturers withtin the faculty (Patrick)
    resource isolated function get lecturer() returns Staff[]|error {
        stream<Staff, sql:Error?> staffStream = db->query(`SELECT * FROM Staff WHERE title = "lecturer"`);
        return from Staff staff in staffStream
            select staff;
    }

    //Delete Lecturer by staffNumber (Patrick)
    resource isolated function delete lecturer/[string staffNumber]() returns http:NoContent|error
    {
        _ = check db->execute(`DELETE FROM Staff WHERE staffNumber = ${staffNumber}`);
        return http:NO_CONTENT;
    }

    //Retrieve all lecturers that teach a certain course(Linda)
    resource isolated function get staff/[string courseCode]() returns LecturerAndCourses[]|error
    {
        stream<LecturerAndCourses, sql:Error?> streamName = db->query(`SELECT
        Lecturer_Course.*,
        Staff.officeNumber,
        Staff.staffName,
        Courses.courseName,
        Courses.NQFLevel
        FROM Lecturer_Course
        INNER JOIN Staff ON Lecturer_Course.staffNumber = Staff.staffNumber
        INNER JOIN Courses ON Lecturer_Course.courseCode = Courses.courseCode
        WHERE
        Lecturer_Course.courseCode = ${courseCode}`);

        return from LecturerAndCourses staff in streamName
            select staff;
    };

    //addinfg a new lecturer(Linda)
    resource isolated function post lecturer(Staff lecture) returns Staff|error {
        do {
            _ = check db->execute(`insert into Staff(staffNumber, officeNumber, staffName, title)
                            values(${lecture.staffNumber}, ${lecture.officeNumber}, ${lecture.staffName}, ${lecture.title}`);
        } on fail var Linda {
            return error(Linda.message());
        }
        return lecture;
    }
}
