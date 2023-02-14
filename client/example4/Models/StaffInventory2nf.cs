using System;
using System.Collections.Generic;

#nullable disable

namespace example4.Models
{
    public partial class StaffInventory2nf
    {
        public long StaffId { get; set; }
        public string InventoryNumber { get; set; }
        public long? StaffReportsTo { get; set; }

        public virtual Inventory InventoryNumberNavigation { get; set; }
        public virtual Staff Staff { get; set; }
        public virtual Staff StaffReportsToNavigation { get; set; }
    }
}
