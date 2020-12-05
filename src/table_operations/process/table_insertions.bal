

import ballerina/io;
import ballerina/java.jdbc;
// import ballerina/auth;
import ballerina/sql;
import ballerina/time;

time:Time time_ = time:currentTime();




function JsonTableInsertions(jdbc:Client jdbcClient) returns sql:ExecutionResult|sql:Error?{

    sql:ExecutionResult|sql:Error? result;
    result = insertJsonTable(jdbcClient,
    
     "{\"bar\": \"baz\", \"balance\": 7.77, \"active\":false}", "{\"bar\": \"baz\", \"balance\": 7.77, \"active\":false}","$.floor[*].apt[*] ? (@.area > 40 && @.area < 90) ? (@.rooms > 2)"

    );
    result = insertJsonTable(jdbcClient,
    
      "{\"bar\": \"baz\", \"balance\": 7.77, \"active\":false}", "{\"bar\": \"baz\", \"balance\": 7.77, \"active\":false}","$.floor[*].apt[*] ? (@.area > 40 && @.area < 90) ? (@.rooms > 2)"  

    );
    return result;

}

function insertJsonTable(jdbc:Client jdbcClient ,string jsonType, string jsonbType, string jsonPathType) returns sql:ExecutionResult|sql:Error?{

// "ID": "SERIAL", 
//             "jsonType":"json",
//             "jsonbType":"jsonb",
//             "jsonpathType":"jsonpath"
   sql:ParameterizedQuery insertQuery =
            `INSERT INTO jsonTypes (
                jsonType, jsonbType, jsonPathType
                             ) 
             VALUES (
                ${jsonType}:: json, ${jsonbType}:: jsonb, ${jsonPathType}:: jsonpath 
            )`;
    

    sql:ExecutionResult|sql:Error result = jdbcClient->execute(insertQuery);

    if (result is sql:ExecutionResult) {
        io:println("\nInsert success, generated Id: ", result.lastInsertId);
    } 
    else{
        io:println("\nError ocurred while insert to numeric table\n");
        io:println(result);
        io:println("\n");
    }
    
    return result;
        

}
function arrayTableInsertions(jdbc:Client jdbcClient) returns sql:ExecutionResult|sql:Error?{

    sql:ExecutionResult|sql:Error? result;
    // result = insertArrayTable(jdbcClient,
    

    //         "{{\"A\"},{\"B\"}}","{\"A\",\"B\",\"\"}", "{1,2,3,4,5}","{{1,2},{3,4}}", "{1,2,3,4}","{1,2,3,4,5,6,7}"
    // );
    // result = insertArrayTable(jdbcClient,
    

    //         "{{\"A\"},{\"B\"}}","{\"A\",\"B\",\"\"}", "{1,2,3,4,5}","{{1,2},{3,4}}", "{1,2,3,4}","{1,2,3,4,5,6,7}"
    // );
    int[] intArray1d;
    intArray1d = [1,2,3];
    sql:ArrayValue intArray1dValue= new (intArray1d); 

    // int[][] intArray2d;
    // intArray2d = [[1,2,3],[1]];
    // sql:ArrayValue intArray2dValue= new (intArray2d); 

    string[] stringArray1d;
    stringArray1d = ["1","2","3"];
    sql:ArrayValue stringArray1dValue= new (stringArray1d); 


    boolean[] booleanArray1d;
    booleanArray1d = [true,false];
    sql:ArrayValue booleanArray1dValue= new (booleanArray1d); 

    byte[][] binaryArray1d;
    byte[] bv = base64 `aGVsbG8gYmFsbGVyaW5hICEhIQ==`;

    binaryArray1d = [bv,bv];
    sql:ArrayValue binaryArray1dValue= new (binaryArray1d); 

    decimal[] floatArray1d;
    floatArray1d = [1.123,3.45];
    sql:ArrayValue floatArray1dValue= new (floatArray1d); 

    result = insertArrayTable(jdbcClient,
    
            
            "{{\"A\"},{\"B\"}}",
            stringArray1dValue, 
            intArray1dValue,
            "{{1,2},{3,4}}", 
            intArray1dValue,
            intArray1dValue,
            booleanArray1dValue,
            intArray1dValue,
            floatArray1dValue
    );
    return result;

}

