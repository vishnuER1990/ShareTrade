using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entity.ViewModels
{
    public class UserReportVM
    {
        public string First_Name { get; set; }
        public string Last_Name { get; set; }
        public string Full_Name { get; set; }
        public string Email_Address { get; set; }
        public string Contact_Number { get; set; }
        public string QID_Number { get; set; }
        public DateTime RegisteredDate { get; set; }
        public string Status { get; set; }
        public string IsAdmin { get; set; }
        public string AdminApproved { get; set; }
    }
}
