import ballerina/io;
import ballerina/java.jdbc;
import ballerina/sql;
import ballerina/time;


public type DomainRecord record{
    
    int ID;
    int posintType;
    int dsmallintType;
    int dbigintType;
    decimal ddecimalType;
    decimal dnumericType;
    float drealType;
    float ddoubleType;
    string dcharType;
    string dvarcharType;
    string dtextType;
    string dnameType;
    string dbyteaType;
    time:Time dtstzType;
    boolean dbooleanType;
    int[] dintarraytype;
};

byte[] byteval = [1,2,3,4,5];

sql:TimestampValue timeStamptzValue2= new("2004-10-19 10:23:54");

int[] intarr = [1,2,3];

sql:ArrayValue arrVal = new(intarr);


function domainTableProcess(jdbc:Client jdbcClient) {

    int|string|sql:Error? createResult  =  createDomainTable(jdbcClient);
    sql:ExecutionResult|sql:Error? insertResult  =  domainTableInsertions(jdbcClient);
    sql:Error? selectResult = domainTableSelection(jdbcClient);

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




function domainTableSelection(jdbc:Client jdbcClient, string columns = "*",string condition = "True") returns sql:Error?{
    // "posintType":"posint"
     io:println("------ Start Query in Domain table-------");

    string selectionQuery = selecionQueryMaker("domainTypes",columns,condition);


        stream<record{}, error> resultStream =
        jdbcClient->query(selectionQuery, DomainRecord);


    stream<DomainRecord, sql:Error> customerStream =
        <stream<DomainRecord, sql:Error>>resultStream;
    
    error? e = customerStream.forEach(function(DomainRecord rec) {
        io:println("\n");
        io:println(rec);
        io:println(rec.posintType);
        io:println(rec.dsmallintType);
        io:println(rec.dbigintType);
        io:println(rec.ddecimalType);
        io:println(rec.dnumericType);
        io:println(rec.drealType);
        io:println(rec.ddoubleType);
        io:println(rec.dcharType);
        io:println(rec.dvarcharType);
        io:println(rec.dtextType);
        io:println(rec.dnameType);
        io:println(rec.dbyteaType);
        io:println(rec.dtstzType);
        io:println(rec.dbooleanType);
        io:println(rec.dintarraytype);
        io:println("\n");
    });
    
    if (e is error) {
        io:println(e);
    }

    io:println("------ End Query in Domain table-------");


}

