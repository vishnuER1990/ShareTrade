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
    
    public partial class Get_UserList_Result
    {
        public int UserInfoId { get; set; }
        public Nullable<int> UserId { get; set; }
        public string UserName { get; set; }
        public string Password { get; set; }
        public Nullable<bool> IsAdmin { get; set; }
        public string First_Name { get; set; }
        public string Last_Name { get; set; }
        public string Full_Name { get; set; }
        public string Email_Address { get; set; }
        public string Contact_Number { get; set; }
        public string QID_Number { get; set; }
        public string Shareholder_ID { get; set; }
        public Nullable<System.DateTime> CreatedDt { get; set; }
        public Nullable<int> CreatedBy { get; set; }
        public Nullable<System.DateTime> UpdatedDt { get; set; }
        public Nullable<int> UpdatedBy { get; set; }
        public string CreatedBy_Name { get; set; }
        public string UpdatedBy_Name { get; set; }
        public Nullable<bool> IsActive { get; set; }
        public Nullable<bool> IsAdminApproved { get; set; }
        public int AvailableShares { get; set; }
    }
}