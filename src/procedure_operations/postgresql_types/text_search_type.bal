import ballerina/io;
import ballerina/java.jdbc;
import ballerina/sql;



string tv = "a fat cat sat on a mat and ate a fat rat";
string tq = "fat & rat";


function textsearchTableProcess(jdbc:Client jdbcClient) {

    sql:ExecutionResult|sql:Error createResult  =  createTextsearchProcedures(jdbcClient);
    sql:ProcedureCallResult|sql:Error callResult;

    // callResult = textsearchProcedureCall(jdbcClient,
    //     tv,tv
    //     ,tq,tq
    // );


     sql:ExecutionResult|sql:Error selectResult = textsearchTearDown(jdbcClient);

}



string textsearchProcName = "textsearchtest";
map<string> tshValues = {
    "tsvInValue": "tsvector","inout tsvInOutValue":"tsvector"
    ,"tsqInValue": "tsquery","inout tsqInOutValue":"tsquery"
};
string textsearchProcParameters = createParas(tshValues);
string dropTextsearchProcParameters = createDrops(tshValues);

function createTextsearchProcedures(jdbc:Client jdbcClient) returns sql:ExecutionResult|sql:Error{

    sql:ExecutionResult|sql:Error result;

    string query = createQuery(
        textsearchProcName,
        textsearchProcParameters,
        "select tsvInValue into tsvInOutValue;"
        +"select tsqInValue into tsqInOutValue;"
        
    );
    io:println(query);
    result = jdbcClient->execute(query);

    if(result is sql:ExecutionResult){
        io:println("textsearch Procedure is initialization Success");
        io:println(result);
        io:println("\n");
    }
    else{
        io:println("textsearch Procedure is initialization failed");
        io:println(result);
        io:println("\n");
    }


    return result;  

}

function textsearchProcedureCall(jdbc:Client jdbcClient,
    string tsvInput,        string tsvInOut
    ,string tsqInput,        string tsqInOut
    )  returns sql:ProcedureCallResult|sql:Error {

// ${inSmallInput} 


    sql:ProcedureCallResult|sql:Error result;

    sql:InOutParameter tsvInOutId = new (tsvInOut);
    sql:InOutParameter tsqInOutId = new (tsqInOut);
    
    sql:ParameterizedCallQuery callQuery =
            `call textsearchtest(
                ${tsvInput},
                ${tsvInOutId},
                ${tsqInput},
                ${tsqInOutId}              
            )`;
    

    result = jdbcClient->call(callQuery);

    if (result is sql:ProcedureCallResult) {
        io:println("\n");
        io:println(result);
        io:println("textsearch value"," - ",tsvInOutId.get(string));
        io:println("textsearch value"," - ",tsqInOutId.get(string));
        io:println("textsearch procedure successfully created");
        io:println("\n");
    } 
    else{
        io:println("\nError ocurred while creating the textsearch procedure\n");
        io:println(result);
        io:println("\n");
    }

    return result;      

}

function textsearchTearDown(jdbc:Client jdbcClient) returns sql:ExecutionResult|sql:Error{

    sql:ExecutionResult|sql:Error result;


    string query = dropQuery(
        textsearchProcName,
        dropTextsearchProcParameters
    );
    io:println(query);
    result = jdbcClient->execute(query);

    if(result is sql:ExecutionResult){
        io:println("textsearch Procedure is drop Success");
        io:println(result);
        io:println("\n");
    }
    else{
        io:println("textsearch Procedure is drop failed");
        io:println(result);
        io:println("\n");
    }


    return result;  

}
