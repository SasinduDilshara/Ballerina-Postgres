import ballerina/io;
import ballerina/java.jdbc;
// import ballerina/auth;
import ballerina/sql;
import ballerina/time;


time:Time time___ = time:currentTime();



// public type PglsnRecord record{
    
//     int ID;
//     string pglsnType;
// };


function pglsnTableSelection(jdbc:Client jdbcClient, string columns = "*",string condition = "True") returns sql:Error?{
// "pglsnType" : "pg_lsn"
     io:println("------ Start Query in Pglsn table-------");

    string selectionQuery = selecionQueryMaker("pglsnTypes",columns,condition);


        stream<record{}, error> resultStream =
        jdbcClient->query(selectionQuery, PglsnRecord);


    stream<PglsnRecord, sql:Error> customerStream =
        <stream<PglsnRecord, sql:Error>>resultStream;
    
    error? e = customerStream.forEach(function(PglsnRecord rec) {
        io:println("\n");
        io:println(rec);
        io:println(rec.pglsnType);
        io:println("\n");
    });
    
    if (e is error) {
        io:println(e);
    }

    io:println("------ End Query in Pglsn table-------");


}


//.........................................................................................................




// public type ObjectIdentifierRecord record{
    
//     int ID;
//     string oidType;
//     string regclassType;
//     string regconfigType;
//     string regdictionaryType;
//     string regnamespaceType;
//     string regoperType;
//     string regoperatorType;
//     string regprocType;
//     string regprocedureType;
//     string regroleType;
//     string regtypeType;
// };


function objectIdentifierTableSelection(jdbc:Client jdbcClient, string columns = "*",string condition = "True") returns sql:Error?{
    //         "oidType" : "oid",
    //         "regclassType" : "regclass",
    //         "regconfigType" : "regconfig",
    //         "regdictionaryType" : "regdictionary",
    //         "regnamespaceType" : "regnamespace",
    //         "regoperType" : "regoper",
    //         "regoperatorType" : "regoperator",
    //         "regprocType" : "regproc",
    //         "regprocedureType" : "regprocedure",
    //         "regroleType" : "regrole",
    //         "regtypeType" : "regtype"
     io:println("------ Start Query in ObjectIdentifier table-------");

    string selectionQuery = selecionQueryMaker("objectIdentifierTypes",columns,condition);


        stream<record{}, error> resultStream =
        jdbcClient->query(selectionQuery, ObjectIdentifierRecord);


    stream<ObjectIdentifierRecord, sql:Error> customerStream =
        <stream<ObjectIdentifierRecord, sql:Error>>resultStream;
    
    error? e = customerStream.forEach(function(ObjectIdentifierRecord rec) {
        io:println("\n");
        io:println(rec);
        io:println(rec.oidType);
        io:println(rec.regclassType);
        io:println(rec.regconfigType);
        io:println(rec.regdictionaryType);
        io:println(rec.regnamespaceType);
        io:println(rec.regoperType);
        io:println(rec.regoperatorType);
        io:println(rec.regprocType);
        io:println(rec.regprocedureType);
        io:println(rec.regroleType);
        io:println(rec.regtypeType);
        io:println("\n");
    });
    
    if (e is error) {
        io:println(e);
    }

    io:println("------ End Query in ObjectIdentifier table-------");


}



//.........................................................................................................




// public type DomainRecord record{
    
//     int ID;
//     int posintType;
// };


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












