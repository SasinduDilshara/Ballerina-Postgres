import ballerina/io;
import ballerina/java.jdbc;
import ballerina/sql;



public type EnumRecord record{
    
    int ID;
    string enumType;

};

function EnumTableProcess(jdbc:Client jdbcClient) {

    int|string|sql:Error? createResult  =  createEnumTable(jdbcClient);
    sql:ExecutionResult|sql:Error? insertResult  =  enumTableInsertions(jdbcClient);
    sql:Error? selectResult = enumTableSelection(jdbcClient);

}


function createEnumTable(jdbc:Client jdbcClient) returns int|string|sql:Error?{

   string tableName = "enumTypes";

        CreateQueries createTableQuery = createQueryMaker({
            "ID": "SERIAL", 
            "enumType":"enumValues"
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





function enumTableInsertions(jdbc:Client jdbcClient) returns sql:ExecutionResult|sql:Error?{

    sql:ExecutionResult|sql:Error? result;
    result = insertEnumTable(jdbcClient,
    
    "value1"

    );
    result = insertEnumTable(jdbcClient,
    
        "value2"

    );
    return result;

}

function insertEnumTable(jdbc:Client jdbcClient ,string enumType) returns sql:ExecutionResult|sql:Error?{
// "enumType":"enumValues"
   sql:ParameterizedQuery insertQuery =
            `INSERT INTO enumTypes (
                enumType
                             ) 
             VALUES (
                ${enumType}::enumvalues
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

function enumTableSelection(jdbc:Client jdbcClient, string columns = "*",string condition = "True") returns sql:Error?{
// "enumType":"enumValues"
     io:println("------ Start Query in Enum table-------");

    string selectionQuery = selecionQueryMaker("enumTypes",columns,condition);

        stream<record{}, error> resultStream =
        jdbcClient->query(selectionQuery, EnumRecord);


    stream<EnumRecord, sql:Error> customerStream =
        <stream<EnumRecord, sql:Error>>resultStream;
    
    error? e = customerStream.forEach(function(EnumRecord rec) {
        io:println("\n");
        io:println(rec);
        io:println(rec.enumType);
        io:println("\n");
    });
    
    if (e is error) {
        io:println(e);
    }

    io:println("------ End Query in Enum table-------");


}
