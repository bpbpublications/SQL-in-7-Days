using System;
using System.Collections.Generic;

#nullable disable

namespace example4.Models
{
    public partial class Passkey
    {
        public long Serial { get; set; }
        public Guid Code { get; set; }
        public long? Staff { get; set; }

        public virtual Staff StaffNavigation { get; set; }
    }
}
