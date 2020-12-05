import ballerina/io;
import ballerina/java.jdbc;
// import ballerina/auth;
import ballerina/sql;
import ballerina/time;



time:Time time_ = time:currentTime();


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







































































string numProcName2 = "smallAndInttest";
map<string> values2 = {
    "smallIntInValue": "smallint","inout smallIntOutValue":"smallint"
    // "IntInValue":"integer","inout intOutValue":"integer"
};
function createNumericProcedures2(jdbc:Client jdbcClient) returns sql:ExecutionResult|sql:Error{

    sql:ExecutionResult|sql:Error result;


    string query = createQuery(
        numProcName2,
        numProcParameters2,
        "select smallIntInValue into smallIntOutValue;"
        // "select intInValue into intOutValue;"
        
    );
    io:println(query);
    result = jdbcClient->execute(query);

    if(result is sql:ExecutionResult){
        io:println("smallAndInttest Procedure is initialization Success");
        io:println(result);
        io:println("\n");
    }
    else{
        io:println("smallAndInttest Procedure is initialization failed");
        io:println(result);
        io:println("\n");
    }


    return result;  

}


function numericProcedureCall2(jdbc:Client jdbcClient,
    sql:SmallIntValue inSmallInput,        sql:SmallIntValue outSmallInput,
    sql:IntegerValue Inputint,             sql:IntegerValue outInt
    )  returns sql:ProcedureCallResult|sql:Error {

// ${inSmallInput},
// ${outSmallInputId},
// ${Inputint},
// ${outIntId}


    sql:ProcedureCallResult|sql:Error result;

    sql:InOutParameter outSmallInputId = new (outSmallInput);
    sql:InOutParameter outIntId = new (outInt);

    sql:ParameterizedCallQuery callQuery =
            `call smallAndInttest(
                ${inSmallInput},
                ${outSmallInputId}
            )`;
    

    result = jdbcClient->call(callQuery);

    if (result is sql:ProcedureCallResult) {
        io:println("\n");
        io:println(result);
        io:println("SmallInt"," - ",outSmallInputId.get(int));
        // io:println("Int"," - ",outIntId.get(int));
        io:println("Numeric procedure successfully created");
        io:println("\n");
    } 
    else{
        io:println("\nError ocurred while creating the Numeric procedure\n");
        io:println(result);
        io:println("\n");
    }

    return result;      

}


// string numProcParameters2 = "smallIntInValue smallint, inout smallIntOutValue smallint";
string numProcParameters2 = createParas(values2);
string dropProcParameters2 = createDrops(values2);

function numericalTearDown2(jdbc:Client jdbcClient) returns sql:ExecutionResult|sql:Error{

    sql:ExecutionResult|sql:Error result;


    string query = dropQuery(
        numProcName2,
        dropProcParameters2
    );
    io:println(query);
    result = jdbcClient->execute(query);

    if(result is sql:ExecutionResult){
        io:println("smallAndInttest Procedure is drop Success");
        io:println(result);
        io:println("\n");
    }
    else{
        io:println("smallAndInttest Procedure is drop failed");
        io:println(result);
        io:println("\n");
    }


    return result;  

}







