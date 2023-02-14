// This code is a part of the book "SQL in 7 Days" by Alex Bolenok
// Copyright (c) 2020-2022 Alex Bolenok

using System;
using Npgsql;

await using var connection = new NpgsqlConnection("Host=sql-in-7-days-database;Username=elsie;Database=advanced;");
await connection.OpenAsync();
await using var command = new NpgsqlCommand($@"
SELECT  inventory_number, name, price, comment
FROM    inventory
WHERE   inventory_number = '{args[0]}';
");
command.Connection = connection;
using var reader = await command.ExecuteReaderAsync();
while (await reader.ReadAsync())
{
    var (inventoryNumber, name, price, comment) = (reader.GetString(0), reader.GetString(1),
        reader.GetDecimal(2), reader.GetString(3));
    Console.WriteLine("{0}\t{1}\t{2}\t{3}", inventoryNumber, name, price, comment);
}
