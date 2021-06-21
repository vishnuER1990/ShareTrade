using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Entity.ViewModels;
using Interfaces.Business;
using Interfaces.Data;

namespace BusinessLayer
{
    public class ShareSaleDetailsBusinessHandler : IShareSaleDetailsBusinessService
    {
        private IShareSaleDetailsDataService _ShareSaleDetailsDataService = null;

        public ShareSaleDetailsBusinessHandler(IShareSaleDetailsDataService saleDetailsDataService)
        {
            this._ShareSaleDetailsDataService = saleDetailsDataService;
        }
        public List<ShareSaleDetailsVM> GetShareSaleDetails(int applicationId)
        {
            return _ShareSaleDetailsDataService.GetShareSaleDetails(applicationId);
        }
    }
}
