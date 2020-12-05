
import ballerina/io;
import ballerina/java.jdbc;
// import ballerina/auth;
import ballerina/sql;
// import ballerina/time;




function createXmlTable(jdbc:Client jdbcClient) returns int|string|sql:Error?{

   string tableName = "xmlTypes";

        CreateQueries createTableQuery = createQueryMaker({
            "ID": "SERIAL", 
            "xmlType":"xml"
        },"ID");

        int|string|sql:Error? initResult = initializeTable(jdbcClient, tableName , createTableQuery.createQuery);
        if (initResult is int) {
            io:println("Sample executed successfully!");
        } 
        else if (initResult is sql:Error) {
            io:println("Customer table initialization failed: ", initResult);
    }

    return initResult;

}

function createJsonTable(jdbc:Client jdbcClient) returns int|string|sql:Error?{

   string tableName = "jsonTypes";

        CreateQueries createTableQuery = createQueryMaker({
            "ID": "SERIAL", 
            "jsonType":"json",
            "jsonbType":"jsonb",
            "jsonpathType":"jsonpath"
        },"ID");

        int|string|sql:Error? initResult = initializeTable(jdbcClient, tableName , createTableQuery.createQuery);
        if (initResult is int) {
            io:println("Sample executed successfully!");
        } 
        else if (initResult is sql:Error) {
            io:println("Customer table initialization failed: ", initResult);
    }

    return initResult;

}

function createArrayTable(jdbc:Client jdbcClient) returns int|string|sql:Error?{

   string tableName = "arrayTypes";

        CreateQueries createTableQuery = createQueryMaker({
            "ID": "SERIAL", 
            "textArrayType":"text[][]",
            "textArray2Type":"text[]",
            "integerArrayType":"int[]",
            "integerArray2Type":"int[][]",
            "arrayType":"int array[5]",
            "array2Type":"int array",
            "booleanArrayType":"boolean[]",
            "byteaArrayType":"int[]",
            "floatArrayType":"double precision[]"
        },"ID");

        int|string|sql:Error? initResult = initializeTable(jdbcClient, tableName , createTableQuery.createQuery);
        if (initResult is int) {
            io:println("Sample executed successfully!");
        } 
        else if (initResult is sql:Error) {
            io:println("Customer table initialization failed: ", initResult);
    }

    return initResult;

}

function createCompositeTable(jdbc:Client jdbcClient) returns int|string|sql:Error?{

   string tableName = "complexTypes";

        CreateQueries createTableQuery = createQueryMaker({
            "ID": "SERIAL", 
            "complexType":"complex",
            "inventoryType":"inventory_item"
        },"ID");

        int|string|sql:Error? initResult = initializeTable(jdbcClient, tableName , createTableQuery.createQuery);
        if (initResult is int) {
            io:println("Sample executed successfully!");
        } 
        else if (initResult is sql:Error) {
            io:println("Customer table initialization failed: ", initResult);
    }

    return initResult;

}


function createRangeTable(jdbc:Client jdbcClient) returns int|string|sql:Error?{

   string tableName = "rangeTypes";

        CreateQueries createTableQuery = createQueryMaker({
            "ID": "SERIAL", 
            "int4rangeType":"int4range",
            "int8rangeType":"int8range",
            "numrangeType":"numrange",
            "tsrangeType":"tsrange",
            "tstzrangeType":"tstzrange",
            "daterangeType":"daterange",
            "floatrangeType":"floatrange"
        },"ID");

        int|string|sql:Error? initResult = initializeTable(jdbcClient, tableName , createTableQuery.createQuery);
        if (initResult is int) {
            io:println("Sample executed successfully!");
        } 
        else if (initResult is sql:Error) {
            io:println("Customer table initialization failed: ", initResult);
    }

    return initResult;

}

