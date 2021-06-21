using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entity.ViewModels
{
    public class SaleDetailsVM
    {
        public int SaleId { get; set; }
        public int ShareDetailsId { get; set; }
        public int ProposalId { get; set; }
        public int NumberOfShares { get; set; }
        public int AvailableShares { get; set; }
        public decimal UnitPrice { get; set; }
        public string SaleRemarks { get; set; }
        public string ShareDescription { get; set; }
        public DateTime CreatedDt { get; set; }
        public int CreatedBy { get; set; }
        public DateTime UpdatedDt { get; set; }
        public int UpdatedBy { get; set; }
        public int Status { get; set; }
        public string StatusComments { get; set; }
        public bool IsActive { get; set; }
        public string Status_String { get; set; }
        public string CreatedBy_String { get; set; }
        public string UpdatedBy_String { get; set; }
        public int BidCount { get; set; }
        public bool IsNegotiable { get; set; }
        public string ShareholderContactNumber { get; set; }
        public DateTime ValidTo { get; set; }
    }
}
