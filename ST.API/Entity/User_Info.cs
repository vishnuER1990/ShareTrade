//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace Entity
{
    using System;
    using System.Collections.Generic;
    
    public partial class User_Info
    {
        public int UserInfoId { get; set; }
        public Nullable<int> UserId { get; set; }
        public string First_Name { get; set; }
        public string Last_Name { get; set; }
        public string Email_Address { get; set; }
        public string Contact_Number { get; set; }
        public string QID_Number { get; set; }
        public string Shareholder_ID { get; set; }
    
        public virtual User User { get; set; }
    }
}