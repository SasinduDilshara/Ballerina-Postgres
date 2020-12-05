import ballerina/io;
import ballerina/java.jdbc;
import ballerina/sql;
import ballerina/time;

sql:TimestampValue timeStampValue = new("1997-12-17 15:37:16.00");
sql:TimestampValue timeStamptzValue = new("1997-12-17 15:37:16.00");
// sql:TimestampValue timeStamptzValue = new("2004-10-19 10:23:54+02");
sql:DateValue dateValue = new("1997-12-17");
sql:TimeValue timeValue = new("04:05:06");
sql:TimeValue timeWithTimeZoneType = new("04:05:06");
// string inter = "4 years";

function DatetimeTableProcess(jdbc:Client jdbcClient) {

    sql:ExecutionResult|sql:Error createResult  =  createDatetimeProcedures(jdbcClient);
    sql:ProcedureCallResult|sql:Error callResult;



    callResult = datetimeProcedureCall(jdbcClient,
         timeStampValue,timeStampValue
        ,timeStamptzValue,timeStamptzValue
        ,dateValue,dateValue
        ,timeValue,timeValue
        ,timeWithTimeZoneType,timeWithTimeZoneType
        // ,inter,inter
    );

    time:Time|error timeCreated = time:createTime(2017, 3, 28, 23, 42, 45,554, "Asia/Colombo");


    if(timeCreated is time:Time){
            sql:TimestampValue timeStampValue2 = new(timeCreated);
            sql:TimestampValue timeStamptzValue2 = new(timeCreated);
            sql:DateValue dateValue2 = new(timeCreated);
            sql:TimeValue timeValue2 = new(timeCreated);
            sql:TimeValue timeWithTimeZoneType2 = new(timeCreated);


             callResult = datetimeProcedureCall(jdbcClient,
                                            timeStampValue,timeStampValue
                                            ,timeStamptzValue,timeStamptzValue
                                            ,dateValue,dateValue
                                            ,timeValue,timeValue
                                            ,timeWithTimeZoneType,timeWithTimeZoneType
                                            // ,inter,inter
                                            );


    }


     sql:ExecutionResult|sql:Error selectResult = datetimeTearDown(jdbcClient);

}




string datetimeProcName = "datetimetest";
map<string> dtValues = {
    "tsInValue": "timestamp","inout tsInOutValue":"timestamp"
    ,"tstzInValue": "timestamptz","inout tstzInOutValue":"timestamptz"
    ,"dInValue": "date","inout dInOutValue":"date"
    ,"tInValue": "time","inout tInOutValue":"time"
    ,"ttzInValue": "timetz","inout ttzInOutValue":"timetz"
    // ,"iInValue": "interval","inout iInOutValue":"interval"
};
string datetimeProcParameters = createParas(dtValues);
string dropDatetimeProcParameters = createDrops(dtValues);

function createDatetimeProcedures(jdbc:Client jdbcClient) returns sql:ExecutionResult|sql:Error{

    sql:ExecutionResult|sql:Error result;

    string query = createQuery(
        datetimeProcName,
        datetimeProcParameters,
        "select tsInValue into tsInOutValue;"
        +"select tstzInValue into tstzInOutValue;"
        +"select dInValue into dInOutValue;"
        +"select tInValue into tInOutValue;"
        +"select ttzInValue into ttzInOutValue;"
        // +"select iInValue into iInOutValue;"
        
    );
    io:println(query);
    result = jdbcClient->execute(query);

    if(result is sql:ExecutionResult){
        io:println("DateTime Procedure is initialization Success");
        io:println(result);
        io:println("\n");
    }
    else{
        io:println("DateTime Procedure is initialization failed");
        io:println(result);
        io:println("\n");
    }


    return result;  

}

public type timeR record {|
    int time;
    zoneR zone;
|};

public type zoneR record {|
    int id;
    string offset;
|};

function datetimeProcedureCall(jdbc:Client jdbcClient,
    sql:TimestampValue tsInput,        sql:TimestampValue tsInOut
    ,sql:TimestampValue tstzInput,     sql:TimestampValue tstzInOut
    ,sql:DateValue dInput,             sql:DateValue dInOut
    ,sql:TimeValue tInput,             sql:TimeValue tInOut
    ,sql:TimeValue ttzInput,             sql:TimeValue ttzInOut
    // ,int intevalIn,                       int intevalInOut
    )  returns sql:ProcedureCallResult|sql:Error {

    sql:ProcedureCallResult|sql:Error result;

    sql:InOutParameter tsInOutId = new (tsInOut);
    sql:InOutParameter tstzInOutId = new (tstzInOut);
    sql:InOutParameter dInOutId = new (dInOut);
    sql:InOutParameter tInOutId = new (tInOut);
    sql:InOutParameter ttzInOutId = new (ttzInOut);
    // sql:InOutParameter iInOutId = new (intevalInOut);
    
    sql:ParameterizedCallQuery callQuery =
            `call datetimetest(
                ${tsInput},
                ${tsInOutId},
                ${tstzInput},
                ${tstzInOutId},
                ${dInput},
                ${dInOutId},
                ${tInput},
                ${tInOutId},
                ${ttzInput},
                ${ttzInOutId}             
            )`;
    

    result = jdbcClient->call(callQuery);

    if (result is sql:ProcedureCallResult) {
        io:println("\n");
        io:println(result);
        io:println("TS value"," - ",tsInOutId.get(zoneR));
        io:println("Timestamp with timezone value"," - ",tstzInOutId.get(timeR));
        io:println("Date value"," - ",dInOutId.get(timeR));
        io:println("Time value"," - ",tInOutId.get(timeR));
        io:println("Time with zone value"," - ",ttzInOutId.get(timeR));
        io:println("Binary procedure successfully created");
        io:println("\n");
    } 
    else{
        io:println("\nError ocurred while creating the DateTime procedure\n");
        io:println(result);
        io:println("\n");
    }

    return result;      

}

function datetimeTearDown(jdbc:Client jdbcClient) returns sql:ExecutionResult|sql:Error{

    sql:ExecutionResult|sql:Error result;


    string query = dropQuery(
        datetimeProcName,
        dropDatetimeProcParameters
    );
    io:println(query);
    result = jdbcClient->execute(query);

    if(result is sql:ExecutionResult){
        io:println("DateTime Procedure is drop Success");
        io:println(result);
        io:println("\n");
    }
    else{
        io:println("Datetime Procedure is drop failed");
        io:println(result);
        io:println("\n");
    }


    return result;  

}