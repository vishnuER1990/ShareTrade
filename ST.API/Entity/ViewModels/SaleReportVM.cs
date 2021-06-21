using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entity.ViewModels
{
    public class SaleReportVM
    {
        public int SaleId { get; set; }
        public long NumberOfShares { get; set; }
        public decimal UnitPrice { get; set; }
        public string PriceNegotiable { get; set; }
        public DateTime ExpiryDate { get; set; }
        public string SaleStatus { get; set; }
        public string StatusDescription { get; set; }
        public DateTime SaleCreatedDate { get; set; }
        public string Seller { get; set; }
        public string SellerContactNumber { get; set; }
        public int BidCount { get; set; }
    }
}
