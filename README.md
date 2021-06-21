# ShareTrade
Share trade is an application which allow users to sell or buy shares of a company. Company will provide a unique identification number to share holders and they can register in the application using same. Application workflow is available in workflow.docx.

Seller
1.	Login/Signup option 
2.	Shareholder can list his share for sale. 
3.	Shareholder can assign the price and number of shares that he needs to sale. 
4.	Admin must verify and approve the seller account.
5.	Shareholder will receive a notification by email and app notification once any buyer has accepted. 
6.	Shareholder can choose the buyer and request to admin for approval.
Buyer
1.	Login/Sign up Option
2.	Buyer can see the share details that listed by shareholder
3.	Buyer can assign the price and number of shares that he interested to buy.
4.	Buyer can request to admin for approval.
5.	Buyer will get the notification by email or app notification from the seller who is accepted his proposal
Admin
1.	Admin can create/edit/delete the users
2.	User verification and approval.

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
