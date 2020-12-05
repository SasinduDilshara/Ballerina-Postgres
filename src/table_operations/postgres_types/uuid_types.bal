import ballerina/io;
import ballerina/java.jdbc;
import ballerina/sql;


public type UuidRecord record{
    
    int ID;
    string uuidType;
};

function uuidTableProcess(jdbc:Client jdbcClient) {

    int|string|sql:Error? createResult  =  createUuidTable(jdbcClient);
    sql:ExecutionResult|sql:Error? insertResult  =  UUIDTableInsertions(jdbcClient);
    sql:Error? selectResult = uuidTableSelection(jdbcClient);

}



function createUuidTable(jdbc:Client jdbcClient) returns int|string|sql:Error?{

   string tableName = "uuidTypes";

        CreateQueries createTableQuery = createQueryMaker({
            "ID": "SERIAL", 
            "uuidType":"uuid"
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



function UUIDTableInsertions(jdbc:Client jdbcClient) returns sql:ExecutionResult|sql:Error?{

    sql:ExecutionResult|sql:Error? result;
    result = insertUUIDTable(jdbcClient,
    
    "A0EEBC99-9C0B-4EF8-BB6D-6BB9BD380A11"

    );
    result = insertUUIDTable(jdbcClient,
    
        "{a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11}"

    );
    result = insertUUIDTable(jdbcClient,
    
    "a0eebc999c0b4ef8bb6d6bb9bd380a11"

    );
    result = insertUUIDTable(jdbcClient,
    
        "a0ee-bc99-9c0b-4ef8-bb6d-6bb9-bd38-0a11"

    );
    result = insertUUIDTable(jdbcClient,
    
        "{a0eebc99-9c0b4ef8-bb6d6bb9-bd380a11}"

    );
    result = insertUUIDTable(jdbcClient,
    
        "a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11"

    );
    return result;

}

function insertUUIDTable(jdbc:Client jdbcClient ,string uuidType) returns sql:ExecutionResult|sql:Error?{

// "uuidType":"uuid"
   sql:ParameterizedQuery insertQuery =
            `INSERT INTO uuidTypes (
                uuidType
                             ) 
             VALUES (
                ${uuidType}::uuid
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

function uuidTableSelection(jdbc:Client jdbcClient, string columns = "*",string condition = "True") returns sql:Error?{
// "uuidType":"uuid"
     io:println("------ Start Query in Uuid table-------");

    string selectionQuery = selecionQueryMaker("uuidTypes",columns,condition);


        stream<record{}, error> resultStream =
        jdbcClient->query(selectionQuery, UuidRecord);


    stream<UuidRecord, sql:Error> customerStream =
        <stream<UuidRecord, sql:Error>>resultStream;
    
    error? e = customerStream.forEach(function(UuidRecord rec) {
        io:println("\n");
        io:println(rec);
        io:println(rec.uuidType);
        io:println("\n");
    });
    
    if (e is error) {
        io:println(e);
    }

    io:println("------ End Query in Uuid table-------");


}
