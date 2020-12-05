import ballerina/io;
import ballerina/java.jdbc;
import ballerina/sql;


sql:BooleanValue booleanVaue = new(true);


function BooleanTableProcess(jdbc:Client jdbcClient) {

    sql:ExecutionResult|sql:Error createResult  =  createBooleanProcedures(jdbcClient);
    sql:ProcedureCallResult|sql:Error callResult;

       callResult = booleanProcedureCall(jdbcClient,
        booleanVaue,booleanVaue
    );


     sql:ExecutionResult|sql:Error selectResult = booleanTearDown(jdbcClient);

}




string booleanProcName = "booleantest";
map<string> boolValues = {
    "booleanInValue": "boolean","inout booleanInOutValue":"boolean"
};
string booleanProcParameters = createParas(boolValues);
string dropBooleanProcParameters = createDrops(boolValues);

function createBooleanProcedures(jdbc:Client jdbcClient) returns sql:ExecutionResult|sql:Error{

    sql:ExecutionResult|sql:Error result;

    string query = createQuery(
        booleanProcName,
        booleanProcParameters,
        "select booleanInValue into booleanInOutValue;"
        
    );
    io:println(query);
    result = jdbcClient->execute(query);

    if(result is sql:ExecutionResult){
        io:println("Boolean Procedure is initialization Success");
        io:println(result);
        io:println("\n");
    }
    else{
        io:println("Boolean Procedure is initialization failed");
        io:println(result);
        io:println("\n");
    }


    return result;  

}

function booleanProcedureCall(jdbc:Client jdbcClient,
    sql:BooleanValue booleanInput,        sql:BooleanValue booleanInOut
    )  returns sql:ProcedureCallResult|sql:Error {

// ${inSmallInput} 


    sql:ProcedureCallResult|sql:Error result;

    sql:InOutParameter booleanInOutId = new (booleanInOut);
    
    sql:ParameterizedCallQuery callQuery =
            `call booleantest(
                ${booleanInput},
                ${booleanInOutId}              
            )`;
    

    result = jdbcClient->call(callQuery);

    if (result is sql:ProcedureCallResult) {
        io:println("\n");
        io:println(result);
        io:println("boolean value"," - ",booleanInOutId.get(string));
        io:println("boolean value"," - ",booleanInOutId.get(int));
        io:println("boolean value"," - ",booleanInOutId.get(boolean));
        io:println("boolean procedure successfully created");
        io:println("\n");
    } 
    else{
        io:println("\nError ocurred while creating the Boolean procedure\n");
        io:println(result);
        io:println("\n");
    }

    return result;      

}

function booleanTearDown(jdbc:Client jdbcClient) returns sql:ExecutionResult|sql:Error{

    sql:ExecutionResult|sql:Error result;


    string query = dropQuery(
        booleanProcName,
        dropBooleanProcParameters
    );
    io:println(query);
    result = jdbcClient->execute(query);

    if(result is sql:ExecutionResult){
        io:println("Boolean Procedure is drop Success");
        io:println(result);
        io:println("\n");
    }
    else{
        io:println("Boolean Procedure is drop failed");
        io:println(result);
        io:println("\n");
    }


    return result;  

}
