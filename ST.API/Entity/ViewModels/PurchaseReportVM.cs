using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entity.ViewModels
{
    public class PurchaseReportVM
    {
        public int SaleId { get; set; }
        public int ProposalId { get; set; }
        public decimal BidPrice { get; set; }
        public int BidUnit { get; set; }
        public decimal SaleUnitPrice { get; set; }
        public string BidStatus { get; set; }
        public DateTime BidCreatedDate { get; set; }
        public string Buyer { get; set; }
        public string Seller { get; set; }
        public string SellerContactNumber { get; set; }
        public long SellerAvailableShares { get; set; }
    }
}
