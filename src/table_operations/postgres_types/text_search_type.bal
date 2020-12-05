import ballerina/io;
import ballerina/java.jdbc;
import ballerina/sql;



public type TextSearchRecord record{
    
    int ID;
    string tsvectorType;
    byte[] tsqueryType;
};



function textsearchTableProcess(jdbc:Client jdbcClient) {

    int|string|sql:Error? createResult  =  createTextSearchTable(jdbcClient);
    sql:ExecutionResult|sql:Error? insertResult  =  textSearchTableInsertions(jdbcClient);
    sql:Error? selectResult = textsearchTableSelection(jdbcClient);

}


function createTextSearchTable(jdbc:Client jdbcClient) returns int|string|sql:Error?{

   string tableName = "textSearchTypes";

        CreateQueries createTableQuery = createQueryMaker({
            "ID": "SERIAL", 
            "tsvectorType":"tsvector",
            "tsqueryType":"tsquery"
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

function textSearchTableInsertions(jdbc:Client jdbcClient) returns sql:ExecutionResult|sql:Error?{

    sql:ExecutionResult|sql:Error? result;
    result = insertTextSearchTable(jdbcClient,
    
    "a fat cat sat on a mat and ate a fat rat","fat & rat"

    );
    result = insertTextSearchTable(jdbcClient,
    
        "a fat cat sat on a mat and ate a fat rat","fat & rat"

    );
    return result;

}

function insertTextSearchTable(jdbc:Client jdbcClient ,string tsvectorType, string tsqueryType) returns sql:ExecutionResult|sql:Error?{

// "tsvectorType":"tsvector",
//             "tsqueryType":"tsquery"
   sql:ParameterizedQuery insertQuery =
            `INSERT INTO textSearchTypes (
                tsvectorType, tsqueryType
                             ) 
             VALUES (
                ${tsvectorType}::tsvector, ${tsqueryType}::tsquery
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

function textsearchTableSelection(jdbc:Client jdbcClient, string columns = "*",string condition = "True") returns sql:Error?{
//             "tsvectorType":"tsvector",
//             "tsqueryType":"tsquery"
     io:println("------ Start Query in TextSearch table-------");

    string selectionQuery = selecionQueryMaker("textsearchTypes",columns,condition);


        stream<record{}, error> resultStream =
        jdbcClient->query(selectionQuery, TextSearchRecord);


    stream<TextSearchRecord, sql:Error> customerStream =
        <stream<TextSearchRecord, sql:Error>>resultStream;
    
    error? e = customerStream.forEach(function(TextSearchRecord rec) {
        io:println("\n");
        io:println(rec);
        io:println(rec.tsvectorType);
        io:println(rec.tsqueryType);
        io:println("\n");
    });
    
    if (e is error) {
        io:println(e);
    }

    io:println("------ End Query in TextSearch table-------");


}

