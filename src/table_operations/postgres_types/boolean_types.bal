import ballerina/io;
import ballerina/java.jdbc;
import ballerina/sql;



public type BooleanRecord record{
    
    int ID;
    boolean booleanType;

};


sql:BooleanValue booleanVaue = new(true);

function BooleanTableProcess(jdbc:Client jdbcClient) {

    int|string|sql:Error? createResult  =  createBooleanTable(jdbcClient);
    sql:ExecutionResult|sql:Error? insertResult  =  booleanTableInsertions(jdbcClient);
    sql:Error? selectResult = BooleanTableSelection(jdbcClient);

}

function createBooleanTable(jdbc:Client jdbcClient) returns int|string|sql:Error?{

    string tableName = "booleanTypes";

        CreateQueries createTableQuery = createQueryMaker({
            "ID": "SERIAL", 
            "booleanType":"boolean"
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



function booleanTableInsertions(jdbc:Client jdbcClient) returns sql:ExecutionResult|sql:Error?{

    sql:ExecutionResult|sql:Error? result;
    result = insertBooleanTimeTable(jdbcClient,
    
    booleanVaue

    );
    return result;

}

function insertBooleanTimeTable(jdbc:Client jdbcClient ,boolean|string|sql:BooleanValue booleanType) returns sql:ExecutionResult|sql:Error?{
    //         "booleanType":"boolean"
   sql:ParameterizedQuery insertQuery =
            `INSERT INTO booleantypes (
                booleanType
                             ) 
             VALUES (
                ${booleanType}
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


function BooleanTableSelection(jdbc:Client jdbcClient, string columns = "*",string condition = "True") returns sql:Error?{
    //         "booleanType":"boolean"
     io:println("------ Start Query in Boolean table-------");

    string selectionQuery = selecionQueryMaker("booleanTypes",columns,condition);

        stream<record{}, error> resultStream =
        jdbcClient->query(selectionQuery, BooleanRecord);


    stream<BooleanRecord, sql:Error> customerStream =
        <stream<BooleanRecord, sql:Error>>resultStream;
    
    error? e = customerStream.forEach(function(BooleanRecord rec) {
        io:println("\n");
        io:println(rec);
        io:println(rec.booleanType);
        io:println("\n");
    });
    
    if (e is error) {
        io:println(e);
    }

    io:println("------ End Query in Boolean table-------");


}
