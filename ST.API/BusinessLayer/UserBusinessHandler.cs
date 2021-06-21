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
    public class UserBusinessHandler : IUserBusinessService
    {
        private IUserDataService _UserDataService = null;

        public UserBusinessHandler(IUserDataService userData)
        {
            this._UserDataService = userData;
        }

        public Response AddUser(UserVM ObjUserVM)
        {
            return _UserDataService.AddUser(ObjUserVM);
        }

        public Response DeleteUser(UserVM ObjUserVM)
        {
            return _UserDataService.DeleteUser(ObjUserVM);
        }

        public Response ForgotPassword(UserVM ObjUserVM)
        {
            return _UserDataService.ForgotPassword(ObjUserVM);
        }

        public List<UserVM> GetUserList(UserVM ObjUserVM)
        {
            return _UserDataService.GetUserList(ObjUserVM);
        }

        public Response UpdateUser(UserVM ObjUserVM)
        {
            return _UserDataService.UpdateUser(ObjUserVM);
        }

        public UserVM ValidateUser(UserVM ObjUserVM)
        {
            UserVM objUser = new UserVM();

            if (string.IsNullOrEmpty(ObjUserVM.UserName) || string.IsNullOrEmpty(ObjUserVM.Password))
            {
                objUser = null;
                return objUser;
            }
            else
            {
                return _UserDataService.ValidateUser(ObjUserVM);
            }
        }
    }
}