function insertArrayTable(jdbc:Client jdbcClient ,string textArrayType ,sql:ArrayValue textArray2Type , sql:ArrayValue integerArrayType, string integerArray2Type, sql:ArrayValue arrayType, sql:ArrayValue array2Type
                            ,sql:ArrayValue booleanArrayType ,string|sql:ArrayValue|byte[]  byteaArrayType, sql:ArrayValue floatArrayType
) returns sql:ExecutionResult|sql:Error?{

            // "textArrayType":"text[][]",
            // "textArray2Type":"text[]",
            // "integerArrayType":"int[]",
            // "integerArray2Type":"int[][]",
            // "arrayType":"int array[5]",
            // "array2Type":"int array",
            // "booleanArrayType":"boolean[]",
            // "byteaArrayType":"bytea[]",
            // "floatArrayType":"double precision[]"
   sql:ParameterizedQuery insertQuery =
            `INSERT INTO arrayTypes (
                textArrayType,textArray2Type, integerArrayType,integerArray2Type, arrayType, array2Type, booleanArrayType, byteaArrayType, floatArrayType
                             ) 
             VALUES (
                ${textArrayType}::text[][],
                ${textArray2Type}, 
                ${integerArrayType},
                ${integerArray2Type}::int[][], 
                ${arrayType}, 
                ${array2Type},
                ${booleanArrayType},
                ${byteaArrayType},
                ${floatArrayType}
            )`;
    

    sql:ExecutionResult|sql:Error result = jdbcClient->execute(insertQuery);

    if (result is sql:ExecutionResult) {
        io:println("\nInsert success, generated Id: ", result.lastInsertId);
    } 
    else{
        io:println("\nError ocurred while insert to numeric table\n");
        io:println(result);
        io:println("\n");
    }
    
    return result;
        

}

function ComplexTableInsertions(jdbc:Client jdbcClient) returns sql:ExecutionResult|sql:Error?{

    sql:ExecutionResult|sql:Error? result;
    result = insertComplexTable(jdbcClient,
    

        "(1.1,2.2)","(\"Name\",2,456.32)"
    );
    // complexR ins = {r:10,i:12};
    // sql:StructValue insval = new(ins);
    // result = insertComplexTable(jdbcClient,
    

    //     insval,"(\"Name\",2,456.32)"
    // );
    return result;

}

function insertComplexTable(jdbc:Client jdbcClient ,string|sql:StructValue complexType, string inventoryType) returns sql:ExecutionResult|sql:Error?{

            // "complexType":"complex",
            // "inventoryType":"inventory_item"
   sql:ParameterizedQuery insertQuery =
            `INSERT INTO complexTypes (
                complexType, inventoryType
                             ) 
             VALUES (
                ${complexType}::complex, ${inventoryType}::inventory_item
            )`;
    

    sql:ExecutionResult|sql:Error result = jdbcClient->execute(insertQuery);

    if (result is sql:ExecutionResult) {
        io:println("\nInsert success, generated Id: ", result.lastInsertId);
    } 
    else{
        io:println("\nError ocurred while insert to numeric table\n");
        io:println(result);
        io:println("\n");
    }
    
    return result;
        

}

function RangeTableInsertions(jdbc:Client jdbcClient) returns sql:ExecutionResult|sql:Error?{

    sql:ExecutionResult|sql:Error? result;
    result = insertRangeTable(jdbcClient,
    

        "(2,50)","(10,100)","(0,24)","(2010-01-01 14:30, 2010-01-01 15:30)","(2010-01-01 14:30, 2010-01-01 15:30)","(2010-01-01 14:30, 2010-01-03 )","(1,4)"
    );
    result = insertRangeTable(jdbcClient,
    

        "(1,3)","(10,100)","(0,24)","(2010-01-01 14:30, 2010-01-01 15:30)","(2010-01-01 14:30, 2010-01-01 15:30)","(2010-01-01 14:30, 2010-01-01 )","(2,12)"
    );
    return result;

}

