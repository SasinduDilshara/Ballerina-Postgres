import ballerina/io;
import ballerina/java.jdbc;
import ballerina/sql;


decimal[] arr = [1.1,2.1,0.113,4.1];
sql:ArrayValue arrVal = new(arr);


function arrayTableProcess(jdbc:Client jdbcClient) {

    sql:ExecutionResult|sql:Error createResult  =  createArrayProcedures(jdbcClient);
    sql:ProcedureCallResult|sql:Error callResult;

    callResult = arrayProcedureCall(jdbcClient,
        arrVal,arrVal
    );
     sql:ExecutionResult|sql:Error teardownResult = arrayTearDown(jdbcClient);

}



string arrayProcName = "arraytest";
map<string> arrayValues = {
    "arrayInValue": "double precision[]","inout arrayInOutValue":"double precision[]"
};
string arrayProcParameters = createParas( arrayValues);
string dropArrayProcParameters = createDrops( arrayValues);

function createArrayProcedures(jdbc:Client jdbcClient) returns sql:ExecutionResult|sql:Error{

    sql:ExecutionResult|sql:Error result;

    string query = createQuery(
        arrayProcName,
        arrayProcParameters,
        "select arrayInValue into arrayInOutValue;"
        
    );
    io:println(query);
    result = jdbcClient->execute(query);

    if(result is sql:ExecutionResult){
        io:println("array Procedure is initialization Success");
        io:println(result);
        io:println("\n");
    }
    else{
        io:println("array Procedure is initialization failed");
        io:println(result);
        io:println("\n");
    }


    return result;  

}

// public type arrayGet record {
    
// };

function arrayProcedureCall(jdbc:Client jdbcClient,
    sql:ArrayValue arrayInput,        sql:ArrayValue arrayInOut
    )  returns sql:ProcedureCallResult|sql:Error {


    sql:ProcedureCallResult|sql:Error result;

    sql:InOutParameter arrayInOutId = new (arrayInOut);
    
    sql:ParameterizedCallQuery callQuery =
            `call arraytest(
                ${arrayInput},
                ${arrayInOutId}              
            )`;
    

    result = jdbcClient->call(callQuery);

    if (result is sql:ProcedureCallResult) {
        io:println("\n");
        io:println(result);
        // io:println("array value"," - ",arrayInOutId.get(string));
        io:println("array value"," - ",arrayInOutId);
        io:println("array procedure successfully created");
        io:println("\n");
    } 
    else{
        io:println("\nError ocurred while creating the array procedure\n");
        io:println(result);
        io:println("\n");
    }

    return result;      

}

function arrayTearDown(jdbc:Client jdbcClient) returns sql:ExecutionResult|sql:Error{

    sql:ExecutionResult|sql:Error result;


    string query = dropQuery(
        arrayProcName,
        dropArrayProcParameters
    );
    io:println(query);
    result = jdbcClient->execute(query);

    if(result is sql:ExecutionResult){
        io:println("array Procedure is drop Success");
        io:println(result);
        io:println("\n");
    }
    else{
        io:println("array Procedure is drop failed");
        io:println(result);
        io:println("\n");
    }


    return result;  

}