// This code is a part of the book "SQL in 7 Days" by Alex Bolenok
// Copyright (c) 2020-2022 Alex Bolenok

using System;
using System.Diagnostics;
using Npgsql;

Random random = new(20200401);
var items = new[] { "BRO", "SCR", "BUC", "DUS", "CLO", "ROO", "MOP", "VAC", "POL" };
await using var connection = new NpgsqlConnection("Host=sql-in-7-days-database;Username=elsie;Database=advanced;");
await connection.OpenAsync();

await using var command = new NpgsqlCommand(@"
SELECT  staff_id, staff.name, service_date, shift_start, shift_end
FROM    inventory
JOIN    staff_inventory
USING   (inventory_number)
JOIN    shift_staff
USING   (staff_id)
JOIN    shift
USING   (shift_id)
JOIN    staff
USING   (staff_id)
JOIN    service
USING   (inventory_number)
WHERE   inventory_number = @inventoryNumber
        AND TSRANGE(service_date, service_date + '1 days'::INTERVAL) && TSRANGE(shift_start, shift_end)");
command.Parameters.Add("inventoryNumber", NpgsqlTypes.NpgsqlDbType.Text);
command.Connection = connection;

// The switch below enables query preparation
if (args.Length > 0 && args[0] == "prepare")
{
    await command.PrepareAsync();
}

var stopwatch = Stopwatch.StartNew();
for (var i = 0; i < 5000; i++)
{
    var item = items[random.Next(items.Length)];
    var number = random.Next(380);
    command.Parameters["inventoryNumber"].Value = $"{item}-{number:00000}";
    using var reader = await command.ExecuteReaderAsync();
    while (await reader.ReadAsync()) { }
}
stopwatch.Stop();
Console.WriteLine(stopwatch.Elapsed);
