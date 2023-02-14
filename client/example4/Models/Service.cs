using System;
using System.Collections.Generic;

#nullable disable

namespace example4.Models
{
    public partial class Service
    {
        public long ServiceId { get; set; }
        public string InventoryNumber { get; set; }
        public DateTime ServiceDate { get; set; }
        public string Comment { get; set; }

        public virtual Inventory InventoryNumberNavigation { get; set; }
    }
}
