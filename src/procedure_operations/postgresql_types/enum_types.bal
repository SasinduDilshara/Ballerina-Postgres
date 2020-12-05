import ballerina/io;
import ballerina/java.jdbc;
import ballerina/sql;


string enVal = "value1";


function EnumTableProcess(jdbc:Client jdbcClient) {

    sql:ExecutionResult|sql:Error createResult  =  createEnumProcedures(jdbcClient);
    sql:ProcedureCallResult|sql:Error callResult;

       callResult = enumProcedureCall(jdbcClient,
        enVal,enVal
    );


     sql:ExecutionResult|sql:Error selectResult = enumTearDown(jdbcClient);

}



string enumProcName = "enumtest";
map<string> enumValues = {
    "enumValuesInValue": "enumValues","inout enumValuesInOutValue":"enumValues"
};
string enumProcParameters = createParas( enumValues);
string dropEnumProcParameters = createDrops( enumValues);

function createEnumProcedures(jdbc:Client jdbcClient) returns sql:ExecutionResult|sql:Error{

    sql:ExecutionResult|sql:Error result;

    string query = createQuery(
        enumProcName,
        enumProcParameters,
        "select enumValuesInValue into enumValuesInOutValue;"
        
    );
    io:println(query);
    result = jdbcClient->execute(query);

    if(result is sql:ExecutionResult){
        io:println("enum Procedure is initialization Success");
        io:println(result);
        io:println("\n");
    }
    else{
        io:println("enum Procedure is initialization failed");
        io:println(result);
        io:println("\n");
    }


    return result;  

}

function enumProcedureCall(jdbc:Client jdbcClient,
    string enumValuesInput,        string enumValuesInOut
    )  returns sql:ProcedureCallResult|sql:Error {

// ${inSmallInput} 


    sql:ProcedureCallResult|sql:Error result;

    sql:InOutParameter enumValuesInOutId = new (enumValuesInOut);
    
    sql:ParameterizedCallQuery callQuery =
            `call enumtest(
                ${enumValuesInput}::enumvalues,
                ${enumValuesInOutId}::enumvalues              
            )`;
    

    result = jdbcClient->call(callQuery);

    if (result is sql:ProcedureCallResult) {
        io:println("\n");
        io:println(result);
        io:println("enum value"," - ",enumValuesInOutId.get(string));
        io:println("enum procedure successfully created");
        io:println("\n");
    } 
    else{
        io:println("\nError ocurred while creating the enum procedure\n");
        io:println(result);
        io:println("\n");
    }

    return result;      

}

function enumTearDown(jdbc:Client jdbcClient) returns sql:ExecutionResult|sql:Error{

    sql:ExecutionResult|sql:Error result;


    string query = dropQuery(
        enumProcName,
        dropEnumProcParameters
    );
    io:println(query);
    result = jdbcClient->execute(query);

    if(result is sql:ExecutionResult){
        io:println("enum Procedure is drop Success");
        io:println(result);
        io:println("\n");
    }
    else{
        io:println("enum Procedure is drop failed");
        io:println(result);
        io:println("\n");
    }


    return result;  

}





