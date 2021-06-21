﻿//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace Entity
{
    using System;
    using System.Data.Entity;
    using System.Data.Entity.Infrastructure;
    using System.Data.Entity.Core.Objects;
    using System.Linq;
    
    public partial class ShareTradeEntities : DbContext
    {
        public ShareTradeEntities()
            : base("name=ShareTradeEntities")
        {
        }
    
        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            throw new UnintentionalCodeFirstException();
        }
    
        public virtual DbSet<Email_Template> Email_Template { get; set; }
        public virtual DbSet<Error_Log> Error_Log { get; set; }
        public virtual DbSet<Proposal_Details> Proposal_Details { get; set; }
        public virtual DbSet<Proposal_Status> Proposal_Status { get; set; }
        public virtual DbSet<QID_Details> QID_Details { get; set; }
        public virtual DbSet<Sale_Status> Sale_Status { get; set; }
        public virtual DbSet<vw_User_info> vw_User_info { get; set; }
        public virtual DbSet<Share_Details> Share_Details { get; set; }
        public virtual DbSet<Certificates> Certificates { get; set; }
        public virtual DbSet<Sale_Details> Sale_Details { get; set; }
        public virtual DbSet<Purchase_Interest_Notification> Purchase_Interest_Notification { get; set; }
        public virtual DbSet<User> User { get; set; }
        public virtual DbSet<User_Info> User_Info { get; set; }
    
        public virtual int Approve_Bid(Nullable<int> bidID, Nullable<int> saleID)
        {
            var bidIDParameter = bidID.HasValue ?
                new ObjectParameter("BidID", bidID) :
                new ObjectParameter("BidID", typeof(int));
    
            var saleIDParameter = saleID.HasValue ?
                new ObjectParameter("SaleID", saleID) :
                new ObjectParameter("SaleID", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("Approve_Bid", bidIDParameter, saleIDParameter);
        }
    
        public virtual ObjectResult<Get_EmailContent_Result> Get_EmailContent(Nullable<int> userId, Nullable<int> proposalId, Nullable<int> saleId, string category)
        {
            var userIdParameter = userId.HasValue ?
                new ObjectParameter("UserId", userId) :
                new ObjectParameter("UserId", typeof(int));
    
            var proposalIdParameter = proposalId.HasValue ?
                new ObjectParameter("ProposalId", proposalId) :
                new ObjectParameter("ProposalId", typeof(int));
    
            var saleIdParameter = saleId.HasValue ?
                new ObjectParameter("SaleId", saleId) :
                new ObjectParameter("SaleId", typeof(int));
    
            var categoryParameter = category != null ?
                new ObjectParameter("Category", category) :
                new ObjectParameter("Category", typeof(string));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<Get_EmailContent_Result>("Get_EmailContent", userIdParameter, proposalIdParameter, saleIdParameter, categoryParameter);
        }
    
        public virtual ObjectResult<Get_SaleDetails_v1_Result> Get_SaleDetails_v1(Nullable<int> sale_Id, Nullable<int> createdBy)
        {
            var sale_IdParameter = sale_Id.HasValue ?
                new ObjectParameter("Sale_Id", sale_Id) :
                new ObjectParameter("Sale_Id", typeof(int));
    
            var createdByParameter = createdBy.HasValue ?
                new ObjectParameter("CreatedBy", createdBy) :
                new ObjectParameter("CreatedBy", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<Get_SaleDetails_v1_Result>("Get_SaleDetails_v1", sale_IdParameter, createdByParameter);
        }
    
        public virtual ObjectResult<Get_BidDetails_Result> Get_BidDetails(Nullable<int> bid_Id, Nullable<int> createdBy)
        {
            var bid_IdParameter = bid_Id.HasValue ?
                new ObjectParameter("Bid_Id", bid_Id) :
                new ObjectParameter("Bid_Id", typeof(int));
    
            var createdByParameter = createdBy.HasValue ?
                new ObjectParameter("CreatedBy", createdBy) :
                new ObjectParameter("CreatedBy", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<Get_BidDetails_Result>("Get_BidDetails", bid_IdParameter, createdByParameter);
        }
    
        public virtual ObjectResult<Get_Summary_Result> Get_Summary(Nullable<int> userId)
        {
            var userIdParameter = userId.HasValue ?
                new ObjectParameter("userId", userId) :
                new ObjectParameter("userId", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<Get_Summary_Result>("Get_Summary", userIdParameter);
        }
    
        public virtual ObjectResult<Get_Summary_BidSubmitted_Result> Get_Summary_BidSubmitted(Nullable<int> userID)
        {
            var userIDParameter = userID.HasValue ?
                new ObjectParameter("userID", userID) :
                new ObjectParameter("userID", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<Get_Summary_BidSubmitted_Result>("Get_Summary_BidSubmitted", userIDParameter);
        }
    
        public virtual ObjectResult<Get_ShareDetails_Result> Get_ShareDetails(Nullable<int> shareId, Nullable<int> createdBy)
        {
            var shareIdParameter = shareId.HasValue ?
                new ObjectParameter("ShareId", shareId) :
                new ObjectParameter("ShareId", typeof(int));
    
            var createdByParameter = createdBy.HasValue ?
                new ObjectParameter("CreatedBy", createdBy) :
                new ObjectParameter("CreatedBy", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<Get_ShareDetails_Result>("Get_ShareDetails", shareIdParameter, createdByParameter);
        }
    
        public virtual ObjectResult<Get_Certificates_Result> Get_Certificates(Nullable<int> userID)
        {
            var userIDParameter = userID.HasValue ?
                new ObjectParameter("UserID", userID) :
                new ObjectParameter("UserID", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<Get_Certificates_Result>("Get_Certificates", userIDParameter);
        }
    
        public virtual ObjectResult<Get_Purchase_Interest_Notification_Result> Get_Purchase_Interest_Notification(Nullable<int> userId)
        {
            var userIdParameter = userId.HasValue ?
                new ObjectParameter("UserId", userId) :
                new ObjectParameter("UserId", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<Get_Purchase_Interest_Notification_Result>("Get_Purchase_Interest_Notification", userIdParameter);
        }
    
        public virtual ObjectResult<Get_SaleBidDetails_Result> Get_SaleBidDetails(Nullable<int> saleId)
        {
            var saleIdParameter = saleId.HasValue ?
                new ObjectParameter("SaleId", saleId) :
                new ObjectParameter("SaleId", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<Get_SaleBidDetails_Result>("Get_SaleBidDetails", saleIdParameter);
        }
    
        public virtual ObjectResult<Get_SaleDetails_Result> Get_SaleDetails(Nullable<int> sale_Id, Nullable<int> createdBy)
        {
            var sale_IdParameter = sale_Id.HasValue ?
                new ObjectParameter("Sale_Id", sale_Id) :
                new ObjectParameter("Sale_Id", typeof(int));
    
            var createdByParameter = createdBy.HasValue ?
                new ObjectParameter("CreatedBy", createdBy) :
                new ObjectParameter("CreatedBy", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<Get_SaleDetails_Result>("Get_SaleDetails", sale_IdParameter, createdByParameter);
        }
    
        public virtual ObjectResult<Get_ShareSaleDetails_Result> Get_ShareSaleDetails(Nullable<int> application_Id)
        {
            var application_IdParameter = application_Id.HasValue ?
                new ObjectParameter("Application_Id", application_Id) :
                new ObjectParameter("Application_Id", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<Get_ShareSaleDetails_Result>("Get_ShareSaleDetails", application_IdParameter);
        }
    
        public virtual ObjectResult<Get_Summary_BidReceived_Result> Get_Summary_BidReceived(Nullable<int> userID)
        {
            var userIDParameter = userID.HasValue ?
                new ObjectParameter("userID", userID) :
                new ObjectParameter("userID", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<Get_Summary_BidReceived_Result>("Get_Summary_BidReceived", userIDParameter);
        }
    
        public virtual ObjectResult<Get_UserList_Result> Get_UserList(string userName, string password)
        {
            var userNameParameter = userName != null ?
                new ObjectParameter("userName", userName) :
                new ObjectParameter("userName", typeof(string));
    
            var passwordParameter = password != null ?
                new ObjectParameter("Password", password) :
                new ObjectParameter("Password", typeof(string));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<Get_UserList_Result>("Get_UserList", userNameParameter, passwordParameter);
        }
    
        public virtual ObjectResult<Get_BidDetails_Report_Result> Get_BidDetails_Report()
        {
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<Get_BidDetails_Report_Result>("Get_BidDetails_Report");
        }
    
        public virtual ObjectResult<Get_SaleDetails_Report_Result> Get_SaleDetails_Report()
        {
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<Get_SaleDetails_Report_Result>("Get_SaleDetails_Report");
        }
    
        public virtual ObjectResult<Get_Quorum_Result> Get_Quorum()
        {
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<Get_Quorum_Result>("Get_Quorum");
        }
    }
}