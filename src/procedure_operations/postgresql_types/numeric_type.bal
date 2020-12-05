import ballerina/io;
import ballerina/java.jdbc;
// import ballerina/auth;
import ballerina/sql;
// import ballerina/time;









sql:SmallIntValue lowerSmallInt = new(-3276);
sql:SmallIntValue lowerSmallInt2 = new(-3276);
sql:SmallIntValue upperSmallInt2 = new(3276);

sql:BigIntValue bigInt1 = new(-3276);
sql:BigIntValue bigInt2 = new(3276);

int upperSmallInt =  32767;
int upperInt =  2147483647;

sql:IntegerValue lowerInt = new(-2147483648);
sql:IntegerValue lowerInt2 = new(-2147483648);
sql:IntegerValue upperInt2 = new(2147483647);

float moneyVal1 = 1767.12;
float moneyVal2 = 167.12;

sql:DecimalValue decVal1 = new(-123456789.123456789);
sql:DecimalValue decVal2 = new(123456789.123456789);

sql:NumericValue numVal1 = new(-123456789.123456789);
sql:NumericValue numVal2 = new(123456789.123456789);

sql:RealValue realVal1 = new(-282.34);
sql:RealValue realVal2 = new(282.349);

sql:DoubleValue dpVal1 = new(-282.34);
sql:DoubleValue dpVal2 = new(282.349);


function NumericTableProcess(jdbc:Client jdbcClient) {

    sql:ExecutionResult|sql:Error createResult  =  createNumericProcedures(jdbcClient);
    sql:ProcedureCallResult|sql:Error callResult   = numericProcedureCall(
                        jdbcClient,lowerSmallInt,upperSmallInt
                        ,lowerInt,upperInt
                        ,bigInt1,bigInt2
                        ,decVal1,decVal2
                        ,numVal1,numVal2
                        ,realVal1,realVal2
                        ,dpVal1,dpVal2
                    );
     sql:ExecutionResult|sql:Error selectResult = numericalTearDown(jdbcClient);

}


string numProcName = "numerictest";
map<string> values = {
    "smallIntInValue": "smallint","inout smallIntOutValue":"bigint",
    "IntInValue":"integer","inout intOutValue":"bigint",
    "bigIntInValue":"bigint","inout bigintOutValue":"bigint",
    "decimalVal":"decimal","inout decimalinOut":"decimal"
    ,"numericVal":"numeric","inout numericinOut":"numeric"
    ,"realVal":"real","inout realinOut":"real"
    ,"doublePrecisionVal":"double precision","inout doublePrecisioninOut":"double precision"
};

function createNumericProcedures(jdbc:Client jdbcClient) returns sql:ExecutionResult|sql:Error{

    sql:ExecutionResult|sql:Error result;


    string query = createQuery(
        numProcName,
        numProcParameters,
        "select smallIntInValue into smallIntOutValue;"
        +"select intInValue into intOutValue;"
        +"select bigIntInValue into bigintOutValue;"
        +"select decimalVal into decimalinOut; "
        +"select numericVal into numericinOut; "
        +"select realVal into realinOut; "
        +"select doublePrecisionVal into doublePrecisioninOut; "
        
    );
    io:println(query);
    result = jdbcClient->execute(query);

    if(result is sql:ExecutionResult){
        io:println("NumericTest Procedure is initialization Success");
        io:println(result);
        io:println("\n");
    }
    else{
        io:println("NumericTest Procedure is initialization failed");
        io:println(result);
        io:println("\n");
    }


    return result;  

}


function numericProcedureCall(jdbc:Client jdbcClient,
    sql:SmallIntValue inSmallInput,        int outSmallInput,
    sql:IntegerValue Inputint,             int outInt,
    sql:BigIntValue Inputbigint,           sql:BigIntValue outbigInt,
    sql:DecimalValue inDecimal,            sql:DecimalValue inoutDecimal,
    sql:NumericValue inNumericVal,         sql:NumericValue inoutNumericVal,
    sql:RealValue inReal,                  sql:RealValue inoutReal,
    sql:DoubleValue inDoublePrecisionVal,  sql:DoubleValue inoutDoublePrecisionVal

    )  returns sql:ProcedureCallResult|sql:Error {

    sql:ProcedureCallResult|sql:Error result;

    sql:InOutParameter outSmallInputId = new (outSmallInput);
    sql:InOutParameter outIntId = new (outInt);
    sql:InOutParameter outbigIntId = new (outbigInt);
    sql:InOutParameter decId = new (inoutDecimal);
    sql:InOutParameter numeId = new (inoutNumericVal);
    sql:InOutParameter realId = new (inoutReal);
    sql:InOutParameter dpId = new (inoutDoublePrecisionVal);
    // sql:InOutParameter ssId = new (serialInOut);

    sql:ParameterizedCallQuery callQuery =
            `call numerictest(
                ${inSmallInput},
                ${outSmallInputId},
                ${Inputint},
                ${outIntId},
                ${Inputbigint},
                ${outbigIntId},
                ${inDecimal},
                ${decId},
                ${inNumericVal},
                ${numeId},
                ${inReal},
                ${realId},
                ${inDoublePrecisionVal},
                ${dpId}                
            )`;
    

    result = jdbcClient->call(callQuery);

    if (result is sql:ProcedureCallResult) {
        io:println("\n");
        io:println(result);
        io:println("SmallInt"," - ",outSmallInputId.get(int));
        io:println("Int"," - ",outIntId.get(int));
        io:println("BigInt"," - ",outbigIntId.get(int));
        io:println("decimal"," - ",decId.get(decimal));
        io:println("numeric"," - ",numeId.get(decimal));
        io:println("real"," - ",realId.get(float));
        io:println("double"," - ",dpId.get(float));
        io:println("Numeric procedure successfully created");
        io:println("\n");
    } 
    else{
        io:println("\nError ocurred while creating the Numeric procedure\n");
        io:println(result);
        io:println("\n");
    }

    return result;      

}






// string numProcParameters = "smallIntInValue smallint, inout smallIntOutValue smallint";
string numProcParameters = createParas(values);
string dropProcParameters = createDrops(values);

function numericalTearDown(jdbc:Client jdbcClient) returns sql:ExecutionResult|sql:Error{

    sql:ExecutionResult|sql:Error result;


    string query = dropQuery(
        numProcName,
        dropProcParameters
    );
    io:println(query);
    result = jdbcClient->execute(query);

    if(result is sql:ExecutionResult){
        io:println("NumericTest Procedure is drop Success");
        io:println(result);
        io:println("\n");
    }
    else{
        io:println("NumericTest Procedure is drop failed");
        io:println(result);
        io:println("\n");
    }


    return result;  

}