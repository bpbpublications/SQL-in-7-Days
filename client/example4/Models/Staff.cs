using System;
using System.Collections.Generic;

#nullable disable

namespace example4.Models
{
    public partial class Staff
    {
        public Staff()
        {
            InverseReportsToNavigation = new HashSet<Staff>();
            ShiftStaffs = new HashSet<ShiftStaff>();
            StaffInventories = new HashSet<StaffInventory>();
        }

        public long StaffId { get; set; }
        public string Name { get; set; }
        public string Title { get; set; }
        public long? ReportsTo { get; set; }

        public virtual Staff ReportsToNavigation { get; set; }
        public virtual Passkey Passkey { get; set; }
        public virtual ICollection<Staff> InverseReportsToNavigation { get; set; }
        public virtual ICollection<ShiftStaff> ShiftStaffs { get; set; }
        public virtual ICollection<StaffInventory> StaffInventories { get; set; }
    }
}
