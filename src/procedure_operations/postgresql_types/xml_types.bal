import ballerina/io;
import ballerina/java.jdbc;
import ballerina/sql;


xml xmlVal = xml `<foo><tag>bar</tag><tag>tag</tag></foo>`;


function xmlTableProcess(jdbc:Client jdbcClient) {

    sql:ExecutionResult|sql:Error createResult  =  createXmlProcedures(jdbcClient);
    sql:ProcedureCallResult|sql:Error callResult;

    callResult = xmlProcedureCall(jdbcClient,
        xmlVal,xmlVal
    );

     sql:ExecutionResult|sql:Error teardownResult = xmlTearDown(jdbcClient);

}




string xmlProcName = "xmltest";
map<string> xmlValues = {
    "xmlInValue": "xml","inout xmlInOutValue":"xml"
};
string xmlProcParameters = createParas( xmlValues);
string dropXmlProcParameters = createDrops( xmlValues);

function createXmlProcedures(jdbc:Client jdbcClient) returns sql:ExecutionResult|sql:Error{

    sql:ExecutionResult|sql:Error result;

    string query = createQuery(
        xmlProcName,
        xmlProcParameters,
        "select xmlInValue into xmlInOutValue;"
        
    );
    io:println(query);
    result = jdbcClient->execute(query);

    if(result is sql:ExecutionResult){
        io:println("xml Procedure is initialization Success");
        io:println(result);
        io:println("\n");
    }
    else{
        io:println("xml Procedure is initialization failed");
        io:println(result);
        io:println("\n");
    }


    return result;  

}

function xmlProcedureCall(jdbc:Client jdbcClient,
    xml xmlInput,        xml xmlInOut
    )  returns sql:ProcedureCallResult|sql:Error {



    sql:ProcedureCallResult|sql:Error result;

    sql:InOutParameter xmlInOutId = new (xmlInOut);
    
    sql:ParameterizedCallQuery callQuery =
            `call xmltest(
                ${xmlInput},
                ${xmlInOutId}              
            )`;
    

    result = jdbcClient->call(callQuery);

    if (result is sql:ProcedureCallResult) {
        io:println("\n");
        io:println(result);
        // io:println("xml value"," - ",xmlInOutId.get(xml));
        io:println("xml procedure successfully created");
        io:println("\n");
    } 
    else{
        io:println("\nError ocurred while creating the xml procedure\n");
        io:println(result);
        io:println("\n");
    }

    return result;      

}

function xmlTearDown(jdbc:Client jdbcClient) returns sql:ExecutionResult|sql:Error{

    sql:ExecutionResult|sql:Error result;


    string query = dropQuery(
        xmlProcName,
        dropXmlProcParameters
    );
    io:println(query);
    result = jdbcClient->execute(query);

    if(result is sql:ExecutionResult){
        io:println("xml Procedure is drop Success");
        io:println(result);
        io:println("\n");
    }
    else{
        io:println("xml Procedure is drop failed");
        io:println(result);
        io:println("\n");
    }


    return result;  

}

