using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using Interfaces.Business;
using Interfaces.Data;
using Entity;
using Entity.ViewModels;

namespace BusinessLayer
{
    public class ReportBusinessHandler : IReportBusinessService
    {
        private IReportDataService _ReportDataService = null;

        public ReportBusinessHandler(IReportDataService ReportDataService)
        {
            this._ReportDataService = ReportDataService;
        }

        public List<ProxyVM> GetProxy(DateTime fromDate, DateTime toDate)
        {
            return _ReportDataService.GetProxy(fromDate, toDate);
        }

        public List<PurchaseReportVM> GetPurchaseList(DateTime fromDate, DateTime toDate)
        {
            return _ReportDataService.GetPurchaseList(fromDate, toDate);
        }

        public List<UserReportVM> GetRegistredUser(DateTime fromDate, DateTime toDate)
        {
            return _ReportDataService.GetRegistredUser(fromDate, toDate);
        }

        public List<SaleReportVM> GetSaleList(DateTime fromDate, DateTime toDate)
        {
            return _ReportDataService.GetSaleList(fromDate, toDate);
        }
    }
}
