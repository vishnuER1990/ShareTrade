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
    
    public partial class Sale_Details
    {
        public int SaleId { get; set; }
        public Nullable<int> ShareDetailsId { get; set; }
        public Nullable<long> NumberOfShares { get; set; }
        public Nullable<decimal> UnitPrice { get; set; }
        public string SaleRemarks { get; set; }
        public Nullable<System.DateTime> CreatedDt { get; set; }
        public Nullable<int> CreatedBy { get; set; }
        public Nullable<System.DateTime> UpdatedDt { get; set; }
        public Nullable<int> UpdatedBy { get; set; }
        public Nullable<int> Status { get; set; }
        public string StatusComments { get; set; }
        public Nullable<System.DateTime> ValidTo { get; set; }
        public Nullable<bool> IsActive { get; set; }
        public Nullable<bool> IsNegotiable { get; set; }
    }
}
