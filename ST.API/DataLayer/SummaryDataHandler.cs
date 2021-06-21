using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Interfaces.Business;
using Interfaces.Data;
using Entity;
using Entity.ViewModels;


namespace DataLayer
{
    public class SummaryDataHandler : ISummaryDataService
    {
        public List<SummaryBidsReceivedVM> GetBidsReceived(int userId)
        {
            List<SummaryBidsReceivedVM> objBidsReceived = new List<SummaryBidsReceivedVM>();

            using (var dbContext = new ShareTradeEntities())
            {
                try
                {
                    var list = dbContext.Get_Summary_BidReceived(userId);

                    objBidsReceived = list.Select(x => new SummaryBidsReceivedVM
                    {
                        BidderContactNumber = x.BidderContactNumber,
                        BidderName = x.BidderName,
                        BidPrice = Convert.ToDecimal(x.BidPrice)
                    }).ToList();
                }
                catch (Exception ex)
                {
                    objBidsReceived = null;
                    ErrorHandler.AddError(ex, 0);
                }
                return objBidsReceived;
            }
        }

        public List<SummaryBidsSubmittedVM> GetBidsSubmitted(int userId)
        {
            List<SummaryBidsSubmittedVM> objBidsSubmitted = new List<SummaryBidsSubmittedVM>();

            using (var dbContext = new ShareTradeEntities())
            {
                try
                {
                    var list = dbContext.Get_Summary_BidSubmitted(userId);

                    objBidsSubmitted = list.Select(x => new SummaryBidsSubmittedVM
                    {
                        BidPrice = Convert.ToDecimal(x.BidPrice),
                        BidStatus = x.StatusDescription,
                        ShareholderName = x.ShareHolderName
                    }).ToList();
                }
                catch (Exception ex)
                {
                    objBidsSubmitted = null;
                    ErrorHandler.AddError(ex, 0);
                }
                return objBidsSubmitted;
            }
        }

        public List<NotificationVM> GetNotifications(int userId)
        {
            List<NotificationVM> objNotification = new List<NotificationVM>();

            using (var dbContext = new ShareTradeEntities())
            {
                try
                {
                    var list = dbContext.Get_Purchase_Interest_Notification(userId);

                    objNotification = list.Select(x => new NotificationVM
                    {
                        NotificationId = x.NotificationId,
                        NotificationText = x.NotificationText,
                        Createdate = Convert.ToDateTime(x.CreatedDt)
                    }).ToList();
                }
                catch (Exception ex)
                {
                    objNotification = null;
                    ErrorHandler.AddError(ex, 0);
                }
                return objNotification;
            }
        }

        public SummaryVM GetSummary(int userId)
        {
            SummaryVM objSummary = new SummaryVM();

            using (var dbContext = new ShareTradeEntities())
            {
                try
                {
                    Get_Summary_Result result = new Get_Summary_Result();

                    result = dbContext.Get_Summary(userId).FirstOrDefault();

                    objSummary.AvailableShares = (long)result.AvailableShares;
                    objSummary.SaleRegisteredForSale = (long)result.SaleRegisteredForSale;
                    objSummary.QID = (long)result.QID;

                }
                catch (Exception ex)
                {
                    objSummary = null;
                    ErrorHandler.AddError(ex, 0);
                }

                return objSummary;
            }
        }
    }
}
