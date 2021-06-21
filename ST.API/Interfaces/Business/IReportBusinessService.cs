using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Entity.ViewModels;

namespace Interfaces.Business
{
    public interface IReportBusinessService
    {
        List<UserReportVM> GetRegistredUser(DateTime fromDate, DateTime toDate);

        List<SaleReportVM> GetSaleList(DateTime fromDate, DateTime toDate);

        List<PurchaseReportVM> GetPurchaseList(DateTime fromDate, DateTime toDate);

        List<ProxyVM> GetProxy(DateTime fromDate, DateTime toDate);
    }
}
