using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entity.ViewModels
{
    public class ProposalDetailsVM
    {
        public int ProposalId { get; set; }
        public int SaleId { get; set; }
        public decimal BidPrice { get; set; }
        public long BidUnit { get; set; }
        public int NumberOfShares { get; set; }
        public string ShareDescription { get; set; }
        public decimal UnitPrice { get; set; }
        public DateTime CreatedDt { get; set; }
        public int CreatedBy { get; set; }
        public DateTime UpdatedDt { get; set; }
        public int UpdatedBy { get; set; }
        public int Status { get; set; }
        public string StatusComments { get; set; }
        public string StatusDescription { get; set; }
        public bool IsActive { get; set; }
        public string CreatedBy_String { get; set; }
        public string UpdatedBy_String { get; set; }
        public string ShareholderContactNumber { get; set; }
        public string Seller { get; set; }
        public string Buyer { get; set; }
        public long SellerAvailableShares { get; set; }
        public DateTime ValidTo { get; set; }
    }
}
