
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Entity;
using Entity.ViewModels;
using Interfaces.Data;

namespace ST.API
{
    public class UserAuthentication
    {
        public string ValidateUser(string username, string password)
        {
            using (var dbContext = new ShareTradeEntities())
            {
                var user = dbContext.vw_User_info.Where(x => x.UserName == username && x.Password == password && x.IsActive == true).FirstOrDefault();

                if(user != null && Convert.ToBoolean(user.IsAdminApproved))
                {
                    return "true";
                } 
                else if(user != null && Convert.ToBoolean(!user.IsAdminApproved))
                {
                    return "AdminApprovalPending";
                }
                else
                {
                    return "false";
                }
            }

        }

        public UserVM GetUserRoleClaim(string username, string password)
        {
            UserVM obUser = new UserVM();

            using (var dbContext = new ShareTradeEntities())
            {
                var objListUser = dbContext.Get_UserList(username, password);

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
                    IsActive = Convert.ToBoolean(x.IsActive)
                }).ToList();

                obUser = tempUserList.FirstOrDefault();
            }
            return obUser;

        }

        public string AddError(Exception ex, int loggedUser)
        {

            using (var dbContext = new ShareTradeEntities())
            {
                try
                {
                    Error_Log error = new Error_Log();
                    error.ErrorDescription = Convert.ToString(ex);
                    error.CreatedBy = loggedUser;

                    dbContext.Error_Log.Add(error);
                    dbContext.SaveChanges();
                    return "Transaction failed. Please contact Admin." + " Error ID : " + error.ErrorId;
                }
                catch (Exception)
                {
                    return "Please contact Admin";
                }
            }
        }
        public void Dispose()
        {
            //Dispose();  
        }
    }
}