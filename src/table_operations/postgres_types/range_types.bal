import ballerina/io;
import ballerina/java.jdbc;
import ballerina/sql;



public type RangeRecord record{
    
    int ID;
    string int4rangeType;
    string int8rangeType;
    string numrangeType;
    string tsrangeType;
    string tstzrangeType;
    string daterangeType;
    string floatrangeType;
};


function rangeTableProcess(jdbc:Client jdbcClient) {

    int|string|sql:Error? createResult  =  createRangeTable(jdbcClient);
    sql:ExecutionResult|sql:Error? insertResult  =  RangeTableInsertions(jdbcClient);
    sql:Error? selectResult = rangeTableSelection(jdbcClient);

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



function rangeTableSelection(jdbc:Client jdbcClient, string columns = "*",string condition = "True") returns sql:Error?{
            // "int4rangeType":"int4range",
            // "int8rangeType":"int8range",
            // "numrangeType":"numrange",
            // "tsrangeType":"tsrange",
            // "tstzrangeType":"tstzrange",
            // "daterangeType":"daterange",
            // "floatrangeType":"floatrange"
    io:println("------ Start Query in Range table-------");
    string selectionQuery = selecionQueryMaker("rangeTypes",columns,condition);


        stream<record{}, error> resultStream =
        jdbcClient->query(selectionQuery, RangeRecord);


    stream<RangeRecord, sql:Error> customerStream =
        <stream<RangeRecord, sql:Error>>resultStream;
    
    error? e = customerStream.forEach(function(RangeRecord rec) {
        io:println("\n");
        io:println(rec);
        io:println(rec.int4rangeType);
        io:println(rec.int8rangeType);
        io:println(rec.numrangeType);
        io:println(rec.tsrangeType);
        io:println(rec.tstzrangeType);
        io:println(rec.daterangeType);
        io:println(rec.floatrangeType);
        io:println("\n");
    });
    
    if (e is error) {
        io:println(e);
    }

    io:println("------ End Query in Range table-------");


}
