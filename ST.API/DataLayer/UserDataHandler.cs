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
    public class UserDataHandler : IUserDataService
    {
        private HttpContext cntx { get; set; }
        public UserDataHandler()
        {
            this.cntx = HttpContext.Current;
        }
        public Response AddUser(UserVM ObjUserVM)
        {
            Response objResponse = new Response();
            long shareHolderId = 0;
            bool adminApproved = false;
            using (var dbContext = new ShareTradeEntities())
            {
                try
                {

                    var share = dbContext.Share_Details.Where(x => x.QID == ObjUserVM.QID_Number).FirstOrDefault();

                    bool userNameExists = dbContext.vw_User_info.Any(x => x.UserName == ObjUserVM.UserName);

                    if(userNameExists)
                    {
                        objResponse.status = false;
                        objResponse.exception = "The username already exists. Please enter another username";
                        return objResponse;
                    }

                    if (share != null)
                    {
                        shareHolderId = (long) share.ShareholderID;
                        adminApproved = true; //If share details exists for QID then no admin approval is required.
                    }

                    User objUser = new User();
                    objUser.UserName = ObjUserVM.UserName;
                    objUser.Password = ObjUserVM.Password;
                    objUser.CreatedDt = DateTime.Now;
                    objUser.CreatedBy = ObjUserVM.CreatedBy;
                    objUser.IsActive = true;
                    objUser.IsAdmin = false;
                    objUser.IsAdminApproved = adminApproved;

                    dbContext.User.Add(objUser);
                    dbContext.SaveChanges();

                    User_Info objUserInfo = new User_Info();
                    objUserInfo.UserId = objUser.UserId;
                    objUserInfo.First_Name = ObjUserVM.First_Name;
                    objUserInfo.Last_Name = ObjUserVM.Last_Name;
                    objUserInfo.Email_Address = ObjUserVM.Email_Address;
                    objUserInfo.Contact_Number = ObjUserVM.Contact_Number;
                    objUserInfo.QID_Number =ObjUserVM.QID_Number;
                    objUserInfo.Shareholder_ID = Convert.ToString(shareHolderId);

                    dbContext.User_Info.Add(objUserInfo);
                    dbContext.SaveChanges();

                    if(!adminApproved)
                    {
                        SendEmail(objUser.UserId, 0, 0, "NewUser");
                        SendEmail(objUser.UserId, 0, 0, "NewUserToClient");
                    }
                    else if(adminApproved)
                    {
                        SendEmail(objUser.UserId, 0, 0, "NewUserRegistration");
                    }

                    objResponse.status = true;
                    objResponse.exception = string.Empty;
                }
                catch (Exception ex)
                {
                    objResponse.status = false;
                    objResponse.exception = ErrorHandler.AddError(ex, 0);
                }
            }
            return objResponse;
        }

        public Response DeleteUser(UserVM ObjUserVM)
        {
            Response objResponse = new Response();
            using (var dbContext = new ShareTradeEntities())
            {
                try
                {
                    User objUser = new User();
                    objUser = dbContext.User.ToList().First(x => x.UserId == ObjUserVM.UserId);

                    objUser.UpdatedDt = DateTime.Now;
                    objUser.UpdatedBy = ObjUserVM.UpdatedBy;
                    objUser.IsActive = ObjUserVM.IsActive;

                    dbContext.SaveChanges();

                    objResponse.status = true;
                    objResponse.exception = string.Empty;
                }
                catch (Exception ex)
                {
                    objResponse.status = false;
                    objResponse.exception = ErrorHandler.AddError(ex, ObjUserVM.UpdatedBy);
                }
            }
            return objResponse;
        }

        public Response UpdateUser(UserVM ObjUserVM)
        {
            Response objResponse = new Response();
            bool existingIsAdminApprovedValue;
            bool newAdminApprovedValue;
            using (var dbContext = new ShareTradeEntities())
            {
                try
                {
                    User objUser = new User();
                    objUser = dbContext.User.ToList().First(x => x.UserId == ObjUserVM.UserId);

                    existingIsAdminApprovedValue = Convert.ToBoolean(objUser.IsAdminApproved);
                    newAdminApprovedValue = ObjUserVM.IsAdminApproved;

                    objUser.UserName = ObjUserVM.UserName;
                    objUser.Password = ObjUserVM.Password;
                    objUser.IsActive = ObjUserVM.IsActive;
                    objUser.IsAdmin = ObjUserVM.IsAdmin;
                    objUser.UpdatedDt = DateTime.Now;
                    objUser.UpdatedBy = ObjUserVM.UpdatedBy;
                    objUser.IsAdminApproved = ObjUserVM.IsAdminApproved;

                    dbContext.SaveChanges();

                    User_Info objUserInfo = new User_Info();
                    objUserInfo = dbContext.User_Info.ToList().First(x => x.UserId == ObjUserVM.UserId);

                    objUserInfo.First_Name = ObjUserVM.First_Name;
                    objUserInfo.Last_Name = ObjUserVM.Last_Name;
                    objUserInfo.Email_Address = ObjUserVM.Email_Address;
                    objUserInfo.Contact_Number = ObjUserVM.Contact_Number;
                    objUserInfo.QID_Number = ObjUserVM.QID_Number;
                    objUserInfo.Shareholder_ID = ObjUserVM.Shareholder_ID;

                    dbContext.SaveChanges();

                    if(existingIsAdminApprovedValue != newAdminApprovedValue)
                    {
                        SendEmail(objUser.UserId, 0, 0, newAdminApprovedValue ? "AdminApprovedUser" : "AdminRejectedUser");
                    }

                    objResponse.status = true;
                    objResponse.exception = string.Empty;
                }
                catch (Exception ex)
                {
                    objResponse.status = false;
                    objResponse.exception = ErrorHandler.AddError(ex, ObjUserVM.UpdatedBy);
                }
            }
            return objResponse;
        }

        public List<UserVM> GetUserList(UserVM ObjUserVM)
        {
           List<UserVM> objListUser = new List<UserVM>();

            using (var dbContext = new ShareTradeEntities())
            {
                try
                {
                    var userList = dbContext.Get_UserList(null, null);
                    var tempUserList = userList.Select(x => new UserVM
                    {
                        UserId = Convert.ToInt32(x.UserId),
                        UserInfoId = x.UserInfoId,
                        UserName = x.UserName,
                        Password = x.Password,
                        IsAdmin = Convert.ToBoolean(x.IsAdmin),
                        First_Name = x.First_Name,
                        Last_Name = x.Last_Name,
                        Full_Name = x.Full_Name,
                        Email_Address = x.Email_Address,
                        Contact_Number =x.Contact_Number,
                        QID_Number = Convert.ToString(x.QID_Number),
                        Shareholder_ID = x.Shareholder_ID,
                        CreatedDt = Convert.ToDateTime(x.CreatedDt),
                        CreatedBy = Convert.ToInt32(x.CreatedBy),
                        UpdatedDt = Convert.ToDateTime(x.UpdatedDt),
                        UpdatedBy = Convert.ToInt32(x.UpdatedBy),
                        CreatedBy_String = x.CreatedBy_Name,
                        UpdatedBy_String = x.UpdatedBy_Name,
                        IsActive = Convert.ToBoolean(x.IsActive),
                        IsAdminApproved = Convert.ToBoolean(x.IsAdminApproved)
                    }).ToList();


                    if (ObjUserVM.UserId != 0)
                    {
                        objListUser = tempUserList.Where(x => x.UserId == ObjUserVM.UserId).ToList();
                    }
                    else
                    {
                        objListUser = tempUserList;
                    }
                }
                catch (Exception ex)
                {
                    objListUser = null;
                    ErrorHandler.AddError(ex, 0);
                }
                return objListUser;
            }
        }

        public UserVM ValidateUser(UserVM ObjUserVM)
        {
            UserVM obUser = new UserVM();

            using (var dbContext = new ShareTradeEntities())
            {
                try
                {
                    var objListUser = dbContext.Get_UserList(ObjUserVM.UserName, ObjUserVM.Password);

                    var tempUserList = objListUser.Select(x => new UserVM
                    {
                        UserId = Convert.ToInt32(x.UserId),
                        UserInfoId = x.UserInfoId,
                        UserName = x.UserName,
                        Password = x.Password,
                        IsAdmin = Convert.ToBoolean(x.IsAdmin),
                        First_Name = x.First_Name,
                        Last_Name = x.Last_Name,
                        Full_Name = x.Full_Name,
                        Email_Address = x.Email_Address,
                        Contact_Number = x.Contact_Number,
                        QID_Number = Convert.ToString(x.QID_Number),
                        Shareholder_ID = x.Shareholder_ID,
                        CreatedDt = Convert.ToDateTime(x.CreatedDt),
                        CreatedBy = Convert.ToInt32(x.CreatedBy),
                        UpdatedDt = Convert.ToDateTime(x.UpdatedDt),
                        UpdatedBy = Convert.ToInt32(x.UpdatedBy),
                        CreatedBy_String = x.CreatedBy_Name,
                        UpdatedBy_String = x.UpdatedBy_Name,
                        IsActive = Convert.ToBoolean(x.IsActive),
                        IsAdminApproved = Convert.ToBoolean(x.IsAdminApproved),
                        ShareCount = x.AvailableShares
                    }).ToList();

                    obUser = tempUserList.FirstOrDefault();
                }
                catch (Exception ex)
                {
                    obUser = null;
                    ErrorHandler.AddError(ex, 0);
                }
                return obUser;
            }
        }

        public Response ForgotPassword(UserVM ObjUserVM)
        {

            Response objResponse = new Response();

            try
            {
                EmailVM emailVM = new EmailVM();
                using (var dbContext = new ShareTradeEntities())
                {
                    var  user = dbContext.vw_User_info.Where(x => x.UserName == ObjUserVM.UserName).FirstOrDefault();
                    if(user == null)
                    {
                        objResponse.status = false;
                        objResponse.exception = "The username does not exists. Please enter a valid username";
                        return objResponse;
                    }
                    Get_EmailContent_Result emailResult = dbContext.Get_EmailContent(user.UserId, 0, 0, "ForgotPassword").FirstOrDefault();
                    emailVM.EmailContent = emailResult.EmailContent;
                    emailVM.EmailSubject = emailResult.EmailSubject;
                    emailVM.ToAddress = emailResult.ToAddress;
                }
                EmailDataHandler email = new EmailDataHandler("test@test.com", emailVM.ToAddress, emailVM.EmailSubject, emailVM.EmailContent, this.cntx);
                email.sendEmail();

                objResponse.status = true;
                objResponse.exception = string.Empty;
            }
            catch (Exception ex)
            {

                objResponse.status = false;
                objResponse.exception = ErrorHandler.AddError(ex, 0);
            }

            return objResponse;
        }

        private void SendEmail(int userId, int proposalId, int saleId, string category)
        {
            EmailVM emailVM = new EmailVM();
            List<vw_User_info> userList = new List<vw_User_info>();
            string _tempContent = string.Empty;
            bool sendEmailToAdmin = false;

            using (var dbContext = new ShareTradeEntities())
            {
                Get_EmailContent_Result emailResult = dbContext.Get_EmailContent(userId, proposalId, saleId, category).FirstOrDefault();
                emailVM.EmailContent = emailResult.EmailContent;
                emailVM.EmailSubject = emailResult.EmailSubject;
                emailVM.ToAddress = emailResult.ToAddress;
                _tempContent = emailVM.EmailContent;
            }

            if (category == "NewUser")
            {
                sendEmailToAdmin = true;
            }
            EmailDataHandler email = new EmailDataHandler("test@test.com", emailVM.ToAddress, emailVM.EmailSubject, emailVM.EmailContent, this.cntx, sendEmailToAdmin);
            email.sendEmail();

        }
    }
}
