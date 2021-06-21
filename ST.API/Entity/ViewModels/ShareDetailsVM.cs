using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entity.ViewModels
{
    public class ShareDetailsVM
    {
        public int ShareDetailsId { get; set; }
        public int UserId { get; set; }
        public string QID { get; set; }
        public string UniqueID { get; set; }
        public long ShareholderID { get; set; }
        public long AvailableShares { get; set; }
        public string Description { get; set; }
        public DateTime CreatedDt { get; set; }
        public int CreatedBy { get; set; }
        public DateTime UpdatedDt { get; set; }
        public int UpdatedBy { get; set; }
        public bool IsActive { get; set; }
        public string CreatedBy_String { get; set; }
        public string UpdatedBy_String { get; set; }
        public string AssignedUser { get; set; }
    }
}
