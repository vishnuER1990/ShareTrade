using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Entity.ViewModels;

namespace Interfaces.Data
{
    public interface IQIDDataService
    {
        List<QIDDetailsVM> GetQIDDetailsList(QIDDetailsVM ObjQIDDetailsVM);

        Response AddQIDDetails(QIDDetailsVM ObjQIDDetailsVM);

        Response UpdateQIDDetails(QIDDetailsVM ObjQIDDetailsVM);

        Response DeleteQIDDetails(QIDDetailsVM ObjQIDDetailsVM);

        QIDDetailsVM ValidateQIDDetails(QIDDetailsVM ObjQIDDetailsVM);
    }
}
