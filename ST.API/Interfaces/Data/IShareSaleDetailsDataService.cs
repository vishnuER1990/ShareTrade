using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Entity.ViewModels;

namespace Interfaces.Data
{
    public interface IShareSaleDetailsDataService
    {
        List<ShareSaleDetailsVM> GetShareSaleDetails(int applicationId);
    }
}
