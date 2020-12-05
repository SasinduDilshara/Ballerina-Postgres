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




//.........................................................................................................



// public type UuidRecord record{
    
//     int ID;
//     byte[] uuidType;
// };


function uuidTableSelection(jdbc:Client jdbcClient, string columns = "*",string condition = "True") returns sql:Error?{
// "uuidType":"uuid"
     io:println("------ Start Query in Uuid table-------");

    string selectionQuery = selecionQueryMaker("uuidTypes",columns,condition);


        stream<record{}, error> resultStream =
        jdbcClient->query(selectionQuery, UuidRecord);


    stream<UuidRecord, sql:Error> customerStream =
        <stream<UuidRecord, sql:Error>>resultStream;
    
    error? e = customerStream.forEach(function(UuidRecord rec) {
        io:println("\n");
        io:println(rec);
        io:println(rec.uuidType);
        io:println("\n");
    });
    
    if (e is error) {
        io:println(e);
    }

    io:println("------ End Query in Uuid table-------");


}





//........................................................................................................


// public type TextSearchRecord record{
    
//     int ID;
//     string tsvectorType;
//     byte[] tsqueryType;
// };


function textsearchTableSelection(jdbc:Client jdbcClient, string columns = "*",string condition = "True") returns sql:Error?{
//             "tsvectorType":"tsvector",
//             "tsqueryType":"tsquery"
     io:println("------ Start Query in TextSearch table-------");

    string selectionQuery = selecionQueryMaker("textsearchTypes",columns,condition);


        stream<record{}, error> resultStream =
        jdbcClient->query(selectionQuery, TextSearchRecord);


    stream<TextSearchRecord, sql:Error> customerStream =
        <stream<TextSearchRecord, sql:Error>>resultStream;
    
    error? e = customerStream.forEach(function(TextSearchRecord rec) {
        io:println("\n");
        io:println(rec);
        io:println(rec.tsvectorType);
        io:println(rec.tsqueryType);
        io:println("\n");
    });
    
    if (e is error) {
        io:println(e);
    }

    io:println("------ End Query in TextSearch table-------");


}









//........................................................................................................


// public type BitRecord record{
    
//     int ID;
//     string bitType;
//     decimal bitVaryType;
//     float bitVaryType2;
//     int bitOnlyType;
// };


function bitTableSelection(jdbc:Client jdbcClient, string columns = "*",string condition = "True") returns sql:Error?{
//             "bitType":"bit(3)",
//             "bitVaryType":"BIT VARYING(5)",
//             "bitVaryType2":"BIT VARYING(7)",
//             "bitOnlyType":"bit"
     io:println("------ Start Query in Bit table-------");

    // string selectionQuery = selecionQueryMaker("bitTypes",columns,condition);

    string selectionQuery = "select ID,bitType::int,bitVaryType,bitVaryType2,bitOnlyType from bitTypes"; 

        stream<record{}, error> resultStream =
        jdbcClient->query(selectionQuery, BitRecord);


    stream<BitRecord, sql:Error> customerStream =
        <stream<BitRecord, sql:Error>>resultStream;
    
    error? e = customerStream.forEach(function(BitRecord rec) {
        io:println("\n");
        io:println(rec);
        io:println(rec.bitType);
        io:println(rec.bitVaryType);
        io:println(rec.bitVaryType2);
        io:println(rec.bitOnlyType);
        io:println("\n");
    });
    
    if (e is error) {
        io:println(e);
    }

    io:println("------ End Query in Bit table-------");


}






//.......................................................................................................


// public type NetworkRecord record{
    
//     int ID;
//     string inetType;
//     string cidrType;
//     string macaddrType;
//     string macaddr8Type;
// };


function networkTableSelection(jdbc:Client jdbcClient, string columns = "*",string condition = "True") returns sql:Error?{
//             "inetType":"inet",
//             "cidrType":"cidr",
//             "macaddrType":"macaddr",
//             "macaddr8Type":"macaddr8"
     io:println("------ Start Query in Network table-------");

    string selectionQuery = selecionQueryMaker("networkTypes",columns,condition);

        stream<record{}, error> resultStream =
        jdbcClient->query(selectionQuery, NetworkRecord);


    stream<NetworkRecord, sql:Error> customerStream =
        <stream<NetworkRecord, sql:Error>>resultStream;
    
    error? e = customerStream.forEach(function(NetworkRecord rec) {
        io:println("\n");
        io:println(rec);
        io:println(rec.inetType);
        io:println(rec.cidrType);
        io:println(rec.macaddrType);
        io:println(rec.macaddr8Type);
        io:println("\n");
    });
    
    if (e is error) {
        io:println(e);
    }

    io:println("------ End Query in Network table-------");


}

//.......................................................................................................




// public type GeometricRecord record{
    
//     int ID;
//     string pointType;
//     string lineType;
//     string lsegType;
//     string boxType;
//     string pathType;
//     string polygonType;
//     string circleType;

// };


function geometricTableSelection(jdbc:Client jdbcClient, string columns = "*",string condition = "True") returns sql:Error?{
// "pointType":"point",
//             "lineType":"line",
//             "lsegType":"lseg",
//             "boxType":"box",
//             "pathType":"path",
//             "polygonType":"polygon",
//             "circleType":"circle"
     io:println("------ Start Query in Geometric table-------");

    string selectionQuery = selecionQueryMaker("geometricTypes",columns,condition);

        stream<record{}, error> resultStream =
        jdbcClient->query(selectionQuery, GeometricRecord);


    stream<GeometricRecord, sql:Error> customerStream =
        <stream<GeometricRecord, sql:Error>>resultStream;
    
    error? e = customerStream.forEach(function(GeometricRecord rec) {
        io:println("\n");
        io:println(rec);
        io:println(rec.pointType);
        io:println(rec.lineType);
        io:println(rec.lsegType);
        io:println(rec.boxType);
        io:println(rec.pathType);
        io:println(rec.polygonType);
        io:println(rec.circleType);
        io:println("\n");
    });
    
    if (e is error) {
        io:println(e);
    }

    io:println("------ End Query in Geometric table-------");


}







//........................................................................................................



// public type EnumRecord record{
    
//     int ID;
//     string enumType;

// };


function enumTableSelection(jdbc:Client jdbcClient, string columns = "*",string condition = "True") returns sql:Error?{
// "enumType":"enumValues"
     io:println("------ Start Query in Enum table-------");

    string selectionQuery = selecionQueryMaker("enumTypes",columns,condition);

        stream<record{}, error> resultStream =
        jdbcClient->query(selectionQuery, EnumRecord);


    stream<EnumRecord, sql:Error> customerStream =
        <stream<EnumRecord, sql:Error>>resultStream;
    
    error? e = customerStream.forEach(function(EnumRecord rec) {
        io:println("\n");
        io:println(rec);
        io:println(rec.enumType);
        io:println("\n");
    });
    
    if (e is error) {
        io:println(e);
    }

    io:println("------ End Query in Enum table-------");


}














