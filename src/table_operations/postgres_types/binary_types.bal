import ballerina/io;
import ballerina/java.jdbc;
import ballerina/sql;

public type BinaryRecord record{

    int ID;
    byte[] byteaType;//1400000

};


sql:BinaryValue binaryValue = new([5, 24, 56, 243, 24, 56, 243, 24, 56, 243, 24, 56, 243, 24, 56, 243, 24, 56, 243, 24, 56, 243, 24, 56, 243, 24, 56, 243]);




function BinaryTableProcess(jdbc:Client jdbcClient) {

    int|string|sql:Error? createResult  =  createBinaryTable(jdbcClient);
    sql:ExecutionResult|sql:Error? insertResult  =  binaryTableInsertions(jdbcClient);
    sql:Error? selectResult = binaryTableSelection(jdbcClient);

}




function createBinaryTable(jdbc:Client jdbcClient) returns int|string|sql:Error?{

    string tableName = "binaryTypes";

        CreateQueries createTableQuery = createQueryMaker({

            "ID": "SERIAL", 
            "byteaType":"bytea"    //Two types need to test. bytea hexa type and bytea escape type.
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


function binaryTableInsertions(jdbc:Client jdbcClient) returns sql:ExecutionResult|sql:Error?{

    sql:ExecutionResult|sql:Error? result;

    byte[] byteArray1 = [5, 24, 56, 243, 24, 56, 243, 24, 56, 243, 24, 56, 243, 24, 56, 243, 24, 56, 243, 24, 56, 243, 24, 56, 243, 24, 56, 243];

    byte[] byteArray2 = base16 `aeeecdefabcd12345567888822aeeecdefabcd12345567888822aeeecdefabcd12345567888822aeeecdefabcd12345567888822aeeecdefabcd12345567888822`;

    byte[] byteArray3 = base64 `aGVsbG8gYmFsbGVyaW5hICEhIQ==`;

     result = insertBinaryTable(jdbcClient,
    
        binaryValue

    );
    result = insertBinaryTable(jdbcClient,
    
        byteArray1

    );
    result = insertBinaryTable(jdbcClient,
    
        byteArray2

    );
    result = insertBinaryTable(jdbcClient,
    
        byteArray3

    );
    return result;

}

function insertBinaryTable(jdbc:Client jdbcClient , sql:BinaryValue|string|byte[] byteaType) returns sql:ExecutionResult|sql:Error?{
    // "byteaType":"bytea" 
   sql:ParameterizedQuery insertQuery =
            `INSERT INTO binaryTypes (
                byteaType
                            ) 
             VALUES (
                ${byteaType}
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


function binaryTableSelection(jdbc:Client jdbcClient, string columns = "*",string condition = "True") returns sql:Error?{
        // "byteaType":"bytea" 

     io:println("------ Start Query in Binary table-------");

    string selectionQuery = selecionQueryMaker("binaryTypes",columns,condition);
        stream<record{}, error> resultStream =
        jdbcClient->query(selectionQuery, BinaryRecord);

    // io:println(resultStream);

    stream<BinaryRecord, sql:Error> customerStream =
        <stream<BinaryRecord, sql:Error>>resultStream;

        // io:println(customerStream);
    
    error? e = customerStream.forEach(function(BinaryRecord rec) {
        io:println("\n");
        // io:println(rec);
        io:println(rec.byteaType);
        io:println("\n");
    });
    
    if (e is error) {
        io:println(e);
    }

    io:println("------ End Query in Binary table-------");


}