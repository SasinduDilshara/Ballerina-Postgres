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










string complexProcName = "complextest";
map<string> cplxValues = {
    "complexInValue": "complex","inout complexInOutValue":"complex"
};
string complexProcParameters = createParas( cplxValues);
string dropComplexProcParameters = createDrops( cplxValues);

function createComplexProcedures(jdbc:Client jdbcClient) returns sql:ExecutionResult|sql:Error{

    sql:ExecutionResult|sql:Error result;

    string query = createQuery(
        complexProcName,
        complexProcParameters,
        "select complexInValue into complexInOutValue;"
        
    );
    io:println(query);
    result = jdbcClient->execute(query);

    if(result is sql:ExecutionResult){
        io:println("complex Procedure is initialization Success");
        io:println(result);
        io:println("\n");
    }
    else{
        io:println("complex Procedure is initialization failed");
        io:println(result);
        io:println("\n");
    }


    return result;  

}

function complexProcedureCall(jdbc:Client jdbcClient,
    string complexInput,        string complexInOut
    )  returns sql:ProcedureCallResult|sql:Error {

// ${inSmallInput} 


    sql:ProcedureCallResult|sql:Error result;

    sql:InOutParameter complexInOutId = new (complexInOut);
    
    sql:ParameterizedCallQuery callQuery =
            `call complextest(
                ${complexInput}::complex,
                ${complexInOutId}              
            )`;
    

    result = jdbcClient->call(callQuery);

    if (result is sql:ProcedureCallResult) {
        io:println("\n");
        io:println(result);
        io:println("complex value"," - ",complexInOutId.get(string));
        io:println("complex procedure successfully created");
        io:println("\n");
    } 
    else{
        io:println("\nError ocurred while creating the complex procedure\n");
        io:println(result);
        io:println("\n");
    }

    return result;      

}

function complexTearDown(jdbc:Client jdbcClient) returns sql:ExecutionResult|sql:Error{

    sql:ExecutionResult|sql:Error result;


    string query = dropQuery(
        complexProcName,
        dropComplexProcParameters
    );
    io:println(query);
    result = jdbcClient->execute(query);

    if(result is sql:ExecutionResult){
        io:println("complex Procedure is drop Success");
        io:println(result);
        io:println("\n");
    }
    else{
        io:println("complex Procedure is drop failed");
        io:println(result);
        io:println("\n");
    }


    return result;  

}









//.....................................................................................................................................................



string enumProcName = "enumtest";
map<string> enumValues = {
    "enumValuesInValue": "enumValues","inout enumValuesInOutValue":"enumValues"
};
string enumProcParameters = createParas( enumValues);
string dropEnumProcParameters = createDrops( enumValues);

function createEnumProcedures(jdbc:Client jdbcClient) returns sql:ExecutionResult|sql:Error{

    sql:ExecutionResult|sql:Error result;

    string query = createQuery(
        enumProcName,
        enumProcParameters,
        "select enumValuesInValue into enumValuesInOutValue;"
        
    );
    io:println(query);
    result = jdbcClient->execute(query);

    if(result is sql:ExecutionResult){
        io:println("enum Procedure is initialization Success");
        io:println(result);
        io:println("\n");
    }
    else{
        io:println("enum Procedure is initialization failed");
        io:println(result);
        io:println("\n");
    }


    return result;  

}

function enumProcedureCall(jdbc:Client jdbcClient,
    string enumValuesInput,        string enumValuesInOut
    )  returns sql:ProcedureCallResult|sql:Error {

// ${inSmallInput} 


    sql:ProcedureCallResult|sql:Error result;

    sql:InOutParameter enumValuesInOutId = new (enumValuesInOut);
    
    sql:ParameterizedCallQuery callQuery =
            `call enumtest(
                ${enumValuesInput}::enumvalues,
                ${enumValuesInOutId}::enumvalues              
            )`;
    

    result = jdbcClient->call(callQuery);

    if (result is sql:ProcedureCallResult) {
        io:println("\n");
        io:println(result);
        io:println("enum value"," - ",enumValuesInOutId.get(string));
        io:println("enum procedure successfully created");
        io:println("\n");
    } 
    else{
        io:println("\nError ocurred while creating the enum procedure\n");
        io:println(result);
        io:println("\n");
    }

    return result;      

}

