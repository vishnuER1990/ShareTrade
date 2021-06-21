using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entity.ViewModels
{
    public class SummaryBidsSubmittedVM
    {
        public string ShareholderName { get; set; }
        public decimal  BidPrice { get; set; }
        public string BidStatus { get; set; }
    }
}
