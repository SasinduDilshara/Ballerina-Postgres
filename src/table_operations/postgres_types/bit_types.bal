import ballerina/io;
import ballerina/java.jdbc;
import ballerina/sql;



public type BitRecord record{
    
    int ID;
    string bitType;
    string bitVaryType;
    string bitVaryType2;
    int bitOnlyType;
};




function bitTableProcess(jdbc:Client jdbcClient) {

    int|string|sql:Error? createResult  =  createBitTable(jdbcClient);
    sql:ExecutionResult|sql:Error? insertResult  =  BitTableInsertions(jdbcClient);
    sql:Error? selectResult = bitTableSelection(jdbcClient);

}



function createBitTable(jdbc:Client jdbcClient) returns int|string|sql:Error?{

   string tableName = "bitTypes";

        CreateQueries createTableQuery = createQueryMaker({
            "ID": "SERIAL", 
            "bitType":"bit(3)",
            "bitVaryType":"BIT VARYING(5)",
            "bitVaryType2":"BIT VARYING(7)",
            "bitOnlyType":"bit"
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



function BitTableInsertions(jdbc:Client jdbcClient) returns sql:ExecutionResult|sql:Error?{

    sql:ExecutionResult|sql:Error? result;

    sql:BitValue bit1Value = new(1);

    result = insertBitTable(jdbcClient,
    
    "111","11100","B100","B10"

    );
    return result;

}


function insertBitTable(jdbc:Client jdbcClient ,string bitType, string bitVaryType, string bitVaryType2, string bitOnlyType) returns sql:ExecutionResult|sql:Error?{
// "bitType":"bit(3)",
//             "bitVaryType":"BIT VARYING(5)",
//             "bitVaryType2":"BIT VARYING(7)",
//             "bitOnlyType":"bit"
   sql:ParameterizedQuery insertQuery =
            `INSERT INTO bitTypes (
                bitType, bitVaryType, bitVaryType2, bitOnlyType
                             ) 
             VALUES (
                ${bitType}::bit(3), ${bitVaryType}::BIT VARYING(5), ${bitVaryType2}::BIT VARYING(7), ${bitOnlyType} :: bit
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


function bitTableSelection(jdbc:Client jdbcClient, string columns = "*",string condition = "True") returns sql:Error?{
//             "bitType":"bit(3)",
//             "bitVaryType":"BIT VARYING(5)",
//             "bitVaryType2":"BIT VARYING(7)",
//             "bitOnlyType":"bit"
     io:println("------ Start Query in Bit table-------");

    string selectionQuery = "select ID,bitType::int,bitVaryType,bitVaryType2,bitOnlyType from bitTypes"; 

        stream<record{}, error> resultStream =
        jdbcClient->query(selectionQuery, BitRecord);


    stream<BitRecord, sql:Error> customerStream =
        <stream<BitRecord, sql:Error>>resultStream;
    
    error? e = customerStream.forEach(function(BitRecord rec) {
        io:println("\n");
        io:println(rec);
        io:println(rec.bitType);
        io:println(rec.bitVaryType);
        io:println(rec.bitVaryType2);
        io:println(rec.bitOnlyType);
        io:println("\n");
    });
    
    if (e is error) {
        io:println(e);
    }

    io:println("------ End Query in Bit table-------");


}

