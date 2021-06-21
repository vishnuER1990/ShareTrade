using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Entity.ViewModels;

namespace Interfaces.Data
{
    public interface ISaleDataService
    {
        void test();

        List<SaleDetailsVM> GetSaleList(SaleDetailsVM ObjApplicationDetailsVM);

        Response AddNewShareSale(SaleDetailsVM ObjApplicationDetailsVM);

        Response UpdateShareSale(SaleDetailsVM ObjApplicationDetailsVM);

        Response DeleteShareSale(SaleDetailsVM ObjApplicationDetailsVM);

        Response NotifyPurchaseInterest(int userId, string share, string price);
    }
}
