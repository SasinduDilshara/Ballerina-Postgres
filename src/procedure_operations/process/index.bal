import ballerina/java.jdbc;

function run(jdbc:Client jdbcClient){


    _ = NumericTableProcess(jdbcClient);
    _ = MoneyTableProcess(jdbcClient);
    _ = CharacterTableProcess(jdbcClient);
    _ = BinaryTableProcess(jdbcClient);
    _ = DatetimeTableProcess(jdbcClient);
    _ = BooleanTableProcess(jdbcClient);
    _ = EnumTableProcess(jdbcClient);
    _ = geometricTableProcess(jdbcClient);
    _ = networkTableProcess(jdbcClient);
    _ = bitTableProcess(jdbcClient);

    _ = textsearchTableProcess(jdbcClient);
    _ = uuidTableProcess(jdbcClient);
    _ = xmlTableProcess(jdbcClient);
    _ = jsonTableProcess(jdbcClient);
    _ = arrayTableProcess(jdbcClient);
    _ = compositeTableProcess(jdbcClient);
    _ = rangeTableProcess(jdbcClient);
    _ = domainTableProcess(jdbcClient);
    _  = objectidentifiersTableProcess(jdbcClient);
    _ = pglsnTableProcess(jdbcClient);
    _ = anyTableProcess(jdbcClient);
    

}

