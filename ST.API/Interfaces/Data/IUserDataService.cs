using Entity.ViewModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Interfaces.Data
{
    public interface IUserDataService
    {
        List<UserVM> GetUserList(UserVM ObjUserVM);

        Response AddUser(UserVM ObjUserVM);

        Response UpdateUser(UserVM ObjUserVM);

        Response DeleteUser(UserVM ObjUserVM);

        UserVM ValidateUser(UserVM ObjUserVM);

        Response ForgotPassword(UserVM ObjUserVM);
    }
}
