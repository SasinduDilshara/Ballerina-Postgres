import ballerina/io;
import ballerina/java.jdbc;
import ballerina/sql;


string uid = "A0EEBC99-9C0B-4EF8-BB6D-6BB9BD380A11";


function uuidTableProcess(jdbc:Client jdbcClient) {

    sql:ExecutionResult|sql:Error createResult  =  createUuidProcedures(jdbcClient);
    sql:ProcedureCallResult|sql:Error callResult;


    // callResult = uuidProcedureCall(jdbcClient,
    //     uid,uid
    // );

     sql:ExecutionResult|sql:Error teardownResult = uuidTearDown(jdbcClient);

}





string uuidProcName = "uuidtest";
map<string> uidValues = {
    "uuidInValue": "uuid","inout uuidInOutValue":"uuid"
};
string uuidProcParameters = createParas( uidValues);
string dropUuidProcParameters = createDrops( uidValues);

function createUuidProcedures(jdbc:Client jdbcClient) returns sql:ExecutionResult|sql:Error{

    sql:ExecutionResult|sql:Error result;

    string query = createQuery(
        uuidProcName,
        uuidProcParameters,
        "select uuidInValue into uuidInOutValue;"
        
    );
    io:println(query);
    result = jdbcClient->execute(query);

    if(result is sql:ExecutionResult){
        io:println("uuid Procedure is initialization Success");
        io:println(result);
        io:println("\n");
    }
    else{
        io:println("uuid Procedure is initialization failed");
        io:println(result);
        io:println("\n");
    }


    return result;  

}

function uuidProcedureCall(jdbc:Client jdbcClient,
    string uuidInput,        string uuidInOut
    )  returns sql:ProcedureCallResult|sql:Error {

// ${inSmallInput} 


    sql:ProcedureCallResult|sql:Error result;

    sql:InOutParameter uuidInOutId = new (uuidInOut);
    
    sql:ParameterizedCallQuery callQuery =
            `call uuidtest(
                ${uuidInput}::uuid,
                ${uuidInOutId}              
            )`;
    

    result = jdbcClient->call(callQuery);

    if (result is sql:ProcedureCallResult) {
        io:println("\n");
        io:println(result);
        io:println("uuid value"," - ",uuidInOutId.get(string));
        io:println("uuid procedure successfully created");
        io:println("\n");
    } 
    else{
        io:println("\nError ocurred while creating the uuid procedure\n");
        io:println(result);
        io:println("\n");
    }

    return result;      

}


function uuidTearDown(jdbc:Client jdbcClient) returns sql:ExecutionResult|sql:Error{

    sql:ExecutionResult|sql:Error result;


    string query = dropQuery(
        uuidProcName,
        dropUuidProcParameters
    );
    io:println(query);
    result = jdbcClient->execute(query);

    if(result is sql:ExecutionResult){
        io:println("uuid Procedure is drop Success");
        io:println(result);
        io:println("\n");
    }
    else{
        io:println("uuid Procedure is drop failed");
        io:println(result);
        io:println("\n");
    }


    return result;  

}