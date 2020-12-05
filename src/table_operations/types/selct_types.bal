
import ballerina/time;
import ballerina/sql;
import ballerina/io;

time:Time time = time:currentTime();
sql:IntegerValue t = new(1);

public function test(){
    io:print("");
}




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
