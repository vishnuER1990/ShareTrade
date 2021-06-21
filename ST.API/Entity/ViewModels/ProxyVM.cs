using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entity.ViewModels
{
    public class ProxyVM
    {
        public int ProvidedProxy { get; set; }
        public int PersonallyAttended { get; set; }
        public int TotalAttendance { get; set; }
        public string Quorum { get; set; }

    }
}
