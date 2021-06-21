using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Data.Entity.Core.Objects;
using System.Data.SqlClient;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Web;
using Interfaces.Data;
using Entity;
using Entity.ViewModels;
using System.Threading.Tasks;

namespace DataLayer
{
    public class SaleDataHandler : ISaleDataService
    {
        private HttpContext cntx { get; set; }

        public SaleDataHandler()
        {
            this.cntx = HttpContext.Current;
        }
        public void test()
        {
            throw new NotImplementedException();
        }


        public Response AddNewShareSale(SaleDetailsVM ObjApplicationDetailsVM)
        {
            Response objResponse = new Response();
            using (var dbContext = new ShareTradeEntities())
            {
                try
                {
                    Sale_Details objApplication_Details = new Sale_Details();

                    objApplication_Details.ShareDetailsId = ObjApplicationDetailsVM.ShareDetailsId;
                    objApplication_Details.NumberOfShares = ObjApplicationDetailsVM.NumberOfShares;
                    objApplication_Details.UnitPrice = ObjApplicationDetailsVM.UnitPrice;
                    objApplication_Details.SaleRemarks = ObjApplicationDetailsVM.SaleRemarks;
                    objApplication_Details.CreatedDt = DateTime.Now;
                    objApplication_Details.CreatedBy = ObjApplicationDetailsVM.CreatedBy;
                    objApplication_Details.Status = 1; //Submitted
                    objApplication_Details.StatusComments = "Submitted. Pending shareholder Approval.";
                    objApplication_Details.IsActive = true;
                    objApplication_Details.IsNegotiable = ObjApplicationDetailsVM.IsNegotiable;
                    objApplication_Details.ValidTo = ObjApplicationDetailsVM.ValidTo.AddDays(1);

                    dbContext.Sale_Details.Add(objApplication_Details);
                    dbContext.SaveChanges();

                    objResponse.status = true;
                    objResponse.exception = string.Empty;
                    Task.Factory.StartNew(() =>
                    {
                        SendEmail(ObjApplicationDetailsVM.CreatedBy, 0, objApplication_Details.SaleId, "NewSale");
                    });

                }
                catch (Exception ex)
                {
                    objResponse.status = false;
                    objResponse.exception = ErrorHandler.AddError(ex, ObjApplicationDetailsVM.CreatedBy);
                }
            }
            return objResponse;
        }

        public Response UpdateShareSale(SaleDetailsVM ObjApplicationDetailsVM)
        {
            Response objResponse = new Response();
            using (var dbContext = new ShareTradeEntities())
            {
                try
                {
                    Sale_Details objApplication_Details = new Sale_Details();
                    objApplication_Details = dbContext.Sale_Details.First(x => x.SaleId == ObjApplicationDetailsVM.SaleId);

                    objApplication_Details.ShareDetailsId = ObjApplicationDetailsVM.ShareDetailsId;
                    objApplication_Details.NumberOfShares = ObjApplicationDetailsVM.NumberOfShares;
                    objApplication_Details.UnitPrice = ObjApplicationDetailsVM.UnitPrice;
                    objApplication_Details.SaleRemarks = ObjApplicationDetailsVM.SaleRemarks;
                    objApplication_Details.IsNegotiable = ObjApplicationDetailsVM.IsNegotiable;
                    objApplication_Details.UpdatedDt = DateTime.Now;
                    objApplication_Details.UpdatedBy = ObjApplicationDetailsVM.UpdatedBy;
                    objApplication_Details.ValidTo = ObjApplicationDetailsVM.ValidTo.AddDays(1);

                    dbContext.SaveChanges();
                    objResponse.status = true;
                    objResponse.exception = string.Empty;

                }
                catch (Exception ex)
                {
                    objResponse.status = false;
                    objResponse.exception = ErrorHandler.AddError(ex, ObjApplicationDetailsVM.UpdatedBy);
                }
            }
            return objResponse;
        }

        public Response DeleteShareSale(SaleDetailsVM ObjApplicationDetailsVM)
        {
            Response objResponse = new Response();
            using (var dbContext = new ShareTradeEntities())
            {
                try
                {
                    Sale_Details objApplication_Details = new Sale_Details();
                    objApplication_Details = dbContext.Sale_Details.First(x => x.SaleId == ObjApplicationDetailsVM.SaleId);

                    objApplication_Details.Status = 2;//Cancelled
                    objApplication_Details.IsActive = false;
                    objApplication_Details.UpdatedBy = ObjApplicationDetailsVM.UpdatedBy;

                    dbContext.SaveChanges();

                    objResponse.status = true;
                    objResponse.exception = string.Empty;

                }
                catch (Exception ex)
                {
                    objResponse.status = false;
                    objResponse.exception = ErrorHandler.AddError(ex, ObjApplicationDetailsVM.UpdatedBy);
                }
            }
            return objResponse;
        }

