using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Web.Http.Cors;
using Interfaces.Business;
using Entity.ViewModels;
using System.Security.Claims;
using Microsoft.Owin;
using System.Data;
using System.Data.OleDb;
using System.Web;

namespace ST.API.Controllers
{
    [EnableCors(origins: "*", headers: "*", methods: "*")]
    [Authorize(Roles = "NormalUser, Admin")]
    public class ShareHolderDataController : ApiController
    {
        // GET: api/ShareHolderData
        public HttpResponseMessage Get()
        {
            HttpResponseMessage response = new HttpResponseMessage();
            DataTable rs = new DataTable();

            using (var odConnection = new OleDbConnection(@"Provider=Microsoft.ACE.OLEDB.12.0;Data Source=C:\Vishnu\PersonalTech\Simcorn\ShareTrade\SMS.xlsx;Extended Properties='Excel 12.0;HDR=YES;IMEX=1;';"))
            {
                odConnection.Open();

                using (OleDbCommand cmd = new OleDbCommand())
                {
                    cmd.Connection = odConnection;
                    cmd.CommandType = CommandType.Text;
                    cmd.CommandText = "SELECT * FROM [Sheet1$]";
                    using (OleDbDataAdapter oleda = new OleDbDataAdapter(cmd))
                    {
                        oleda.Fill(rs);
                    }
                }
                odConnection.Close();
            }
            response = Request.CreateResponse(HttpStatusCode.OK, rs);
            return response;
        }

        // GET: api/ShareHolderData/5
        public HttpResponseMessage Get(int id)
        {

            if (id == 1)
            {
                return GetQuorumReport();
            }
            else
            {

                HttpResponseMessage response = new HttpResponseMessage();
                DataTable rs = new DataTable();
                string path = HttpContext.Current.Server.MapPath("~/ShareHolderData/SMS.xlsx");
                using (var odConnection = new OleDbConnection(@"Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + path + ";Extended Properties='Excel 12.0;HDR=YES;IMEX=1;';"))
                {
                    odConnection.Open();

                    using (OleDbCommand cmd = new OleDbCommand())
                    {
                        cmd.Connection = odConnection;
                        cmd.CommandType = CommandType.Text;
                        cmd.CommandText = "SELECT * FROM [Sheet1$]";
                        using (OleDbDataAdapter oleda = new OleDbDataAdapter(cmd))
                        {
                            oleda.Fill(rs);
                        }
                    }
                    odConnection.Close();
                }
                response = Request.CreateResponse(HttpStatusCode.OK, rs);
                return response;
            }
        }

        // POST: api/ShareHolderData
        public void Post([FromBody]string value)
        {
        }

        // PUT: api/ShareHolderData/5
        public void Put(int id, [FromBody]string value)
        {
        }

        // DELETE: api/ShareHolderData/5
        public void Delete(int id)
        {
        }

        private HttpResponseMessage GetQuorumReport()
        {
            HttpResponseMessage response = new HttpResponseMessage();
            DataTable rs = new DataTable();
            DataTable dt = new DataTable();
            string path = HttpContext.Current.Server.MapPath("~/ShareHolderData/SMS.xlsx");
            using (var odConnection = new OleDbConnection(@"Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + path + ";Extended Properties='Excel 12.0;HDR=YES;IMEX=1;';"))
            {
                odConnection.Open();

                using (OleDbCommand cmd = new OleDbCommand())
                {
                    cmd.Connection = odConnection;
                    cmd.CommandType = CommandType.Text;
                    cmd.CommandText = "SELECT * FROM [Sheet1$]";
                    using (OleDbDataAdapter oleda = new OleDbDataAdapter(cmd))
                    {
                        oleda.Fill(rs);
                    }
                }
                odConnection.Close();
            }

            rs.Rows[0].Delete();
            rs.AcceptChanges();

            for (int i = 0; i < rs.Rows.Count; i++)
            {
                rs.Rows[i][4] = rs.Rows[i][4].ToString().Replace(",", "");
                rs.Rows[i][5] = rs.Rows[i][5].ToString().Replace(",", "");
                rs.Rows[i][4] = rs.Rows[i][4].ToString() == "" ? "0" : rs.Rows[i][4].ToString();
                rs.Rows[i][5] = rs.Rows[i][5].ToString() == "" ? "0" : rs.Rows[i][5].ToString();
            }
            rs.AcceptChanges();

            DataTable dtCloned = rs.Clone();
            dtCloned.Columns[4].DataType = typeof(Int32);
            dtCloned.Columns[5].DataType = typeof(Int32);
            foreach (DataRow row in rs.Rows)
            {
                dtCloned.ImportRow(row);
            }

            object sumObject;
            sumObject = dtCloned.Compute("Sum(F5)", string.Empty);
            object sumObject1;
            sumObject1 = dtCloned.Compute("Sum(F6)", string.Empty);

            DataRow rows = dt.NewRow();
            dt.Columns.Add("TotalNumberofShares");
            dt.Columns.Add("TotalSharesValue");
            rows[0] = sumObject.ToString();
            rows[1] = sumObject1.ToString();
            dt.Rows.Add(rows);

            response = Request.CreateResponse(HttpStatusCode.OK, dt);
            return response;
        }
    }
}
