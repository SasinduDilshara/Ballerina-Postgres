import ballerina/io;
import ballerina/java.jdbc;
import ballerina/sql;


string jsonVal = "{\"name\":\"Hello\"}";
string jsonpath = "$.floor[*].apt[*] ? (@.area > 40 && @.area < 90) ? (@.rooms > 2)";

function jsonTableProcess(jdbc:Client jdbcClient) {

    sql:ExecutionResult|sql:Error createResult  =  createJsonProcedures(jdbcClient);
    sql:ProcedureCallResult|sql:Error callResult;

    //   callResult = jsonProcedureCall(jdbcClient,
    //     jsonVal,jsonVal
    //     ,jsonVal,jsonVal
    //     ,jsonpath,jsonpath
    // );

     sql:ExecutionResult|sql:Error teardownResult = jsonTearDown(jdbcClient);

}



string jsonProcName = "jsontest";
map<string> jsonValues = {
    "jsonInValue": "json","inout jsonInOutValue":"json"
    ,"jsonbInValue": "jsonb","inout jsonbInOutValue":"jsonb"
    ,"jsonpathInValue": "jsonpath","inout jsonpathInOutValue":"jsonpath"
};
string jsonProcParameters = createParas( jsonValues);
string dropJsonProcParameters = createDrops( jsonValues);

function createJsonProcedures(jdbc:Client jdbcClient) returns sql:ExecutionResult|sql:Error{

    sql:ExecutionResult|sql:Error result;

    string query = createQuery(
        jsonProcName,
        jsonProcParameters,
        "select jsonInValue into jsonInOutValue;"
        +"select jsonbInValue into jsonbInOutValue;"
        +"select jsonpathInValue into jsonpathInOutValue;"
        
    );
    io:println(query);
    result = jdbcClient->execute(query);

    if(result is sql:ExecutionResult){
        io:println("json Procedure is initialization Success");
        io:println(result);
        io:println("\n");
    }
    else{
        io:println("json Procedure is initialization failed");
        io:println(result);
        io:println("\n");
    }


    return result;  

}

function jsonProcedureCall(jdbc:Client jdbcClient,
    string jsonInput,        string jsonInOut
    ,string jsonbInput,        string jsonbInOut
    ,string jsonpathInput,        string jsonpathInOut
    )  returns sql:ProcedureCallResult|sql:Error {

// ${inSmallInput} 


    sql:ProcedureCallResult|sql:Error result;

    sql:InOutParameter jsonInOutId = new (jsonInOut);
    sql:InOutParameter jsonbInOutId = new (jsonbInOut);
    sql:InOutParameter jsonpathInOutId = new (jsonpathInOut);
    
    sql:ParameterizedCallQuery callQuery =
            `call jsontest(
                ${jsonInput}
                ,${jsonInOutId}
                ,${jsonbInput}
                ,${jsonbInOutId}
                ,${jsonpathInput}
                ,${jsonpathInOutId}                
            )`;
    

    result = jdbcClient->call(callQuery);

    if (result is sql:ProcedureCallResult) {
        io:println("\n");
        io:println(result);
        // io:println("json(n) value"," - ",jsonInOutId.get(string));
        io:println("jsonb value"," - ",jsonbInOutId.get(string));
        io:println("json value"," - ",jsonpathInOutId.get(string));
        io:println("json procedure successfully created");
        io:println("\n");
    } 
    else{
        io:println("\nError ocurred while creating the json procedure\n");
        io:println(result);
        io:println("\n");
    }

    return result;      

}

function jsonTearDown(jdbc:Client jdbcClient) returns sql:ExecutionResult|sql:Error{

    sql:ExecutionResult|sql:Error result;


    string query = dropQuery(
        jsonProcName,
        dropJsonProcParameters
    );
    io:println(query);
    result = jdbcClient->execute(query);

    if(result is sql:ExecutionResult){
        io:println("json Procedure is drop Success");
        io:println(result);
        io:println("\n");
    }
    else{
        io:println("json Procedure is drop failed");
        io:println(result);
        io:println("\n");
    }


    return result;  

}