function enumTearDown(jdbc:Client jdbcClient) returns sql:ExecutionResult|sql:Error{

    sql:ExecutionResult|sql:Error result;


    string query = dropQuery(
        enumProcName,
        dropEnumProcParameters
    );
    io:println(query);
    result = jdbcClient->execute(query);

    if(result is sql:ExecutionResult){
        io:println("enum Procedure is drop Success");
        io:println(result);
        io:println("\n");
    }
    else{
        io:println("enum Procedure is drop failed");
        io:println(result);
        io:println("\n");
    }


    return result;  

}







//......................................................................................................................................................



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






//......................................................................................................................................................

string objectidentifierProcName = "objectidentifiertest";
map<string> oiValues = {
    "oidInValue": "oid","inout oidInOutValue":"oid"
};
string objectidentifierProcParameters = createParas( oiValues);
string dropObjectidentifierProcParameters = createDrops( oiValues);

function createObjectidentifierProcedures(jdbc:Client jdbcClient) returns sql:ExecutionResult|sql:Error{

    sql:ExecutionResult|sql:Error result;

    string query = createQuery(
        objectidentifierProcName,
        objectidentifierProcParameters,
        "select oidInValue into oidInOutValue;"
        
    );
    io:println(query);
    result = jdbcClient->execute(query);

    if(result is sql:ExecutionResult){
        io:println("objectidentifier Procedure is initialization Success");
        io:println(result);
        io:println("\n");
    }
    else{
        io:println("objectidentifier Procedure is initialization failed");
        io:println(result);
        io:println("\n");
    }


    return result;  

}

function objectidentifierProcedureCall(jdbc:Client jdbcClient,
    string oidInput,        string oidInOut
    )  returns sql:ProcedureCallResult|sql:Error {

// ${inSmallInput} 


    sql:ProcedureCallResult|sql:Error result;

    sql:InOutParameter oidInOutId = new (oidInOut);
    
    sql:ParameterizedCallQuery callQuery =
            `call objectidentifiertest(
                ${oidInput}::oid,
                ${oidInOutId}              
            )`;
    

    result = jdbcClient->call(callQuery);

    if (result is sql:ProcedureCallResult) {
        io:println("\n");
        io:println(result);
        io:println("objectidentifier value"," - ",oidInOutId.get(string));
        io:println("objectidentifier procedure successfully created");
        io:println("\n");
    } 
    else{
        io:println("\nError ocurred while creating the objectidentifier procedure\n");
        io:println(result);
        io:println("\n");
    }

    return result;      

}

function objectidentifierTearDown(jdbc:Client jdbcClient) returns sql:ExecutionResult|sql:Error{

    sql:ExecutionResult|sql:Error result;


    string query = dropQuery(
        objectidentifierProcName,
        dropObjectidentifierProcParameters
    );
    io:println(query);
    result = jdbcClient->execute(query);

    if(result is sql:ExecutionResult){
        io:println("objectidentifier Procedure is drop Success");
        io:println(result);
        io:println("\n");
    }
    else{
        io:println("objectidentifier Procedure is drop failed");
        io:println(result);
        io:println("\n");
    }


    return result;  

}






//......................................................................................................................................................
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
    sql:IntegerValue intInput,        sql:IntegerValue intInOut
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






//......................................................................................................................................................

string rangeProcName = "rangetest";
map<string> rangValues = {
    "int4rangeInValue": "int4range","inout int4rangeInOutValue":"int4range"
};
string rangeProcParameters = createParas( rangValues);
string dropRangeProcParameters = createDrops( rangValues);

function createRangeProcedures(jdbc:Client jdbcClient) returns sql:ExecutionResult|sql:Error{

    sql:ExecutionResult|sql:Error result;

    string query = createQuery(
        rangeProcName,
        rangeProcParameters,
        "select int4rangeInValue into int4rangeInOutValue;"
        
    );
    io:println(query);
    result = jdbcClient->execute(query);

    if(result is sql:ExecutionResult){
        io:println("range Procedure is initialization Success");
        io:println(result);
        io:println("\n");
    }
    else{
        io:println("range Procedure is initialization failed");
        io:println(result);
        io:println("\n");
    }


    return result;  

}

