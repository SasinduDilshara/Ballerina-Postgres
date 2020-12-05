

// import ballerina/io;
import ballerina/java.jdbc;
// import ballerina/auth;
import ballerina/sql;
import ballerina/time;



time:Time time = time:currentTime();

function proceduresCreations(jdbc:Client jdbcClient)  returns sql:ExecutionResult|sql:Error {

    sql:ExecutionResult|sql:Error result;

    result = createNumericProcedures(jdbcClient);
    result = createNumericProcedures2(jdbcClient);
    result = createMoneyProcedures(jdbcClient);
    result = createCharacterProcedures(jdbcClient);
    result = createBinaryProcedures(jdbcClient);
    result = createDatetimeProcedures(jdbcClient);

    result = createBooleanProcedures(jdbcClient);
    result = createGeometricProcedures(jdbcClient);
    result = createNetworkProcedures(jdbcClient);
    result = createBitProcedures(jdbcClient);
    result = createTextsearchProcedures(jdbcClient);

    result = createUuidProcedures(jdbcClient);
    result = createXmlProcedures(jdbcClient);
    result = createJsonProcedures(jdbcClient);
    result = createArrayProcedures(jdbcClient);
    result = createRangeProcedures(jdbcClient);

    result = createDomainProcedures(jdbcClient);
    result = createObjectidentifierProcedures(jdbcClient);
    result = createPglsnProcedures(jdbcClient);
    result = createEnumProcedures(jdbcClient);
    result = createComplexProcedures(jdbcClient);

    // result = createAnyProcedures(jdbcClient);

    return result;       

}




sql:CharValue charVal1 = new("A");
sql:CharValue charVal2 = new("A");

// string charVal1 = "A";
// string charVal2 = "A";

sql:TextValue TextVal1 = new("A");
sql:TextValue TextVal2 = new("A");

// string TextVal1 = "A";
// string TextVal2 = "A";

// byte[] byteVal1 = [1,2,3,4,5,6];
// byte[] byteVal2 = [1,2,3,4,5,6];











int inter = 4;



// string bitn = "0000000001";
// string varbitn = "01110";
// string bit = "0";

    // result = xmlProcedureCall(jdbcClient,
    //     xmlVal,xmlVal
    // );





// string xmlVal = "<foo><tag>bar</tag><tag>tag</tag></foo>";
string jsonVal = "{\"name\":\"Hello\"}";

// string arrVal = "{1,2,3,4}";

// int[]  arr = [32767,32767,32767,32767];
// sql:ArrayValue arrVal = new(arrIntVal);

// decimal[] arr = [1.1,2.1,0.113,4.1];

// string[] arr = ["A","B"];

// byte[][] arr = [[1,2,3],[1,2,3]];

// boolean[] arr = [true,false];

// sql:IntegerValue[] arr = [lowerInt,lowerInt];



// int dom1 = 1;
string oi1 = "564182";
string pg = "16/B374D848";
string enVal = "value1";


string anyVal1 = "1";
string anyVal2= "[1,2,3,4,5]";
string anyVal3 = "3";
string anyVal4 = "value1";
string anyVal5 = "(1,4)";
string anyVal6 = "{ID:1}";


function proceduresCalls(jdbc:Client jdbcClient)  returns sql:ProcedureCallResult|sql:Error {

    sql:ProcedureCallResult|sql:Error result;


    // result = numericProcedureCall2(
    //     jdbcClient,lowerSmallInt,lowerSmallInt
    //     ,lowerInt2,upperInt2
    // );




    // result = characterProcedureCall(jdbcClient,
    //     charVal1,charVal2
    //     ,"A","A"
    //     ,TextVal1,TextVal2
    //     ,"A","A"
    // );
    // io:println(byteVal1.value);

 
























    // result = pglsnProcedureCall(jdbcClient,
    //     pg,pg
    // );






    // result = anyProcedureCall(jdbcClient,
    //     anyVal1,anyVal1,arrVal,arrVal,anyVal3,anyVal3,anyVal4,anyVal4,anyVal5,anyVal5,anyVal6,anyVal6
    // );

    return result;   

}

//.....................................................................................................................................................






















function tearDown(jdbc:Client jdbcClient) returns sql:ExecutionResult|sql:Error{

    sql:ExecutionResult|sql:Error result;


    result = numericalTearDown(jdbcClient);
    result = numericalTearDown2(jdbcClient);
    result = moneyTearDown(jdbcClient);
    result = CharacterTearDown(jdbcClient);
    result = binaryTearDown(jdbcClient);
    result = datetimeTearDown(jdbcClient);

    result = booleanTearDown(jdbcClient);
    result = geometricTearDown(jdbcClient);
    result = networkTearDown(jdbcClient);
    result = bitTearDown(jdbcClient);
    result = textsearchTearDown(jdbcClient);

    result = uuidTearDown(jdbcClient);
    result = xmlTearDown(jdbcClient);
    result = jsonTearDown(jdbcClient);
    result = arrayTearDown(jdbcClient);
    result = rangeTearDown(jdbcClient);

    result = domainTearDown(jdbcClient);
    result = objectidentifierTearDown(jdbcClient);
    result = pglsnTearDown(jdbcClient);
    result = enumTearDown(jdbcClient);
    result = complexTearDown(jdbcClient);

    // result = anyTearDown(jdbcClient);

    return result;

}

