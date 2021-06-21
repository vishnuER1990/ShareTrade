using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entity.ViewModels
{
    public class ShareSaleDetailsVM
    {
        public int ApplicationId { get; set; }
        public int ShareDetailsId { get; set; }
        public int ProposalId { get; set; }
        public string ApplicationRemarks { get; set; }
        public int NumberOfShares { get; set; }
        public decimal ShareUnitPrice { get; set; }
        public string ShareDescription { get; set; }
        public decimal BidPrice { get; set; }
        public int BidUnit { get; set; }
        public string ApplicationStatus { get; set; }
        public string ApplicationStatusComments { get; set; }
        public string BidStatus { get; set; }
        public string BidStatusComments { get; set; }
        public DateTime ApplicationCreatedDt { get; set; }
        public string ApplicationCreatedBy { get; set; }
        public DateTime ApplicationUpdatedDt { get; set; }
        public string ApplicationUpdatedBy { get; set; }
        public DateTime ShareCreatedDt { get; set; }
        public string ShareCreatedBy { get; set; }
        public DateTime ProposalCreatedDt { get; set; }
        public string ProposalCreatedBy { get; set; }
    }
}
