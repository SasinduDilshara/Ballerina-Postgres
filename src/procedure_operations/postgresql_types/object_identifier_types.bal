import ballerina/io;
import ballerina/java.jdbc;
import ballerina/sql;


// string oi1 = "564182";
int integerdata = 32767;


function objectidentifiersTableProcess(jdbc:Client jdbcClient) {

    sql:ExecutionResult|sql:Error createResult  =  createObjectidentifierProcedures(jdbcClient);
    sql:ProcedureCallResult|sql:Error callResult;

    callResult = objectidentifierProcedureCall(jdbcClient,
        integerdata,integerdata
    );
     sql:ExecutionResult|sql:Error teardownResult = objectidentifierTearDown(jdbcClient);

}




string objectidentifierProcName = "objectidentifiertest";
map<string> oiValues = {
    "oidInValue": "oid","inout oidInOutValue":"oid"
};
string objectidentifierProcParameters = createParas( oiValues);
string dropObjectidentifierProcParameters = createDrops( oiValues);

function createObjectidentifierProcedures(jdbc:Client jdbcClient) returns sql:ExecutionResult|sql:Error{

    sql:ExecutionResult|sql:Error result;

    string query = createQuery(
        objectidentifierProcName,
        objectidentifierProcParameters,
        "select oidInValue into oidInOutValue;"
        
    );
    io:println(query);
    result = jdbcClient->execute(query);

    if(result is sql:ExecutionResult){
        io:println("objectidentifier Procedure is initialization Success");
        io:println(result);
        io:println("\n");
    }
    else{
        io:println("objectidentifier Procedure is initialization failed");
        io:println(result);
        io:println("\n");
    }


    return result;  

}

function objectidentifierProcedureCall(jdbc:Client jdbcClient,
    int oidInput,        int oidInOut
    )  returns sql:ProcedureCallResult|sql:Error {

// ${inSmallInput} 


    sql:ProcedureCallResult|sql:Error result;

    sql:InOutParameter oidInOutId = new (oidInOut);
    
    sql:ParameterizedCallQuery callQuery =
            `call objectidentifiertest(
                ${oidInput},
                ${oidInOutId}              
            )`;
    

    result = jdbcClient->call(callQuery);

    if (result is sql:ProcedureCallResult) {
        io:println("\n");
        io:println(result);
        io:println("objectidentifier value"," - ",oidInOutId.get(int));
        io:println("objectidentifier procedure successfully created");
        io:println("\n");
    } 
    else{
        io:println("\nError ocurred while creating the objectidentifier procedure\n");
        io:println(result);
        io:println("\n");
    }

    return result;      

}

function objectidentifierTearDown(jdbc:Client jdbcClient) returns sql:ExecutionResult|sql:Error{

    sql:ExecutionResult|sql:Error result;


    string query = dropQuery(
        objectidentifierProcName,
        dropObjectidentifierProcParameters
    );
    io:println(query);
    result = jdbcClient->execute(query);

    if(result is sql:ExecutionResult){
        io:println("objectidentifier Procedure is drop Success");
        io:println(result);
        io:println("\n");
    }
    else{
        io:println("objectidentifier Procedure is drop failed");
        io:println(result);
        io:println("\n");
    }


    return result;  

}
