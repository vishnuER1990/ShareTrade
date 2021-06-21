using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Entity;
using Entity.ViewModels;
using Interfaces.Data;

namespace DataLayer
{
    public class QIDDataHandler : IQIDDataService
    {
        public Response AddQIDDetails(QIDDetailsVM ObjQIDDetailsVM)
        {
            Response objResponse = new Response();
            using (var dbContext = new ShareTradeEntities())
            {
                try
                {
                    //QID_Details objQidDetails = new QID_Details();
                    //objQidDetails.QID = ObjQIDDetailsVM.QID;
                    //objQidDetails.ShareAvailable = ObjQIDDetailsVM.ShareAvailable;
                    //objQidDetails.ShareDescription = ObjQIDDetailsVM.ShareDescription;


                    //dbContext.QID_Details.Add(objQidDetails);
                    //dbContext.SaveChanges();

                    objResponse.status = true;
                    objResponse.exception = string.Empty;
                }
                catch (Exception ex)
                {
                    objResponse.status = true;
                    objResponse.exception = ErrorHandler.AddError(ex, 0);
                }
            }
            return objResponse;
        }

        public Response DeleteQIDDetails(QIDDetailsVM ObjQIDDetailsVM)
        {
            throw new NotImplementedException();
        }

        public List<QIDDetailsVM> GetQIDDetailsList(QIDDetailsVM ObjQIDDetailsVM)
        {
            using (var dbContext = new ShareTradeEntities())
            {
                List<QIDDetailsVM> objList = new List<QIDDetailsVM>();
                try
                {
                    List<QID_Details> objQIDList = dbContext.QID_Details.ToList();

                    var tempList = objQIDList.Select(x => new QIDDetailsVM
                    {
                        //QID = x.QID,
                        ShareAvailable = x.ShareAvailable,
                        ShareDescription = x.ShareDescription
                    }).ToList();

                    if (ObjQIDDetailsVM.QID != 0)
                    {
                        objList = tempList.Where(x => x.QID == ObjQIDDetailsVM.QID).ToList();
                    }
                    else
                    {
                        objList = tempList;
                    }

                }
                catch (Exception ex)
                {
                    objList = null;
                    ErrorHandler.AddError(ex, 0);
                }
                return objList;
            }
        }

        public Response UpdateQIDDetails(QIDDetailsVM ObjQIDDetailsVM)
        {
            throw new NotImplementedException();
        }

        public QIDDetailsVM ValidateQIDDetails(QIDDetailsVM ObjQIDDetailsVM)
        {
            using (var dbContext = new ShareTradeEntities())
            {
                QIDDetailsVM objQIDDetailsVM = new QIDDetailsVM();

                try
                {
                    List<QID_Details> objQIDList = dbContext.QID_Details.ToList();

                    var tempList = objQIDList.Select(x => new QIDDetailsVM
                    {
                        //QID = x.QID,
                        ShareAvailable = x.ShareAvailable,
                        ShareDescription = x.ShareDescription
                    }).ToList();

                    objQIDDetailsVM = tempList.Where(x => x.QID == ObjQIDDetailsVM.QID).FirstOrDefault();

                }
                catch (Exception ex)
                {
                    objQIDDetailsVM = null;
                    ErrorHandler.AddError(ex, 0);
                }
                return objQIDDetailsVM;
            }
        }
    }
}
