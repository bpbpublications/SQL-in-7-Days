using System;
using System.Collections.Generic;

#nullable disable

namespace example4.Models
{
    public partial class Inventory
    {
        public Inventory()
        {
            Services = new HashSet<Service>();
            StaffInventories = new HashSet<StaffInventory>();
        }

        public string InventoryNumber { get; set; }
        public string Name { get; set; }
        public decimal Price { get; set; }
        public string Comment { get; set; }

        public virtual InventoryServiceStat InventoryServiceStat { get; set; }
        public virtual InventoryStaff1nf InventoryStaff1nf { get; set; }
        public virtual ICollection<Service> Services { get; set; }
        public virtual ICollection<StaffInventory> StaffInventories { get; set; }
    }
}
