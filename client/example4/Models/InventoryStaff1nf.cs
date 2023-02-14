using System;
using System.Collections.Generic;

#nullable disable

namespace example4.Models
{
    public partial class InventoryStaff1nf
    {
        public string InventoryNumber { get; set; }
        public long[] StaffIds { get; set; }

        public virtual Inventory InventoryNumberNavigation { get; set; }
    }
}
