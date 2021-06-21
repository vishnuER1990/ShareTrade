using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Entity;
using Entity.ViewModels;
using Interfaces.Data;
using System.Data.SqlClient;
using System.Web;

namespace DataLayer
{
    public class ProposalDataHandler : IProposalDataService
    {
        private HttpContext cntx { get; set; }
        public ProposalDataHandler()
        {
            this.cntx = HttpContext.Current;
        }
        public Response AddProposal(ProposalDetailsVM ObjProposalDetailsVM)
        {
            Response objResponse = new Response();

            using (var dbContext = new ShareTradeEntities())
            {
                try
                {

                    Proposal_Details objProposal = new Proposal_Details();
                    objProposal.SaleId = ObjProposalDetailsVM.SaleId;
                    objProposal.BidPrice = ObjProposalDetailsVM.BidPrice;
                    objProposal.BidUnit = ObjProposalDetailsVM.BidUnit;
                    objProposal.CreatedDt = DateTime.Now;
                    objProposal.CreatedBy = ObjProposalDetailsVM.CreatedBy;
                    objProposal.Status = ObjProposalDetailsVM.Status;
                    objProposal.StatusComments = ObjProposalDetailsVM.StatusComments;
                    objProposal.IsActive = true;

                    dbContext.Proposal_Details.Add(objProposal);
                    dbContext.SaveChanges();

                    objResponse.status = true;
                    objResponse.exception = string.Empty;

                    SendEmail(objProposal.ProposalId, ObjProposalDetailsVM.SaleId, "BidSubmitted");
                }
                catch (Exception ex)
                {
                    objResponse.status = false;                    
                    objResponse.exception = ErrorHandler.AddError(ex, ObjProposalDetailsVM.CreatedBy);
                }

            }

            return objResponse;
        }

        public Response UpdateProposal(ProposalDetailsVM ObjProposalDetailsVM)
        {
            Response objResponse = new Response();
            using (var dbContext = new ShareTradeEntities())
            {
                try
                {
                    Proposal_Details objProposal = new Proposal_Details();
                    Sale_Details objSale = new Sale_Details();
                    if (ObjProposalDetailsVM.Status == 4)//Approve
                    {
                        dbContext.Approve_Bid(ObjProposalDetailsVM.ProposalId, ObjProposalDetailsVM.SaleId);

                        objResponse.status = true;
                        objResponse.exception = string.Empty;

                        SendEmail(ObjProposalDetailsVM.ProposalId, ObjProposalDetailsVM.SaleId, "AdminApprovedBuyer");
                        SendEmail(ObjProposalDetailsVM.ProposalId, ObjProposalDetailsVM.SaleId, "AdminApprovedSeller");

                        return objResponse;

                    }
                    if (ObjProposalDetailsVM.Status == 5)//Reject
                    {
                        objProposal = dbContext.Proposal_Details.First(x => x.ProposalId == ObjProposalDetailsVM.ProposalId);
                        objProposal.Status = ObjProposalDetailsVM.Status;
                        objProposal.StatusComments = "Bid has been rejected by Admin";
                        objProposal.UpdatedDt = DateTime.Now;
                        objProposal.UpdatedBy = ObjProposalDetailsVM.UpdatedBy;
                        dbContext.SaveChanges();

                        objSale = dbContext.Sale_Details.First(x => x.SaleId == ObjProposalDetailsVM.SaleId);
                        objSale.Status = ObjProposalDetailsVM.Status;
                        objProposal.UpdatedDt = DateTime.Now;
                        objProposal.UpdatedBy = ObjProposalDetailsVM.UpdatedBy;
                        dbContext.SaveChanges();


                        objResponse.status = true;
                        objResponse.exception = string.Empty;

                        SendEmail(ObjProposalDetailsVM.ProposalId, ObjProposalDetailsVM.SaleId, "AdminRejectedSeller");
                        SendEmail(ObjProposalDetailsVM.ProposalId, ObjProposalDetailsVM.SaleId, "AdminRejectedBuyer");

                        return objResponse;


                    }
                    objProposal = dbContext.Proposal_Details.First(x => x.ProposalId == ObjProposalDetailsVM.ProposalId);

                    objProposal.BidPrice = ObjProposalDetailsVM.BidPrice;
                    objProposal.BidUnit = ObjProposalDetailsVM.BidUnit;
                    objProposal.Status = ObjProposalDetailsVM.Status;
                    objProposal.StatusComments = ObjProposalDetailsVM.StatusComments;
                    objProposal.UpdatedDt = DateTime.Now;
                    objProposal.UpdatedBy = ObjProposalDetailsVM.UpdatedBy; 

                    dbContext.SaveChanges();

                    objResponse.status = true;
                    objResponse.exception = string.Empty;

                    if (ObjProposalDetailsVM.Status == 2)
                    {
                        SendEmail(ObjProposalDetailsVM.ProposalId, ObjProposalDetailsVM.SaleId, "BidApproved");
                        SendEmail(ObjProposalDetailsVM.ProposalId, ObjProposalDetailsVM.SaleId, "BidApprovedToAdmin");
                        SendEmail(ObjProposalDetailsVM.ProposalId, ObjProposalDetailsVM.SaleId, "BidApprovedToSeller");
                    }
                    else
                        SendEmail(ObjProposalDetailsVM.ProposalId, ObjProposalDetailsVM.SaleId, "BidRejected");

                }
                catch (Exception ex)
                {
                    objResponse.status = false;
                    objResponse.exception = ErrorHandler.AddError(ex, ObjProposalDetailsVM.UpdatedBy);
                }
            }
            return objResponse;
        }

