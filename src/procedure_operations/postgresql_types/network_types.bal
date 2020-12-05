import ballerina/io;
import ballerina/java.jdbc;
import ballerina/sql;


string inetVal = "192.168.0.1/24";


function networkTableProcess(jdbc:Client jdbcClient) {

    sql:ExecutionResult|sql:Error createResult  =  createNetworkProcedures(jdbcClient);
    sql:ProcedureCallResult|sql:Error callResult;

    // callResult = networkProcedureCall(jdbcClient,
    //     inetVal,inetVal
    // );


     sql:ExecutionResult|sql:Error selectResult = networkTearDown(jdbcClient);

}




string networkProcName = "networktest";
map<string> netValues = {
    "inetInValue": "inet","inout inetInOutValue":"inet"
};
string networkProcParameters = createParas( netValues);
string dropNetworkProcParameters = createDrops( netValues);

function createNetworkProcedures(jdbc:Client jdbcClient) returns sql:ExecutionResult|sql:Error{

    sql:ExecutionResult|sql:Error result;

    string query = createQuery(
        networkProcName,
        networkProcParameters,
        "select inetInValue into inetInOutValue;"
        
    );
    io:println(query);
    result = jdbcClient->execute(query);

    if(result is sql:ExecutionResult){
        io:println("network Procedure is initialization Success");
        io:println(result);
        io:println("\n");
    }
    else{
        io:println("network Procedure is initialization failed");
        io:println(result);
        io:println("\n");
    }


    return result;  

}

function networkProcedureCall(jdbc:Client jdbcClient,
    string inetInput,        string inetInOut
    )  returns sql:ProcedureCallResult|sql:Error {

// ${inSmallInput} 


    sql:ProcedureCallResult|sql:Error result;

    sql:InOutParameter inetInOutId = new (inetInOut);
    
    sql:ParameterizedCallQuery callQuery =
            `call networktest(
                ${inetInput}::inet,
                ${inetInOutId}              
            )`;
    

    result = jdbcClient->call(callQuery);

    if (result is sql:ProcedureCallResult) {
        io:println("\n");
        io:println(result);
        io:println("network value"," - ",inetInOutId.get(string));
        io:println("network procedure successfully created");
        io:println("\n");
    } 
    else{
        io:println("\nError ocurred while creating the network procedure\n");
        io:println(result);
        io:println("\n");
    }

    return result;      

}

function networkTearDown(jdbc:Client jdbcClient) returns sql:ExecutionResult|sql:Error{

    sql:ExecutionResult|sql:Error result;


    string query = dropQuery(
        networkProcName,
        dropNetworkProcParameters
    );
    io:println(query);
    result = jdbcClient->execute(query);

    if(result is sql:ExecutionResult){
        io:println("network Procedure is drop Success");
        io:println(result);
        io:println("\n");
    }
    else{
        io:println("network Procedure is drop failed");
        io:println(result);
        io:println("\n");
    }


    return result;  

}
