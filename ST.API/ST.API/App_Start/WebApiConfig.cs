using System.Web.Http;
using Unity;
using ST.API.App_Start;
using BusinessLayer;
using Interfaces.Business;
using Interfaces.Data;
using DataLayer;

namespace ST.API
{
    public static class WebApiConfig
    {
        public static void Register(HttpConfiguration config)
        {

            //config.EnableCors();

            //Unity resolver
            var container = new UnityContainer();

            container.RegisterType<ISaleBusinessService, SaleBusinessHandler>();
            container.RegisterType<IProposalBusinessService, ProposalBusinessHandler>();
            container.RegisterType<IShareDetailBusinessService, ShareDetailBusinessHandler>();
            container.RegisterType<IUserBusinessService, UserBusinessHandler>();
            container.RegisterType<IQIDBusinessService, QIDBusinessHandler>();
            container.RegisterType<ISummaryBusinessService, SummaryBusinessHandler>();
            container.RegisterType<ICertificateBusinessService, CertificateBusinessHandler>();
            container.RegisterType<IReportBusinessService, ReportBusinessHandler>();

            container.RegisterType<ISaleDataService, SaleDataHandler>();
            container.RegisterType<IProposalDataService, ProposalDataHandler>();
            container.RegisterType<IShareDetailDataService, ShareDetailDataHandler>();
            container.RegisterType<IUserDataService, UserDataHandler>();
            container.RegisterType<IQIDDataService, QIDDataHandler>();
            container.RegisterType<ISummaryDataService, SummaryDataHandler>();
            container.RegisterType<ICertificatesDataService, CertificateDataHandler>();
            container.RegisterType<IReportDataService, ReportDataHandler>();

            config.DependencyResolver = new UnityConfig(container);


            // Web API configuration and services

            // Web API routes
            config.MapHttpAttributeRoutes();

            config.Routes.MapHttpRoute(
                name: "DefaultApi",
                routeTemplate: "api/{controller}/{id}",
                defaults: new { id = RouteParameter.Optional }
            );


        }
    }
}
