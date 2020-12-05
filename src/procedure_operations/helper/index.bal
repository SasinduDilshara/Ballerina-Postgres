
function dropQuery(string name, string parameters) returns string{

    string query = "DROP PROCEDURE "+
                     name
                     +" ("+
                     parameters+
                     ")";


    return query;

}


function createQuery(string name, string parameters,string logic) returns string{

    string query = "Create or replace procedure "+
                    name+" ( "+
                    parameters + " ) "+
                    "language plpgsql "+
                    "as $$ "+
                    "begin "+
                    logic +
                    " "+
                    "end; $$;";
    return query;

}


function createParas(map<string> args) returns string{

    string sent = "";

    foreach var [name,datatype] in args.entries() {
        sent += name + " " + datatype+",";
    }
    int valueLength = sent.length();
    sent = sent.substring(0,valueLength - 1);

    return sent;

}

function createDrops(map<string> args) returns string{

    string sent = "";

    foreach var [name,datatype] in args.entries() {
        sent += datatype+",";
    }
    int valueLength = sent.length();
    sent = sent.substring(0,valueLength - 1);

    return sent;

}