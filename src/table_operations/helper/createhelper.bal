
import ballerina/io;
import ballerina/java.jdbc;
// import ballerina/auth;
import ballerina/sql;
// import ballerina/time;

function initializeTable(jdbc:Client jdbcClient, string tableName,string createQuery) returns int|string|sql:Error? {

    sql:ExecutionResult result =  check jdbcClient->execute("DROP TABLE IF EXISTS "+tableName);

    io:println("Drop table executed. ", result);

    result = check jdbcClient->execute("CREATE TABLE IF NOT EXISTS " + tableName +" "+ createQuery);
    
    return result.affectedRowCount;


}


public function createQueryMaker(map<string> args, string primarykey) returns CreateQueries{

    io:println("Table create query initializing....");
    

    string createQuery = "";
    createQuery += "(";

    foreach var [name,datatype] in args.entries() {
    createQuery += name + " " + datatype+", ";
    }
    createQuery += "PRIMARY KEY("+primarykey+")";
    createQuery += ")";

    // string createQuery = "(customerId SERIAL, firstName VARCHAR(300),lastName VARCHAR(300), registrationID INTEGER, creditLimit real,country VARCHAR(300), PRIMARY KEY (customerId))";
    // string insertQuery = "(firstName,lastName,registrationID,creditLimit,country) VALUES ('Peter', 'Stuart', 1, 5000.71, 'USA')";

     CreateQueries result =  {
         createQuery
            };

    return result;

}



