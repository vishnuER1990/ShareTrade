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
    
    public partial class Get_SaleDetails_v1_Result
    {
        public int SaleId { get; set; }
        public Nullable<int> ShareDetailsId { get; set; }
        public int ProposalId { get; set; }
        public string SaleRemarks { get; set; }
        public Nullable<long> NumberOfShares { get; set; }
        public Nullable<decimal> ShareUnitPrice { get; set; }
        public Nullable<int> ApplicationStatus { get; set; }
        public string ApplicationStatusComments { get; set; }
        public Nullable<long> AvailableShares { get; set; }
        public string ShareDescription { get; set; }
        public Nullable<System.DateTime> SaleCreatedDt { get; set; }
        public Nullable<System.DateTime> SaleUpdatedDt { get; set; }
        public Nullable<System.DateTime> ShareCreatedDt { get; set; }
        public string SaleCreatedBy { get; set; }
        public string SaleUpdatedBy { get; set; }
        public string ShareCreatedBy { get; set; }
        public int BidCount { get; set; }
    }
}