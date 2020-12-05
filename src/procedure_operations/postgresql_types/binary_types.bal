
import ballerina/io;
import ballerina/java.jdbc;
// import ballerina/auth;
import ballerina/sql;
// import ballerina/time;


byte[] byteVal3 = [1,2,3,4,5,6];
byte[] byteVal4 = [1,2,3,4,5,6];

sql:BinaryValue byteVal1 = new(byteVal3);
sql:BinaryValue byteVal2 = new(byteVal4);

function BinaryTableProcess(jdbc:Client jdbcClient) {

    sql:ExecutionResult|sql:Error createResult  =  createBinaryProcedures(jdbcClient);
    // sql:ProcedureCallResult|sql:Error callResult   = binaryProcedureCall(jdbcClient,
    //     byteVal1,byteVal2
    // );
     sql:ExecutionResult|sql:Error selectResult = binaryTearDown(jdbcClient);

}


string binaryProcName = "binarytest";
map<string> binValues = {
    "binaryInValue": "bytea","inout binaryInOutValue":"bytea"
};
string binaryProcParameters = createParas(binValues);
string dropBinaryProcParameters = createDrops(binValues);

function createBinaryProcedures(jdbc:Client jdbcClient) returns sql:ExecutionResult|sql:Error{

    sql:ExecutionResult|sql:Error result;

    string query = createQuery(
        binaryProcName,
        binaryProcParameters,
        "select binaryInValue into binaryInOutValue;"
        
    );
    io:println(query);
    result = jdbcClient->execute(query);

    if(result is sql:ExecutionResult){
        io:println("Binary Procedure is initialization Success");
        io:println(result);
        io:println("\n");
    }
    else{
        io:println("Binary Procedure is initialization failed");
        io:println(result);
        io:println("\n");
    }


    return result;  

}

function binaryProcedureCall(jdbc:Client jdbcClient,
    sql:BinaryValue binaryInput,        sql:BinaryValue binaryInOut
    )  returns sql:ProcedureCallResult|sql:Error {




    sql:ProcedureCallResult|sql:Error result;

    sql:InOutParameter binaryInOutId = new (binaryInOut);
    
    sql:ParameterizedCallQuery callQuery =
            `call binarytest(
                ${binaryInput},
                ${binaryInOutId}              
            )`;
    

    result = jdbcClient->call(callQuery);

    if (result is sql:ProcedureCallResult) {
        io:println("\n");
        io:println(result);
        // io:println("Binary value"," - ",binaryInOutId.get(string));
        io:println("Binary procedure successfully created");
        io:println("\n");
    } 
    else{
        io:println("\nError ocurred while creating the Binary procedure\n");
        io:println(result);
        io:println("\n");
    }

    return result;      

}

function binaryTearDown(jdbc:Client jdbcClient) returns sql:ExecutionResult|sql:Error{

    sql:ExecutionResult|sql:Error result;


    string query = dropQuery(
        binaryProcName,
        dropBinaryProcParameters
    );
    io:println(query);
    result = jdbcClient->execute(query);

    if(result is sql:ExecutionResult){
        io:println("Binary Procedure is drop Success");
        io:println(result);
        io:println("\n");
    }
    else{
        io:println("Binary Procedure is drop failed");
        io:println(result);
        io:println("\n");
    }


    return result;  

}