        public Response DeleteProposal(ProposalDetailsVM ObjProposalDetailsVM)
        {
            Response objResponse = new Response();
            using (var dbContext = new ShareTradeEntities())
            {
                try
                {
                    Proposal_Details objProposal = new Proposal_Details();
                    objProposal = dbContext.Proposal_Details.First(x => x.ProposalId == ObjProposalDetailsVM.ProposalId);

                    objProposal.UpdatedDt = DateTime.Now;
                    objProposal.UpdatedBy = ObjProposalDetailsVM.UpdatedBy;
                    objProposal.IsActive = false;

                    dbContext.SaveChanges();

                    objResponse.status = true;
                    objResponse.exception = string.Empty;
                }
                catch (Exception ex)
                {
                    objResponse.status = false;
                    objResponse.exception = ErrorHandler.AddError(ex, ObjProposalDetailsVM.UpdatedBy);
                }
            }
            return objResponse;
        }

        public List<ProposalDetailsVM> GetProposalList(ProposalDetailsVM ObjProposalDetailsVM)
        {
            List<ProposalDetailsVM> objListProposal = new List<ProposalDetailsVM>();

            using (var dbContext = new ShareTradeEntities())
            {
                try
                {
                    if (ObjProposalDetailsVM.SaleId !=0)
                    {

                        var proposalList = dbContext.Get_SaleBidDetails(ObjProposalDetailsVM.SaleId);

                        objListProposal = proposalList.Select(x => new ProposalDetailsVM
                        {
                            ProposalId = x.ProposalId,
                            SaleId = Convert.ToInt32(x.SaleId),
                            BidPrice = Convert.ToDecimal(x.BidPrice),
                            BidUnit = Convert.ToInt32(x.BidUnit),
                            NumberOfShares = Convert.ToInt32(x.NumberOfShares),
                            UnitPrice = Convert.ToInt32(x.UnitPrice),
                            CreatedDt = Convert.ToDateTime(x.CreatedDt),
                            CreatedBy_String = x.CreatedBy_string,
                            UpdatedDt = Convert.ToDateTime(x.UpdatedDt),
                            UpdatedBy_String = x.UpdatedBy_string,
                            Status = Convert.ToInt32(x.Status),
                            StatusComments = x.StatusComments,
                            StatusDescription = x.StatusDescription,
                            ShareDescription = x.ShareDescription,
                            ValidTo = Convert.ToDateTime(x.ValidTo)
                            //ShareholderContactNumber = x.ShareholderContactNumber
                        }).ToList();
                    }
                    else
                    {
                        var proposalList_1 = dbContext.Get_BidDetails(ObjProposalDetailsVM.ProposalId, ObjProposalDetailsVM.CreatedBy);

                        objListProposal = proposalList_1.Select(x => new ProposalDetailsVM
                        {
                            ProposalId = x.ProposalId,
                            SaleId = Convert.ToInt32(x.SaleId),
                            BidPrice = Convert.ToDecimal(x.BidPrice),
                            BidUnit = Convert.ToInt32(x.BidUnit),
                            CreatedDt = Convert.ToDateTime(x.BidCreatedDt),
                            CreatedBy_String = x.BidCreatedBy,
                            UpdatedDt = Convert.ToDateTime(x.BidUpdatedDt),
                            UpdatedBy_String = x.BidUpdatedBy,
                            Status = Convert.ToInt32(x.Status),
                            StatusComments = x.StatusComments,
                            StatusDescription = x.StatusDescription,
                            ShareDescription = x.ShareDescription,
                            ShareholderContactNumber = x.ShareholderContactNumber,
                            Seller = x.Seller,
                            Buyer = x.Buyer,
                            SellerAvailableShares = Convert.ToInt32(x.SellerAvailableShares)
                        }).ToList();
                    }
                }
                catch (Exception ex)
                {
                    ErrorHandler.AddError(ex, 0);
                }
                return objListProposal;
            }
        }

        private void SendEmail(int proposalId, int saleId, string category)
        {
            EmailVM emailVM = new EmailVM();
            using (var dbContext = new ShareTradeEntities())
            {
                Get_EmailContent_Result emailResult = dbContext.Get_EmailContent(0, proposalId, saleId, category).FirstOrDefault();
                emailVM.EmailContent = emailResult.EmailContent;
                emailVM.EmailSubject = emailResult.EmailSubject;
                emailVM.ToAddress = emailResult.ToAddress;
            }
            EmailDataHandler email = new EmailDataHandler("test@test.com", emailVM.ToAddress, emailVM.EmailSubject, emailVM.EmailContent, this.cntx, false);
            email.sendEmail();
        }
       
    }
}
