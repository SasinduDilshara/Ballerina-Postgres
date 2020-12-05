import ballerina/io;
import ballerina/java.jdbc;
import ballerina/sql;


sql:BitValue varbitn = new(1);
sql:BitValue bit = new(0);
sql:BitValue bitn = new(1);


function bitTableProcess(jdbc:Client jdbcClient) {

    sql:ExecutionResult|sql:Error createResult  =  createBitProcedures(jdbcClient);
    sql:ProcedureCallResult|sql:Error callResult;

    // callResult = bitProcedureCall(jdbcClient,
    //     bitn,bitn
    //     ,varbitn,varbitn
    //     ,bit,bit
    // );


     sql:ExecutionResult|sql:Error selectResult = bitTearDown(jdbcClient);

}



string bitProcName = "bittest";
map<string> bitValues = {
    "bitInValue": "bit(10)","inout bitInOutValue":"bit(10)"
    ,"varbitInValue": "BIT VARYING(10)","inout varbitInOutValue":"BIT VARYING(10)"
    ,"bitOnlyInValue": "bit","inout bitOnlyInOutValue":"bit"
};
string bitProcParameters = createParas( bitValues);
string dropBitProcParameters = createDrops( bitValues);

function createBitProcedures(jdbc:Client jdbcClient) returns sql:ExecutionResult|sql:Error{

    sql:ExecutionResult|sql:Error result;

    string query = createQuery(
        bitProcName,
        bitProcParameters,
        "select bitInValue into bitInOutValue;"
        +"select varbitInValue into varbitInOutValue;"
        +"select bitOnlyInValue into bitOnlyInOutValue;"
        
    );
    io:println(query);
    result = jdbcClient->execute(query);

    if(result is sql:ExecutionResult){
        io:println("bit Procedure is initialization Success");
        io:println(result);
        io:println("\n");
    }
    else{
        io:println("bit Procedure is initialization failed");
        io:println(result);
        io:println("\n");
    }


    return result;  

}

function bitProcedureCall(jdbc:Client jdbcClient,
    sql:BitValue bitInput,        sql:BitValue bitInOut
    ,sql:BitValue varbitInput,        sql:BitValue varbitInOut
    ,sql:BitValue bitOnlyInput,        sql:BitValue bitOnlyInOut
    )  returns sql:ProcedureCallResult|sql:Error {

// ${inSmallInput} 


    sql:ProcedureCallResult|sql:Error result;

    sql:InOutParameter bitInOutId = new (bitInOut);
    sql:InOutParameter varbitInOutId = new (varbitInOut);
    sql:InOutParameter bitOnlyInOutId = new (bitOnlyInOut);
    
    sql:ParameterizedCallQuery callQuery =
            `call bittest(
                ${bitInput}
                ,${bitInOutId}
                ,${varbitInput}
                ,${varbitInOutId}
                ,${bitOnlyInput}
                ,${bitOnlyInOutId}                
            )`;
    

    result = jdbcClient->call(callQuery);

    if (result is sql:ProcedureCallResult) {
        io:println("\n");
        io:println(result);
        // io:println("bit(n) value"," - ",bitInOutId.get(string));
        io:println("varbit value"," - ",varbitInOutId.get(string));
        io:println("bit value"," - ",bitOnlyInOutId.get(string));
        io:println("bit procedure successfully created");
        io:println("\n");
    } 
    else{
        io:println("\nError ocurred while creating the bit procedure\n");
        io:println(result);
        io:println("\n");
    }

    return result;      

}

function bitTearDown(jdbc:Client jdbcClient) returns sql:ExecutionResult|sql:Error{

    sql:ExecutionResult|sql:Error result;


    string query = dropQuery(
        bitProcName,
        dropBitProcParameters
    );
    io:println(query);
    result = jdbcClient->execute(query);

    if(result is sql:ExecutionResult){
        io:println("bit Procedure is drop Success");
        io:println(result);
        io:println("\n");
    }
    else{
        io:println("bit Procedure is drop failed");
        io:println(result);
        io:println("\n");
    }


    return result;  

}

