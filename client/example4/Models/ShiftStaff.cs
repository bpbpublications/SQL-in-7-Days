using System;
using System.Collections.Generic;

#nullable disable

namespace example4.Models
{
    public partial class ShiftStaff
    {
        public long ShiftId { get; set; }
        public long StaffId { get; set; }

        public virtual Shift Shift { get; set; }
        public virtual Staff Staff { get; set; }
    }
}
