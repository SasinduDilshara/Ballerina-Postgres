import ballerina/io;
import ballerina/java.jdbc;
import ballerina/sql;

string anyVal1 = "1";
string anyVal2= "[1,2,3,4,5]";
string anyVal3 = "3";
string anyVal4 = "value1";
string anyVal5 = "(1,4)";
string anyVal6 = "{ID:1}";


function anyTableProcess(jdbc:Client jdbcClient) {

    sql:ExecutionResult|sql:Error createResult  =  createAnyProcedures(jdbcClient);
    // sql:ProcedureCallResult|sql:Error callResult;

//    callResult = anyProcedureCall(jdbcClient,
//         anyVal1,anyVal1,arrVal,arrVal,anyVal3,anyVal3,anyVal4,anyVal4,anyVal5,anyVal5,anyVal6,anyVal6
//     );

     sql:ExecutionResult|sql:Error teardownResult = anyTearDown(jdbcClient);

}



string anyProcName = "anytest";
map<string> anyValues = {
    // "anyInValue": "any","inout anyInOutValue":"any"
    "anyelementInValue": "anyelement","inout anyelementInOutValue":"anyelement"
    ,"anyarrayInValue": "anyarray","inout anyarrayInOutValue":"anyarray"
    ,"anynonarrayInValue": "anynonarray","inout anynonarrayInOutValue":"anynonarray"
    ,"anyenumInValue": "anyenum","inout anyenumInOutValue":"anyenum"
    ,"anyrangeInValue": "anyrange","inout anyrangeInOutValue":"anyrange"
    ,"recordInValue": "record","inout recordInOutValue":"record"
};
string anyProcParameters = createParas( anyValues);
string dropAnyProcParameters = createDrops( anyValues);

function createAnyProcedures(jdbc:Client jdbcClient) returns sql:ExecutionResult|sql:Error{

    sql:ExecutionResult|sql:Error result;

    string query = createQuery(
        anyProcName,
        anyProcParameters,
        // "select anyInValue into anyInOutValue;"
        "select anyelementInValue into anyelementInOutValue;"
        +"select anyarrayInValue into anyarrayInOutValue;"
        +"select anynonarrayInValue into anynonarrayInOutValue;"
        +"select anyenumInValue into anyenumInOutValue;"
        +"select anyrangeInValue into anyrangeInOutValue;"
        +"select recordInValue into recordInOutValue;"
        
    );
    io:println(query);
    result = jdbcClient->execute(query);

    if(result is sql:ExecutionResult){
        io:println("any Procedure is initialization Success");
        io:println(result);
        io:println("\n");
    }
    else{
        io:println("any Procedure is initialization failed");
        io:println(result);
        io:println("\n");
    }


    return result;  

}

function anyProcedureCall(jdbc:Client jdbcClient
    // string anyInput,        string anyInOut,
    ,string anyelementInput,        string anyelementInOut
    ,sql:ArrayValue anyarrayInput,        sql:ArrayValue anyarrayInOut
    ,string anynonarrayInput,        string anynonarrayInOut
    ,string anyenumInput,        string anyenumInOut
    ,string anyrangeInput,        string anyrangeInOut
    ,string recordInput,        string recordInOut
    )  returns sql:ProcedureCallResult|sql:Error {

// ${inSmallInput} 
// ${anyInput}
// ,${anyInOutId}
// ,${anyelementInput}
// ,${anyelementInOutId}
// ,${anyarrayInput}
// ,${anyarrayInOutId}  

    sql:ProcedureCallResult|sql:Error result;

    // sql:InOutParameter anyInOutId = new (anyInOut);
    sql:InOutParameter anyelementInOutId = new (anyelementInOut);
    sql:InOutParameter anyarrayInOutId = new (anyarrayInOut);
    sql:InOutParameter anynonarrayInOutId = new (anynonarrayInOut);
    sql:InOutParameter anyenumInOutId = new (anyenumInOut);
    sql:InOutParameter anyrangeInOutId = new (anyrangeInOut);
    sql:InOutParameter recordInOutId = new (recordInOut);
    
    sql:ParameterizedCallQuery callQuery =
            `call anytest(
                ${anyelementInput}
                ,${anyelementInOutId}
                ,${anyarrayInput}
                ,${anyarrayInOutId}
                ,${anynonarrayInput}
                ,${anynonarrayInOutId}
                ,${anyenumInput}
                ,${anyenumInOutId}
                ,${anyrangeInput}
                ,${anyrangeInOutId}
                ,${recordInput}
                ,${recordInOutId}                  
            )`;
    

    result = jdbcClient->call(callQuery);

    if (result is sql:ProcedureCallResult) {
        io:println("\n");
        io:println(result);
        // io:println("any(n) value"," - ",anyInOutId.get(string));
        io:println("anyelement value"," - ",anyelementInOutId.get(string));
        io:println("anyarray value"," - ",anyarrayInOutId.get(string));
        io:println("anynonarray value"," - ",anynonarrayInOutId.get(string));
        io:println("anyenum value"," - ",anyenumInOutId.get(string));
        io:println("anyrange value"," - ",anyrangeInOutId.get(string));
        io:println("record value"," - ",recordInOutId.get(string));
        io:println("any procedure successfully created");
        io:println("\n");
    } 
    else{
        io:println("\nError ocurred while creating the any procedure\n");
        io:println(result);
        io:println("\n");
    }

    return result;      

}

function anyTearDown(jdbc:Client jdbcClient) returns sql:ExecutionResult|sql:Error{

    sql:ExecutionResult|sql:Error result;


    string query = dropQuery(
        anyProcName,
        dropAnyProcParameters
    );
    io:println(query);
    result = jdbcClient->execute(query);

    if(result is sql:ExecutionResult){
        io:println("any Procedure is drop Success");
        io:println(result);
        io:println("\n");
    }
    else{
        io:println("any Procedure is drop failed");
        io:println(result);
        io:println("\n");
    }


    return result;  

}
