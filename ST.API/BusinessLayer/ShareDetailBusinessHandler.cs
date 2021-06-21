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
    public class ShareDetailBusinessHandler : IShareDetailBusinessService
    {
        private IShareDetailDataService _ShareDetailDataService = null;

        public ShareDetailBusinessHandler(IShareDetailDataService shareData)
        {
            this._ShareDetailDataService = shareData;
        }

        public Response AddNewShare(ShareDetailsVM ObjShareDetailsVM)
        {
            return _ShareDetailDataService.AddNewShare(ObjShareDetailsVM);
        }

        public Response UpdateShare(ShareDetailsVM ObjShareDetailsVM)
        {
            return _ShareDetailDataService.UpdateShare(ObjShareDetailsVM);
        }

        public Response DeleteShare(ShareDetailsVM ObjShareDetailsVM)
        {
            return _ShareDetailDataService.DeleteShare(ObjShareDetailsVM);
        }

        public List<ShareDetailsVM> GetShareList(ShareDetailsVM ObjShareDetailsVM)
        {
            return _ShareDetailDataService.GetShareList(ObjShareDetailsVM);
        }

    }
}