function rangeProcedureCall(jdbc:Client jdbcClient,
    string int4rangeInput,        string int4rangeInOut
    )  returns sql:ProcedureCallResult|sql:Error {

// ${inSmallInput} 


    sql:ProcedureCallResult|sql:Error result;

    sql:InOutParameter int4rangeInOutId = new (int4rangeInOut);
    
    sql:ParameterizedCallQuery callQuery =
            `call rangetest(
                ${int4rangeInput}::int4range,
                ${int4rangeInOutId}              
            )`;
    

    result = jdbcClient->call(callQuery);

    if (result is sql:ProcedureCallResult) {
        io:println("\n");
        io:println(result);
        io:println("range value"," - ",int4rangeInOutId.get(string));
        io:println("range procedure successfully created");
        io:println("\n");
    } 
    else{
        io:println("\nError ocurred while creating the range procedure\n");
        io:println(result);
        io:println("\n");
    }

    return result;      

}

function rangeTearDown(jdbc:Client jdbcClient) returns sql:ExecutionResult|sql:Error{

    sql:ExecutionResult|sql:Error result;


    string query = dropQuery(
        rangeProcName,
        dropRangeProcParameters
    );
    io:println(query);
    result = jdbcClient->execute(query);

    if(result is sql:ExecutionResult){
        io:println("range Procedure is drop Success");
        io:println(result);
        io:println("\n");
    }
    else{
        io:println("range Procedure is drop failed");
        io:println(result);
        io:println("\n");
    }


    return result;  

}










//.....................................................................................................................................................
string arrayProcName = "arraytest";
map<string> arrayValues = {
    "arrayInValue": "double precision[]","inout arrayInOutValue":"double precision[]"
};
string arrayProcParameters = createParas( arrayValues);
string dropArrayProcParameters = createDrops( arrayValues);

function createArrayProcedures(jdbc:Client jdbcClient) returns sql:ExecutionResult|sql:Error{

    sql:ExecutionResult|sql:Error result;

    string query = createQuery(
        arrayProcName,
        arrayProcParameters,
        "select arrayInValue into arrayInOutValue;"
        
    );
    io:println(query);
    result = jdbcClient->execute(query);

    if(result is sql:ExecutionResult){
        io:println("array Procedure is initialization Success");
        io:println(result);
        io:println("\n");
    }
    else{
        io:println("array Procedure is initialization failed");
        io:println(result);
        io:println("\n");
    }


    return result;  

}

public type arrayGet record {
    
};

function arrayProcedureCall(jdbc:Client jdbcClient,
    sql:ArrayValue arrayInput,        sql:ArrayValue arrayInOut
    )  returns sql:ProcedureCallResult|sql:Error {

// ${inSmallInput} 


    sql:ProcedureCallResult|sql:Error result;

    sql:InOutParameter arrayInOutId = new (arrayInOut);
    
    sql:ParameterizedCallQuery callQuery =
            `call arraytest(
                ${arrayInput},
                ${arrayInOutId}              
            )`;
    

    result = jdbcClient->call(callQuery);

    if (result is sql:ProcedureCallResult) {
        io:println("\n");
        io:println(result);
        // io:println("array value"," - ",arrayInOutId.get(arrayGet));
        io:println("array value"," - ",arrayInOutId);
        io:println("array procedure successfully created");
        io:println("\n");
    } 
    else{
        io:println("\nError ocurred while creating the array procedure\n");
        io:println(result);
        io:println("\n");
    }

    return result;      

}

function arrayTearDown(jdbc:Client jdbcClient) returns sql:ExecutionResult|sql:Error{

    sql:ExecutionResult|sql:Error result;


    string query = dropQuery(
        arrayProcName,
        dropArrayProcParameters
    );
    io:println(query);
    result = jdbcClient->execute(query);

    if(result is sql:ExecutionResult){
        io:println("array Procedure is drop Success");
        io:println(result);
        io:println("\n");
    }
    else{
        io:println("array Procedure is drop failed");
        io:println(result);
        io:println("\n");
    }


    return result;  

}







//......................................................................................................................................................


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







//......................................................................................................................................................





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

// ${inSmallInput} 


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








//......................................................................................................................................................






string uuidProcName = "uuidtest";
map<string> uidValues = {
    "uuidInValue": "uuid","inout uuidInOutValue":"uuid"
};
string uuidProcParameters = createParas( uidValues);
string dropUuidProcParameters = createDrops( uidValues);

