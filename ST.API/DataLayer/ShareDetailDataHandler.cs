using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity.Core.Objects;
using System.Data.SqlClient;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Web;
using Interfaces.Data;
using Entity;
using Entity.ViewModels;

namespace DataLayer
{
    public class ShareDetailDataHandler : IShareDetailDataService
    {
        public Response AddNewShare(ShareDetailsVM ObjShareDetailsVM)
        {
            Response objResponse = new Response();
            using (var dbContext = new ShareTradeEntities())
            {
                try
                {

                    if (dbContext.Share_Details.ToList().Where(x => x.QID == ObjShareDetailsVM.QID).Count() > 0)
                    {
                        Share_Details objShareDetailsUpdate = new Share_Details();
                        objShareDetailsUpdate = dbContext.Share_Details.FirstOrDefault(x => x.QID == ObjShareDetailsVM.QID);
                        objShareDetailsUpdate.AvailableShares = ObjShareDetailsVM.AvailableShares + objShareDetailsUpdate.AvailableShares;
                        objShareDetailsUpdate.ShareholderID = ObjShareDetailsVM.ShareholderID;
                        objShareDetailsUpdate.UpdatedDt = DateTime.Now;
                        objShareDetailsUpdate.UpdatedBy = ObjShareDetailsVM.CreatedBy;

                        dbContext.SaveChanges();

                        if (dbContext.User_Info.ToList().Where(x => x.QID_Number == ObjShareDetailsVM.QID).Count() > 0)
                        {
                            User_Info objUser = new User_Info();
                            objUser = dbContext.User_Info.ToList().Where(x => x.QID_Number == ObjShareDetailsVM.QID).FirstOrDefault();
                            objUser.Shareholder_ID = Convert.ToString(ObjShareDetailsVM.ShareholderID);
                            dbContext.SaveChanges();
                        }
                    }
                    else
                    {
                        Share_Details objShareDetails = new Share_Details();
                        objShareDetails.AvailableShares = ObjShareDetailsVM.AvailableShares;
                        objShareDetails.ShareholderID = ObjShareDetailsVM.ShareholderID;
                        objShareDetails.QID = ObjShareDetailsVM.QID;
                        //objShareDetails.UniqueID = Guid.NewGuid().ToString("N");
                        objShareDetails.CreatedDt = DateTime.Now;
                        objShareDetails.CreatedBy = ObjShareDetailsVM.CreatedBy;
                        objShareDetails.IsActive = true;

                        dbContext.Share_Details.Add(objShareDetails);
                        dbContext.SaveChanges();
                    }

                    objResponse.status = true;
                    objResponse.exception = string.Empty;
                }
                catch (Exception ex)
                {
                    objResponse.status = false;
                    objResponse.exception = ErrorHandler.AddError(ex, ObjShareDetailsVM.CreatedBy);
                }
            }
            return objResponse;
        }

        public Response UpdateShare(ShareDetailsVM ObjShareDetailsVM)
        {
            Response objResponse = new Response();
            using (var dbContext = new ShareTradeEntities())
            {
                try
                {
                    Share_Details objShareDetails = new Share_Details();
                    objShareDetails = dbContext.Share_Details.First(x => x.ShareDetailsId == ObjShareDetailsVM.ShareDetailsId);

                    objShareDetails.AvailableShares = ObjShareDetailsVM.AvailableShares;
                    objShareDetails.ShareholderID = ObjShareDetailsVM.ShareholderID;
                    objShareDetails.UpdatedDt = DateTime.Now;
                    objShareDetails.UpdatedBy = ObjShareDetailsVM.UpdatedBy;

                    dbContext.SaveChanges();

                    if (dbContext.User_Info.ToList().Where(x => x.QID_Number == ObjShareDetailsVM.QID).Count() > 0)
                    {
                        User_Info objUser = new User_Info();
                        objUser = dbContext.User_Info.ToList().Where(x => x.QID_Number == ObjShareDetailsVM.QID).FirstOrDefault();
                        objUser.Shareholder_ID = Convert.ToString(ObjShareDetailsVM.ShareholderID);

                        dbContext.SaveChanges();
                    }


                    objResponse.status = true;
                    objResponse.exception = string.Empty;
                }
                catch (Exception ex)
                {
                    objResponse.status = false;
                    objResponse.exception = ErrorHandler.AddError(ex, ObjShareDetailsVM.UpdatedBy);
                }
            }
            return objResponse;
        }

        public Response DeleteShare(ShareDetailsVM ObjShareDetailsVM)
        {
            Response objResponse = new Response();
            using (var dbContext = new ShareTradeEntities())
            {
                try
                {
                    Share_Details objShareDetails = new Share_Details();
                    objShareDetails = dbContext.Share_Details.First(x => x.ShareDetailsId == ObjShareDetailsVM.ShareDetailsId);

                    objShareDetails.UpdatedDt = DateTime.Now;
                    objShareDetails.UpdatedBy = ObjShareDetailsVM.UpdatedBy;
                    objShareDetails.IsActive = false;

                    dbContext.SaveChanges();

                    objResponse.status = true;
                    objResponse.exception = string.Empty;
                }
                catch (Exception ex)
                {
                    objResponse.status = false;
                    objResponse.exception = ErrorHandler.AddError(ex, ObjShareDetailsVM.UpdatedBy);
                }
            }
            return objResponse;
        }

        public List<ShareDetailsVM> GetShareList(ShareDetailsVM ObjShareDetailsVM)
        {
            List<ShareDetailsVM> objListShare = new List<ShareDetailsVM>();

            using (var dbContext = new ShareTradeEntities())
            {
                try
                {
                    var shareList = dbContext.Get_ShareDetails(ObjShareDetailsVM.ShareDetailsId, ObjShareDetailsVM.CreatedBy);

                    objListShare = shareList.Select(x => new ShareDetailsVM
                    {
                        ShareDetailsId = x.ShareDetailsId,
                        AvailableShares = Convert.ToInt32(x.AvailableShares),
                        ShareholderID = x.ShareholderID !=null ? (long) x.ShareholderID: 0,
                        CreatedDt = Convert.ToDateTime(x.CreatedDt),
                        UpdatedDt = Convert.ToDateTime(x.UpdatedDt),
                        CreatedBy_String = x.ShareCreatedBy,
                        UpdatedBy_String = x.ShareUpdatedBy,
                        AssignedUser = x.AssignedUser,
                        QID = x.QID,
                        UniqueID = x.UniqueID
                    }).ToList();
                }
                catch (Exception ex)
                {
                    objListShare = null;
                    ErrorHandler.AddError(ex, 0);
                }
                return objListShare;
            }
        }
    }
}
