# ShareTrade
Share trade is an application which allow users to sell or buy shares of a company. Company will provide a unique identification number to share holders and they can register in the application using same. Application workflow is available in workflow.docx.

# Angular
Please run the command "npm install" before building the application. This will install required dependecies for the project

# Database
Please create a database with the name "ShareTrade". The version used in project is SQL 2016.

# API
Please change the connection string in the web config file in Web API project by changing the SQL server name.

<connectionStrings>
    <add name="ShareTradeEntities" connectionString="metadata=res://*/DataModel.csdl|res://*/DataModel.ssdl|res://*/DataModel.msl;provider=System.Data.SqlClient;provider connection string=&quot;data source=[Server Name];initial catalog=ShareTrade;integrated security=True;MultipleActiveResultSets=True;App=EntityFramework&quot;" providerName="System.Data.EntityClient" />
  </connectionStrings>

# Credentials
This is available in database. Please see [dbo].[User_Info] table.
