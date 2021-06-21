using Entity.ViewModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;


namespace Interfaces.Business
{
    public interface ISummaryBusinessService
    {
        SummaryVM GetSummary(int userId);

        List<SummaryBidsReceivedVM> GetBidsReceived(int userId);

        List<SummaryBidsSubmittedVM> GetBidsSubmitted(int userId);

        List<NotificationVM> GetNotifications(int userId);

    }
}
