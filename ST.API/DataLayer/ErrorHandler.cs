using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Entity;
using Entity.ViewModels;
using Interfaces.Data;
using System.Data.SqlClient;

namespace DataLayer
{
    public class ErrorHandler
    {
        public static string AddError(Exception ex, int loggedUser)
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
                catch (Exception )
                {
                    return "Please contact Admin";
                }
            }
        }

    }
}
