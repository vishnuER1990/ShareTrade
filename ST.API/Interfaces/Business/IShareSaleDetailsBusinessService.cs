using Entity.ViewModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Interfaces.Business
{
    public interface IShareSaleDetailsBusinessService
    {
        List<ShareSaleDetailsVM> GetShareSaleDetails(int applicationId);
    }
}
