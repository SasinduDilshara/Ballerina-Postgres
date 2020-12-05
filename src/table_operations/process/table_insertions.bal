

import ballerina/io;
import ballerina/java.jdbc;
// import ballerina/auth;
import ballerina/sql;
import ballerina/time;

time:Time time_ = time:currentTime();








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


