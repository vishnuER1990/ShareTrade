using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web;
using Entity;
using Entity.ViewModels;
using Interfaces.Data;

namespace DataLayer
{
    public class ReportDataHandler : IReportDataService
    {
        public List<ProxyVM> GetProxy(DateTime fromDate, DateTime toDate)
        {
            List<ProxyVM> proxy = new List<ProxyVM>();
            using (var dbContext = new ShareTradeEntities())
            {

                var quorum = dbContext.Get_Quorum().ToList();

                proxy = quorum.Select(x => new ProxyVM
                {
                   ProvidedProxy = Convert.ToInt32(x.ProvidedProxy),
                    PersonallyAttended = Convert.ToInt32(x.PersonallyAttended),
                    TotalAttendance = Convert.ToInt32(x.TotalAttendance),
                    Quorum = Convert.ToString(x.Quorum)
                }).ToList();
            }
            return proxy;
        }


        public List<PurchaseReportVM> GetPurchaseList(DateTime fromDate, DateTime toDate)
        {
            List<PurchaseReportVM> objListProposal = new List<PurchaseReportVM>();

            using (var dbContext = new ShareTradeEntities())
            {
                try
                {
                    if (fromDate == DateTime.MinValue || toDate == DateTime.MinValue)
                    {
                        fromDate = DateTime.MinValue.Date;
                        toDate = DateTime.MaxValue.Date;
                    }

                    var proposalList_1 = dbContext.Get_BidDetails_Report().Where(x=>Convert.ToDateTime(x.BidCreatedDate).Date >= fromDate.Date && Convert.ToDateTime(x.BidCreatedDate).Date <= toDate.Date);

                    objListProposal = proposalList_1.Select(x => new PurchaseReportVM
                    {
                        BidCreatedDate = Convert.ToDateTime(x.BidCreatedDate),
                        BidPrice = Convert.ToDecimal(x.BidPrice),
                        BidStatus = x.BidStatus,
                        BidUnit = Convert.ToInt32(x.BidUnit),
                        Buyer = x.Buyer,
                        ProposalId = x.ProposalId,
                        SaleId = Convert.ToInt32(x.SaleId),
                        SaleUnitPrice = Convert.ToDecimal(x.SaleUnitPrice),
                        Seller = x.Seller,
                        SellerAvailableShares = (long)x.SellerAvailableShares,
                        SellerContactNumber = x.SellerContactNumber

                    }).ToList();

                }
                catch (Exception ex)
                {
                    ErrorHandler.AddError(ex, 0);
                }
                return objListProposal;
            }
        }

        public List<UserReportVM> GetRegistredUser(DateTime fromDate, DateTime toDate)
        {
            List<UserReportVM> objListUser = new List<UserReportVM>();

            using (var dbContext = new ShareTradeEntities())
            {
                try
                {
                    if (fromDate == DateTime.MinValue || toDate == DateTime.MinValue)
                    {
                        fromDate = DateTime.MinValue.Date;
                        toDate = DateTime.MaxValue.Date;
                    }
                    var userList = dbContext.Get_UserList(null, null).Where(x => x.IsAdmin != true && (Convert.ToDateTime(x.CreatedDt).Date >= fromDate.Date && Convert.ToDateTime(x.CreatedDt).Date <= toDate.Date)); 

                    var tempUserList = userList.Select(x => new UserReportVM
                    {
                        First_Name = x.First_Name,
                        Last_Name = x.Last_Name,
                        Full_Name = x.Full_Name,
                        Email_Address = x.Email_Address,
                        Contact_Number = x.Contact_Number,
                        QID_Number = Convert.ToString(x.QID_Number),
                        IsAdmin = Convert.ToBoolean(x.IsAdmin) ? "Yes" : "No",
                        RegisteredDate = Convert.ToDateTime(x.CreatedDt),
                        Status = Convert.ToBoolean(x.IsActive) ? "Yes" : "No",
                        AdminApproved = Convert.ToBoolean(x.IsAdminApproved) ? "Yes" : "No"
                    }).ToList();

                    objListUser = tempUserList;
                }
                catch (Exception ex)
                {
                    objListUser = null;
                    ErrorHandler.AddError(ex, 0);
                }
                return objListUser;
            }
        }

        public List<SaleReportVM> GetSaleList(DateTime fromDate, DateTime toDate)
        {
            List<SaleReportVM> objSaleDetailsList = new List<SaleReportVM>();

            using (var dbContext = new ShareTradeEntities())
            {
                try
                {
                    if(fromDate == DateTime.MinValue || toDate == DateTime.MinValue)
                    {
                        fromDate = DateTime.MinValue.Date;
                        toDate = DateTime.MaxValue.Date;
                    }
                  
                    var saleList = dbContext.Get_SaleDetails_Report().Where(x=> Convert.ToDateTime(x.SaleCreatedDate).Date >= fromDate.Date && Convert.ToDateTime(x.SaleCreatedDate).Date <= toDate.Date);

                    objSaleDetailsList = saleList.Select(x => new SaleReportVM
                    {
                        SaleId = x.SaleId,
                        NumberOfShares = (long)x.NumberOfShares,
                        UnitPrice = Convert.ToDecimal(x.UnitPrice),
                        PriceNegotiable = Convert.ToBoolean(x.PriceNegotiable) ? "Yes" : "No",
                        ExpiryDate = Convert.ToDateTime(x.ExpiryDate),
                        SaleStatus = x.SaleStatus,
                        StatusDescription = x.StatusDescription,
                        SaleCreatedDate = Convert.ToDateTime(x.SaleCreatedDate),
                        Seller = x.Seller,
                        SellerContactNumber = Convert.ToString(x.SellerContactNumber),
                        BidCount = Convert.ToInt32(x.BidCount)
                    }).ToList();
                }
                catch (Exception ex)
                {
                    objSaleDetailsList = null;
                    ErrorHandler.AddError(ex, 0);
                }
                return objSaleDetailsList;
            }
        }
    }
}
