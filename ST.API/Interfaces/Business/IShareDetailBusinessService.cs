using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Interfaces.Business;
using Interfaces.Data;
using Entity;
using Entity.ViewModels;
namespace Interfaces.Business
{
    public interface IShareDetailBusinessService
    {
        List<ShareDetailsVM> GetShareList(ShareDetailsVM ObjShareDetailsVM);

        Response AddNewShare(ShareDetailsVM ObjShareDetailsVM);

        Response UpdateShare(ShareDetailsVM ObjShareDetailsVM);

        Response DeleteShare(ShareDetailsVM ObjShareDetailsVM);
    }
}
