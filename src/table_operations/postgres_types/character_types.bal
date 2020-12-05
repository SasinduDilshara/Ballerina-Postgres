import ballerina/io;
import ballerina/java.jdbc;
import ballerina/sql;


public type characterRecord record{

    int ID;
    string charType;
    string varcharType;
    string textType;
    string nameType;
    string charWithoutLengthType;

};


sql:CharValue charValue = new("Test Char Value");
sql:VarcharValue varcharValue = new("Test VarChar Value");
sql:TextValue textValue = new("Test Text Value");
sql:TextValue nameValue = new("Test Name Value");
sql:CharValue charValue2 = new("1");


function CharacterTableProcess(jdbc:Client jdbcClient) {

    int|string|sql:Error? createResult  =  createCharacterTable(jdbcClient);
    sql:ExecutionResult|sql:Error? insertResult  =  characterTableInsertions(jdbcClient);
    sql:Error? selectResult = characterTableSelection(jdbcClient);

}


function createCharacterTable(jdbc:Client jdbcClient) returns int|string|sql:Error?{

    string tableName = "charTypes";

        CreateQueries createTableQuery = createQueryMaker({

            "ID": "SERIAL", 
            "charType":"char(200)",
            "varcharType":"varchar(10485760)",
            "textType":"text",
            "nameType":"name",
            "charWithoutLengthType": "char"
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



function characterTableInsertions(jdbc:Client jdbcClient) returns sql:ExecutionResult|sql:Error?{

    sql:ExecutionResult|sql:Error? result;
    result = insertCharacterTable(jdbcClient,
    
    charValue,varcharValue,
    textValue,
    nameValue,
    charValue2

    );
    return result;

}

function insertCharacterTable(jdbc:Client jdbcClient , sql:CharValue charType, sql:VarcharValue varcharType, sql:TextValue textType, sql:TextValue nameType, sql:CharValue charWithoutLengthType) returns sql:ExecutionResult|sql:Error?{
    //         "charType":"char(10485760)",
    //         "varcharType":"varchar(10485760)",
    //         "textType":"text",
    //         "nameType":"name",
    //         "charWithoutLengthType": "char"
   sql:ParameterizedQuery insertQuery =
            `INSERT INTO charTypes (
                charType, varcharType, textType, nameType, charWithoutLengthType              ) 
             VALUES (
                ${charType}, ${varcharType}, ${textType}, ${nameType}, ${charWithoutLengthType}
            )`;
    

    sql:ExecutionResult|sql:Error result = jdbcClient->execute(insertQuery);

    if (result is sql:ExecutionResult) {
        io:println("\nInsert success, generated Id: ", result.lastInsertId);
    } 
    else{
        io:println("\nError ocurred while insert to character table\n");
        io:println(result);
        io:println("\n");
    }
    
    return result;
        

}

function characterTableSelection(jdbc:Client jdbcClient, string columns = "*",string condition = "True") returns sql:Error?{
    //         "charType":"char(10)",
    //         "varcharType":"varchar(10)",
    //         "textType":"text",
    //         "nameType":"name",
    //         "charWithoutLengthType": "char"
     io:println("------ Start Query in character table-------");

    string selectionQuery = selecionQueryMaker("charTypes",columns,condition);
        stream<record{}, error> resultStream =
        jdbcClient->query(selectionQuery, characterRecord);

    // io:println(resultStream);

    stream<characterRecord, sql:Error> customerStream =
        <stream<characterRecord, sql:Error>>resultStream;

        // io:println(customerStream);
    
    error? e = customerStream.forEach(function(characterRecord rec) {
        io:println("\n");
        io:println(rec);
        io:println(rec.charType);
        io:println(rec.varcharType);
        io:println(rec.textType);
        io:println(rec.nameType);
        io:println(rec.charWithoutLengthType);
        io:println("\n");
    });
    
    if (e is error) {
        io:println(e);
    }

    io:println("------ End Query in character table-------");


}