import ballerina/io;
import ballerina/java.jdbc;
import ballerina/sql;

sql:IntegerValue dom1 = new(1);
// int dom1 = 1;

function domainTableProcess(jdbc:Client jdbcClient) {

    sql:ExecutionResult|sql:Error createResult  =  createDomainProcedures(jdbcClient);
    sql:ProcedureCallResult|sql:Error callResult;

    // callResult = domainProcedureCall(jdbcClient,
    //     dom1,dom1
    // );
     sql:ExecutionResult|sql:Error teardownResult = domainTearDown(jdbcClient);

}


string domainProcName = "domaintest";
map<string> domValues = {
    "intInValue": "posint","inout intInOutValue":"posint"
};
string domainProcParameters = createParas( domValues);
string dropDomainProcParameters = createDrops( domValues);

function createDomainProcedures(jdbc:Client jdbcClient) returns sql:ExecutionResult|sql:Error{

    sql:ExecutionResult|sql:Error result;

    string query = createQuery(
        domainProcName,
        domainProcParameters,
        "select intInValue into intInOutValue;"
        
    );
    io:println(query);
    result = jdbcClient->execute(query);

    if(result is sql:ExecutionResult){
        io:println("domain Procedure is initialization Success");
        io:println(result);
        io:println("\n");
    }
    else{
        io:println("domain Procedure is initialization failed");
        io:println(result);
        io:println("\n");
    }


    return result;  

}

function domainProcedureCall(jdbc:Client jdbcClient,
    sql:IntegerValue|int intInput,        sql:IntegerValue|int intInOut
    )  returns sql:ProcedureCallResult|sql:Error {

// ${inSmallInput} 


    sql:ProcedureCallResult|sql:Error result;

    sql:InOutParameter intInOutId = new (intInOut);
    
    sql:ParameterizedCallQuery callQuery =
            `call domaintest(
                ${intInput},
                ${intInOutId}              
            )`;
    

    result = jdbcClient->call(callQuery);

    if (result is sql:ProcedureCallResult) {
        io:println("\n");
        io:println(result);
        io:println("domain value"," - ",intInOutId.get(string));
        io:println("domain procedure successfully created");
        io:println("\n");
    } 
    else{
        io:println("\nError ocurred while creating the domain procedure\n");
        io:println(result);
        io:println("\n");
    }

    return result;      

}

function domainTearDown(jdbc:Client jdbcClient) returns sql:ExecutionResult|sql:Error{

    sql:ExecutionResult|sql:Error result;


    string query = dropQuery(
        domainProcName,
        dropDomainProcParameters
    );
    io:println(query);
    result = jdbcClient->execute(query);

    if(result is sql:ExecutionResult){
        io:println("domain Procedure is drop Success");
        io:println(result);
        io:println("\n");
    }
    else{
        io:println("domain Procedure is drop failed");
        io:println(result);
        io:println("\n");
    }


    return result;  

}

