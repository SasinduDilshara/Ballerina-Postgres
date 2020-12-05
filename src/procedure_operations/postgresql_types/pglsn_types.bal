import ballerina/io;
import ballerina/java.jdbc;
import ballerina/sql;

string pglsn = "16/B374D848";


function pglsnTableProcess(jdbc:Client jdbcClient) {

    sql:ExecutionResult|sql:Error createResult  =  createPglsnProcedures(jdbcClient);
    sql:ProcedureCallResult|sql:Error callResult;

    // callResult = pglsnProcedureCall(jdbcClient,
    //         pglsn,pglsn
    //     );

     sql:ExecutionResult|sql:Error teardownResult = pglsnTearDown(jdbcClient);

}



string pglsnProcName = "pglsntest";
map<string> pgValues = {
    "pg_lsnInValue": "pg_lsn","inout pg_lsnInOutValue":"pg_lsn"
};
string pglsnProcParameters = createParas( pgValues);
string dropPglsnProcParameters = createDrops( pgValues);

function createPglsnProcedures(jdbc:Client jdbcClient) returns sql:ExecutionResult|sql:Error{

    sql:ExecutionResult|sql:Error result;

    string query = createQuery(
        pglsnProcName,
        pglsnProcParameters,
        "select pg_lsnInValue into pg_lsnInOutValue;"
        
    );
    io:println(query);
    result = jdbcClient->execute(query);

    if(result is sql:ExecutionResult){
        io:println("pglsn Procedure is initialization Success");
        io:println(result);
        io:println("\n");
    }
    else{
        io:println("pglsn Procedure is initialization failed");
        io:println(result);
        io:println("\n");
    }


    return result;  

}

function pglsnProcedureCall(jdbc:Client jdbcClient,
    string pg_lsnInput,        string pg_lsnInOut
    )  returns sql:ProcedureCallResult|sql:Error {

// ${inSmallInput} 


    sql:ProcedureCallResult|sql:Error result;

    sql:InOutParameter pg_lsnInOutId = new (pg_lsnInOut);
    
    sql:ParameterizedCallQuery callQuery =
            `call pglsntest(
                ${pg_lsnInput}::pg_lsn,
                ${pg_lsnInOutId}              
            )`;
    

    result = jdbcClient->call(callQuery);

    if (result is sql:ProcedureCallResult) {
        io:println("\n");
        io:println(result);
        io:println("pglsn value"," - ",pg_lsnInOutId.get(string));
        io:println("pglsn procedure successfully created");
        io:println("\n");
    } 
    else{
        io:println("\nError ocurred while creating the pglsn procedure\n");
        io:println(result);
        io:println("\n");
    }

    return result;      

}

function pglsnTearDown(jdbc:Client jdbcClient) returns sql:ExecutionResult|sql:Error{

    sql:ExecutionResult|sql:Error result;


    string query = dropQuery(
        pglsnProcName,
        dropPglsnProcParameters
    );
    io:println(query);
    result = jdbcClient->execute(query);

    if(result is sql:ExecutionResult){
        io:println("pglsn Procedure is drop Success");
        io:println(result);
        io:println("\n");
    }
    else{
        io:println("pglsn Procedure is drop failed");
        io:println(result);
        io:println("\n");
    }


    return result;  

}

