using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Interfaces.Business;
using Interfaces.Data;
using Entity;
using Entity.ViewModels;

namespace BusinessLayer
{
    public class SaleBusinessHandler : ISaleBusinessService
    {
        private ISaleDataService _ApplicationDataService = null;

        public SaleBusinessHandler(ISaleDataService applicationData)
        {
            this._ApplicationDataService = applicationData;
        }

        public Response AddNewShareSale(SaleDetailsVM ObjApplicationDetailsVM)
        {
            return _ApplicationDataService.AddNewShareSale(ObjApplicationDetailsVM);
        }

        public Response UpdateShareSale(SaleDetailsVM ObjApplicationDetailsVM)
        {

            return _ApplicationDataService.UpdateShareSale(ObjApplicationDetailsVM);
        }

        public Response DeleteShareSale(SaleDetailsVM ObjApplicationDetailsVM)
        {
            return _ApplicationDataService.DeleteShareSale(ObjApplicationDetailsVM);
        }

        List<SaleDetailsVM> ISaleBusinessService.GetSaleList(SaleDetailsVM ObjApplicationDetailsVM)
        {
            return _ApplicationDataService.GetSaleList(ObjApplicationDetailsVM);
        }
        public void test()
        {
            _ApplicationDataService.test();
        }

        public Response NotifyPurchaseInterest(int userId, string share, string price)
        {
            return _ApplicationDataService.NotifyPurchaseInterest(userId, share, price);
        }
    }
}