function createUuidProcedures(jdbc:Client jdbcClient) returns sql:ExecutionResult|sql:Error{

    sql:ExecutionResult|sql:Error result;

    string query = createQuery(
        uuidProcName,
        uuidProcParameters,
        "select uuidInValue into uuidInOutValue;"
        
    );
    io:println(query);
    result = jdbcClient->execute(query);

    if(result is sql:ExecutionResult){
        io:println("uuid Procedure is initialization Success");
        io:println(result);
        io:println("\n");
    }
    else{
        io:println("uuid Procedure is initialization failed");
        io:println(result);
        io:println("\n");
    }


    return result;  

}

function uuidProcedureCall(jdbc:Client jdbcClient,
    string uuidInput,        string uuidInOut
    )  returns sql:ProcedureCallResult|sql:Error {

// ${inSmallInput} 


    sql:ProcedureCallResult|sql:Error result;

    sql:InOutParameter uuidInOutId = new (uuidInOut);
    
    sql:ParameterizedCallQuery callQuery =
            `call uuidtest(
                ${uuidInput}::uuid,
                ${uuidInOutId}              
            )`;
    

    result = jdbcClient->call(callQuery);

    if (result is sql:ProcedureCallResult) {
        io:println("\n");
        io:println(result);
        io:println("uuid value"," - ",uuidInOutId.get(string));
        io:println("uuid procedure successfully created");
        io:println("\n");
    } 
    else{
        io:println("\nError ocurred while creating the uuid procedure\n");
        io:println(result);
        io:println("\n");
    }

    return result;      

}

function uuidTearDown(jdbc:Client jdbcClient) returns sql:ExecutionResult|sql:Error{

    sql:ExecutionResult|sql:Error result;


    string query = dropQuery(
        uuidProcName,
        dropUuidProcParameters
    );
    io:println(query);
    result = jdbcClient->execute(query);

    if(result is sql:ExecutionResult){
        io:println("uuid Procedure is drop Success");
        io:println(result);
        io:println("\n");
    }
    else{
        io:println("uuid Procedure is drop failed");
        io:println(result);
        io:println("\n");
    }


    return result;  

}







//......................................................................................................................................................



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








//......................................................................................................................................................


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







//......................................................................................................................................................


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




//......................................................................................................................................................


string geometricProcName = "geometrictest";
map<string> geoValues = {
    "pointInValue": "point","inout pointInOutValue":"point"
};
string geometricProcParameters = createParas(geoValues);
string dropGeometricProcParameters = createDrops(geoValues);

function createGeometricProcedures(jdbc:Client jdbcClient) returns sql:ExecutionResult|sql:Error{

    sql:ExecutionResult|sql:Error result;

    string query = createQuery(
        geometricProcName,
        geometricProcParameters,
        "select pointInValue into pointInOutValue;"
        
    );
    io:println(query);
    result = jdbcClient->execute(query);

    if(result is sql:ExecutionResult){
        io:println("Geometric Procedure is initialization Success");
        io:println(result);
        io:println("\n");
    }
    else{
        io:println("Geometric Procedure is initialization failed");
        io:println(result);
        io:println("\n");
    }


    return result;  

}

function geometricProcedureCall(jdbc:Client jdbcClient,
    string pointInput,        string pointInOut
    )  returns sql:ProcedureCallResult|sql:Error {

// ${inSmallInput} 


    sql:ProcedureCallResult|sql:Error result;

    sql:InOutParameter pointInOutId = new (pointInOut);
    
    sql:ParameterizedCallQuery callQuery =
            `call geometrictest(
                ${pointInput}::point,
                ${pointInOutId}              
            )`;
    

    result = jdbcClient->call(callQuery);

    if (result is sql:ProcedureCallResult) {
        io:println("\n");
        io:println(result);
        io:println("geometric value"," - ",pointInOutId.get(string));
        io:println("geometric procedure successfully created");
        io:println("\n");
    } 
    else{
        io:println("\nError ocurred while creating the geometric procedure\n");
        io:println(result);
        io:println("\n");
    }

    return result;      

}

function geometricTearDown(jdbc:Client jdbcClient) returns sql:ExecutionResult|sql:Error{

    sql:ExecutionResult|sql:Error result;


    string query = dropQuery(
        geometricProcName,
        dropGeometricProcParameters
    );
    io:println(query);
    result = jdbcClient->execute(query);

    if(result is sql:ExecutionResult){
        io:println("Geometric Procedure is drop Success");
        io:println(result);
        io:println("\n");
    }
    else{
        io:println("Geometric Procedure is drop failed");
        io:println(result);
        io:println("\n");
    }


    return result;  

}

//-----------------------------------------------------------------------------------------------------------------------------------------------











































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







