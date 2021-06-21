using Entity.ViewModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;


namespace Interfaces.Business
{
    public interface IQIDBusinessService
    {
        List<QIDDetailsVM> GetQIDDetailsList(QIDDetailsVM ObjQIDDetailsVM);

        Response AddQIDDetails(QIDDetailsVM ObjQIDDetailsVM);

        Response UpdateQIDDetails(QIDDetailsVM ObjQIDDetailsVM);

        Response DeleteQIDDetails(QIDDetailsVM ObjQIDDetailsVM);

        QIDDetailsVM ValidateQIDDetails(QIDDetailsVM ObjQIDDetailsVM);
    }
}
