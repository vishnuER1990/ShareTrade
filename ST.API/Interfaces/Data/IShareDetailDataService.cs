using Entity.ViewModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Interfaces.Data
{
    public interface IShareDetailDataService
    {
        List<ShareDetailsVM> GetShareList(ShareDetailsVM ObjShareDetailsVM);

        Response AddNewShare(ShareDetailsVM ObjShareDetailsVM);

        Response UpdateShare(ShareDetailsVM ObjShareDetailsVM);

        Response DeleteShare(ShareDetailsVM ObjShareDetailsVM);
    }
}
