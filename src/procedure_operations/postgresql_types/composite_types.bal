import ballerina/io;
import ballerina/java.jdbc;
import ballerina/sql;

string cplx = "(1.1,2.32)";



function compositeTableProcess(jdbc:Client jdbcClient) {

    sql:ExecutionResult|sql:Error createResult  =  createComplexProcedures(jdbcClient);
    sql:ProcedureCallResult|sql:Error callResult;

    // callResult = complexProcedureCall(jdbcClient,
    //     cplx,cplx
    // );
     sql:ExecutionResult|sql:Error teardownResult = complexTearDown(jdbcClient);

}





string complexProcName = "complextest";
map<string> cplxValues = {
    "complexInValue": "complex","inout complexInOutValue":"complex"
};
string complexProcParameters = createParas( cplxValues);
string dropComplexProcParameters = createDrops( cplxValues);

function createComplexProcedures(jdbc:Client jdbcClient) returns sql:ExecutionResult|sql:Error{

    sql:ExecutionResult|sql:Error result;

    string query = createQuery(
        complexProcName,
        complexProcParameters,
        "select complexInValue into complexInOutValue;"
        
    );
    io:println(query);
    result = jdbcClient->execute(query);

    if(result is sql:ExecutionResult){
        io:println("complex Procedure is initialization Success");
        io:println(result);
        io:println("\n");
    }
    else{
        io:println("complex Procedure is initialization failed");
        io:println(result);
        io:println("\n");
    }


    return result;  

}

function complexProcedureCall(jdbc:Client jdbcClient,
    string complexInput,        string complexInOut
    )  returns sql:ProcedureCallResult|sql:Error {

// ${inSmallInput} 


    sql:ProcedureCallResult|sql:Error result;

    sql:InOutParameter complexInOutId = new (complexInOut);
    
    sql:ParameterizedCallQuery callQuery =
            `call complextest(
                ${complexInput}::complex,
                ${complexInOutId}              
            )`;
    

    result = jdbcClient->call(callQuery);

    if (result is sql:ProcedureCallResult) {
        io:println("\n");
        io:println(result);
        io:println("complex value"," - ",complexInOutId.get(string));
        io:println("complex procedure successfully created");
        io:println("\n");
    } 
    else{
        io:println("\nError ocurred while creating the complex procedure\n");
        io:println(result);
        io:println("\n");
    }

    return result;      

}

function complexTearDown(jdbc:Client jdbcClient) returns sql:ExecutionResult|sql:Error{

    sql:ExecutionResult|sql:Error result;


    string query = dropQuery(
        complexProcName,
        dropComplexProcParameters
    );
    io:println(query);
    result = jdbcClient->execute(query);

    if(result is sql:ExecutionResult){
        io:println("complex Procedure is drop Success");
        io:println(result);
        io:println("\n");
    }
    else{
        io:println("complex Procedure is drop failed");
        io:println(result);
        io:println("\n");
    }


    return result;  

}
