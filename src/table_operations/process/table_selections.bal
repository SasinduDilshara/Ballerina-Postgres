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


//.........................................................................................................



// public type RangeRecord record{
    
//     int ID;
//     string int4rangeType;
//     string int8rangeType;
//     string numrangeType;
//     string tsrangeType;
//     string tstzrangeType;
//     string daterangeType;
//     string floatrangeType;
// };


function rangeTableSelection(jdbc:Client jdbcClient, string columns = "*",string condition = "True") returns sql:Error?{
            // "int4rangeType":"int4range",
            // "int8rangeType":"int8range",
            // "numrangeType":"numrange",
            // "tsrangeType":"tsrange",
            // "tstzrangeType":"tstzrange",
            // "daterangeType":"daterange",
            // "floatrangeType":"floatrange"
    io:println("------ Start Query in Range table-------");
    string selectionQuery = selecionQueryMaker("rangeTypes",columns,condition);


        stream<record{}, error> resultStream =
        jdbcClient->query(selectionQuery, RangeRecord);


    stream<RangeRecord, sql:Error> customerStream =
        <stream<RangeRecord, sql:Error>>resultStream;
    
    error? e = customerStream.forEach(function(RangeRecord rec) {
        io:println("\n");
        io:println(rec);
        io:println(rec.int4rangeType);
        io:println(rec.int8rangeType);
        io:println(rec.numrangeType);
        io:println(rec.tsrangeType);
        io:println(rec.tstzrangeType);
        io:println(rec.daterangeType);
        io:println(rec.floatrangeType);
        io:println("\n");
    });
    
    if (e is error) {
        io:println(e);
    }

    io:println("------ End Query in Range table-------");


}



//.........................................................................................................




// public type ComplexRecord record{
    
//     int ID;
    
//     string complexType;
//     string inventoryType;

//     // record{|
//     //     decimal r;
//     //     decimal i;
//     // |} complexType;

//     // record{|
//     //     string name;
//     //     decimal supplier_id;
//     //     decimal price;
//     // |} inventoryType;
    
// };


function complexTableSelection(jdbc:Client jdbcClient, string columns = "*",string condition = "True") returns sql:Error?{
            // "complexType":"complex",
            // "inventoryType":"inventory_item"
    io:println("------ Start Query in Complex table-------");

    string selectionQuery = selecionQueryMaker("complexTypes",columns,condition);

        selectionQuery = "select complexType::text , inventoryType::text from complexTypes";
        // selectionQuery = "select complexType , inventoryType::text from complexTypes";
        stream<record{}, error> resultStream =
        jdbcClient->query(selectionQuery, ComplexRecord);


    stream<ComplexRecord, sql:Error> customerStream =
        <stream<ComplexRecord, sql:Error>>resultStream;
    
    error? e = customerStream.forEach(function(ComplexRecord rec) {
        io:println("\n");
        io:println(rec);
        // io:println(rec.complexType.r);
        // io:println(rec.inventoryType.name);
        // io:println("\n");
    });
    
    if (e is error) {
        io:println(e);
    }

    io:println("------ End Query in Complex table-------");


}





//.........................................................................................................

// public type ArrayRecord record{
    
//     int ID;
//     string textArrayType;
//     string[] textArray2Type;
//     int[] integerArrayType;
//     string integerArray2Type;
//     int[5] arrayType;
//     int[] array2Type;
// };


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
    // selectionQuery = "select textArrayType::text[], textArray2Type, integerArrayType, integerArray2Type::int[],arrayType,array2Type from arrayTypes";


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




//.........................................................................................................




// public type JsonRecord record{
    
//     int ID;
//     json jsonType;
//     json jsonbType;
//     string jsonpathType;
// };


function jsonTableSelection(jdbc:Client jdbcClient, string columns = "*",string condition = "True") returns sql:Error?{
//             "jsonType":"json",
//             "jsonbType":"jsonb",
//             "jsonpathType":"jsonpath"
     io:println("------ Start Query in Json table-------");

    string selectionQuery = selecionQueryMaker("jsonTypes",columns,condition);


        stream<record{}, error> resultStream =
        jdbcClient->query(selectionQuery, JsonRecord);


    stream<JsonRecord, sql:Error> customerStream =
        <stream<JsonRecord, sql:Error>>resultStream;
    
    error? e = customerStream.forEach(function(JsonRecord rec) {
        io:println("\n");
        io:println(rec);
        io:println(rec.jsonType);
        io:println(rec.jsonbType);
        io:println(rec.jsonpathType);
        io:println("\n");
    });
    
    if (e is error) {
        io:println(e);
    }

    io:println("------ End Query in Json table-------");


}




//.........................................................................................................




// public type XmlRecord record{
    
//     int ID;
//     string xmlType;
// };


function xmlTableSelection(jdbc:Client jdbcClient, string columns = "*",string condition = "True") returns sql:Error?{
// "xmlType":"xml"
     io:println("------ Start Query in Xml table-------");

    string selectionQuery = selecionQueryMaker("xmlTypes",columns,condition);

    selectionQuery = "select ID,xmlType::text from xmlTypes";

        stream<record{}, error> resultStream =
        jdbcClient->query(selectionQuery, XmlRecord);


    stream<XmlRecord, sql:Error> customerStream =
        <stream<XmlRecord, sql:Error>>resultStream;
    
    error? e = customerStream.forEach(function(XmlRecord rec) {
        io:println("\n");
        io:println(rec);
        io:println(rec.xmlType);
        io:println("\n");
    });
    
    if (e is error) {
        io:println(e);
    }

    io:println("------ End Query in Xml table-------");


}

