function createDomainTable(jdbc:Client jdbcClient) returns int|string|sql:Error?{

   string tableName = "domainTypes";

        CreateQueries createTableQuery = createQueryMaker({
            "ID": "SERIAL", 
            "posintType":"posint",
            "dsmallintType":"dsmallint",
            "dbigintType":"dbigint",
            "ddecimalType":"ddecimal",
            "dnumericType":"dnumeric",
            "drealType":"dreal",
            "ddoubleType":"ddouble",
            "dcharType":"dchar",
            "dvarcharType":"dvarchar",
            "dtextType":"dtext",
            "dnameType":"dname",
            "dbyteaType":"dbytea"
            ,"dtstzType":"dtstz"
            ,"dbooleanType":"dboolean"
            ,"dintarrayType":"dintarray"
            // ,"dxmlType":"dxml"
        },"ID");

        int|string|sql:Error? initResult = initializeTable(jdbcClient, tableName , createTableQuery.createQuery);
        if (initResult is int) {
            io:println("Sample executed successfully!");
        } 
        else if (initResult is sql:Error) {
            io:println("Customer table initialization failed: ", initResult);
    }

    return initResult;

}

function createObjectIdentifierTable(jdbc:Client jdbcClient) returns int|string|sql:Error?{

   string tableName = "objectIdentifierTypes";

        CreateQueries createTableQuery = createQueryMaker({
            "ID": "SERIAL", 
            "oidType" : "oid",
            "regclassType" : "regclass",
            // "regcollationType" : "regcollation",
            "regconfigType" : "regconfig",
            "regdictionaryType" : "regdictionary",
            "regnamespaceType" : "regnamespace",
            "regoperType" : "regoper",
            "regoperatorType" : "regoperator",
            "regprocType" : "regproc",
            "regprocedureType" : "regprocedure",
            "regroleType" : "regrole",
            "regtypeType" : "regtype"
        },"ID");

        int|string|sql:Error? initResult = initializeTable(jdbcClient, tableName , createTableQuery.createQuery);
        if (initResult is int) {
            io:println("Sample executed successfully!");
        } 
        else if (initResult is sql:Error) {
            io:println("Customer table initialization failed: ", initResult);
    }

    return initResult;

}

function createPglsnTable(jdbc:Client jdbcClient) returns int|string|sql:Error?{

   string tableName = "pglsnTypes";

        CreateQueries createTableQuery = createQueryMaker({
            "ID": "SERIAL", 
            "pglsnType" : "pg_lsn"
        },"ID");

        int|string|sql:Error? initResult = initializeTable(jdbcClient, tableName , createTableQuery.createQuery);
        if (initResult is int) {
            io:println("Sample executed successfully!");
        } 
        else if (initResult is sql:Error) {
            io:println("Customer table initialization failed: ", initResult);
    }

    return initResult;

}

// function createPseudoTypeTable(jdbc:Client jdbcClient) returns int|string|sql:Error?{

//    string tableName = "pseudoTypes";

//         CreateQueries createTableQuery = createQueryMaker({
//             "ID": "SERIAL", 
//             "anyType" : "any",
//             "anyelementType" : "anyelement",
//             "anyarrayType" : "anyarray",
//             "anynonarrayType" : "anynonarray",
//             "anyenumType" : "anyenum",
//             "anyrangeType" : "anyrange",
//             "anycompatibleType" : "anycompatible",
//             "anycompatiblearrayType" : "anycompatiblearray",
//             "anycompatiblenonarrayType" : "anycompatiblenonarray",
//             "anycompatiblerangeType" : "anycompatiblerange",
//             "cstringType" : "cstring",
//             "internalType" : "internal",
//             "language_handlerType" : "language_handler",
//             "fdw_handlerType" : "fdw_handler",
//             "table_am_handlerType" : "table_am_handler",
//             "index_am_handlerType" : "index_am_handler",
//             "tsm_handlerType" : "tsm_handler",
//             "recordType" : "record",
//             "triggerType" : "trigger",
//             "event_triggerType" : "event_trigger",
//             "pg_ddl_commandType" : "pg_ddl_command",
//             "voidType" : "void",
//             "unknownType" : "unknown"
//         },"ID");

//         int|string|sql:Error? initResult = initializeTable(jdbcClient, tableName , createTableQuery.createQuery);
//         if (initResult is int) {
//             io:println("Sample executed successfully!");
//         } 
//         else if (initResult is sql:Error) {
//             io:println("Customer table initialization failed: ", initResult);
//     }

//     return initResult;

// }
