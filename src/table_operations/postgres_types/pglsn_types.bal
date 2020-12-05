import ballerina/io;
import ballerina/java.jdbc;
import ballerina/sql;



public type PglsnRecord record{
    
    int ID;
    string pglsnType;
};




function pglsnTableProcess(jdbc:Client jdbcClient) {

    int|string|sql:Error? createResult  =  createPglsnTable(jdbcClient);
    sql:ExecutionResult|sql:Error? insertResult  =  pslgnTableInsertions(jdbcClient);
    sql:Error? selectResult = pglsnTableSelection(jdbcClient);

}



function createPglsnTable(jdbc:Client jdbcClient) returns int|string|sql:Error?{

   string tableName = "pglsnTypes";

        CreateQueries createTableQuery = createQueryMaker({
            "ID": "SERIAL", 
            "pglsnType" : "pg_lsn"
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



function pslgnTableInsertions(jdbc:Client jdbcClient) returns sql:ExecutionResult|sql:Error?{

    sql:ExecutionResult|sql:Error? result;
    result = insertPslgnTable(jdbcClient,
    
        "16/B374D848"

    );
    result = insertPslgnTable(jdbcClient,
    
        "16/B374D848"

    );
    return result;

}

function insertPslgnTable(jdbc:Client jdbcClient ,string pglsnType) returns sql:ExecutionResult|sql:Error?{

            // "pglsnType" : "pg_lsn"
   sql:ParameterizedQuery insertQuery =
            `INSERT INTO pglsnTypes (
                pglsnType
                             ) 
             VALUES (
                ${pglsnType}::pg_lsn
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





function pglsnTableSelection(jdbc:Client jdbcClient, string columns = "*",string condition = "True") returns sql:Error?{
// "pglsnType" : "pg_lsn"
     io:println("------ Start Query in Pglsn table-------");

    string selectionQuery = selecionQueryMaker("pglsnTypes",columns,condition);


        stream<record{}, error> resultStream =
        jdbcClient->query(selectionQuery, PglsnRecord);


    stream<PglsnRecord, sql:Error> customerStream =
        <stream<PglsnRecord, sql:Error>>resultStream;
    
    error? e = customerStream.forEach(function(PglsnRecord rec) {
        io:println("\n");
        io:println(rec);
        io:println(rec.pglsnType);
        io:println("\n");
    });
    
    if (e is error) {
        io:println(e);
    }

    io:println("------ End Query in Pglsn table-------");


}

