import ballerina/io;
import ballerina/java.jdbc;
// import ballerina/auth;
import ballerina/sql;
// import ballerina/time;

sql:CharValue charVal1 = new("Character Type Test Value");
sql:CharValue charVal2 = new("Character Type Test Value");


sql:TextValue TextVal1 = new("Character Type Test Value");
sql:TextValue TextVal2 = new("Character Type Test Value");

function CharacterTableProcess(jdbc:Client jdbcClient) {

    sql:ExecutionResult|sql:Error createResult  =  createCharacterProcedures(jdbcClient);
    sql:ProcedureCallResult|sql:Error callResult   = characterProcedureCall(jdbcClient,
        charVal1,charVal2
        ,"Character Type Test Value","Character Type Test Value"
        ,TextVal1,TextVal2
        ,"Character Type Test Value","Character Type Test Value"
    );
     sql:ExecutionResult|sql:Error selectResult = CharacterTearDown(jdbcClient);

}





string characterProcName = "charactertest";
map<string> charValues = {
    "charInValue": "char(10485760)","inout charInOutValue":"char(10485760)"
    ,"varcharInValue": "varchar(10485760)","inout varcharInOutValue":"varchar(10485760)"
    ,"textInValue": "text","inout textInOutValue":"text"
    ,"nameInValue": "name","inout nameInOutValue":"name"
};
string characterProcParameters = createParas(charValues);
string dropCharacterProcParameters = createDrops(charValues);

function createCharacterProcedures(jdbc:Client jdbcClient) returns sql:ExecutionResult|sql:Error{

    sql:ExecutionResult|sql:Error result;

    string query = createQuery(
        characterProcName,
        characterProcParameters,
        "select charInValue into charInOutValue;"
        +"select varcharInValue into varcharInOutValue;"
        +"select textInValue into textInOutValue;"
        +"select nameInValue into nameInOutValue;"
        
    );
    io:println(query);
    result = jdbcClient->execute(query);

    if(result is sql:ExecutionResult){
        io:println("Character Procedure is initialization Success");
        io:println(result);
        io:println("\n");
    }
    else{
        io:println("Character Procedure is initialization failed");
        io:println(result);
        io:println("\n");
    }


    return result;  

}

function characterProcedureCall(jdbc:Client jdbcClient,
     sql:CharValue charInput,        sql:CharValue charInOut
    ,string varcharInput,        string varcharInOut
    ,sql:TextValue textInput,        sql:TextValue textInOut
    ,string nameInput,        string nameInOut
    )  returns sql:ProcedureCallResult|sql:Error {

// ${charInput},
//                 ${charInOutId},
//                 ${varcharInput},
//                 ${varcharInOutId},
//                 ${textInput},
//                 ${textInOutId},
//                 ${nameInput},
//                 ${nameInOutId}   


    sql:ProcedureCallResult|sql:Error result;

    sql:InOutParameter charInOutId = new (charInOut);
    sql:InOutParameter varcharInOutId = new (varcharInOut);
    sql:InOutParameter textInOutId = new (textInOut);
    sql:InOutParameter nameInOutId = new (nameInOut);
    
    sql:ParameterizedCallQuery callQuery =
            `call charactertest(
                ${charInput},
                ${charInOutId},
                ${varcharInput},
                ${varcharInOutId},
                ${textInput},
                ${textInOutId},
                ${nameInput},
                ${nameInOutId}             
            )`;
    

    result = jdbcClient->call(callQuery);

    if (result is sql:ProcedureCallResult) {
        io:println("\n");
        io:println(result);
        io:println("Char value"," - ",charInOutId.get(string));
        io:println("Varchar value"," - ",varcharInOutId.get(string));
        io:println("Text value"," - ",textInOutId.get(string));
        io:println("Name value"," - ",nameInOutId.get(string));
        io:println("Character procedure successfully created");
        io:println("\n");
    } 
    else{
        io:println("\nError ocurred while creating the Character procedure\n");
        io:println(result);
        io:println("\n");
    }

    return result;      

}

function CharacterTearDown(jdbc:Client jdbcClient) returns sql:ExecutionResult|sql:Error{

    sql:ExecutionResult|sql:Error result;


    string query = dropQuery(
        characterProcName,
        dropCharacterProcParameters
    );
    io:println(query);
    result = jdbcClient->execute(query);

    if(result is sql:ExecutionResult){
        io:println("Character Procedure is drop Success");
        io:println(result);
        io:println("\n");
    }
    else{
        io:println("Character Procedure is drop failed");
        io:println(result);
        io:println("\n");
    }


    return result;  

}


