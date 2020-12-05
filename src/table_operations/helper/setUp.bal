import ballerina/io;
import ballerina/java.jdbc;
// import ballerina/auth;
import ballerina/sql;
// import ballerina/time;




public function setUp(jdbc:Client jdbcClient) returns sql:Error|sql:ExecutionResult{

    sql:ExecutionResult|sql:Error result; 

    result = jdbcClient->execute("DROP TYPE IF EXISTS enumValues CASCADE;");

    if(result is sql:Error){
        io:println("Error occurred while creating the enum type..");
        io:println(result);
    }
    
    result = jdbcClient->execute("CREATE TYPE enumValues AS ENUM ('value1','value2','value3')");

    if(result is sql:Error){
        io:println("Error occurred while creating the enum type..");
        io:println(result);
    }

    
    result = jdbcClient->execute("DROP TYPE IF EXISTS complex CASCADE;");

    if(result is sql:Error){
        io:println("Error occurred while creating the complex type..");
        io:println(result);
    }
    
    result = jdbcClient->execute("CREATE TYPE complex AS (r double precision,i double precision)");

    if(result is sql:Error){
        io:println("Error occurred while creating the complex type..");
        io:println(result);
    }

    result = jdbcClient->execute("DROP TYPE IF EXISTS inventory_item CASCADE;");

    if(result is sql:Error){
        io:println("Error occurred while creating the inventory_item type..");
        io:println(result);
    }
    
    result = jdbcClient->execute("CREATE TYPE inventory_item AS (name text,supplier_id integer,price numeric)");

    if(result is sql:Error){
        io:println("Error occurred while creating the inventory_item type..");
        io:println(result);
    }


    result = jdbcClient->execute("DROP TYPE IF EXISTS floatrange CASCADE;");

    if(result is sql:Error){
        io:println("Error occurred while creating the floatrange type..");
        io:println(result);
    }
    
    result = jdbcClient->execute("CREATE TYPE floatrange AS RANGE (subtype = float8,subtype_diff = float8mi )");

    if(result is sql:Error){
        io:println("Error occurred while creating the floatrange type..");
        io:println(result);
    }


    result = jdbcClient->execute("DROP Domain IF EXISTS posint CASCADE;");

    if(result is sql:Error){
        io:println("Error occurred while creating the posint domain..");
        io:println(result);
    }
    
    result = jdbcClient->execute("CREATE DOMAIN posint AS integer CHECK (VALUE > 0);");

    if(result is sql:Error){
        io:println("Error occurred while creating the posint domain..");
        io:println(result);
    }

    result = jdbcClient->execute("DROP Domain IF EXISTS dsmallint CASCADE;");

    if(result is sql:Error){
        io:println("Error occurred while creating the dsmallint domain..");
        io:println(result);
    }
    
    result = jdbcClient->execute("CREATE DOMAIN dsmallint AS smallint CHECK (VALUE > 0);");

    if(result is sql:Error){
        io:println("Error occurred while creating the dsmallint domain..");
        io:println(result);
    }

    result = jdbcClient->execute("DROP Domain IF EXISTS dbigint CASCADE;");

    if(result is sql:Error){
        io:println("Error occurred while creating the dbigint domain..");
        io:println(result);
    }
    
    result = jdbcClient->execute("CREATE DOMAIN dbigint AS bigint CHECK (VALUE > 0);");

    if(result is sql:Error){
        io:println("Error occurred while creating the dbigint domain..");
        io:println(result);
    }





    result = jdbcClient->execute("DROP Domain IF EXISTS ddecimal CASCADE;");

    if(result is sql:Error){
        io:println("Error occurred while creating the ddecimal domain..");
        io:println(result);
    }
    
    result = jdbcClient->execute("CREATE DOMAIN ddecimal AS decimal CHECK (VALUE > 0);");

    if(result is sql:Error){
        io:println("Error occurred while creating the ddecimal domain..");
        io:println(result);
    }


    result = jdbcClient->execute("DROP Domain IF EXISTS dnumeric CASCADE;");

    if(result is sql:Error){
        io:println("Error occurred while creating the dnumeric domain..");
        io:println(result);
    }
    
    result = jdbcClient->execute("CREATE DOMAIN dnumeric AS numeric CHECK (VALUE > 0);");

    if(result is sql:Error){
        io:println("Error occurred while creating the dnumeric domain..");
        io:println(result);
    }


    result = jdbcClient->execute("DROP Domain IF EXISTS dreal CASCADE;");

    if(result is sql:Error){
        io:println("Error occurred while creating the dreal domain..");
        io:println(result);
    }
    
    result = jdbcClient->execute("CREATE DOMAIN dreal AS real CHECK (VALUE > 0);");

    if(result is sql:Error){
        io:println("Error occurred while creating the dreal domain..");
        io:println(result);
    }


    result = jdbcClient->execute("DROP Domain IF EXISTS ddouble CASCADE;");

    if(result is sql:Error){
        io:println("Error occurred while creating the ddouble domain..");
        io:println(result);
    }
    
    result = jdbcClient->execute("CREATE DOMAIN ddouble AS double precision CHECK (VALUE > 0);");

    if(result is sql:Error){
        io:println("Error occurred while creating the ddouble domain..");
        io:println(result);
    }

    result = jdbcClient->execute("DROP Domain IF EXISTS dchar CASCADE;");

    if(result is sql:Error){
        io:println("Error occurred while creating the dchar domain..");
        io:println(result);
    }
    
    result = jdbcClient->execute("CREATE DOMAIN dchar AS char(10)  ;");

    if(result is sql:Error){
        io:println("Error occurred while creating the dchar domain..");
        io:println(result);
    }

    result = jdbcClient->execute("DROP Domain IF EXISTS dvarchar CASCADE;");

    if(result is sql:Error){
        io:println("Error occurred while creating the dvarchar domain..");
        io:println(result);
    }
    
    result = jdbcClient->execute("CREATE DOMAIN dvarchar AS varchar(10)  ;");

    if(result is sql:Error){
        io:println("Error occurred while creating the dvarchar domain..");
        io:println(result);
    }


    result = jdbcClient->execute("DROP Domain IF EXISTS dtext CASCADE;");

    if(result is sql:Error){
        io:println("Error occurred while creating the dtext domain..");
        io:println(result);
    }
    
    result = jdbcClient->execute("CREATE DOMAIN dtext AS text  ;");

    if(result is sql:Error){
        io:println("Error occurred while creating the dtext domain..");
        io:println(result);
    }

    result = jdbcClient->execute("DROP Domain IF EXISTS dname CASCADE;");

    if(result is sql:Error){
        io:println("Error occurred while creating the dname domain..");
        io:println(result);
    }
    
    result = jdbcClient->execute("CREATE DOMAIN dname AS name ;");

    if(result is sql:Error){
        io:println("Error occurred while creating the dname domain..");
        io:println(result);
    }
//date,boolean,xml,array

     result = jdbcClient->execute("DROP Domain IF EXISTS dbytea CASCADE;");

    if(result is sql:Error){
        io:println("Error occurred while creating the dbytea domain..");
        io:println(result);
    }
    
    result = jdbcClient->execute("CREATE DOMAIN dbytea AS bytea ;");

    if(result is sql:Error){
        io:println("Error occurred while creating the dbytea domain..");
        io:println(result);
    }


    result = jdbcClient->execute("DROP Domain IF EXISTS dtstz CASCADE;");

    if(result is sql:Error){
        io:println("Error occurred while creating the dtstz domain..");
        io:println(result);
    }
    
    result = jdbcClient->execute("CREATE DOMAIN dtstz AS timestamptz ;");

    if(result is sql:Error){
        io:println("Error occurred while creating the dtstz domain..");
        io:println(result);
    }
    result = jdbcClient->execute("DROP Domain IF EXISTS dboolean CASCADE;");

    if(result is sql:Error){
        io:println("Error occurred while creating the dboolean domain..");
        io:println(result);
    }
    
    result = jdbcClient->execute("CREATE DOMAIN dboolean AS boolean ;");

    if(result is sql:Error){
        io:println("Error occurred while creating the dboolean domain..");
        io:println(result);
    }

    result = jdbcClient->execute("DROP Domain IF EXISTS dxml CASCADE;");

    if(result is sql:Error){
        io:println("Error occurred while creating the dxml domain..");
        io:println(result);
    }
    
    result = jdbcClient->execute("CREATE DOMAIN dxml AS xml ;");

    if(result is sql:Error){
        io:println("Error occurred while creating the dxml domain..");
        io:println(result);
    }

    result = jdbcClient->execute("DROP Domain IF EXISTS dintarray CASCADE;");

    if(result is sql:Error){
        io:println("Error occurred while creating the dintarray domain..");
        io:println(result);
    }
    
    result = jdbcClient->execute("CREATE DOMAIN dintarray AS int[] ;");

    if(result is sql:Error){
        io:println("Error occurred while creating the dintarray domain..");
        io:println(result);
    }

    return result;

}


