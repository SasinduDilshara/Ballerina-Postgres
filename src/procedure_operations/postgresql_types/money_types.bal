
import ballerina/io;
import ballerina/java.jdbc;
// import ballerina/auth;
import ballerina/sql;
// import ballerina/time;



function MoneyTableProcess(jdbc:Client jdbcClient) {

    sql:ExecutionResult|sql:Error createResult  =  createMoneyProcedures(jdbcClient);
    // sql:ProcedureCallResult|sql:Error callResult   =  moneyProcedureCall(jdbcClient,
    //     moneyVal1,moneyVal2
    // );
     sql:ExecutionResult|sql:Error selectResult = moneyTearDown(jdbcClient);

}



string moneyProcName = "moneytest";
map<string> monValues = {
    "moneyInValue": "money","inout moneyInOutValue":"money"
};
string moneyProcParameters = createParas(monValues);
string dropMoneyProcParameters = createDrops(monValues);

function createMoneyProcedures(jdbc:Client jdbcClient) returns sql:ExecutionResult|sql:Error{

    sql:ExecutionResult|sql:Error result;

    string query = createQuery(
        moneyProcName,
        moneyProcParameters,
        "select moneyInValue into moneyInOutValue;"
        
    );
    io:println(query);
    result = jdbcClient->execute(query);

    if(result is sql:ExecutionResult){
        io:println("Money Procedure is initialization Success");
        io:println(result);
        io:println("\n");
    }
    else{
        io:println("Money Procedure is initialization failed");
        io:println(result);
        io:println("\n");
    }


    return result;  

}



function moneyProcedureCall(jdbc:Client jdbcClient,
    float moneyInput,        float moneyInOut
    )  returns sql:ProcedureCallResult|sql:Error {




    sql:ProcedureCallResult|sql:Error result;

    sql:InOutParameter moneyInOutId = new (moneyInOut);
    
    sql:ParameterizedCallQuery callQuery =
            `call moneytest(
                ${moneyInput},
                ${moneyInOutId}              
            )`;
    

    result = jdbcClient->call(callQuery);

    if (result is sql:ProcedureCallResult) {
        io:println("\n");
        io:println(result);
        io:println("Money value"," - ",moneyInOutId.get(string));
        io:println("Money procedure successfully created");
        io:println("\n");
    } 
    else{
        io:println("\nError ocurred while creating the Numeric procedure\n");
        io:println(result);
        io:println("\n");
    }

    return result;      

}

function moneyTearDown(jdbc:Client jdbcClient) returns sql:ExecutionResult|sql:Error{

    sql:ExecutionResult|sql:Error result;


    string query = dropQuery(
        moneyProcName,
        dropMoneyProcParameters
    );
    io:println(query);
    result = jdbcClient->execute(query);

    if(result is sql:ExecutionResult){
        io:println("Money Procedure is drop Success");
        io:println(result);
        io:println("\n");
    }
    else{
        io:println("Money Procedure is drop failed");
        io:println(result);
        io:println("\n");
    }


    return result;  

}
