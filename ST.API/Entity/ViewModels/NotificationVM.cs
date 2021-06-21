using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entity.ViewModels
{
    public class NotificationVM
    {
        public int NotificationId { get; set; }
        public string NotificationText { get; set; }
        public string CreatedBy { get; set; }
        public DateTime Createdate { get; set; }
    }
}
