// This code is a part of the book "SQL in 7 Days" by Alex Bolenok
// Copyright (c) 2020-2022 Alex Bolenok

using System;
using System.Linq;
using example4.Db;
using Microsoft.EntityFrameworkCore;

await using var db = new Elsie();
await foreach (var record in
            (from inventory in db.Inventories
             from staffInventory in inventory.StaffInventories
             let staff = staffInventory.Staff
             from shiftStaff in staff.ShiftStaffs
             let shift = shiftStaff.Shift
             from service in inventory.Services
             where inventory.InventoryNumber == args[0]
                && service.ServiceDate < shift.ShiftEnd
                && service.ServiceDate.AddDays(1) > shift.ShiftStart
             select new { staff.StaffId, staff.Name, service.ServiceDate, shift.ShiftStart, shift.ShiftEnd }
             ).AsAsyncEnumerable())
{
    Console.WriteLine($"{record.StaffId}\t{record.Name}\t{record.ServiceDate}\t{record.ShiftStart}\t{record.ShiftEnd}");
}
