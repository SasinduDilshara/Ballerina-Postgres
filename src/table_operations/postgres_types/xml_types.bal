import ballerina/io;
import ballerina/java.jdbc;
import ballerina/sql;


public type XmlRecord record{
    
    int ID;
    string xmlType;
};

function xmlTableProcess(jdbc:Client jdbcClient) {

    int|string|sql:Error? createResult  =  createXmlTable(jdbcClient);
    sql:ExecutionResult|sql:Error? insertResult  =  xmlTableInsertions(jdbcClient);
    sql:Error? selectResult = xmlTableSelection(jdbcClient);

}


function createXmlTable(jdbc:Client jdbcClient) returns int|string|sql:Error?{

   string tableName = "xmlTypes";

        CreateQueries createTableQuery = createQueryMaker({
            "ID": "SERIAL", 
            "xmlType":"xml"
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


function xmlTableInsertions(jdbc:Client jdbcClient) returns sql:ExecutionResult|sql:Error?{

    sql:ExecutionResult|sql:Error? result;
    
    result = insertXmlTable(jdbcClient,
    
     xml `<foo><tag>bar</tag><tag>tag</tag></foo>`

    );
    return result;

}

function insertXmlTable(jdbc:Client jdbcClient ,string|xml xmlType) returns sql:ExecutionResult|sql:Error?{

// "xmlType":"xml"
   sql:ParameterizedQuery insertQuery =
            `INSERT INTO xmlTypes (
                xmlType
                             ) 
             VALUES (
                ${xmlType}
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


function xmlTableSelection(jdbc:Client jdbcClient, string columns = "*",string condition = "True") returns sql:Error?{
// "xmlType":"xml"
     io:println("------ Start Query in Xml table-------");

    string selectionQuery = selecionQueryMaker("xmlTypes",columns,condition);

    selectionQuery = "select ID,xmlType::text from xmlTypes";

        stream<record{}, error> resultStream =
        jdbcClient->query(selectionQuery, XmlRecord);


    stream<XmlRecord, sql:Error> customerStream =
        <stream<XmlRecord, sql:Error>>resultStream;
    
    error? e = customerStream.forEach(function(XmlRecord rec) {
        io:println("\n");
        io:println(rec);
        io:println(rec.xmlType);
        io:println("\n");
    });
    
    if (e is error) {
        io:println(e);
    }

    io:println("------ End Query in Xml table-------");


}

