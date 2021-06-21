using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entity.ViewModels
{
    public class UserVM
    {
        public int UserId { get; set; }
        public int UserInfoId { get; set; }
        public string UserName { get; set; }
        public string Password { get; set; }
        public string First_Name { get; set; }
        public string Last_Name { get; set; }
        public string Full_Name { get; set; }        
        public string Email_Address { get; set; }
        public string Contact_Number { get; set; }
        public string QID_Number { get; set; }
        public string Shareholder_ID { get; set; }
        public DateTime CreatedDt { get; set; }
        public int CreatedBy { get; set; }
        public DateTime UpdatedDt { get; set; }
        public int UpdatedBy { get; set; }
        public bool IsActive { get; set; }
        public bool IsAdmin { get; set; }
        public bool IsAdminApproved { get; set; }
        public string CreatedBy_String { get; set; }
        public string UpdatedBy_String { get; set; }
        public int ShareCount { get; set; }
    }
}
