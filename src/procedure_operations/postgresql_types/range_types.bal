import ballerina/io;
import ballerina/java.jdbc;
import ballerina/sql;

string rangVal = "(1,2)";

function rangeTableProcess(jdbc:Client jdbcClient) {

    sql:ExecutionResult|sql:Error createResult  =  createRangeProcedures(jdbcClient);
    sql:ProcedureCallResult|sql:Error callResult;

    // callResult = rangeProcedureCall(jdbcClient,
    //     rangVal,rangVal
    // );
     sql:ExecutionResult|sql:Error teardownResult = rangeTearDown(jdbcClient);

}



string rangeProcName = "rangetest";
map<string> rangValues = {
    "int4rangeInValue": "int4range","inout int4rangeInOutValue":"int4range"
};
string rangeProcParameters = createParas( rangValues);
string dropRangeProcParameters = createDrops( rangValues);

function createRangeProcedures(jdbc:Client jdbcClient) returns sql:ExecutionResult|sql:Error{

    sql:ExecutionResult|sql:Error result;

    string query = createQuery(
        rangeProcName,
        rangeProcParameters,
        "select int4rangeInValue into int4rangeInOutValue;"
        
    );
    io:println(query);
    result = jdbcClient->execute(query);

    if(result is sql:ExecutionResult){
        io:println("range Procedure is initialization Success");
        io:println(result);
        io:println("\n");
    }
    else{
        io:println("range Procedure is initialization failed");
        io:println(result);
        io:println("\n");
    }


    return result;  

}

function rangeProcedureCall(jdbc:Client jdbcClient,
    string int4rangeInput,        string int4rangeInOut
    )  returns sql:ProcedureCallResult|sql:Error {

// ${inSmallInput} 


    sql:ProcedureCallResult|sql:Error result;

    sql:InOutParameter int4rangeInOutId = new (int4rangeInOut);
    
    sql:ParameterizedCallQuery callQuery =
            `call rangetest(
                ${int4rangeInput}::int4range,
                ${int4rangeInOutId}              
            )`;
    

    result = jdbcClient->call(callQuery);

    if (result is sql:ProcedureCallResult) {
        io:println("\n");
        io:println(result);
        io:println("range value"," - ",int4rangeInOutId.get(string));
        io:println("range procedure successfully created");
        io:println("\n");
    } 
    else{
        io:println("\nError ocurred while creating the range procedure\n");
        io:println(result);
        io:println("\n");
    }

    return result;      

}

function rangeTearDown(jdbc:Client jdbcClient) returns sql:ExecutionResult|sql:Error{

    sql:ExecutionResult|sql:Error result;


    string query = dropQuery(
        rangeProcName,
        dropRangeProcParameters
    );
    io:println(query);
    result = jdbcClient->execute(query);

    if(result is sql:ExecutionResult){
        io:println("range Procedure is drop Success");
        io:println(result);
        io:println("\n");
    }
    else{
        io:println("range Procedure is drop failed");
        io:println(result);
        io:println("\n");
    }


    return result;  

}

