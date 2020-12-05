import ballerina/io;
import ballerina/java.jdbc;
// import ballerina/auth;
import ballerina/sql;
// import ballerina/time;










public function main() {
    jdbc:Client|sql:Error jdbcClient =  new ("jdbc:postgresql://localhost:5432/java_procedure_test","postgres","postgres");
           
    if (jdbcClient is jdbc:Client) {

        // sql:SmallIntValue a= new(5);

        // sql:InOutParameter b= new(a);

        sql:Error|sql:ExecutionResult result = setUp(jdbcClient);

        sql:ExecutionResult|sql:Error err = proceduresCreations(jdbcClient);

        // sql:ProcedureCallResult| sql:Error callResults = proceduresCalls(jdbcClient);
        

        // sql:ExecutionResult| sql:Error tearResult = tearDown(jdbcClient);
        sql:Error? e = jdbcClient.close();  

        if(e is sql:Error){
            io:println("Conection close failed!!");
        } 
    } 
    else {
        io:println("Initialization failed!!");
        io:println(jdbcClient);
    }
}



