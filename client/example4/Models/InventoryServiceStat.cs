using System;
using System.Collections.Generic;

#nullable disable

namespace example4.Models
{
    public partial class InventoryServiceStat
    {
        public string InventoryNumber { get; set; }
        public long JobCount { get; set; }

        public virtual Inventory InventoryNumberNavigation { get; set; }
    }
}
