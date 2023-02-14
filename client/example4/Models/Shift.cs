using System;
using System.Collections.Generic;

#nullable disable

namespace example4.Models
{
    public partial class Shift
    {
        public Shift()
        {
            ShiftStaffs = new HashSet<ShiftStaff>();
        }

        public long ShiftId { get; set; }
        public DateTime ShiftStart { get; set; }
        public DateTime ShiftEnd { get; set; }

        public virtual ICollection<ShiftStaff> ShiftStaffs { get; set; }
    }
}
