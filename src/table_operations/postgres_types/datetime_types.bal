import ballerina/io;
import ballerina/java.jdbc;
import ballerina/sql;
import ballerina/time;

public type timeR record {|
    int time;
    zoneR zone;
|};

public type zoneR record {|
    int id;
    string offset;
|};
public type randomType record {|
    
|};

public type DateTimeRecord record{
    
    int ID;
    time:Time timestampType;
    timeR timestamptzType;
    time:Time dateType;
    time:Time timeType;
    time:Time timeWithTimeZoneType;
    string intervalType;

};


function DatetimeTableProcess(jdbc:Client jdbcClient) {

    int|string|sql:Error? createResult  =  createDateTimeTable(jdbcClient);
    sql:ExecutionResult|sql:Error? insertResult  =  DateTimeTableInsertions(jdbcClient);
    sql:Error? selectResult = dateTimeTableSelection(jdbcClient);

}


function createDateTimeTable(jdbc:Client jdbcClient) returns int|string|sql:Error?{

    string tableName = "dateTimeTypes";

        CreateQueries createTableQuery = createQueryMaker({
            "ID": "SERIAL", 
            "timestampType":"timestamp",
            "timestamptzType":"timestamptz",
            "dateType":"date",
            "timeType":"time",
            "timeWithTimeZoneType":"timetz",
            "intervalType":"interval"
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



function DateTimeTableInsertions(jdbc:Client jdbcClient) returns sql:ExecutionResult|sql:Error?{

    sql:ExecutionResult|sql:Error? result;

    sql:TimestampValue timeStampValue = new("1997-12-17 15:37:16.00");
    sql:TimestampValue timeStamptzValue = new("2004-10-19 10:23:54");
    sql:DateValue dateValue = new("1997-12-17");
    sql:TimeValue timeValue = new("04:05:06");
    sql:TimeValue timeWithTimeZoneType = new("04:05:06");

    result = insertDateTimeTable(jdbcClient,
    
    timeStampValue,timeStamptzValue,dateValue,timeValue,timeWithTimeZoneType,"4 Year"

    );
    
    time:Time|error timeCreated = time:createTime(2017, 3, 28, 23, 42, 45,554, "Asia/Colombo");
    if(timeCreated is time:Time){

    sql:TimestampValue timeStampValue2 = new(timeCreated);
    sql:TimestampValue timeStamptzValue2 = new(timeCreated);
    sql:DateValue dateValue2 = new(timeCreated);
    sql:TimeValue timeValue2 = new(timeCreated);
    sql:TimeValue timeWithTimeZoneType2 = new(timeCreated);


    result = insertDateTimeTable(jdbcClient,
    
    timeStampValue2,timeStamptzValue2,dateValue2,timeValue2,timeWithTimeZoneType2,"4 Year"

    );


    }





    return result;

}

function insertDateTimeTable(jdbc:Client jdbcClient , sql:TimestampValue timestampType, sql:TimestampValue timestamptzType, sql:DateValue dateType, sql:TimeValue timeType,sql:TimeValue|string timeWithTimeZoneType, string|int intervalType) returns sql:ExecutionResult|sql:Error?{
    //         "timestampType":"timestamp",
    // "timestamptzType":"timestamptz",
    //         "dateType":"date",
    //         "timeType":"time",
    //         "intervalType":"interval"
   sql:ParameterizedQuery insertQuery =
            `INSERT INTO dateTimeTypes (
                timestampType, timestamptzType, dateType, timeType,timeWithTimeZoneType, intervalType
                             ) 
             VALUES (
                ${timestampType} 
                ,${timestamptzType}
                , ${dateType}
                , ${timeType}
                ,${timeWithTimeZoneType}
                , ${intervalType} :: interval
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



function dateTimeTableSelection(jdbc:Client jdbcClient, string columns = "*",string condition = "True") returns sql:Error?{
    //         "timestampType":"timestamp",
    //         "dateType":"date",
    //         "timeType":"time",
    //         "intervalType":"interval"
     io:println("------ Start Query in DateTime table-------");

    string selectionQuery = selecionQueryMaker("dateTimeTypes",columns,condition);

        stream<record{}, error> resultStream =
        jdbcClient->query(selectionQuery, DateTimeRecord);

    stream<DateTimeRecord, sql:Error> customerStream =
        <stream<DateTimeRecord, sql:Error>>resultStream;
    
    error? e = customerStream.forEach(function(DateTimeRecord rec) {
        io:println("\n");
        io:println(rec);
        io:println("\n");
        io:println(rec.timestampType);
        time:Time|error t3 = time:toTimeZone(rec.timestampType, "Asia/Colombo");
        if (t3 is time:Time) {
            io:println("timestampType After converting the time zone: ", time:toString(t3));
        }
        io:println("\n\n\n");
        io:println(rec.timestamptzType);
        io:println(rec.dateType);
        t3 = time:toTimeZone(rec.dateType, "Asia/Colombo");
        if (t3 is time:Time) {
            io:println(" dateType After converting the time zone: ", time:toString(t3));
        }
        io:println(rec.timeType);
        t3 = time:toTimeZone(rec.timeType, "Asia/Colombo");
        if (t3 is time:Time) {
            io:println(" timeType After converting the time zone: ", time:toString(t3));
        }
        io:println(rec.timeWithTimeZoneType);
        t3 = time:toTimeZone(rec.timeWithTimeZoneType, "Asia/Colombo");
        if (t3 is time:Time) {
            io:println("timeWithTimeZoneType After converting the time zone: ", time:toString(t3));
        }
        io:println(rec.intervalType);
        
        io:println("\n");
    });
    
    if (e is error) {
        io:println(e);
    }

    io:println("------ End Query in DateTime table-------");


}



