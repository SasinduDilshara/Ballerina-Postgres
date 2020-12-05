import ballerina/io;
import ballerina/java.jdbc;
import ballerina/sql;


public type complexR record{|
        float r;
        float i;
    |};

public type ComplexRecord record{
    
    int ID;
    
    // complexR complexType;
    string complexType;

    string inventoryType;

    
};



function compositeTableProcess(jdbc:Client jdbcClient) {

    int|string|sql:Error? createResult  =  createCompositeTable(jdbcClient);
    sql:ExecutionResult|sql:Error? insertResult  =  ComplexTableInsertions(jdbcClient);
    sql:Error? selectResult = complexTableSelection(jdbcClient);

}


function createCompositeTable(jdbc:Client jdbcClient) returns int|string|sql:Error?{

   string tableName = "complexTypes";

        CreateQueries createTableQuery = createQueryMaker({
            "ID": "SERIAL", 
            "complexType":"complex",
            "inventoryType":"inventory_item"
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

function ComplexTableInsertions(jdbc:Client jdbcClient) returns sql:ExecutionResult|sql:Error?{

    sql:ExecutionResult|sql:Error? result;
    result = insertComplexTable(jdbcClient,
    

        "(1.1,2.2)","(\"Name\",2,456.32)"
    );
    
    return result;

}

function insertComplexTable(jdbc:Client jdbcClient ,string|sql:StructValue complexType, string inventoryType) returns sql:ExecutionResult|sql:Error?{

            // "complexType":"complex",
            // "inventoryType":"inventory_item"
   sql:ParameterizedQuery insertQuery =
            `INSERT INTO complexTypes (
                complexType, inventoryType
                             ) 
             VALUES (
                ${complexType}::complex, ${inventoryType}::inventory_item
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

function complexTableSelection(jdbc:Client jdbcClient, string columns = "*",string condition = "True") returns sql:Error?{
            // "complexType":"complex",
            // "inventoryType":"inventory_item"
    io:println("------ Start Query in Complex table-------");

    string selectionQuery = selecionQueryMaker("complexTypes",columns,condition);

        selectionQuery = "select complexType::text , inventoryType::text from complexTypes";
        stream<record{}, error> resultStream =
        jdbcClient->query(selectionQuery, ComplexRecord);


    stream<ComplexRecord, sql:Error> customerStream =
        <stream<ComplexRecord, sql:Error>>resultStream;
    
    error? e = customerStream.forEach(function(ComplexRecord rec) {
        io:println("\n");
        io:println(rec);
        io:println(rec.complexType);
        io:println(rec.inventoryType);
        io:println("\n");
    });
    
    if (e is error) {
        io:println(e);
    }

    io:println("------ End Query in Complex table-------");


}
