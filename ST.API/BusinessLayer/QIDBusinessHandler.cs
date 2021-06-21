using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using Interfaces.Business;
using Interfaces.Data;
using Entity;
using Entity.ViewModels;

namespace BusinessLayer
{
    public class QIDBusinessHandler : IQIDBusinessService
    {
        private IQIDDataService _QIDDataService = null;
        public QIDBusinessHandler(IQIDDataService QIDDataService)
        {
            this._QIDDataService = QIDDataService;
        }
        public Response AddQIDDetails(QIDDetailsVM ObjQIDDetailsVM)
        {
            return _QIDDataService.AddQIDDetails(ObjQIDDetailsVM);
        }

        public Response DeleteQIDDetails(QIDDetailsVM ObjQIDDetailsVM)
        {
            throw new NotImplementedException();
        }

        public List<QIDDetailsVM> GetQIDDetailsList(QIDDetailsVM ObjQIDDetailsVM)
        {
            return _QIDDataService.GetQIDDetailsList(ObjQIDDetailsVM);
        }

        public Response UpdateQIDDetails(QIDDetailsVM ObjQIDDetailsVM)
        {
            throw new NotImplementedException();
        }

        public QIDDetailsVM ValidateQIDDetails(QIDDetailsVM ObjQIDDetailsVM)
        {
            return _QIDDataService.ValidateQIDDetails(ObjQIDDetailsVM);
        }
    }
}