function insertRangeTable(jdbc:Client jdbcClient ,string int4rangeType, string int8rangeType, string numrangeType,string tsrangeType,string tstzrangeType,string daterangeType, string floatrangeType) returns sql:ExecutionResult|sql:Error?{

            // "int4rangeType":"int4range",
            // "int8rangeType":"int8range",
            // "numrangeType":"numrange",
            // "tsrangeType":"tsrange",
            // "tstzrangeType":"tstzrange",
            // "daterangeType":"daterange",
            // "floatrangeType":"floatrange"
   sql:ParameterizedQuery insertQuery =
            `INSERT INTO rangeTypes (
                int4rangeType, int8rangeType, numrangeType, tsrangeType, tstzrangeType, daterangeType, floatrangeType
                             ) 
             VALUES (
                ${int4rangeType}::int4range, ${int8rangeType}::int8range, ${numrangeType}::numrange, ${tsrangeType}::tsrange, ${tstzrangeType}::tstzrange, ${daterangeType}::daterange, ${floatrangeType}::floatrange

            )`;
    

    sql:ExecutionResult|sql:Error result = jdbcClient->execute(insertQuery);

    if (result is sql:ExecutionResult) {
        io:println("\nInsert success, generated Id: ", result.lastInsertId);
    } 
    else{
        io:println("\nError ocurred while insert to numeric table\n");
        io:println(result);
        io:println("\n");
    }
    
    return result;
        

}

    byte[] byteval = [1,2,3,4,5];

    sql:TimestampValue timeStamptzValue2= new("2004-10-19 10:23:54");

    int[] intarr = [1,2,3];

    sql:ArrayValue arrVal = new(intarr);

function domainTableInsertions(jdbc:Client jdbcClient) returns sql:ExecutionResult|sql:Error?{

    sql:ExecutionResult|sql:Error? result;
    

        result = insertDomainTable(jdbcClient,
    
        2147483647,32767,9223372036854775807,
        123456.123456,123456.123456,0.123456,123456654321.123,
        "CHAR","VARCHAR","TEXT","name",
        byteval
        ,timeStamptzValue2
        ,true
        ,arrVal

    );

    return result;

}




function insertDomainTable(jdbc:Client jdbcClient ,string|int posintType,string|int dsmallintType,string|int dbigintType

,string|int|decimal ddecimalType,string|int|decimal dnumericType,string|int|float drealType,string|int|float ddoubleType
,string dcharType,string dvarcharType,string dtextType,string dnameType
,byte[] dbyteaType
,sql:TimestampValue dtstzType
,boolean dbooleanType,
sql:ArrayValue dintarrayType
) returns sql:ExecutionResult|sql:Error?{

            // "posintType":"posint"

            // 
   sql:ParameterizedQuery insertQuery =
            `INSERT INTO domainTypes (
                posintType,dsmallintType,dbigintType
                ,ddecimalType,dnumericType,drealType,ddoubleType
                ,dcharType,dvarcharType,dtextType,dnameType,dbyteaType
                ,dtstzType
                ,dbooleanType
                ,dintarrayType
                ) 
             VALUES (
                ${posintType},
                ${dsmallintType},
                ${dbigintType},
                ${ddecimalType},
                ${dnumericType},
                ${drealType},
                ${ddoubleType},
                ${dcharType},
                ${dvarcharType},
                ${dtextType},
                ${dnameType},
                ${dbyteaType},
                ${dtstzType},
                ${dbooleanType},
                ${dintarrayType}

            )`;
    

    sql:ExecutionResult|sql:Error result = jdbcClient->execute(insertQuery);

    if (result is sql:ExecutionResult) {
        io:println("\nInsert success, generated Id: ", result.lastInsertId);
    } 
    else{
        io:println("\nError ocurred while insert to numeric table\n");
        io:println(result);
        io:println("\n");
    }
    
    return result;
        

}



