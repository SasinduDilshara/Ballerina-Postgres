import ballerina/io;
import ballerina/java.jdbc;
import ballerina/sql;


public type ArrayRecord record{
    
    int ID;
    string textArrayType;
    string[] textArray2Type;
    int[] integerArrayType;
    string integerArray2Type;
    int[5] arrayType;
    int[] array2Type;
    boolean[] booleanArrayType;
    int[] byteaArrayType;
    decimal[] floatArrayType;
};


    int[] intArray1d = [1,2,3];
    sql:ArrayValue intArray1dValue= new (intArray1d); 

    string[] stringArray1d = ["1","2","3"];
    sql:ArrayValue stringArray1dValue= new (stringArray1d); 


    boolean[] booleanArray1d = [true,false];
    sql:ArrayValue booleanArray1dValue= new (booleanArray1d); 

    byte[] bv = base64 `aGVsbG8gYmFsbGVyaW5hICEhIQ==`;

    byte[][] binaryArray1d = [bv,bv];
    sql:ArrayValue binaryArray1dValue= new (binaryArray1d); 

    decimal[] floatArray1d = [1.123,3.45];
    sql:ArrayValue floatArray1dValue= new (floatArray1d); 



function arrayTableProcess(jdbc:Client jdbcClient) {

    int|string|sql:Error? createResult  =  createArrayTable(jdbcClient);
    sql:ExecutionResult|sql:Error? insertResult  =  arrayTableInsertions(jdbcClient);
    sql:Error? selectResult = arrayTableSelection(jdbcClient);

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


function arrayTableInsertions(jdbc:Client jdbcClient) returns sql:ExecutionResult|sql:Error?{

    sql:ExecutionResult|sql:Error? result;

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


function arrayTableSelection(jdbc:Client jdbcClient, string columns = "*",string condition = "True") returns sql:Error?{
            // "textArrayType":"text[][]",
            // "textArray2Type":"text[]",
            // "integerArrayType":"int[]",
            // "integerArray2Type":"int[][]",
            // "arrayType":"int array[5]",
            // "array2Type":"int array",
            // "booleanArrayType":"boolean[]",
            // "byteaArrayType":"bytea[]",
            // "floatArrayType":"double precision[]"
     io:println("------ Start Query in Array table-------");

    string selectionQuery = selecionQueryMaker("arrayTypes",columns,condition);

    selectionQuery = "select textArrayType::text, textArray2Type, integerArrayType, integerArray2Type::text,arrayType,array2Type,booleanArrayType,byteaArrayType,floatArrayType from arrayTypes";

        stream<record{}, error> resultStream =
        jdbcClient->query(selectionQuery, ArrayRecord);


    stream<ArrayRecord, sql:Error> customerStream =
        <stream<ArrayRecord, sql:Error>>resultStream;
    
    error? e = customerStream.forEach(function(ArrayRecord rec) {
        io:println("\n");
        io:println(rec);
        io:println(rec.textArrayType);
        io:println(rec.textArray2Type);
        io:println(rec.integerArrayType);
        io:println(rec.integerArray2Type);
        io:println(rec.arrayType);
        io:println(rec.array2Type);
        io:println(rec.booleanArrayType);
        io:println(rec.byteaArrayType);
        io:println(rec.floatArrayType);
        io:println("\n");
    });
    
    if (e is error) {
        io:println(e);
    }

    io:println("------ End Query in Array table-------");


}
