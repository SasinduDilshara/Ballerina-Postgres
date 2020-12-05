
import ballerina/time;
import ballerina/sql;
import ballerina/io;

time:Time time = time:currentTime();
sql:IntegerValue t = new(1);

public function test(){
    io:print("");
}










public type JsonRecord record{
    
    int ID;
    json jsonType;
    json jsonbType;
    string jsonpathType;
};

public type XmlRecord record{
    
    int ID;
    string xmlType;
};

public type ArrayRecord record{
    
    int ID;
    string textArrayType;
    string[] textArray2Type;
    int[] integerArrayType;
    string integerArray2Type;
    int[5] arrayType;
    int[] array2Type;
    boolean[] booleanArrayType;
    int[] byteaArrayType;
    decimal[] floatArrayType;
};

// sql:StructValue complexRecord = new(record{

// })

public type complexR record{|
        float r;
        float i;
    |};

//         int ID;
    
//     // string complexType;
//     // sql:StructValue complexType;

// //    record{
// //         float r;
// //         float i;
// //     } complexType;

//     string inventoryType;


//     // record{|
//     //     string name;
//     //     int supplier_id;
//     //     decimal price;
//     // |} inventoryType;

public type ComplexRecord record{
    
    int ID;
    
    // complexR complexType;
    string complexType;

    string inventoryType;

    
};


public type RangeRecord record{
    
    int ID;
    string int4rangeType;
    string int8rangeType;
    string numrangeType;
    string tsrangeType;
    string tstzrangeType;
    string daterangeType;
    string floatrangeType;
};


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



public type ObjectIdentifierRecord record{
    
    int ID;
    string oidType;
    string regclassType;
    string regconfigType;
    string regdictionaryType;
    string regnamespaceType;
    string regoperType;
    string regoperatorType;
    string regprocType;
    string regprocedureType;
    string regroleType;
    string regtypeType;
};





public type PglsnRecord record{
    
    int ID;
    string pglsnType;
};
