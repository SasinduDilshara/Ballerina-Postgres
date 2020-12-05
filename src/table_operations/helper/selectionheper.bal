
function selecionQueryMaker(string tableName , string columns = "*",string condition = "True") returns string{

    return "Select " + columns + " from "+ tableName + " where " + condition;

}


