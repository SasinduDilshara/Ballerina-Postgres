import ballerina/io;
import ballerina/java.jdbc;
import ballerina/sql;


string pointVal = "(1,2)";


function geometricTableProcess(jdbc:Client jdbcClient) {

    sql:ExecutionResult|sql:Error createResult  =  createGeometricProcedures(jdbcClient);
    sql:ProcedureCallResult|sql:Error callResult;

    //     callResult = geometricProcedureCall(jdbcClient,
    //     pointVal,pointVal
    // );


     sql:ExecutionResult|sql:Error selectResult = geometricTearDown(jdbcClient);

}




string geometricProcName = "geometrictest";
map<string> geoValues = {
    "pointInValue": "point","inout pointInOutValue":"point"
};
string geometricProcParameters = createParas(geoValues);
string dropGeometricProcParameters = createDrops(geoValues);

function createGeometricProcedures(jdbc:Client jdbcClient) returns sql:ExecutionResult|sql:Error{

    sql:ExecutionResult|sql:Error result;

    string query = createQuery(
        geometricProcName,
        geometricProcParameters,
        "select pointInValue into pointInOutValue;"
        
    );
    io:println(query);
    result = jdbcClient->execute(query);

    if(result is sql:ExecutionResult){
        io:println("Geometric Procedure is initialization Success");
        io:println(result);
        io:println("\n");
    }
    else{
        io:println("Geometric Procedure is initialization failed");
        io:println(result);
        io:println("\n");
    }


    return result;  

}

function geometricProcedureCall(jdbc:Client jdbcClient,
    string pointInput,        string pointInOut
    )  returns sql:ProcedureCallResult|sql:Error {

// ${inSmallInput} 


    sql:ProcedureCallResult|sql:Error result;

    sql:InOutParameter pointInOutId = new (pointInOut);
    
    sql:ParameterizedCallQuery callQuery =
            `call geometrictest(
                ${pointInput}::point,
                ${pointInOutId}              
            )`;
    

    result = jdbcClient->call(callQuery);

    if (result is sql:ProcedureCallResult) {
        io:println("\n");
        io:println(result);
        io:println("geometric value"," - ",pointInOutId.get(string));
        io:println("geometric procedure successfully created");
        io:println("\n");
    } 
    else{
        io:println("\nError ocurred while creating the geometric procedure\n");
        io:println(result);
        io:println("\n");
    }

    return result;      

}

function geometricTearDown(jdbc:Client jdbcClient) returns sql:ExecutionResult|sql:Error{

    sql:ExecutionResult|sql:Error result;


    string query = dropQuery(
        geometricProcName,
        dropGeometricProcParameters
    );
    io:println(query);
    result = jdbcClient->execute(query);

    if(result is sql:ExecutionResult){
        io:println("Geometric Procedure is drop Success");
        io:println(result);
        io:println("\n");
    }
    else{
        io:println("Geometric Procedure is drop failed");
        io:println(result);
        io:println("\n");
    }


    return result;  

}
