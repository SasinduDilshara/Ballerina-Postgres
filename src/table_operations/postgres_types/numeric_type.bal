import ballerina/io;
import ballerina/java.jdbc;
// import ballerina/auth;
import ballerina/sql;
// import ballerina/time;


public type numericRecord record{

    int ID;
    int smallIntType;
    int intType;
    int bigIntType;
    decimal decimalType;
    decimal numericType;
    float realType;
    float doublePrecisionType;
    int smallSerialType;
    int serialType;
    int bigSerialType;

};


sql:SmallIntValue smallIntValue1 = new(32768);
sql:IntegerValue IntValue1 = new(2147483647);
sql:BigIntValue bigIntValue1 = new(2147483647);

sql:DecimalValue decimalValue1 = new(9223372036854775807922337203685477580792233720368547758079223372036854775807.92233720368547758079223372036854775807);
sql:NumericValue numericValue1 = new(9223372036854775807922337203685477580792233720368547758079223372036854775807.92233720368547758079223372036854775807);
sql:RealValue realValue1 = new(123.12345678);
sql:FloatValue floatValue1 = new(9223372036854775807922337203685477580792233720368547758079223372036854775807.92233720368547758079223372036854775807);
sql:DoubleValue doubleValue1 = new(123456789.123456);


function NumericTableProcess(jdbc:Client jdbcClient) {

    int|string|sql:Error? createResult  =  createNumericTable(jdbcClient);
    sql:ExecutionResult|sql:Error? insertResult  =  numericTableInsertions(jdbcClient);
    sql:Error? selectResult = numericTableSelection(jdbcClient);

}


function createNumericTable(jdbc:Client jdbcClient) returns int|string|sql:Error?{

    string tableName = "numericTypes";

        CreateQueries createTableQuery = createQueryMaker({

            "ID": "SERIAL", "smallIntType":"smallInt","intType": "integer", "bigIntType": "bigint", "decimalType": "decimal","numericType": "numeric",
            "realType":"real", "doublePrecisionType":"double precision","smallSerialType":"smallserial", "serialType":"serial", "bigSerialType":"bigserial"

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



function numericTableInsertions(jdbc:Client jdbcClient) returns sql:ExecutionResult|sql:Error?{

    sql:ExecutionResult|sql:Error? result;
    result = insertNumericTable(jdbcClient,
    
        -32767.2,-2147483647,-9223372036854775807.9,
        122.22,
        2.66,
        123456.123456,
        123456789.123456,
        1,1,1

    );
    result = insertNumericTable(jdbcClient,
    
        -32768,-2147483648,-9223372036854775808,
        -92233720368547758079223372036854775807.92233720368547758079223372036854775807,
        -19223372036854775807922337203685477580792233720368547758079223372036854775807.92233720368547758079223372036854775807,
        123456.123456,
        123456789.123456,
        1,1,1

    );


    result = insertNumericTable(jdbcClient,
        smallIntValue1,IntValue1,bigIntValue1,
        decimalValue1,
        numericValue1,
        realValue1,
        doubleValue1,
        32766.2,
        2147483646.9,
        9223372036854775806.9
    );
    return result;

}

function insertNumericTable(jdbc:Client jdbcClient , 
                            int|float|decimal|sql:SmallIntValue smallIntType, int|float|decimal|sql:IntegerValue intType, int|float|decimal|sql:BigIntValue bigInttypeypeType,
                            int|float|decimal|sql:DecimalValue decimalType, int|float|decimal|sql:NumericValue numericType,
                            int|float|decimal|sql:RealValue realType,int|float|decimal|sql:DoubleValue doublePrecisionType, 
                            int|float|decimal smallSerialType, int|float|decimal serialType,int|decimal bigSerialType) returns sql:ExecutionResult|sql:Error?{

   sql:ParameterizedQuery insertQuery =
            `INSERT INTO numericTypes (
                smallIntType, intType, bigIntType, decimalType, numericType, realType, doublePrecisionType, smallSerialType, serialType, bigSerialType
                ) 
             VALUES (
            ${smallIntType}, ${intType}, ${bigInttypeypeType}, ${decimalType}, ${numericType}, ${realType}, ${doublePrecisionType}, ${smallSerialType}, ${serialType}, ${bigSerialType}
            
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


function numericTableSelection(jdbc:Client jdbcClient, string columns = "*",string condition = "True") returns sql:Error?{

     io:println("------ Start Query in numerica table-------");

    string selectionQuery = selecionQueryMaker("numericTypes",columns,condition);
        stream<record{}, error> resultStream =
        jdbcClient->query(selectionQuery, numericRecord);

    stream<numericRecord, sql:Error> customerStream =
        <stream<numericRecord, sql:Error>>resultStream;

    error? e = customerStream.forEach(function(numericRecord rec) {
        io:println(rec);
        io:println(rec.smallIntType);
        io:println(rec.intType);
        io:println(rec.bigIntType);
        io:println(rec.decimalType);
        io:println(rec.numericType);
        io:println(rec.realType);
        io:println(rec.doublePrecisionType);
        io:println(rec.smallSerialType);
        io:println(rec.serialType);
        io:println(rec.bigSerialType);
        
    });
    if (e is error) {
        io:println(e);
    }

    io:println("------ End Query in numerica table-------");


}