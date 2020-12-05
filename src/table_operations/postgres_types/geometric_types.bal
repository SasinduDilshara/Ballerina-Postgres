import ballerina/io;
import ballerina/java.jdbc;
import ballerina/sql;



public type GeometricRecord record{
    
    int ID;
    string pointType;
    string lineType;
    string lsegType;
    string boxType;
    string pathType;
    string polygonType;
    string circleType;

};


function geometricTableProcess(jdbc:Client jdbcClient) {

    int|string|sql:Error? createResult  =  createGeometricTable(jdbcClient);
    sql:ExecutionResult|sql:Error? insertResult  =  geometricTableInsertions(jdbcClient);
    sql:Error? selectResult = geometricTableSelection(jdbcClient);

}


function createGeometricTable(jdbc:Client jdbcClient) returns int|string|sql:Error?{

   string tableName = "geometricTypes";

        CreateQueries createTableQuery = createQueryMaker({
            "ID": "SERIAL", 
            "pointType":"point",
            "lineType":"line",
            "lsegType":"lseg",
            "boxType":"box",
            "pathType":"path",
            "polygonType":"polygon",
            "circleType":"circle"
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


function geometricTableInsertions(jdbc:Client jdbcClient) returns sql:ExecutionResult|sql:Error?{

    sql:ExecutionResult|sql:Error? result;
    result = insertGeometricTable(jdbcClient,
    
    "(1,2)", "{1,2,3}","[(1,2),(3,4)]","((1,2),(3,4))","((1,2),(3,4))","((1,2),(3,4))","((1,2),3)"

    );
    result = insertGeometricTable(jdbcClient,
    
    "(1,2)", "{1,2,3}","[(1,2),(3,4)]","((1,2),(3,4))","((1,2),(3,4))","((1,2),(3,4))","((1,2),3)"

    );
    
    return result;

}

function insertGeometricTable(jdbc:Client jdbcClient ,string pointType, string lineType, string lsegType, string boxType, string pathType, string polygonType, string circleType) returns sql:ExecutionResult|sql:Error?{
// "pointType":"point",
//             "lineType":"line",
//             "lsegType":"lseg",
//             "boxType":"box",
//             "pathType":"path",
//             "polygonType":"polygon",
//             "circleType":"circle"
   sql:ParameterizedQuery insertQuery =
            `INSERT INTO geometrictypes (
                pointType, lineType, lsegType, boxType, pathType, polygonType, circleType
                             ) 
             VALUES (
                ${pointType}::point, ${lineType}::line, ${lsegType}::lseg, ${boxType}::box, ${pathType}::path, ${polygonType}::polygon, ${circleType}::circle
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



function geometricTableSelection(jdbc:Client jdbcClient, string columns = "*",string condition = "True") returns sql:Error?{
// "pointType":"point",
//             "lineType":"line",
//             "lsegType":"lseg",
//             "boxType":"box",
//             "pathType":"path",
//             "polygonType":"polygon",
//             "circleType":"circle"
     io:println("------ Start Query in Geometric table-------");

    string selectionQuery = selecionQueryMaker("geometricTypes",columns,condition);

        stream<record{}, error> resultStream =
        jdbcClient->query(selectionQuery, GeometricRecord);


    stream<GeometricRecord, sql:Error> customerStream =
        <stream<GeometricRecord, sql:Error>>resultStream;
    
    error? e = customerStream.forEach(function(GeometricRecord rec) {
        io:println("\n");
        io:println(rec);
        io:println(rec.pointType);
        io:println(rec.lineType);
        io:println(rec.lsegType);
        io:println(rec.boxType);
        io:println(rec.pathType);
        io:println(rec.polygonType);
        io:println(rec.circleType);
        io:println("\n");
    });
    
    if (e is error) {
        io:println(e);
    }

    io:println("------ End Query in Geometric table-------");


}
