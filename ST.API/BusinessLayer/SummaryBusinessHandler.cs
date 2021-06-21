using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Interfaces.Business;
using Interfaces.Data;
using Entity;
using Entity.ViewModels;

namespace BusinessLayer
{
    public class SummaryBusinessHandler : ISummaryBusinessService
    {
        private ISummaryDataService summaryDataService = null;

        public SummaryBusinessHandler(ISummaryDataService summary)
        {
            this.summaryDataService = summary;
        }

        public List<SummaryBidsReceivedVM> GetBidsReceived(int userId)
        {
            return this.summaryDataService.GetBidsReceived(userId);
        }

        public List<SummaryBidsSubmittedVM> GetBidsSubmitted(int userId)
        {
            return this.summaryDataService.GetBidsSubmitted(userId);
        }

        public List<NotificationVM> GetNotifications(int userId)
        {
            return this.summaryDataService.GetNotifications(userId);
        }

        public SummaryVM GetSummary(int userId)
        {
           return this.summaryDataService.GetSummary(userId);
        }
    }
}