        public List<SaleDetailsVM> GetSaleList(SaleDetailsVM ObjApplicationDetailsVM)
        {
            List<SaleDetailsVM> objSaleDetailsList = new List<SaleDetailsVM>();

            using (var dbContext = new ShareTradeEntities())
            {
                try
                {

                    var saleList = dbContext.Get_SaleDetails(ObjApplicationDetailsVM.SaleId, ObjApplicationDetailsVM.CreatedBy);
                    objSaleDetailsList = saleList.Select(x => new SaleDetailsVM
                    {
                        SaleId = x.SaleId,
                        ShareDetailsId = Convert.ToInt32(x.ShareDetailsId),
                        NumberOfShares = Convert.ToInt32(x.NumberOfShares),
                        UnitPrice = Convert.ToDecimal(x.ShareUnitPrice),
                        SaleRemarks = x.SaleRemarks,
                        Status = Convert.ToInt32(x.ApplicationStatus),
                        StatusComments = x.ApplicationStatusComments,
                        AvailableShares = Convert.ToInt32(x.AvailableShares),
                        ShareDescription = x.ShareDescription,
                        CreatedDt = Convert.ToDateTime(x.SaleCreatedDt),
                        UpdatedDt = Convert.ToDateTime(x.SaleUpdatedDt),
                        UpdatedBy_String = x.SaleUpdatedBy,
                        CreatedBy_String = x.SaleCreatedBy,
                        Status_String = x.StatusDescription,
                        CreatedBy = Convert.ToInt32(x.CreatedBy),
                        UpdatedBy = Convert.ToInt32(x.UpdatedBy),
                        IsNegotiable = Convert.ToBoolean(x.IsNegotiable),
                        ShareholderContactNumber = x.ShareholderContactNumber,
                        ValidTo = Convert.ToDateTime(x.ValidTo)
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

        public Response NotifyPurchaseInterest(int userId, string share, string price)
        {
            Response objResponse = new Response();
            using (var dbContext = new ShareTradeEntities())
            {
                try
                {
                    Purchase_Interest_Notification notification = new Purchase_Interest_Notification();
                    notification.CreatedBy = userId;
                    notification.Share = Convert.ToInt64(share);
                    notification.Price = Convert.ToDecimal(price);
                    notification.CreatedDt = DateTime.Now;

                    dbContext.Purchase_Interest_Notification.Add(notification);
                    dbContext.SaveChanges();

                    objResponse.status = true;
                    objResponse.exception = string.Empty;

                    Task.Factory.StartNew(() =>
                    {
                        SendEmail(userId, 0, 0, "PurchaseInterest");
                    });

                }
                catch (Exception ex)
                {
                    objResponse.status = false;
                    objResponse.exception = ErrorHandler.AddError(ex, userId);
                }
            }
            return objResponse;
        }
        private async Task SendEmail(int userId, int proposalId, int saleId, string category)
        {
            EmailVM emailVM = new EmailVM();
            List<vw_User_info> userList = new List<vw_User_info>();
            string _tempContent = string.Empty;

            using (var dbContext = new ShareTradeEntities())
            {
                Get_EmailContent_Result emailResult = dbContext.Get_EmailContent(userId, proposalId, saleId, category).FirstOrDefault();
                emailVM.EmailContent = emailResult.EmailContent;
                emailVM.EmailSubject = emailResult.EmailSubject;
                emailVM.ToAddress = emailResult.ToAddress;
                _tempContent = emailVM.EmailContent;

                userList = dbContext.vw_User_info.Where(x => x.Email_Address != null && x.IsAdmin == false).ToList();
            }
            if(category == "NewSale")
            {

                userList = userList.Where(x => x.UserId != userId).ToList();

                foreach ( var user in userList)
                {
                    emailVM.EmailContent = _tempContent;//Initialize email content in the loop each time with orginal content.

                    emailVM.ToAddress = user.Email_Address;
                    emailVM.EmailContent = emailVM.EmailContent.Replace("$UserFirstName$", user.First_Name);
                    EmailDataHandler email = new EmailDataHandler("test@test.com", emailVM.ToAddress, emailVM.EmailSubject, emailVM.EmailContent, this.cntx, false);
                    email.sendEmail();
                }

                //Send to Admin
                EmailDataHandler email1 = new EmailDataHandler("test@test.com", "itsupport@shailship.com", emailVM.EmailSubject, _tempContent.Replace("$UserFirstName$", "Admin"), this.cntx, false);
                email1.sendEmail();
            }
            else if (category == "PurchaseInterest")
            {                
                userList = userList.Where(x=>x.UserId != userId).ToList();

                foreach (var user in userList)
                {
                    emailVM.EmailContent = _tempContent;//Initialize email content in the loop each time with orginal content.

                    emailVM.ToAddress = user.Email_Address;
                    emailVM.EmailContent = emailVM.EmailContent.Replace("$UserFirstName$", user.First_Name);
                    EmailDataHandler email = new EmailDataHandler("test@test.com", emailVM.ToAddress, emailVM.EmailSubject, emailVM.EmailContent, this.cntx, false);
                    email.sendEmail();
                }
            }
            else
            {
                EmailDataHandler email = new EmailDataHandler("test@test.com", emailVM.ToAddress, emailVM.EmailSubject, emailVM.EmailContent, this.cntx);
                email.sendEmail();
            }
        }

    }
}
