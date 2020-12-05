import ballerina/io;
import ballerina/java.jdbc;
import ballerina/sql;


public type moneyRecord record{

    int ID;
    decimal moneyType;

};



function MoneyTableProcess(jdbc:Client jdbcClient) {

    int|string|sql:Error? createResult  =  createMoneyTable(jdbcClient);
    sql:ExecutionResult|sql:Error? insertResult  =  moneyTableInsertions(jdbcClient);
    sql:Error? selectResult = moneyTableSelection(jdbcClient);

}


function createMoneyTable(jdbc:Client jdbcClient) returns int|string|sql:Error?{

    string tableName = "moneyTypes";

        CreateQueries createTableQuery = createQueryMaker({

            "ID": "SERIAL", 
            "MoneyType":"money"
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




function moneyTableInsertions(jdbc:Client jdbcClient) returns sql:ExecutionResult|sql:Error?{

    sql:ExecutionResult|sql:Error? result;
    result = insertMoneyTable(jdbcClient,
    
    -92233720368547758.08

    );
    result = insertMoneyTable(jdbcClient,
    
        92233720368547758.07

    );
    return result;

}

function insertMoneyTable(jdbc:Client jdbcClient , decimal moneyType) returns sql:ExecutionResult|sql:Error?{
    // "MoneyType":"money"
   sql:ParameterizedQuery insertQuery =
            `INSERT INTO moneyTypes (
                moneyType              ) 
             VALUES (
                ${moneyType}
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


function moneyTableSelection(jdbc:Client jdbcClient, string columns = "*",string condition = "True") returns sql:Error?{
    // "MoneyType":"money"
     io:println("------ Start Query in money table-------");

    string selectionQuery = selecionQueryMaker("moneyTypes","ID, moneytype::numeric",condition);
        stream<record{}, error> resultStream =
        jdbcClient->query(selectionQuery, moneyRecord);

    // io:println(resultStream);

    stream<moneyRecord, sql:Error> customerStream =
        <stream<moneyRecord, sql:Error>>resultStream;

        // io:println(customerStream);

    error? e = customerStream.forEach(function(moneyRecord rec) {
        io:println(rec);
        io:println(rec.moneyType);
        
    });
    if (e is error) {
        io:println(e);
    }

    io:println("------ End Query in money table-------");


}