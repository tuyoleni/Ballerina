import ballerina/graphql;
import ballerinax/mysql;

//  ----------------------------------------------------------------    Connecting to the database

final mysql:Client libraryClient = check new (
    host = "localhost",
    user = "user", password = "password",
    port = 3306,
    database = "ballerina"
);
