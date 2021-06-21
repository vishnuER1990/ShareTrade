using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entity.ViewModels
{
    public class EmailVM
    {
        public string EmailContent { get; set; }
        public string ToAddress { get; set; }
        public string EmailSubject { get; set; }
    }
}
