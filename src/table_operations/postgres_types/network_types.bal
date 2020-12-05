import ballerina/io;
import ballerina/java.jdbc;
import ballerina/sql;


public type NetworkRecord record{
    
    int ID;
    string inetType;
    string cidrType;
    string macaddrType;
    string macaddr8Type;
};




function networkTableProcess(jdbc:Client jdbcClient) {

    int|string|sql:Error? createResult  =  createNetworkTable(jdbcClient);
    sql:ExecutionResult|sql:Error? insertResult  =  networkTableInsertions(jdbcClient);
    sql:Error? selectResult = networkTableSelection(jdbcClient);

}




function createNetworkTable(jdbc:Client jdbcClient) returns int|string|sql:Error?{

   string tableName = "networkTypes";

        CreateQueries createTableQuery = createQueryMaker({
            "ID": "SERIAL", 
            "inetType":"inet",
            "cidrType":"cidr",
            "macaddrType":"macaddr",
            "macaddr8Type":"macaddr8"
        },"ID");

        int|string|sql:Error? initResult = initializeTable(jdbcClient, tableName , createTableQuery.createQuery);
        if (initResult is int) {
            io:println("Sample executed successfully!");
        } 
        else if (initResult is sql:Error) {
            io:println("Customer table initialization failed: ", initResult);
    }

    return initResult;

}



function networkTableInsertions(jdbc:Client jdbcClient) returns sql:ExecutionResult|sql:Error?{

    sql:ExecutionResult|sql:Error? result;
    result = insertNetworkTable(jdbcClient,
    
    "192.168.0.1/24","::ffff:1.2.3.0/120","08:00:2b:01:02:03","08-00-2b-01-02-03-04-05"

    );
    result = insertNetworkTable(jdbcClient,
    
        "192.168.0.1/24","::ffff:1.2.3.0/120","08:00:2b:01:02:03","08-00-2b-01-02-03-04-05"

    );
    return result;

}

function insertNetworkTable(jdbc:Client jdbcClient ,string inetType, string cidrType, string macaddrType, string macaddr8Type) returns sql:ExecutionResult|sql:Error?{
// "inetType":"inet",
//             "cidrType":"cidr",
//             "macaddrType":"macaddr",
//             "macaddr8Type":"macaddr8"
   sql:ParameterizedQuery insertQuery =
            `INSERT INTO networkTypes (
                inetType, cidrType, macaddrType, macaddr8Type
                             ) 
             VALUES (
                ${inetType}::inet, ${cidrType}::cidr, ${macaddrType}::macaddr, ${macaddr8Type}::macaddr8
            )`;
    

    sql:ExecutionResult|sql:Error result = jdbcClient->execute(insertQuery);

    if (result is sql:ExecutionResult) {
        io:println("\nInsert success, generated Id: ", result.lastInsertId);
    } 
    else{
        io:println("\nError ocurred while insert to numeric table\n");
        io:println(result);
        io:println("\n");
    }
    
    return result;
        

}

function networkTableSelection(jdbc:Client jdbcClient, string columns = "*",string condition = "True") returns sql:Error?{
//             "inetType":"inet",
//             "cidrType":"cidr",
//             "macaddrType":"macaddr",
//             "macaddr8Type":"macaddr8"
     io:println("------ Start Query in Network table-------");

    string selectionQuery = selecionQueryMaker("networkTypes",columns,condition);

        stream<record{}, error> resultStream =
        jdbcClient->query(selectionQuery, NetworkRecord);


    stream<NetworkRecord, sql:Error> customerStream =
        <stream<NetworkRecord, sql:Error>>resultStream;
    
    error? e = customerStream.forEach(function(NetworkRecord rec) {
        io:println("\n");
        io:println(rec);
        io:println(rec.inetType);
        io:println(rec.cidrType);
        io:println(rec.macaddrType);
        io:println(rec.macaddr8Type);
        io:println("\n");
    });
    
    if (e is error) {
        io:println(e);
    }

    io:println("------ End Query in Network table-------");


}