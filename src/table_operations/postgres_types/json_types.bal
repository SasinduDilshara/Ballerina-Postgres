import ballerina/io;
import ballerina/java.jdbc;
import ballerina/sql;

public type JsonRecord record{
    
    int ID;
    json jsonType;
    json jsonbType;
    string jsonpathType;
};

function jsonTableProcess(jdbc:Client jdbcClient) {

    int|string|sql:Error? createResult  =  createJsonTable(jdbcClient);
    sql:ExecutionResult|sql:Error? insertResult  =  JsonTableInsertions(jdbcClient);
    sql:Error? selectResult = jsonTableSelection(jdbcClient);

}


function createJsonTable(jdbc:Client jdbcClient) returns int|string|sql:Error?{

   string tableName = "jsonTypes";

        CreateQueries createTableQuery = createQueryMaker({
            "ID": "SERIAL", 
            "jsonType":"json",
            "jsonbType":"jsonb",
            "jsonpathType":"jsonpath"
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


function JsonTableInsertions(jdbc:Client jdbcClient) returns sql:ExecutionResult|sql:Error?{

    sql:ExecutionResult|sql:Error? result;
    result = insertJsonTable(jdbcClient,
    
     "{\"bar\": \"baz\", \"balance\": 7.77, \"active\":false}", "{\"bar\": \"baz\", \"balance\": 7.77, \"active\":false}","$.floor[*].apt[*] ? (@.area > 40 && @.area < 90) ? (@.rooms > 2)"

    );
    result = insertJsonTable(jdbcClient,
    
      "{\"bar\": \"baz\", \"balance\": 7.77, \"active\":false}", "{\"bar\": \"baz\", \"balance\": 7.77, \"active\":false}","$.floor[*].apt[*] ? (@.area > 40 && @.area < 90) ? (@.rooms > 2)"  

    );
    return result;

}

function insertJsonTable(jdbc:Client jdbcClient ,string jsonType, string jsonbType, string jsonPathType) returns sql:ExecutionResult|sql:Error?{

// "ID": "SERIAL", 
//             "jsonType":"json",
//             "jsonbType":"jsonb",
//             "jsonpathType":"jsonpath"
   sql:ParameterizedQuery insertQuery =
            `INSERT INTO jsonTypes (
                jsonType, jsonbType, jsonPathType
                             ) 
             VALUES (
                ${jsonType}:: json, ${jsonbType}:: jsonb, ${jsonPathType}:: jsonpath 
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


function jsonTableSelection(jdbc:Client jdbcClient, string columns = "*",string condition = "True") returns sql:Error?{
//             "jsonType":"json",
//             "jsonbType":"jsonb",
//             "jsonpathType":"jsonpath"
     io:println("------ Start Query in Json table-------");

    string selectionQuery = selecionQueryMaker("jsonTypes",columns,condition);


        stream<record{}, error> resultStream =
        jdbcClient->query(selectionQuery, JsonRecord);


    stream<JsonRecord, sql:Error> customerStream =
        <stream<JsonRecord, sql:Error>>resultStream;
    
    error? e = customerStream.forEach(function(JsonRecord rec) {
        io:println("\n");
        io:println(rec);
        io:println(rec.jsonType);
        io:println(rec.jsonbType);
        io:println(rec.jsonpathType);
        io:println("\n");
    });
    
    if (e is error) {
        io:println(e);
    }

    io:println("------ End Query in Json table-------");


}