function objectIdentifierTableInsertions(jdbc:Client jdbcClient) returns sql:ExecutionResult|sql:Error?{

    sql:ExecutionResult|sql:Error? result;
    result = insertObjectIdentifierTable(jdbcClient,
    
        "564182","pg_type","english","simple","pg_catalog","!","*(int,int)","NOW","sum(int4)","postgres","int"

    );
    // result = insertObjectIdentifierTable(jdbcClient,
    
    //     "564182","pg_type","english","simple","pg_catalog","*","*(integer,​integer) or -(NONE,​integer)","sum","sum(int4)","smithee","integer"

    // );
    return result;

}

function insertObjectIdentifierTable(jdbc:Client jdbcClient ,string oidType, string regclassType, string regconfigType, string regdictionaryType, string regnamespaceType, string regoperType, string regoperatorType, string regprocType, string regprocedureType, string regroleType, string regtypeType ) returns sql:ExecutionResult|sql:Error?{

    //         "oidType" : "oid",
    //         "regclassType" : "regclass",
    //         "regconfigType" : "regconfig",Are we going to have the meeting tonight
    //         "regdictionaryType" : "regdictionary",
    //         "regnamespaceType" : "regnamespace",
    //         "regoperType" : "regoper",
    //         "regoperatorType" : "regoperator",
    //         "regprocType" : "regproc",
    //         "regprocedureType" : "regprocedure",
    //         "regroleType" : "regrole",
    //         "regtypeType" : "regtype"
   sql:ParameterizedQuery insertQuery =
            `INSERT INTO objectIdentifierTypes (
                oidType, regclassType, regconfigType, regdictionaryType, regnamespaceType, regoperType, regoperatorType, regprocType, regprocedureType, regroleType, regtypeType
                             ) 
             VALUES (
                ${oidType} ::oid,
                 ${regclassType} ::regclass, ${regconfigType} ::regconfig, ${regdictionaryType} ::regdictionary, ${regnamespaceType} ::regnamespace, ${regoperType} ::regoper, ${regoperatorType} ::regoperator, ${regprocType} ::regproc, ${regprocedureType} ::regprocedure, ${regroleType} ::regrole, ${regtypeType} ::regtype
            )`;
    

    sql:ExecutionResult|sql:Error result = jdbcClient->execute(insertQuery);

    if (result is sql:ExecutionResult) {
        io:println("\nInsert success, generated Id: ", result.lastInsertId);
    } 
    else{
        io:println("\nError ocurred while insert to numeric table\n");
        io:println(result);
        io:println("\n");
    }
    
    return result;
        

}



function pslgnTableInsertions(jdbc:Client jdbcClient) returns sql:ExecutionResult|sql:Error?{

    sql:ExecutionResult|sql:Error? result;
    result = insertPslgnTable(jdbcClient,
    
        "16/B374D848"

    );
    result = insertPslgnTable(jdbcClient,
    
        "16/B374D848"

    );
    return result;

}

function insertPslgnTable(jdbc:Client jdbcClient ,string pglsnType) returns sql:ExecutionResult|sql:Error?{

            // "pglsnType" : "pg_lsn"
   sql:ParameterizedQuery insertQuery =
            `INSERT INTO pglsnTypes (
                pglsnType
                             ) 
             VALUES (
                ${pglsnType}::pg_lsn
            )`;
    

    sql:ExecutionResult|sql:Error result = jdbcClient->execute(insertQuery);

    if (result is sql:ExecutionResult) {
        io:println("\nInsert success, generated Id: ", result.lastInsertId);
    } 
    else{
        io:println("\nError ocurred while insert to numeric table\n");
        io:println(result);
        io:println("\n");
    }
    
    return result;
        

}


