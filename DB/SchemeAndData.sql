
Note: Create a database with the name "ShareTrade". Comment this line after that and run the script.


USE [ShareTrade]
GO
/****** Object:  Table [dbo].[User_Info]    Script Date: 21-06-2021 11:53:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User_Info](
	[UserInfoId] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NULL,
	[First_Name] [nvarchar](100) NULL,
	[Last_Name] [nvarchar](100) NULL,
	[Email_Address] [nvarchar](100) NULL,
	[Contact_Number] [nvarchar](100) NULL,
	[QID_Number] [nvarchar](100) NULL,
	[Shareholder_ID] [nvarchar](100) NULL,
 CONSTRAINT [PK_User_Info] PRIMARY KEY CLUSTERED 
(
	[UserInfoId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[User]    Script Date: 21-06-2021 11:53:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[UserId] [int] IDENTITY(1,1) NOT NULL,
	[UserName] [nvarchar](100) NULL,
	[Password] [nvarchar](100) NULL,
	[CreatedDt] [datetime] NULL,
	[CreatedBy] [int] NULL,
	[UpdatedDt] [datetime] NULL,
	[UpdatedBy] [int] NULL,
	[IsActive] [bit] NULL,
	[IsAdmin] [bit] NULL,
	[IsAdminApproved] [bit] NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_User_info]    Script Date: 21-06-2021 11:53:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [dbo].[vw_User_info] AS
SELECT T.[UserInfoId]
      ,T.[UserId]
	  ,V.[UserName]
      ,V.[Password]
      ,V.[IsAdmin]
      ,T.[First_Name]
      ,T.[Last_Name]
	  , T.[First_Name] +' ' + T.[Last_Name] AS Full_Name
      ,T.[Email_Address]
      ,T.[Contact_Number]
      ,T.[QID_Number]
      ,T.[Shareholder_ID]
      ,V.[CreatedDt]
      ,V.[CreatedBy]
      ,V.[UpdatedDt]
      ,V.[UpdatedBy]
      ,V.[IsActive]
	  ,V.IsAdminApproved
  FROM [dbo].[User_Info] T
  INNER JOIN [dbo].[User] V
  ON T.UserId = V.UserId

GO
/****** Object:  Table [dbo].[Certificates]    Script Date: 21-06-2021 11:53:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Certificates](
	[CertificateId] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NULL,
	[Path] [varchar](500) NULL,
	[UploadedDt] [datetime] NULL,
 CONSTRAINT [PK_Certificates] PRIMARY KEY CLUSTERED 
(
	[CertificateId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Email_Template]    Script Date: 21-06-2021 11:53:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Email_Template](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Category] [varchar](50) NULL,
	[Content] [varchar](max) NULL,
 CONSTRAINT [PK_Email_Template] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Error_Log]    Script Date: 21-06-2021 11:53:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Error_Log](
	[ErrorId] [int] IDENTITY(1,1) NOT NULL,
	[ErrorDescription] [varchar](max) NULL,
	[CreatedDt] [datetime] NULL,
	[CreatedBy] [int] NULL,
 CONSTRAINT [PK_Error_Log] PRIMARY KEY CLUSTERED 
(
	[ErrorId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Proposal_Details]    Script Date: 21-06-2021 11:53:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Proposal_Details](
	[ProposalId] [int] IDENTITY(1,1) NOT NULL,
	[SaleId] [bigint] NULL,
	[BidPrice] [decimal](18, 0) NULL,
	[BidUnit] [bigint] NULL,
	[CreatedDt] [datetime] NULL,
	[CreatedBy] [int] NULL,
	[UpdatedDt] [datetime] NULL,
	[UpdatedBy] [int] NULL,
	[Status] [int] NULL,
	[StatusComments] [varchar](300) NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_Proposal_Details] PRIMARY KEY CLUSTERED 
(
	[ProposalId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Proposal_Status]    Script Date: 21-06-2021 11:53:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Proposal_Status](
	[StatusId] [int] IDENTITY(1,1) NOT NULL,
	[StatusDescription] [varchar](50) NULL,
 CONSTRAINT [PK_Proposal_Status] PRIMARY KEY CLUSTERED 
(
	[StatusId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Purchase_Interest_Notification]    Script Date: 21-06-2021 11:53:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Purchase_Interest_Notification](
	[NotificationId] [int] IDENTITY(1,1) NOT NULL,
	[Share] [bigint] NULL,
	[Price] [decimal](18, 0) NULL,
	[CreatedBy] [int] NULL,
	[CreatedDt] [datetime] NULL,
 CONSTRAINT [PK_Purchase_Interest_Notification] PRIMARY KEY CLUSTERED 
(
	[NotificationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[QID_Details]    Script Date: 21-06-2021 11:53:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[QID_Details](
	[DetailsId] [int] IDENTITY(1,1) NOT NULL,
	[QID] [varbinary](50) NOT NULL,
	[ShareDescription] [varchar](50) NOT NULL,
	[ShareAvailable] [int] NOT NULL,
 CONSTRAINT [PK_QID_Details] PRIMARY KEY CLUSTERED 
(
	[DetailsId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Quorum]    Script Date: 21-06-2021 11:53:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Quorum](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[QID] [varchar](50) NULL,
	[NumberofShares] [varchar](100) NULL,
	[SharesValue] [varchar](100) NULL,
	[SharePercentage] [varchar](100) NULL,
	[isProxy] [bit] NULL,
	[CrtDt] [datetime] NULL,
 CONSTRAINT [PK_Quorum_1] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Sale_Details]    Script Date: 21-06-2021 11:53:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Sale_Details](
	[SaleId] [int] IDENTITY(1,1) NOT NULL,
	[ShareDetailsId] [int] NULL,
	[NumberOfShares] [bigint] NULL,
	[UnitPrice] [decimal](18, 0) NULL,
	[SaleRemarks] [varchar](300) NULL,
	[CreatedDt] [datetime] NULL,
	[CreatedBy] [int] NULL,
	[UpdatedDt] [datetime] NULL,
	[UpdatedBy] [int] NULL,
	[Status] [int] NULL,
	[StatusComments] [varchar](300) NULL,
	[ValidTo] [date] NULL,
	[IsActive] [bit] NULL,
	[IsNegotiable] [bit] NULL,
 CONSTRAINT [PK_Application_Details] PRIMARY KEY CLUSTERED 
(
	[SaleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Sale_Status]    Script Date: 21-06-2021 11:53:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Sale_Status](
	[StatusId] [int] IDENTITY(1,1) NOT NULL,
	[StatusDescription] [varchar](50) NULL,
 CONSTRAINT [PK_Application_Status] PRIMARY KEY CLUSTERED 
(
	[StatusId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Share_Details]    Script Date: 21-06-2021 11:53:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Share_Details](
	[ShareDetailsId] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NULL,
	[QID] [varchar](100) NULL,
	[ShareholderID] [bigint] NULL,
	[AvailableShares] [bigint] NULL,
	[Description] [varchar](300) NULL,
	[UniqueID] [varchar](50) NULL,
	[CreatedDt] [datetime] NULL,
	[CreatedBy] [int] NULL,
	[UpdatedDt] [datetime] NULL,
	[UpdatedBy] [int] NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_Share_Details] PRIMARY KEY CLUSTERED 
(
	[ShareDetailsId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Share_Details_Audit]    Script Date: 21-06-2021 11:53:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Share_Details_Audit](
	[ShareDetailsAuditId] [int] IDENTITY(1,1) NOT NULL,
	[ShareDetailsId] [int] NULL,
	[QID] [varchar](100) NULL,
	[AvailableShares] [int] NULL,
	[Description] [varchar](300) NULL,
	[UniqueID] [varchar](50) NULL,
	[CreatedDt] [datetime] NULL,
	[CreatedBy] [int] NULL,
	[UpdatedDt] [datetime] NULL,
	[UpdatedBy] [int] NULL,
	[InsertedDate] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Share_Details_Update_Audit]    Script Date: 21-06-2021 11:53:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Share_Details_Update_Audit](
	[ShareDetailsAuditId] [int] IDENTITY(1,1) NOT NULL,
	[SellerQID] [varchar](100) NULL,
	[BuyerQID] [varchar](100) NULL,
	[AvailableShares] [bigint] NULL,
	[ProposedShares] [bigint] NULL,
	[TransactionDate] [datetime] NULL,
	[FromShareId] [int] NULL,
	[ToShareId] [int] NULL
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Certificates] ON 
GO
INSERT [dbo].[Certificates] ([CertificateId], [UserId], [Path], [UploadedDt]) VALUES (1, 24, N'C:\Vishnu\PersonalTech\Simcorn\ShareTrade\ST.API\ST.API\UploadFile\Linkedin Note.txt', NULL)
GO
SET IDENTITY_INSERT [dbo].[Certificates] OFF
GO
SET IDENTITY_INSERT [dbo].[Email_Template] ON 
GO
INSERT [dbo].[Email_Template] ([ID], [Category], [Content]) VALUES (1, N'Bid', N'<!doctype html>
<html>

<head>
    <meta name="viewport" content="width=device-width" />
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <title>Simple Transactional Email</title>
    <style>
        /*//////////////////////////////////////////////////////////////////           [ FONT ]*/
        @font-face {
            font-family: OpenSans-Regular;
        }

        /*//////////////////////////////////////////////////////////////////           [ RESTYLE TAG ]*/
        * {
            margin: 0px;
            padding: 0px;
            box-sizing: border-box;
        }

        /* ------------------------------------ */
        a {
            margin: 0px;
            transition: all 0.4s;
            -webkit-transition: all 0.4s;
            -o-transition: all 0.4s;
            -moz-transition: all 0.4s;
        }

        a:focus {
            outline: none !important;
        }

        /* ------------------------------------ */
        h1,
        h2,
        h3,
        h4,
        h5,
        h6 {
            margin: 0px;
        }

        p {
            margin: 0px;
        }

        ul,
        li {
            margin: 0px;
            list-style-type: none;
        }

        /* ------------------------------------ */
        input {
            display: block;
            outline: none;
            border: none !important;
        }

        textarea {
            display: block;
            outline: none;
        }

        textarea:focus,
        input:focus {
            border-color: transparent !important;
        }

        /* ------------------------------------ */
        button {
            outline: none !important;
            border: none;
            background: transparent;
        }

        button:hover {
            cursor: pointer;
        }

        iframe {
            border: none !important;
        }

        /*//////////////////////////////////////////////////////////////////           [ Utiliti ]*/
        /*//////////////////////////////////////////////////////////////////           [ Table ]*/
        .limiter {
            width: 100%;
            margin: 0 auto;
        }

        .container-table100 {
            width: 100%;
            min-height: 10vh;
            display: -webkit-box;
            display: -webkit-flex;
            display: -moz-box;
            display: -ms-flexbox;
            display: flex;
            align-items: center;
            justify-content: center;
            flex-wrap: wrap;
            padding-bottom: 10px;
        }

        .wrap-table100 {
            width: 100%;
        }

        table {
            border-spacing: 1;
            border-collapse: collapse;
            background: white;
            border-radius: 10px;
            overflow: hidden;
            width: 100%;
            margin: 0 auto;
            position: relative;
        }

        table * {
            position: relative;
        }

        table td,
        table th {
            padding-left: 8px;
        }

        table thead tr {
            height: 60px;
            background: #36304a;
        }

        table tbody tr {
            height: 50px;
        }

        table tbody tr:last-child {
            border: 0;
        }

        table td,
        table th {
            text-align: left;
        }

        table td.l,
        table th.l {
            text-align: right;
        }

        table td.c,
        table th.c {
            text-align: center;
        }

        table td.r,
        table th.r {
            text-align: center;
        }

        .table100-head th {
            font-family: OpenSans-Regular;
            font-size: 18px;
            color: #fff;
            line-height: 1.2;
            font-weight: unset;
        }

        .table100 tbody {
            background-color: #eaeaea
        }

        tbody tr:nth-child(even) {
            background-color: grey
        }

        tbody tr {
            font-family: OpenSans-Regular;
            font-size: 15px;
            color: #808080;
            line-height: 1.2;
            font-weight: unset;
        }

        .column1 {
            width: 260px;
            padding-left: 40px;
        }

        .column4 {
            text-align: left;
        }

        .column5 {
            width: 170px;
            text-align: right;
        }

        .column6 {
            width: 222px;
            text-align: right;
            padding-right: 62px;
        }

        @media screen and (max-width: 992px) {
            table {
                display: block;
            }

            table>*,
            table tr,
            table td,
            table th {
                display: block;
            }

            table thead {
                display: none;
            }

            table tbody tr {
                height: auto;
                padding: 37px 0;
            }

            table tbody tr td {
                padding-left: 40% !important;
                margin-bottom: 24px;
            }

            table tbody tr td:last-child {
                margin-bottom: 0;
            }

            table tbody tr td:before {
                font-family: OpenSans-Regular;
                font-size: 14px;
                color: #999999;
                line-height: 1.2;
                font-weight: unset;
                position: absolute;
                width: 40%;
                left: 30px;
                top: 0;
            }

            table tbody tr td:nth-child(1):before {
                content: "Date";
            }

            table tbody tr td:nth-child(2):before {
                content: "Order ID";
            }

            table tbody tr td:nth-child(3):before {
                content: "Name";
            }

            table tbody tr td:nth-child(4):before {
                content: "Price";
            }

            table tbody tr td:nth-child(5):before {
                content: "Quantity";
            }

            table tbody tr td:nth-child(6):before {
                content: "Total";
            }

            .column4,
            .column5,
            .column6 {
                text-align: left;
            }

            .column4,
            .column5,
            .column6,
            .column1,
            .column2,
            .column3 {
                width: 100%;
            }

            tbody tr {
                font-size: 14px;
            }
        }

        @media (max-width: 576px) {
            .container-table100 {
                padding-left: 15px;
                padding-right: 15px;
            }
        }

        /* -------------------------------------            GLOBAL RESETS        ------------------------------------- */
        /*All the styling goes here*/
        img {
            border: none;
            -ms-interpolation-mode: bicubic;
            max-width: 100%;
        }

        body {
            background-color: #f6f6f6;
            font-family: sans-serif;
            -webkit-font-smoothing: antialiased;
            font-size: 14px;
            line-height: 1.4;
            margin: 0;
            padding: 0;
            -ms-text-size-adjust: 100%;
            -webkit-text-size-adjust: 100%;
        }

        table {
            border-collapse: separate;
            mso-table-lspace: 0pt;
            mso-table-rspace: 0pt;
            width: 100%;
        }

        table td {
            font-family: sans-serif;
            font-size: 14px;
            vertical-align: top;
        }

        /* -------------------------------------            BODY & CONTAINER        ------------------------------------- */
        .body {
            background-color: #f6f6f6;
            width: 100%;
        }

        /* Set a max-width, and make it display as block so it will automatically stretch to that width, but will also shrink down on a phone or something */
        .container {
            display: block;
            margin: 0 auto !important;
            padding: 10px;
            width: 100%;
        }

        /* This should also be a block element, so that it will fill 100% of the .container */
        .content {
            box-sizing: border-box;
            display: block;
            margin: 0 auto;
            padding: 10px;
        }

        /* -------------------------------------            HEADER, FOOTER, MAIN        ------------------------------------- */
        .main {
            background: #ffffff;
            border-radius: 3px;
            width: 100%;
        }

        .wrapper {
            box-sizing: border-box;
            padding: 20px;
        }

        .content-block {
            padding-bottom: 10px;
            padding-top: 10px;
        }

        .footer {
            clear: both;
            margin-top: 10px;
            text-align: center;
            width: 100%;
        }

        .footer td,
        .footer p,
        .footer span,
        .footer a {
            color: #999999;
            font-size: 12px;
            text-align: center;
        }

        /* -------------------------------------            TYPOGRAPHY        ------------------------------------- */
        h1,
        h2,
        h3,
        h4 {
            color: #000000;
            font-family: sans-serif;
            font-weight: 400;
            line-height: 1.4;
            margin: 0;
            margin-bottom: 30px;
        }

        h1 {
            font-size: 35px;
            font-weight: 300;
            text-align: center;
            text-transform: capitalize;
        }

        p,
        ul,
        ol {
            font-family: sans-serif;
            font-size: 14px;
            font-weight: normal;
            margin: 0;
            margin-bottom: 15px;
        }

        p li,
        ul li,
        ol li {
            list-style-position: inside;
            margin-left: 5px;
        }

        a {
            color: #3498db;
            text-decoration: underline;
        }

        /* -------------------------------------            BUTTONS        ------------------------------------- */
        .btn {
            box-sizing: border-box;
            width: 100%;
        }

        .btn>tbody>tr>td {
            padding-bottom: 15px;
        }

        .btn table {
            width: auto;
        }

        .btn table td {
            background-color: #ffffff;
            border-radius: 5px;
            text-align: center;
        }

        .btn a {
            background-color: #ffffff;
            border: solid 1px #3498db;
            border-radius: 5px;
            box-sizing: border-box;
            color: #3498db;
            cursor: pointer;
            display: inline-block;
            font-size: 14px;
            font-weight: bold;
            margin: 0;
            padding: 12px 25px;
            text-decoration: none;
            text-transform: capitalize;
        }

        .btn-primary table td {
            background-color: #3498db;
        }

        .btn-primary a {
            background-color: #3498db;
            border-color: #3498db;
            color: #ffffff;
        }

        /* -------------------------------------            OTHER STYLES THAT MIGHT BE USEFUL        ------------------------------------- */
        .last {
            margin-bottom: 0;
        }

        .first {
            margin-top: 0;
        }

        .align-center {
            text-align: center;
        }

        .align-right {
            text-align: right;
        }

        .align-left {
            text-align: left;
        }

        .clear {
            clear: both;
        }

        .mt0 {
            margin-top: 0;
        }

        .mb0 {
            margin-bottom: 0;
        }

        .preheader {
            color: transparent;
            display: none;
            height: 0;
            max-height: 0;
            max-width: 0;
            opacity: 0;
            overflow: hidden;
            mso-hide: all;
            visibility: hidden;
            width: 0;
        }

        .powered-by a {
            text-decoration: none;
        }

        hr {
            border: 0;
            border-bottom: 1px solid #f6f6f6;
            margin: 20px 0;
        }

        /* -------------------------------------            PRESERVE THESE STYLES IN THE HEAD        ------------------------------------- */
        @media all {
            .ExternalClass {
                width: 100%;
            }

            .ExternalClass,
            .ExternalClass p,
            .ExternalClass span,
            .ExternalClass font,
            .ExternalClass td,
            .ExternalClass div {
                line-height: 100%;
            }

            .apple-link a {
                color: inherit !important;
                font-family: inherit !important;
                font-size: inherit !important;
                font-weight: inherit !important;
                line-height: inherit !important;
                text-decoration: none !important;
            }

            #MessageViewBody a {
                color: inherit;
                text-decoration: none;
                font-size: inherit;
                font-family: inherit;
                font-weight: inherit;
                line-height: inherit;
            }
        }
    </style>
</head>

<body class="">
    <table role="presentation" border="0" cellpadding="0" cellspacing="0" class="body">
        <tr>
            <td>&nbsp;</td>
            <td class="container">
                <div class="content">
                    <!-- START CENTERED WHITE CONTAINER -->
                    <table role="presentation" class="main">
                        <!-- START MAIN CONTENT AREA -->
                        <tr>
                            <td class="wrapper">
                                <table role="presentation" border="0" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td>
                                            <p>Hi $UserFirstName$,</p>
                                            <p>$Introduction$</p>
                                            <p>Sale Details</p>
                                            <div class="container-table100">
                                                <div class="wrap-table100">
                                                    <div class="table100">
                                                        <table>
                                                            <thead>
                                                                <tr class="table100-head">
                                                                    <th class="column2">Number Of Shares</th>
                                                                    <th class="column3">Unit Price</th>
                                                                    <th class="column4">Sale Date</th>
                                                                </tr>
                                                            </thead>
                                                            <tbody>
                                                                <tr>
                                                                    <td class="column2">$NUmberOfShares$</td>
                                                                    <td class="column3">$UnitPrice$</td>
                                                                    <td class="column4">$SaleCreatedDate$</td>
                                                                </tr>
                                                            </tbody>
                                                        </table>
                                                    </div>
                                                </div>
                                            </div>
                                            <p>Bid Details</p>
                                            <div class="container-table100">
                                                <div class="wrap-table100">
                                                    <div class="table100">
                                                        <table>
                                                            <thead>
                                                                <tr class="table100-head">
                                                                    <th class="column1">Bidder Name</th>
                                                                    <th class="column2">Bid Unit</th>
                                                                    <th class="column3">Bid Price</th>
                                                                    <th class="column4">Bid Date</th>
                                                                </tr>
                                                            </thead>
                                                            <tbody>
                                                                <tr>
                                                                    <td class="column1">$BidderName$</td>
                                                                    <td class="column2">$BidUnit$</td>
                                                                    <td class="column3">$BidPrice$</td>
                                                                    <td class="column4">$BidDate$</td>
                                                                </tr>
                                                            </tbody>
                                                        </table>
                                                    </div>
                                                </div>
                                            </div>
                                            <table role="presentation" border="0" cellpadding="0" cellspacing="0"
                                                class="btn btn-primary">
                                                <tbody>
                                                    <tr>
                                                        <td align="left">
                                                            <table role="presentation" border="0" cellpadding="0"
                                                                cellspacing="0">
                                                                <tbody>
                                                                    <tr>
                                                                        <td> <a href="$url$"
                                                                                target="_blank">$ActionName$</a> </td>
                                                                    </tr>
                                                                </tbody>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                            <p>This is an autogenerated email. Please do not reply to this email.</p>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr> <!-- END MAIN CONTENT AREA -->
                    </table> <!-- END CENTERED WHITE CONTAINER -->
                   
                </div>
            </td>
            <td>&nbsp;</td>
        </tr>
    </table> <span style="display: none;">$random$</span>
</body>

</html>')
GO
INSERT [dbo].[Email_Template] ([ID], [Category], [Content]) VALUES (3, N'ForgotPassword', N'<!doctype html>    
<html>
   <head>
      <meta name="viewport" content="width=device-width" />
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
      <title>Simple Transactional Email</title>
      <style>              /*//////////////////////////////////////////////////////////////////           [ FONT ]*/           @font-face {           font-family: OpenSans-Regular;           }           /*//////////////////////////////////////////////////////////////////           [ RESTYLE TAG ]*/           * {           margin: 0px;            padding: 0px;            box-sizing: border-box;           }           /* ------------------------------------ */           a {           margin: 0px;           transition: all 0.4s;           -webkit-transition: all 0.4s;           -o-transition: all 0.4s;           -moz-transition: all 0.4s;           }           a:focus {           outline: none !important;           }           /* ------------------------------------ */           h1,h2,h3,h4,h5,h6 {margin: 0px;}           p {margin: 0px;}           ul, li {           margin: 0px;           list-style-type: none;           }           /* ------------------------------------ */           input {           display: block;           outline: none;           border: none !important;           }           textarea {           display: block;           outline: none;           }           textarea:focus, input:focus {           border-color: transparent !important;           }           /* ------------------------------------ */           button {           outline: none !important;           border: none;           background: transparent;           }           button:hover {           cursor: pointer;           }           iframe {           border: none !important;           }           /*//////////////////////////////////////////////////////////////////           [ Utiliti ]*/           /*//////////////////////////////////////////////////////////////////           [ Table ]*/           .limiter {           width: 100%;           margin: 0 auto;           }           .container-table100 {           width: 100%;           min-height: 10vh;           display: -webkit-box;           display: -webkit-flex;           display: -moz-box;           display: -ms-flexbox;           display: flex;           align-items: center;           justify-content: center;           flex-wrap: wrap;           padding-bottom: 10px;           }           .wrap-table100 {           width: 100%;           }           table {           border-spacing: 1;           border-collapse: collapse;           background: white;           border-radius: 10px;           overflow: hidden;           width: 100%;           margin: 0 auto;           position: relative;           }           table * {           position: relative;           }           table td, table th {           padding-left: 8px;           }           table thead tr {           height: 60px;           background: #36304a;           }           table tbody tr {           height: 50px;           }           table tbody tr:last-child {           border: 0;           }           table td, table th {           text-align: left;           }           table td.l, table th.l {           text-align: right;           }           table td.c, table th.c {           text-align: center;           }           table td.r, table th.r {           text-align: center;           }           .table100-head th{           font-family: OpenSans-Regular;           font-size: 18px;           color: #fff;           line-height: 1.2;           font-weight: unset;           }           .table100 tbody{           background-color: #eaeaea           }           tbody tr:nth-child(even) {           background-color: grey           }           tbody tr {           font-family: OpenSans-Regular;           font-size: 15px;           color: #808080;           line-height: 1.2;           font-weight: unset;           }         .column1 {           width: 260px;           padding-left: 40px;           }           .column4 {           text-align: left;           }           .column5 {           width: 170px;           text-align: right;           }           .column6 {           width: 222px;           text-align: right;           padding-right: 62px;           }           @media screen and (max-width: 992px) {           table {           display: block;           }           table > *, table tr, table td, table th {           display: block;           }           table thead {           display: none;           }           table tbody tr {           height: auto;           padding: 37px 0;           }           table tbody tr td {           padding-left: 40% !important;           margin-bottom: 24px;           }           table tbody tr td:last-child {           margin-bottom: 0;           }           table tbody tr td:before {           font-family: OpenSans-Regular;           font-size: 14px;           color: #999999;           line-height: 1.2;           font-weight: unset;           position: absolute;           width: 40%;           left: 30px;           top: 0;           }           table tbody tr td:nth-child(1):before {           content: "Date";           }           table tbody tr td:nth-child(2):before {           content: "Order ID";           }           table tbody tr td:nth-child(3):before {           content: "Name";           }           table tbody tr td:nth-child(4):before {           content: "Price";           }           table tbody tr td:nth-child(5):before {           content: "Quantity";           }           table tbody tr td:nth-child(6):before {           content: "Total";           }           .column4,           .column5,           .column6 {           text-align: left;           }           .column4,           .column5,           .column6,           .column1,           .column2,           .column3 {           width: 100%;           }           tbody tr {           font-size: 14px;           }           }           @media (max-width: 576px) {           .container-table100 {           padding-left: 15px;           padding-right: 15px;           }           }               /* -------------------------------------            GLOBAL RESETS        ------------------------------------- */      /*All the styling goes here*/    img {   border: none;   -ms-interpolation-mode: bicubic;   max-width: 100%;  }    body {   background-color: #f6f6f6;   font-family: sans-serif;   -webkit-font-smoothing: antialiased;   font-size: 14px;   line-height: 1.4;   margin: 0;   padding: 0;   -ms-text-size-adjust: 100%;   -webkit-text-size-adjust: 100%;  }    table {   border-collapse: separate;   mso-table-lspace: 0pt;   mso-table-rspace: 0pt;   width: 100%;  }    table td {   font-family: sans-serif;   font-size: 14px;   vertical-align: top;  }      /* -------------------------------------            BODY & CONTAINER        ------------------------------------- */    .body {   background-color: #f6f6f6;   width: 100%;  }      /* Set a max-width, and make it display as block so it will automatically stretch to that width, but will also shrink down on a phone or something */    .container {   display: block;   margin: 0 auto !important;   padding: 10px;   width: 100%;  }      /* This should also be a block element, so that it will fill 100% of the .container */    .content {   box-sizing: border-box;   display: block;   margin: 0 auto;   padding: 10px; }      /* -------------------------------------            HEADER, FOOTER, MAIN        ------------------------------------- */    .main {   background: #ffffff;   border-radius: 3px;   width: 100%;  }    .wrapper {   box-sizing: border-box;   padding: 20px;  }    .content-block {   padding-bottom: 10px;   padding-top: 10px;  }    .footer {   clear: both;   margin-top: 10px;   text-align: center;   width: 100%;  }    .footer td,  .footer p,  .footer span,  .footer a {   color: #999999;   font-size: 12px;   text-align: center;  }      /* -------------------------------------            TYPOGRAPHY        ------------------------------------- */    h1,  h2,  h3,  h4 {   color: #000000;   font-family: sans-serif;   font-weight: 400;   line-height: 1.4;   margin: 0;   margin-bottom: 30px;  }    h1 {   font-size: 35px;   font-weight: 300;   text-align: center;   text-transform: capitalize;  }    p,  ul,  ol {   font-family: sans-serif;   font-size: 14px;   font-weight: normal;   margin: 0;   margin-bottom: 15px;  }    p li,  ul li,  ol li {   list-style-position: inside;   margin-left: 5px;  }    a {   color: #3498db;   text-decoration: underline;  }      /* -------------------------------------            BUTTONS        ------------------------------------- */    .btn {   box-sizing: border-box;   width: 100%;  }    .btn>tbody>tr>td {   padding-bottom: 15px;  }    .btn table {   width: auto;  }    .btn table td {   background-color: #ffffff;   border-radius: 5px;   text-align: center;  }    .btn a {   background-color: #ffffff;   border: solid 1px #3498db;   border-radius: 5px;   box-sizing: border-box;   color: #3498db;   cursor: pointer;   display: inline-block;   font-size: 14px;   font-weight: bold;   margin: 0;   padding: 12px 25px;   text-decoration: none;   text-transform: capitalize;  }    .btn-primary table td {   background-color: #3498db;  }    .btn-primary a {   background-color: #3498db;   border-color: #3498db;   color: #ffffff;  }      /* -------------------------------------            OTHER STYLES THAT MIGHT BE USEFUL        ------------------------------------- */    .last {   margin-bottom: 0;  }    .first {   margin-top: 0;  }    .align-center {   text-align: center;  }    .align-right {   text-align: right;  }    .align-left {   text-align: left;  }    .clear {   clear: both;  }    .mt0 {   margin-top: 0;  }    .mb0 {   margin-bottom: 0;  }    .preheader {   color: transparent;   display: none;   height: 0;   max-height: 0;   max-width: 0;   opacity: 0;   overflow: hidden;   mso-hide: all;   visibility: hidden;   width: 0;  }    .powered-by a {   text-decoration: none;  }    hr {   border: 0;   border-bottom: 1px solid #f6f6f6;   margin: 20px 0;  }        /* -------------------------------------            PRESERVE THESE STYLES IN THE HEAD        ------------------------------------- */    @media all {   .ExternalClass {    width: 100%;   }   .ExternalClass,   .ExternalClass p,   .ExternalClass span,   .ExternalClass font,   .ExternalClass td,   .ExternalClass div {    line-height: 100%;   }   .apple-link a {    color: inherit !important;    font-family: inherit !important;    font-size: inherit !important;    font-weight: inherit !important;    line-height: inherit !important;    text-decoration: none !important;   }   #MessageViewBody a {    color: inherit;    text-decoration: none;    font-size: inherit;    font-family: inherit;    font-weight: inherit;    line-height: inherit;   }     }        </style>
   </head>
   <body class="">
      <table role="presentation" border="0" cellpadding="0" cellspacing="0" class="body">
         <tr>
            <td>&nbsp;</td>
            <td class="container">
               <div class="content">
                  <!-- START CENTERED WHITE CONTAINER -->                                  
                  <table role="presentation" class="main">
                     <!-- START MAIN CONTENT AREA -->                                       
                     <tr>
                        <td class="wrapper">
                           <table role="presentation" border="0" cellpadding="0" cellspacing="0">
                              <tr>
                                 <td>
                                    <p>Hi $UserFirstName$,</p>
                                    <p>$Introduction$</p>
                                   
                                    <table role="presentation" border="0" cellpadding="0" cellspacing="0" class="btn btn-primary">
                                       <tbody>
                                          <tr>
                                             <td align="left">
                                                <table role="presentation" border="0" cellpadding="0" cellspacing="0">
                                                   <tbody>
                                                      <tr>
                                                         <td> <a href="$url$" target="_blank">$ActionName$</a> </td>
                                                      </tr>
                                                   </tbody>
                                                </table>
                                             </td>
                                          </tr>
                                       </tbody>
                                    </table>
                                    <p>This is an autogenerated email. Please do not reply to this email.</p>
                                 </td>
                              </tr>
                           </table>
                        </td>
                     </tr>
                     <!-- END MAIN CONTENT AREA -->                                  
                  </table>
                  <!-- END CENTERED WHITE CONTAINER -->                <!-- START FOOTER -->              <!--<div class="footer">                <table role="presentation" border="0" cellpadding="0" cellspacing="0">                  <tr>                    <td class="content-block">                      <span class="apple-link">Company Inc, 3 Abbey Road, San Francisco CA 94102</span>                      <br> Don''t like these emails? <a href="http://i.imgur.com/CScmqnj.gif">Unsubscribe</a>.                    </td>                  </tr>                  <tr>                    <td class="content-block powered-by">                      Powered by <a href="http://htmlemail.io">HTMLemail</a>.                    </td>                  </tr>                </table>              </div>-->              <!-- END FOOTER -->                               
               </div>
            </td>
            <td>&nbsp;</td>
         </tr>
      </table>
      <span style="display: none;">$random$</span>
   </body>
</html>')
GO
INSERT [dbo].[Email_Template] ([ID], [Category], [Content]) VALUES (4, N'NewSale', N'<!doctype html>
<html>

<head>
    <meta name="viewport" content="width=device-width" />
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <title>Simple Transactional Email</title>
    <style>
        /*//////////////////////////////////////////////////////////////////           [ FONT ]*/
        @font-face {
            font-family: OpenSans-Regular;
        }

        /*//////////////////////////////////////////////////////////////////           [ RESTYLE TAG ]*/
        * {
            margin: 0px;
            padding: 0px;
            box-sizing: border-box;
        }

        /* ------------------------------------ */
        a {
            margin: 0px;
            transition: all 0.4s;
            -webkit-transition: all 0.4s;
            -o-transition: all 0.4s;
            -moz-transition: all 0.4s;
        }

        a:focus {
            outline: none !important;
        }

        /* ------------------------------------ */
        h1,
        h2,
        h3,
        h4,
        h5,
        h6 {
            margin: 0px;
        }

        p {
            margin: 0px;
        }

        ul,
        li {
            margin: 0px;
            list-style-type: none;
        }

        /* ------------------------------------ */
        input {
            display: block;
            outline: none;
            border: none !important;
        }

        textarea {
            display: block;
            outline: none;
        }

        textarea:focus,
        input:focus {
            border-color: transparent !important;
        }

        /* ------------------------------------ */
        button {
            outline: none !important;
            border: none;
            background: transparent;
        }

        button:hover {
            cursor: pointer;
        }

        iframe {
            border: none !important;
        }

        /*//////////////////////////////////////////////////////////////////           [ Utiliti ]*/
        /*//////////////////////////////////////////////////////////////////           [ Table ]*/
        .limiter {
            width: 100%;
            margin: 0 auto;
        }

        .container-table100 {
            width: 100%;
            min-height: 10vh;
            display: -webkit-box;
            display: -webkit-flex;
            display: -moz-box;
            display: -ms-flexbox;
            display: flex;
            align-items: center;
            justify-content: center;
            flex-wrap: wrap;
            padding-bottom: 10px;
        }

        .wrap-table100 {
            width: 100%;
        }

        table {
            border-spacing: 1;
            border-collapse: collapse;
            background: white;
            border-radius: 10px;
            overflow: hidden;
            width: 100%;
            margin: 0 auto;
            position: relative;
        }

        table * {
            position: relative;
        }

        table td,
        table th {
            padding-left: 8px;
        }

        table thead tr {
            height: 60px;
            background: #36304a;
        }

        table tbody tr {
            height: 50px;
        }

        table tbody tr:last-child {
            border: 0;
        }

        table td,
        table th {
            text-align: left;
        }

        table td.l,
        table th.l {
            text-align: right;
        }

        table td.c,
        table th.c {
            text-align: center;
        }

        table td.r,
        table th.r {
            text-align: center;
        }

        .table100-head th {
            font-family: OpenSans-Regular;
            font-size: 18px;
            color: #fff;
            line-height: 1.2;
            font-weight: unset;
        }

        .table100 tbody {
            background-color: #eaeaea
        }

        tbody tr:nth-child(even) {
            background-color: grey
        }

        tbody tr {
            font-family: OpenSans-Regular;
            font-size: 15px;
            color: #808080;
            line-height: 1.2;
            font-weight: unset;
        }

        .column1 {
            width: 260px;
            padding-left: 40px;
        }

        .column4 {
            text-align: left;
        }

        .column5 {
            width: 170px;
            text-align: right;
        }

        .column6 {
            width: 222px;
            text-align: right;
            padding-right: 62px;
        }

        @media screen and (max-width: 992px) {
            table {
                display: block;
            }

            table>*,
            table tr,
            table td,
            table th {
                display: block;
            }

            table thead {
                display: none;
            }

            table tbody tr {
                height: auto;
                padding: 37px 0;
            }

            table tbody tr td {
                padding-left: 40% !important;
                margin-bottom: 24px;
            }

            table tbody tr td:last-child {
                margin-bottom: 0;
            }

            table tbody tr td:before {
                font-family: OpenSans-Regular;
                font-size: 14px;
                color: #999999;
                line-height: 1.2;
                font-weight: unset;
                position: absolute;
                width: 40%;
                left: 30px;
                top: 0;
            }

            table tbody tr td:nth-child(1):before {
                content: "Date";
            }

            table tbody tr td:nth-child(2):before {
                content: "Order ID";
            }

            table tbody tr td:nth-child(3):before {
                content: "Name";
            }

            table tbody tr td:nth-child(4):before {
                content: "Price";
            }

            table tbody tr td:nth-child(5):before {
                content: "Quantity";
            }

            table tbody tr td:nth-child(6):before {
                content: "Total";
            }

            .column4,
            .column5,
            .column6 {
                text-align: left;
            }

            .column4,
            .column5,
            .column6,
            .column1,
            .column2,
            .column3 {
                width: 100%;
            }

            tbody tr {
                font-size: 14px;
            }
        }

        @media (max-width: 576px) {
            .container-table100 {
                padding-left: 15px;
                padding-right: 15px;
            }
        }

        /* -------------------------------------            GLOBAL RESETS        ------------------------------------- */
        /*All the styling goes here*/
        img {
            border: none;
            -ms-interpolation-mode: bicubic;
            max-width: 100%;
        }

        body {
            background-color: #f6f6f6;
            font-family: sans-serif;
            -webkit-font-smoothing: antialiased;
            font-size: 14px;
            line-height: 1.4;
            margin: 0;
            padding: 0;
            -ms-text-size-adjust: 100%;
            -webkit-text-size-adjust: 100%;
        }

        table {
            border-collapse: separate;
            mso-table-lspace: 0pt;
            mso-table-rspace: 0pt;
            width: 100%;
        }

        table td {
            font-family: sans-serif;
            font-size: 14px;
            vertical-align: top;
        }

        /* -------------------------------------            BODY & CONTAINER        ------------------------------------- */
        .body {
            background-color: #f6f6f6;
            width: 100%;
        }

        /* Set a max-width, and make it display as block so it will automatically stretch to that width, but will also shrink down on a phone or something */
        .container {
            display: block;
            margin: 0 auto !important;
            padding: 10px;
            width: 100%;
        }

        /* This should also be a block element, so that it will fill 100% of the .container */
        .content {
            box-sizing: border-box;
            display: block;
            margin: 0 auto;
            padding: 10px;
        }

        /* -------------------------------------            HEADER, FOOTER, MAIN        ------------------------------------- */
        .main {
            background: #ffffff;
            border-radius: 3px;
            width: 100%;
        }

        .wrapper {
            box-sizing: border-box;
            padding: 20px;
        }

        .content-block {
            padding-bottom: 10px;
            padding-top: 10px;
        }

        .footer {
            clear: both;
            margin-top: 10px;
            text-align: center;
            width: 100%;
        }

        .footer td,
        .footer p,
        .footer span,
        .footer a {
            color: #999999;
            font-size: 12px;
            text-align: center;
        }

        /* -------------------------------------            TYPOGRAPHY        ------------------------------------- */
        h1,
        h2,
        h3,
        h4 {
            color: #000000;
            font-family: sans-serif;
            font-weight: 400;
            line-height: 1.4;
            margin: 0;
            margin-bottom: 30px;
        }

        h1 {
            font-size: 35px;
            font-weight: 300;
            text-align: center;
            text-transform: capitalize;
        }

        p,
        ul,
        ol {
            font-family: sans-serif;
            font-size: 14px;
            font-weight: normal;
            margin: 0;
            margin-bottom: 15px;
        }

        p li,
        ul li,
        ol li {
            list-style-position: inside;
            margin-left: 5px;
        }

        a {
            color: #3498db;
            text-decoration: underline;
        }

        /* -------------------------------------            BUTTONS        ------------------------------------- */
        .btn {
            box-sizing: border-box;
            width: 100%;
        }

        .btn>tbody>tr>td {
            padding-bottom: 15px;
        }

        .btn table {
            width: auto;
        }

        .btn table td {
            background-color: #ffffff;
            border-radius: 5px;
            text-align: center;
        }

        .btn a {
            background-color: #ffffff;
            border: solid 1px #3498db;
            border-radius: 5px;
            box-sizing: border-box;
            color: #3498db;
            cursor: pointer;
            display: inline-block;
            font-size: 14px;
            font-weight: bold;
            margin: 0;
            padding: 12px 25px;
            text-decoration: none;
            text-transform: capitalize;
        }

        .btn-primary table td {
            background-color: #3498db;
        }

        .btn-primary a {
            background-color: #3498db;
            border-color: #3498db;
            color: #ffffff;
        }

        /* -------------------------------------            OTHER STYLES THAT MIGHT BE USEFUL        ------------------------------------- */
        .last {
            margin-bottom: 0;
        }

        .first {
            margin-top: 0;
        }

        .align-center {
            text-align: center;
        }

        .align-right {
            text-align: right;
        }

        .align-left {
            text-align: left;
        }

        .clear {
            clear: both;
        }

        .mt0 {
            margin-top: 0;
        }

        .mb0 {
            margin-bottom: 0;
        }

        .preheader {
            color: transparent;
            display: none;
            height: 0;
            max-height: 0;
            max-width: 0;
            opacity: 0;
            overflow: hidden;
            mso-hide: all;
            visibility: hidden;
            width: 0;
        }

        .powered-by a {
            text-decoration: none;
        }

        hr {
            border: 0;
            border-bottom: 1px solid #f6f6f6;
            margin: 20px 0;
        }

        /* -------------------------------------            PRESERVE THESE STYLES IN THE HEAD        ------------------------------------- */
        @media all {
            .ExternalClass {
                width: 100%;
            }

            .ExternalClass,
            .ExternalClass p,
            .ExternalClass span,
            .ExternalClass font,
            .ExternalClass td,
            .ExternalClass div {
                line-height: 100%;
            }

            .apple-link a {
                color: inherit !important;
                font-family: inherit !important;
                font-size: inherit !important;
                font-weight: inherit !important;
                line-height: inherit !important;
                text-decoration: none !important;
            }

            #MessageViewBody a {
                color: inherit;
                text-decoration: none;
                font-size: inherit;
                font-family: inherit;
                font-weight: inherit;
                line-height: inherit;
            }
        }
    </style>
</head>

<body class="">
    <table role="presentation" border="0" cellpadding="0" cellspacing="0" class="body">
        <tr>
            <td>&nbsp;</td>
            <td class="container">
                <div class="content">
                    <!-- START CENTERED WHITE CONTAINER -->
                    <table role="presentation" class="main">
                        <!-- START MAIN CONTENT AREA -->
                        <tr>
                            <td class="wrapper">
                                <table role="presentation" border="0" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td>
                                            <p>Hi $UserFirstName$,</p>
                                            <p>$Introduction$</p>
                                            <p>Sale Details</p>
                                            <div class="container-table100">
                                                <div class="wrap-table100">
                                                    <div class="table100">
                                                        <table>
                                                            <thead>
                                                                <tr class="table100-head">
                                                                    <th class="column2">Number Of Shares</th>
                                                                    <th class="column3">Unit Price</th>
                                                                    <th class="column4">Sale Date</th>
                                                                </tr>
                                                            </thead>
                                                            <tbody>
                                                                <tr>
                                                                    <td class="column2">$NUmberOfShares$</td>
                                                                    <td class="column3">$UnitPrice$</td>
                                                                    <td class="column4">$SaleCreatedDate$</td>
                                                                </tr>
                                                            </tbody>
                                                        </table>
                                                    </div>
                                                </div>
                                            </div>
                                            <table role="presentation" border="0" cellpadding="0" cellspacing="0"
                                                class="btn btn-primary">
                                                <tbody>
                                                    <tr>
                                                        <td align="left">
                                                            <table role="presentation" border="0" cellpadding="0"
                                                                cellspacing="0">
                                                                <tbody>
                                                                    <tr>
                                                                        <td> <a href="$url$"
                                                                                target="_blank">$ActionName$</a> </td>
                                                                    </tr>
                                                                </tbody>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                            <p>This is an autogenerated email. Please do not reply to this email.</p>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr> 
                    </table> 
                    
                </div>
            </td>
            <td>&nbsp;</td>
        </tr>
    </table> <span style="display: none;">$random$</span>
</body>

</html>')
GO
INSERT [dbo].[Email_Template] ([ID], [Category], [Content]) VALUES (5, N'PurchaseInterest', N'<!doctype html>
<html>

<head>
    <meta name="viewport" content="width=device-width" />
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <title>Simple Transactional Email</title>
    <style>
        /*//////////////////////////////////////////////////////////////////           [ FONT ]*/
        @font-face {
            font-family: OpenSans-Regular;
        }

        /*//////////////////////////////////////////////////////////////////           [ RESTYLE TAG ]*/
        * {
            margin: 0px;
            padding: 0px;
            box-sizing: border-box;
        }

        /* ------------------------------------ */
        a {
            margin: 0px;
            transition: all 0.4s;
            -webkit-transition: all 0.4s;
            -o-transition: all 0.4s;
            -moz-transition: all 0.4s;
        }

        a:focus {
            outline: none !important;
        }

        /* ------------------------------------ */
        h1,
        h2,
        h3,
        h4,
        h5,
        h6 {
            margin: 0px;
        }

        p {
            margin: 0px;
        }

        ul,
        li {
            margin: 0px;
            list-style-type: none;
        }

        /* ------------------------------------ */
        input {
            display: block;
            outline: none;
            border: none !important;
        }

        textarea {
            display: block;
            outline: none;
        }

        textarea:focus,
        input:focus {
            border-color: transparent !important;
        }

        /* ------------------------------------ */
        button {
            outline: none !important;
            border: none;
            background: transparent;
        }

        button:hover {
            cursor: pointer;
        }

        iframe {
            border: none !important;
        }

        /*//////////////////////////////////////////////////////////////////           [ Utiliti ]*/
        /*//////////////////////////////////////////////////////////////////           [ Table ]*/
        .limiter {
            width: 100%;
            margin: 0 auto;
        }

        .container-table100 {
            width: 100%;
            min-height: 10vh;
            display: -webkit-box;
            display: -webkit-flex;
            display: -moz-box;
            display: -ms-flexbox;
            display: flex;
            align-items: center;
            justify-content: center;
            flex-wrap: wrap;
            padding-bottom: 10px;
        }

        .wrap-table100 {
            width: 100%;
        }

        table {
            border-spacing: 1;
            border-collapse: collapse;
            background: white;
            border-radius: 10px;
            overflow: hidden;
            width: 100%;
            margin: 0 auto;
            position: relative;
        }

        table * {
            position: relative;
        }

        table td,
        table th {
            padding-left: 8px;
        }

        table thead tr {
            height: 60px;
            background: #36304a;
        }

        table tbody tr {
            height: 50px;
        }

        table tbody tr:last-child {
            border: 0;
        }

        table td,
        table th {
            text-align: left;
        }

        table td.l,
        table th.l {
            text-align: right;
        }

        table td.c,
        table th.c {
            text-align: center;
        }

        table td.r,
        table th.r {
            text-align: center;
        }

        .table100-head th {
            font-family: OpenSans-Regular;
            font-size: 18px;
            color: #fff;
            line-height: 1.2;
            font-weight: unset;
        }

        .table100 tbody {
            background-color: #eaeaea
        }

        tbody tr:nth-child(even) {
            background-color: grey
        }

        tbody tr {
            font-family: OpenSans-Regular;
            font-size: 15px;
            color: #808080;
            line-height: 1.2;
            font-weight: unset;
        }

        .column1 {
            width: 260px;
            padding-left: 40px;
        }

        .column4 {
            text-align: left;
        }

        .column5 {
            width: 170px;
            text-align: right;
        }

        .column6 {
            width: 222px;
            text-align: right;
            padding-right: 62px;
        }

        @media screen and (max-width: 992px) {
            table {
                display: block;
            }

            table>*,
            table tr,
            table td,
            table th {
                display: block;
            }

            table thead {
                display: none;
            }

            table tbody tr {
                height: auto;
                padding: 37px 0;
            }

            table tbody tr td {
                padding-left: 40% !important;
                margin-bottom: 24px;
            }

            table tbody tr td:last-child {
                margin-bottom: 0;
            }

            table tbody tr td:before {
                font-family: OpenSans-Regular;
                font-size: 14px;
                color: #999999;
                line-height: 1.2;
                font-weight: unset;
                position: absolute;
                width: 40%;
                left: 30px;
                top: 0;
            }

            table tbody tr td:nth-child(1):before {
                content: "Date";
            }

            table tbody tr td:nth-child(2):before {
                content: "Order ID";
            }

            table tbody tr td:nth-child(3):before {
                content: "Name";
            }

            table tbody tr td:nth-child(4):before {
                content: "Price";
            }

            table tbody tr td:nth-child(5):before {
                content: "Quantity";
            }

            table tbody tr td:nth-child(6):before {
                content: "Total";
            }

            .column4,
            .column5,
            .column6 {
                text-align: left;
            }

            .column4,
            .column5,
            .column6,
            .column1,
            .column2,
            .column3 {
                width: 100%;
            }

            tbody tr {
                font-size: 14px;
            }
        }

        @media (max-width: 576px) {
            .container-table100 {
                padding-left: 15px;
                padding-right: 15px;
            }
        }

        /* -------------------------------------            GLOBAL RESETS        ------------------------------------- */
        /*All the styling goes here*/
        img {
            border: none;
            -ms-interpolation-mode: bicubic;
            max-width: 100%;
        }

        body {
            background-color: #f6f6f6;
            font-family: sans-serif;
            -webkit-font-smoothing: antialiased;
            font-size: 14px;
            line-height: 1.4;
            margin: 0;
            padding: 0;
            -ms-text-size-adjust: 100%;
            -webkit-text-size-adjust: 100%;
        }

        table {
            border-collapse: separate;
            mso-table-lspace: 0pt;
            mso-table-rspace: 0pt;
            width: 100%;
        }

        table td {
            font-family: sans-serif;
            font-size: 14px;
            vertical-align: top;
        }

        /* -------------------------------------            BODY & CONTAINER        ------------------------------------- */
        .body {
            background-color: #f6f6f6;
            width: 100%;
        }

        /* Set a max-width, and make it display as block so it will automatically stretch to that width, but will also shrink down on a phone or something */
        .container {
            display: block;
            margin: 0 auto !important;
            padding: 10px;
            width: 100%;
        }

        /* This should also be a block element, so that it will fill 100% of the .container */
        .content {
            box-sizing: border-box;
            display: block;
            margin: 0 auto;
            padding: 10px;
        }

        /* -------------------------------------            HEADER, FOOTER, MAIN        ------------------------------------- */
        .main {
            background: #ffffff;
            border-radius: 3px;
            width: 100%;
        }

        .wrapper {
            box-sizing: border-box;
            padding: 20px;
        }

        .content-block {
            padding-bottom: 10px;
            padding-top: 10px;
        }

        .footer {
            clear: both;
            margin-top: 10px;
            text-align: center;
            width: 100%;
        }

        .footer td,
        .footer p,
        .footer span,
        .footer a {
            color: #999999;
            font-size: 12px;
            text-align: center;
        }

        /* -------------------------------------            TYPOGRAPHY        ------------------------------------- */
        h1,
        h2,
        h3,
        h4 {
            color: #000000;
            font-family: sans-serif;
            font-weight: 400;
            line-height: 1.4;
            margin: 0;
            margin-bottom: 30px;
        }

        h1 {
            font-size: 35px;
            font-weight: 300;
            text-align: center;
            text-transform: capitalize;
        }

        p,
        ul,
        ol {
            font-family: sans-serif;
            font-size: 14px;
            font-weight: normal;
            margin: 0;
            margin-bottom: 15px;
        }

        p li,
        ul li,
        ol li {
            list-style-position: inside;
            margin-left: 5px;
        }

        a {
            color: #3498db;
            text-decoration: underline;
        }

        /* -------------------------------------            BUTTONS        ------------------------------------- */
        .btn {
            box-sizing: border-box;
            width: 100%;
        }

        .btn>tbody>tr>td {
            padding-bottom: 15px;
        }

        .btn table {
            width: auto;
        }

        .btn table td {
            background-color: #ffffff;
            border-radius: 5px;
            text-align: center;
        }

        .btn a {
            background-color: #ffffff;
            border: solid 1px #3498db;
            border-radius: 5px;
            box-sizing: border-box;
            color: #3498db;
            cursor: pointer;
            display: inline-block;
            font-size: 14px;
            font-weight: bold;
            margin: 0;
            padding: 12px 25px;
            text-decoration: none;
            text-transform: capitalize;
        }

        .btn-primary table td {
            background-color: #3498db;
        }

        .btn-primary a {
            background-color: #3498db;
            border-color: #3498db;
            color: #ffffff;
        }

        /* -------------------------------------            OTHER STYLES THAT MIGHT BE USEFUL        ------------------------------------- */
        .last {
            margin-bottom: 0;
        }

        .first {
            margin-top: 0;
        }

        .align-center {
            text-align: center;
        }

        .align-right {
            text-align: right;
        }

        .align-left {
            text-align: left;
        }

        .clear {
            clear: both;
        }

        .mt0 {
            margin-top: 0;
        }

        .mb0 {
            margin-bottom: 0;
        }

        .preheader {
            color: transparent;
            display: none;
            height: 0;
            max-height: 0;
            max-width: 0;
            opacity: 0;
            overflow: hidden;
            mso-hide: all;
            visibility: hidden;
            width: 0;
        }

        .powered-by a {
            text-decoration: none;
        }

        hr {
            border: 0;
            border-bottom: 1px solid #f6f6f6;
            margin: 20px 0;
        }

        /* -------------------------------------            PRESERVE THESE STYLES IN THE HEAD        ------------------------------------- */
        @media all {
            .ExternalClass {
                width: 100%;
            }

            .ExternalClass,
            .ExternalClass p,
            .ExternalClass span,
            .ExternalClass font,
            .ExternalClass td,
            .ExternalClass div {
                line-height: 100%;
            }

            .apple-link a {
                color: inherit !important;
                font-family: inherit !important;
                font-size: inherit !important;
                font-weight: inherit !important;
                line-height: inherit !important;
                text-decoration: none !important;
            }

            #MessageViewBody a {
                color: inherit;
                text-decoration: none;
                font-size: inherit;
                font-family: inherit;
                font-weight: inherit;
                line-height: inherit;
            }
        }
    </style>
</head>

<body class="">
    <table role="presentation" border="0" cellpadding="0" cellspacing="0" class="body">
        <tr>
            <td>&nbsp;</td>
            <td class="container">
                <div class="content">
                    <!-- START CENTERED WHITE CONTAINER -->
                    <table role="presentation" class="main">
                        <!-- START MAIN CONTENT AREA -->
                        <tr>
                            <td class="wrapper">
                                <table role="presentation" border="0" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td>
                                            <p>Hi $UserFirstName$,</p>
                                            <p>$Introduction$</p>
                                            <p>Share Interested : $InterestedShare$</p>
                                            <p>Price Interested : $InterestedPrice$</p>
                                            <table role="presentation" border="0" cellpadding="0" cellspacing="0"
                                                class="btn btn-primary">
                                                <tbody>
                                                    <tr>
                                                        <td align="left">
                                                            <table role="presentation" border="0" cellpadding="0"
                                                                cellspacing="0">
                                                                <tbody>
                                                                    <tr>
                                                                        <td> <a href="$url$"
                                                                                target="_blank">$ActionName$</a> </td>
                                                                    </tr>
                                                                </tbody>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                            <p>This is an autogenerated email. Please do not reply to this email.</p>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </div>
            </td>
            <td>&nbsp;</td>
        </tr>
    </table> <span style="display: none;">$random$</span>
</body>

</html>')
GO
INSERT [dbo].[Email_Template] ([ID], [Category], [Content]) VALUES (6, N'NewUser', N'<!doctype html>
<html>

<head>
    <meta name="viewport" content="width=device-width" />
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <title>Simple Transactional Email</title>
    <style>
        /*//////////////////////////////////////////////////////////////////           [ FONT ]*/
        @font-face {
            font-family: OpenSans-Regular;
        }

        /*//////////////////////////////////////////////////////////////////           [ RESTYLE TAG ]*/
        * {
            margin: 0px;
            padding: 0px;
            box-sizing: border-box;
        }

        /* ------------------------------------ */
        a {
            margin: 0px;
            transition: all 0.4s;
            -webkit-transition: all 0.4s;
            -o-transition: all 0.4s;
            -moz-transition: all 0.4s;
        }

        a:focus {
            outline: none !important;
        }

        /* ------------------------------------ */
        h1,
        h2,
        h3,
        h4,
        h5,
        h6 {
            margin: 0px;
        }

        p {
            margin: 0px;
        }

        ul,
        li {
            margin: 0px;
            list-style-type: none;
        }

        /* ------------------------------------ */
        input {
            display: block;
            outline: none;
            border: none !important;
        }

        textarea {
            display: block;
            outline: none;
        }

        textarea:focus,
        input:focus {
            border-color: transparent !important;
        }

        /* ------------------------------------ */
        button {
            outline: none !important;
            border: none;
            background: transparent;
        }

        button:hover {
            cursor: pointer;
        }

        iframe {
            border: none !important;
        }

        /*//////////////////////////////////////////////////////////////////           [ Utiliti ]*/
        /*//////////////////////////////////////////////////////////////////           [ Table ]*/
        .limiter {
            width: 100%;
            margin: 0 auto;
        }

        .container-table100 {
            width: 100%;
            min-height: 10vh;
            display: -webkit-box;
            display: -webkit-flex;
            display: -moz-box;
            display: -ms-flexbox;
            display: flex;
            align-items: center;
            justify-content: center;
            flex-wrap: wrap;
            padding-bottom: 10px;
        }

        .wrap-table100 {
            width: 100%;
        }

        table {
            border-spacing: 1;
            border-collapse: collapse;
            background: white;
            border-radius: 10px;
            overflow: hidden;
            width: 100%;
            margin: 0 auto;
            position: relative;
        }

        table * {
            position: relative;
        }

        table td,
        table th {
            padding-left: 8px;
        }

        table thead tr {
            height: 60px;
            background: #36304a;
        }

        table tbody tr {
            height: 50px;
        }

        table tbody tr:last-child {
            border: 0;
        }

        table td,
        table th {
            text-align: left;
        }

        table td.l,
        table th.l {
            text-align: right;
        }

        table td.c,
        table th.c {
            text-align: center;
        }

        table td.r,
        table th.r {
            text-align: center;
        }

        .table100-head th {
            font-family: OpenSans-Regular;
            font-size: 18px;
            color: #fff;
            line-height: 1.2;
            font-weight: unset;
        }

        .table100 tbody {
            background-color: #eaeaea
        }

        tbody tr:nth-child(even) {
            background-color: grey
        }

        tbody tr {
            font-family: OpenSans-Regular;
            font-size: 15px;
            color: #808080;
            line-height: 1.2;
            font-weight: unset;
        }

        .column1 {
            width: 260px;
            padding-left: 40px;
        }

        .column4 {
            text-align: left;
        }

        .column5 {
            width: 170px;
            text-align: right;
        }

        .column6 {
            width: 222px;
            text-align: right;
            padding-right: 62px;
        }

        @media screen and (max-width: 992px) {
            table {
                display: block;
            }

            table>*,
            table tr,
            table td,
            table th {
                display: block;
            }

            table thead {
                display: none;
            }

            table tbody tr {
                height: auto;
                padding: 37px 0;
            }

            table tbody tr td {
                padding-left: 40% !important;
                margin-bottom: 24px;
            }

            table tbody tr td:last-child {
                margin-bottom: 0;
            }

            table tbody tr td:before {
                font-family: OpenSans-Regular;
                font-size: 14px;
                color: #999999;
                line-height: 1.2;
                font-weight: unset;
                position: absolute;
                width: 40%;
                left: 30px;
                top: 0;
            }

            table tbody tr td:nth-child(1):before {
                content: "Date";
            }

            table tbody tr td:nth-child(2):before {
                content: "Order ID";
            }

            table tbody tr td:nth-child(3):before {
                content: "Name";
            }

            table tbody tr td:nth-child(4):before {
                content: "Price";
            }

            table tbody tr td:nth-child(5):before {
                content: "Quantity";
            }

            table tbody tr td:nth-child(6):before {
                content: "Total";
            }

            .column4,
            .column5,
            .column6 {
                text-align: left;
            }

            .column4,
            .column5,
            .column6,
            .column1,
            .column2,
            .column3 {
                width: 100%;
            }

            tbody tr {
                font-size: 14px;
            }
        }

        @media (max-width: 576px) {
            .container-table100 {
                padding-left: 15px;
                padding-right: 15px;
            }
        }

        /* -------------------------------------            GLOBAL RESETS        ------------------------------------- */
        /*All the styling goes here*/
        img {
            border: none;
            -ms-interpolation-mode: bicubic;
            max-width: 100%;
        }

        body {
            background-color: #f6f6f6;
            font-family: sans-serif;
            -webkit-font-smoothing: antialiased;
            font-size: 14px;
            line-height: 1.4;
            margin: 0;
            padding: 0;
            -ms-text-size-adjust: 100%;
            -webkit-text-size-adjust: 100%;
        }

        table {
            border-collapse: separate;
            mso-table-lspace: 0pt;
            mso-table-rspace: 0pt;
            width: 100%;
        }

        table td {
            font-family: sans-serif;
            font-size: 14px;
            vertical-align: top;
        }

        /* -------------------------------------            BODY & CONTAINER        ------------------------------------- */
        .body {
            background-color: #f6f6f6;
            width: 100%;
        }

        /* Set a max-width, and make it display as block so it will automatically stretch to that width, but will also shrink down on a phone or something */
        .container {
            display: block;
            margin: 0 auto !important;
            padding: 10px;
            width: 100%;
        }

        /* This should also be a block element, so that it will fill 100% of the .container */
        .content {
            box-sizing: border-box;
            display: block;
            margin: 0 auto;
            padding: 10px;
        }

        /* -------------------------------------            HEADER, FOOTER, MAIN        ------------------------------------- */
        .main {
            background: #ffffff;
            border-radius: 3px;
            width: 100%;
        }

        .wrapper {
            box-sizing: border-box;
            padding: 20px;
        }

        .content-block {
            padding-bottom: 10px;
            padding-top: 10px;
        }

        .footer {
            clear: both;
            margin-top: 10px;
            text-align: center;
            width: 100%;
        }

        .footer td,
        .footer p,
        .footer span,
        .footer a {
            color: #999999;
            font-size: 12px;
            text-align: center;
        }

        /* -------------------------------------            TYPOGRAPHY        ------------------------------------- */
        h1,
        h2,
        h3,
        h4 {
            color: #000000;
            font-family: sans-serif;
            font-weight: 400;
            line-height: 1.4;
            margin: 0;
            margin-bottom: 30px;
        }

        h1 {
            font-size: 35px;
            font-weight: 300;
            text-align: center;
            text-transform: capitalize;
        }

        p,
        ul,
        ol {
            font-family: sans-serif;
            font-size: 14px;
            font-weight: normal;
            margin: 0;
            margin-bottom: 15px;
        }

        p li,
        ul li,
        ol li {
            list-style-position: inside;
            margin-left: 5px;
        }

        a {
            color: #3498db;
            text-decoration: underline;
        }

        /* -------------------------------------            BUTTONS        ------------------------------------- */
        .btn {
            box-sizing: border-box;
            width: 100%;
        }

        .btn>tbody>tr>td {
            padding-bottom: 15px;
        }

        .btn table {
            width: auto;
        }

        .btn table td {
            background-color: #ffffff;
            border-radius: 5px;
            text-align: center;
        }

        .btn a {
            background-color: #ffffff;
            border: solid 1px #3498db;
            border-radius: 5px;
            box-sizing: border-box;
            color: #3498db;
            cursor: pointer;
            display: inline-block;
            font-size: 14px;
            font-weight: bold;
            margin: 0;
            padding: 12px 25px;
            text-decoration: none;
            text-transform: capitalize;
        }

        .btn-primary table td {
            background-color: #3498db;
        }

        .btn-primary a {
            background-color: #3498db;
            border-color: #3498db;
            color: #ffffff;
        }

        /* -------------------------------------            OTHER STYLES THAT MIGHT BE USEFUL        ------------------------------------- */
        .last {
            margin-bottom: 0;
        }

        .first {
            margin-top: 0;
        }

        .align-center {
            text-align: center;
        }

        .align-right {
            text-align: right;
        }

        .align-left {
            text-align: left;
        }

        .clear {
            clear: both;
        }

        .mt0 {
            margin-top: 0;
        }

        .mb0 {
            margin-bottom: 0;
        }

        .preheader {
            color: transparent;
            display: none;
            height: 0;
            max-height: 0;
            max-width: 0;
            opacity: 0;
            overflow: hidden;
            mso-hide: all;
            visibility: hidden;
            width: 0;
        }

        .powered-by a {
            text-decoration: none;
        }

        hr {
            border: 0;
            border-bottom: 1px solid #f6f6f6;
            margin: 20px 0;
        }

        /* -------------------------------------            PRESERVE THESE STYLES IN THE HEAD        ------------------------------------- */
        @media all {
            .ExternalClass {
                width: 100%;
            }

            .ExternalClass,
            .ExternalClass p,
            .ExternalClass span,
            .ExternalClass font,
            .ExternalClass td,
            .ExternalClass div {
                line-height: 100%;
            }

            .apple-link a {
                color: inherit !important;
                font-family: inherit !important;
                font-size: inherit !important;
                font-weight: inherit !important;
                line-height: inherit !important;
                text-decoration: none !important;
            }

            #MessageViewBody a {
                color: inherit;
                text-decoration: none;
                font-size: inherit;
                font-family: inherit;
                font-weight: inherit;
                line-height: inherit;
            }
        }
    </style>
</head>

<body class="">
    <table role="presentation" border="0" cellpadding="0" cellspacing="0" class="body">
        <tr>
            <td>&nbsp;</td>
            <td class="container">
                <div class="content">
                    <!-- START CENTERED WHITE CONTAINER -->
                    <table role="presentation" class="main">
                        <!-- START MAIN CONTENT AREA -->
                        <tr>
                            <td class="wrapper">
                                <table role="presentation" border="0" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td>
                                            <p>Hi $UserFirstName$,</p>
                                            <p>$Introduction$</p>
                                            <p>User Details</p>
                                            <div class="container-table100">
                                                <div class="wrap-table100">
                                                    <div class="table100">
                                                        <table>
                                                            <thead>
                                                                <tr class="table100-head">
                                                                    <th class="column2">First Name</th>
                                                                    <th class="column3">Last Name</th>
                                                                    <th class="column4">Email Address</th>
                                                                    <th class="column4">Contact Number</th>
                                                                </tr>
                                                            </thead>
                                                            <tbody>
                                                                <tr>
                                                                    <td class="column2">$FirstName$</td>
                                                                    <td class="column3">$LastName$</td>
                                                                    <td class="column4">$EmailAddress$</td>
                                                                    <td class="column4">$ConactNumber$</td>
                                                                </tr>
                                                            </tbody>
                                                        </table>
                                                    </div>
                                                </div>
                                            </div>
                                            <table role="presentation" border="0" cellpadding="0" cellspacing="0"
                                                class="btn btn-primary">
                                                <tbody>
                                                    <tr>
                                                        <td align="left">
                                                            <table role="presentation" border="0" cellpadding="0"
                                                                cellspacing="0">
                                                                <tbody>
                                                                    <tr>
                                                                        <td> <a href="$url$"
                                                                                target="_blank">$ActionName$</a> </td>
                                                                    </tr>
                                                                </tbody>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                            <p>This is an autogenerated email. Please do not reply to this email.</p>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </div>
            </td>
            <td>&nbsp;</td>
        </tr>
    </table> <span style="display: none;">$random$</span>
</body>

</html>')
GO
INSERT [dbo].[Email_Template] ([ID], [Category], [Content]) VALUES (7, N'AdminApprovedUser', N'<!doctype html>  <html>    <head>      <meta name="viewport" content="width=device-width" />      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />      <title>Simple Transactional Email</title>      <style>          /*//////////////////////////////////////////////////////////////////           [ FONT ]*/          @font-face {              font-family: OpenSans-Regular;          }            /*//////////////////////////////////////////////////////////////////           [ RESTYLE TAG ]*/          * {              margin: 0px;              padding: 0px;              box-sizing: border-box;          }            /* ------------------------------------ */          a {              margin: 0px;              transition: all 0.4s;              -webkit-transition: all 0.4s;              -o-transition: all 0.4s;              -moz-transition: all 0.4s;          }            a:focus {              outline: none !important;          }            /* ------------------------------------ */          h1,          h2,          h3,          h4,          h5,          h6 {              margin: 0px;          }            p {              margin: 0px;          }            ul,          li {              margin: 0px;              list-style-type: none;          }            /* ------------------------------------ */          input {              display: block;              outline: none;              border: none !important;          }            textarea {              display: block;              outline: none;          }            textarea:focus,          input:focus {              border-color: transparent !important;          }            /* ------------------------------------ */          button {              outline: none !important;              border: none;              background: transparent;          }            button:hover {              cursor: pointer;          }            iframe {              border: none !important;          }            /*//////////////////////////////////////////////////////////////////           [ Utiliti ]*/          /*//////////////////////////////////////////////////////////////////           [ Table ]*/          .limiter {              width: 100%;              margin: 0 auto;          }            .container-table100 {              width: 100%;              min-height: 10vh;              display: -webkit-box;              display: -webkit-flex;              display: -moz-box;              display: -ms-flexbox;              display: flex;              align-items: center;              justify-content: center;              flex-wrap: wrap;              padding-bottom: 10px;          }            .wrap-table100 {              width: 100%;          }            table {              border-spacing: 1;              border-collapse: collapse;              background: white;              border-radius: 10px;              overflow: hidden;              width: 100%;              margin: 0 auto;              position: relative;          }            table * {              position: relative;          }            table td,          table th {              padding-left: 8px;          }            table thead tr {              height: 60px;              background: #36304a;          }            table tbody tr {              height: 50px;          }            table tbody tr:last-child {              border: 0;          }            table td,          table th {              text-align: left;          }            table td.l,          table th.l {              text-align: right;          }            table td.c,          table th.c {              text-align: center;          }            table td.r,          table th.r {              text-align: center;          }            .table100-head th {              font-family: OpenSans-Regular;              font-size: 18px;              color: #fff;              line-height: 1.2;              font-weight: unset;          }            .table100 tbody {              background-color: #eaeaea          }            tbody tr:nth-child(even) {              background-color: grey          }            tbody tr {              font-family: OpenSans-Regular;              font-size: 15px;              color: #808080;              line-height: 1.2;              font-weight: unset;          }            .column1 {              width: 260px;              padding-left: 40px;          }            .column4 {              text-align: left;          }            .column5 {              width: 170px;              text-align: right;          }            .column6 {              width: 222px;              text-align: right;              padding-right: 62px;          }            @media screen and (max-width: 992px) {              table {                  display: block;              }                table>*,              table tr,              table td,              table th {                  display: block;              }                table thead {                  display: none;              }                table tbody tr {                  height: auto;                  padding: 37px 0;              }                table tbody tr td {                  padding-left: 40% !important;                  margin-bottom: 24px;              }                table tbody tr td:last-child {                  margin-bottom: 0;              }                table tbody tr td:before {                  font-family: OpenSans-Regular;                  font-size: 14px;                  color: #999999;                  line-height: 1.2;                  font-weight: unset;                  position: absolute;                  width: 40%;                  left: 30px;                  top: 0;              }                table tbody tr td:nth-child(1):before {                  content: "Date";              }                table tbody tr td:nth-child(2):before {                  content: "Order ID";              }                table tbody tr td:nth-child(3):before {                  content: "Name";              }                table tbody tr td:nth-child(4):before {                  content: "Price";              }                table tbody tr td:nth-child(5):before {                  content: "Quantity";              }                table tbody tr td:nth-child(6):before {                  content: "Total";              }                .column4,              .column5,              .column6 {                  text-align: left;              }                .column4,              .column5,              .column6,              .column1,              .column2,              .column3 {                  width: 100%;              }                tbody tr {                  font-size: 14px;              }          }            @media (max-width: 576px) {              .container-table100 {                  padding-left: 15px;                  padding-right: 15px;              }          }            /* -------------------------------------            GLOBAL RESETS        ------------------------------------- */          /*All the styling goes here*/          img {              border: none;              -ms-interpolation-mode: bicubic;              max-width: 100%;          }            body {              background-color: #f6f6f6;              font-family: sans-serif;              -webkit-font-smoothing: antialiased;              font-size: 14px;              line-height: 1.4;              margin: 0;              padding: 0;              -ms-text-size-adjust: 100%;              -webkit-text-size-adjust: 100%;          }            table {              border-collapse: separate;              mso-table-lspace: 0pt;              mso-table-rspace: 0pt;              width: 100%;          }            table td {              font-family: sans-serif;              font-size: 14px;              vertical-align: top;          }            /* -------------------------------------            BODY & CONTAINER        ------------------------------------- */          .body {              background-color: #f6f6f6;              width: 100%;          }            /* Set a max-width, and make it display as block so it will automatically stretch to that width, but will also shrink down on a phone or something */          .container {              display: block;              margin: 0 auto !important;              padding: 10px;              width: 100%;          }            /* This should also be a block element, so that it will fill 100% of the .container */          .content {              box-sizing: border-box;              display: block;              margin: 0 auto;              padding: 10px;          }            /* -------------------------------------            HEADER, FOOTER, MAIN        ------------------------------------- */          .main {              background: #ffffff;              border-radius: 3px;              width: 100%;          }            .wrapper {              box-sizing: border-box;              padding: 20px;          }            .content-block {              padding-bottom: 10px;              padding-top: 10px;          }            .footer {              clear: both;              margin-top: 10px;              text-align: center;              width: 100%;          }            .footer td,          .footer p,          .footer span,          .footer a {              color: #999999;              font-size: 12px;              text-align: center;          }            /* -------------------------------------            TYPOGRAPHY        ------------------------------------- */          h1,          h2,          h3,          h4 {              color: #000000;              font-family: sans-serif;              font-weight: 400;              line-height: 1.4;              margin: 0;              margin-bottom: 30px;          }            h1 {              font-size: 35px;              font-weight: 300;              text-align: center;              text-transform: capitalize;          }            p,          ul,          ol {              font-family: sans-serif;              font-size: 14px;              font-weight: normal;              margin: 0;              margin-bottom: 15px;          }            p li,          ul li,          ol li {              list-style-position: inside;              margin-left: 5px;          }            a {              color: #3498db;              text-decoration: underline;          }            /* -------------------------------------            BUTTONS        ------------------------------------- */          .btn {              box-sizing: border-box;              width: 100%;          }            .btn>tbody>tr>td {              padding-bottom: 15px;          }            .btn table {              width: auto;          }            .btn table td {              background-color: #ffffff;              border-radius: 5px;              text-align: center;          }            .btn a {              background-color: #ffffff;              border: solid 1px #3498db;              border-radius: 5px;              box-sizing: border-box;              color: #3498db;              cursor: pointer;              display: inline-block;              font-size: 14px;              font-weight: bold;              margin: 0;              padding: 12px 25px;              text-decoration: none;              text-transform: capitalize;          }            .btn-primary table td {              background-color: #3498db;          }            .btn-primary a {              background-color: #3498db;              border-color: #3498db;              color: #ffffff;          }            /* -------------------------------------            OTHER STYLES THAT MIGHT BE USEFUL        ------------------------------------- */          .last {              margin-bottom: 0;          }            .first {              margin-top: 0;          }            .align-center {              text-align: center;          }            .align-right {              text-align: right;          }            .align-left {              text-align: left;          }            .clear {              clear: both;          }            .mt0 {              margin-top: 0;          }            .mb0 {              margin-bottom: 0;          }            .preheader {              color: transparent;              display: none;              height: 0;              max-height: 0;              max-width: 0;              opacity: 0;              overflow: hidden;              mso-hide: all;              visibility: hidden;              width: 0;          }            .powered-by a {              text-decoration: none;          }            hr {              border: 0;              border-bottom: 1px solid #f6f6f6;              margin: 20px 0;          }            /* -------------------------------------            PRESERVE THESE STYLES IN THE HEAD        ------------------------------------- */          @media all {              .ExternalClass {                  width: 100%;              }                .ExternalClass,              .ExternalClass p,              .ExternalClass span,              .ExternalClass font,              .ExternalClass td,              .ExternalClass div {                  line-height: 100%;              }                .apple-link a {                  color: inherit !important;                  font-family: inherit !important;                  font-size: inherit !important;                  font-weight: inherit !important;                  line-height: inherit !important;                  text-decoration: none !important;              }                #MessageViewBody a {                  color: inherit;                  text-decoration: none;                  font-size: inherit;                  font-family: inherit;                  font-weight: inherit;                  line-height: inherit;              }          }      </style>  </head>    <body class="">      <table role="presentation" border="0" cellpadding="0" cellspacing="0" class="body">          <tr>              <td>&nbsp;</td>              <td class="container">                  <div class="content">                      <!-- START CENTERED WHITE CONTAINER -->                      <table role="presentation" class="main">                          <!-- START MAIN CONTENT AREA -->                          <tr>                              <td class="wrapper">                                  <table role="presentation" border="0" cellpadding="0" cellspacing="0">                                      <tr>                                          <td>                                              <p>Hi $UserFirstName$,</p>                                              <p>$Introduction$</p>                                              <table role="presentation" border="0" cellpadding="0" cellspacing="0"                                                  class="btn btn-primary">                                                  <tbody>                                                      <tr>                                                          <td align="left">                                                              <table role="presentation" border="0" cellpadding="0"                                                                  cellspacing="0">                                                                  <tbody>                                                                      <tr>                                                                          <td> <a href="$url$"                                                                                  target="_blank">$ActionName$</a> </td>                                                                      </tr>                                                                  </tbody>                                                              </table>                                                          </td>                                                      </tr>                                                  </tbody>                                              </table>                                              <p>This is an autogenerated email. Please do not reply to this email.</p>                                          </td>                                      </tr>                                  </table>                              </td>                          </tr>                      </table>                  </div>              </td>              <td>&nbsp;</td>          </tr>      </table> <span style="display: none;">$random$</span>  </body>    </html>')
GO
INSERT [dbo].[Email_Template] ([ID], [Category], [Content]) VALUES (8, N'AdminRejectedUser', N'<!doctype html>
<html>

<head>
    <meta name="viewport" content="width=device-width" />
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <title>Simple Transactional Email</title>
    <style>
        /*//////////////////////////////////////////////////////////////////           [ FONT ]*/
        @font-face {
            font-family: OpenSans-Regular;
        }

        /*//////////////////////////////////////////////////////////////////           [ RESTYLE TAG ]*/
        * {
            margin: 0px;
            padding: 0px;
            box-sizing: border-box;
        }

        /* ------------------------------------ */
        a {
            margin: 0px;
            transition: all 0.4s;
            -webkit-transition: all 0.4s;
            -o-transition: all 0.4s;
            -moz-transition: all 0.4s;
        }

        a:focus {
            outline: none !important;
        }

        /* ------------------------------------ */
        h1,
        h2,
        h3,
        h4,
        h5,
        h6 {
            margin: 0px;
        }

        p {
            margin: 0px;
        }

        ul,
        li {
            margin: 0px;
            list-style-type: none;
        }

        /* ------------------------------------ */
        input {
            display: block;
            outline: none;
            border: none !important;
        }

        textarea {
            display: block;
            outline: none;
        }

        textarea:focus,
        input:focus {
            border-color: transparent !important;
        }

        /* ------------------------------------ */
        button {
            outline: none !important;
            border: none;
            background: transparent;
        }

        button:hover {
            cursor: pointer;
        }

        iframe {
            border: none !important;
        }

        /*//////////////////////////////////////////////////////////////////           [ Utiliti ]*/
        /*//////////////////////////////////////////////////////////////////           [ Table ]*/
        .limiter {
            width: 100%;
            margin: 0 auto;
        }

        .container-table100 {
            width: 100%;
            min-height: 10vh;
            display: -webkit-box;
            display: -webkit-flex;
            display: -moz-box;
            display: -ms-flexbox;
            display: flex;
            align-items: center;
            justify-content: center;
            flex-wrap: wrap;
            padding-bottom: 10px;
        }

        .wrap-table100 {
            width: 100%;
        }

        table {
            border-spacing: 1;
            border-collapse: collapse;
            background: white;
            border-radius: 10px;
            overflow: hidden;
            width: 100%;
            margin: 0 auto;
            position: relative;
        }

        table * {
            position: relative;
        }

        table td,
        table th {
            padding-left: 8px;
        }

        table thead tr {
            height: 60px;
            background: #36304a;
        }

        table tbody tr {
            height: 50px;
        }

        table tbody tr:last-child {
            border: 0;
        }

        table td,
        table th {
            text-align: left;
        }

        table td.l,
        table th.l {
            text-align: right;
        }

        table td.c,
        table th.c {
            text-align: center;
        }

        table td.r,
        table th.r {
            text-align: center;
        }

        .table100-head th {
            font-family: OpenSans-Regular;
            font-size: 18px;
            color: #fff;
            line-height: 1.2;
            font-weight: unset;
        }

        .table100 tbody {
            background-color: #eaeaea
        }

        tbody tr:nth-child(even) {
            background-color: grey
        }

        tbody tr {
            font-family: OpenSans-Regular;
            font-size: 15px;
            color: #808080;
            line-height: 1.2;
            font-weight: unset;
        }

        .column1 {
            width: 260px;
            padding-left: 40px;
        }

        .column4 {
            text-align: left;
        }

        .column5 {
            width: 170px;
            text-align: right;
        }

        .column6 {
            width: 222px;
            text-align: right;
            padding-right: 62px;
        }

        @media screen and (max-width: 992px) {
            table {
                display: block;
            }

            table>*,
            table tr,
            table td,
            table th {
                display: block;
            }

            table thead {
                display: none;
            }

            table tbody tr {
                height: auto;
                padding: 37px 0;
            }

            table tbody tr td {
                padding-left: 40% !important;
                margin-bottom: 24px;
            }

            table tbody tr td:last-child {
                margin-bottom: 0;
            }

            table tbody tr td:before {
                font-family: OpenSans-Regular;
                font-size: 14px;
                color: #999999;
                line-height: 1.2;
                font-weight: unset;
                position: absolute;
                width: 40%;
                left: 30px;
                top: 0;
            }

            table tbody tr td:nth-child(1):before {
                content: "Date";
            }

            table tbody tr td:nth-child(2):before {
                content: "Order ID";
            }

            table tbody tr td:nth-child(3):before {
                content: "Name";
            }

            table tbody tr td:nth-child(4):before {
                content: "Price";
            }

            table tbody tr td:nth-child(5):before {
                content: "Quantity";
            }

            table tbody tr td:nth-child(6):before {
                content: "Total";
            }

            .column4,
            .column5,
            .column6 {
                text-align: left;
            }

            .column4,
            .column5,
            .column6,
            .column1,
            .column2,
            .column3 {
                width: 100%;
            }

            tbody tr {
                font-size: 14px;
            }
        }

        @media (max-width: 576px) {
            .container-table100 {
                padding-left: 15px;
                padding-right: 15px;
            }
        }

        /* -------------------------------------            GLOBAL RESETS        ------------------------------------- */
        /*All the styling goes here*/
        img {
            border: none;
            -ms-interpolation-mode: bicubic;
            max-width: 100%;
        }

        body {
            background-color: #f6f6f6;
            font-family: sans-serif;
            -webkit-font-smoothing: antialiased;
            font-size: 14px;
            line-height: 1.4;
            margin: 0;
            padding: 0;
            -ms-text-size-adjust: 100%;
            -webkit-text-size-adjust: 100%;
        }

        table {
            border-collapse: separate;
            mso-table-lspace: 0pt;
            mso-table-rspace: 0pt;
            width: 100%;
        }

        table td {
            font-family: sans-serif;
            font-size: 14px;
            vertical-align: top;
        }

        /* -------------------------------------            BODY & CONTAINER        ------------------------------------- */
        .body {
            background-color: #f6f6f6;
            width: 100%;
        }

        /* Set a max-width, and make it display as block so it will automatically stretch to that width, but will also shrink down on a phone or something */
        .container {
            display: block;
            margin: 0 auto !important;
            padding: 10px;
            width: 100%;
        }

        /* This should also be a block element, so that it will fill 100% of the .container */
        .content {
            box-sizing: border-box;
            display: block;
            margin: 0 auto;
            padding: 10px;
        }

        /* -------------------------------------            HEADER, FOOTER, MAIN        ------------------------------------- */
        .main {
            background: #ffffff;
            border-radius: 3px;
            width: 100%;
        }

        .wrapper {
            box-sizing: border-box;
            padding: 20px;
        }

        .content-block {
            padding-bottom: 10px;
            padding-top: 10px;
        }

        .footer {
            clear: both;
            margin-top: 10px;
            text-align: center;
            width: 100%;
        }

        .footer td,
        .footer p,
        .footer span,
        .footer a {
            color: #999999;
            font-size: 12px;
            text-align: center;
        }

        /* -------------------------------------            TYPOGRAPHY        ------------------------------------- */
        h1,
        h2,
        h3,
        h4 {
            color: #000000;
            font-family: sans-serif;
            font-weight: 400;
            line-height: 1.4;
            margin: 0;
            margin-bottom: 30px;
        }

        h1 {
            font-size: 35px;
            font-weight: 300;
            text-align: center;
            text-transform: capitalize;
        }

        p,
        ul,
        ol {
            font-family: sans-serif;
            font-size: 14px;
            font-weight: normal;
            margin: 0;
            margin-bottom: 15px;
        }

        p li,
        ul li,
        ol li {
            list-style-position: inside;
            margin-left: 5px;
        }

        a {
            color: #3498db;
            text-decoration: underline;
        }

        /* -------------------------------------            BUTTONS        ------------------------------------- */
        .btn {
            box-sizing: border-box;
            width: 100%;
        }

        .btn>tbody>tr>td {
            padding-bottom: 15px;
        }

        .btn table {
            width: auto;
        }

        .btn table td {
            background-color: #ffffff;
            border-radius: 5px;
            text-align: center;
        }

        .btn a {
            background-color: #ffffff;
            border: solid 1px #3498db;
            border-radius: 5px;
            box-sizing: border-box;
            color: #3498db;
            cursor: pointer;
            display: inline-block;
            font-size: 14px;
            font-weight: bold;
            margin: 0;
            padding: 12px 25px;
            text-decoration: none;
            text-transform: capitalize;
        }

        .btn-primary table td {
            background-color: #3498db;
        }

        .btn-primary a {
            background-color: #3498db;
            border-color: #3498db;
            color: #ffffff;
        }

        /* -------------------------------------            OTHER STYLES THAT MIGHT BE USEFUL        ------------------------------------- */
        .last {
            margin-bottom: 0;
        }

        .first {
            margin-top: 0;
        }

        .align-center {
            text-align: center;
        }

        .align-right {
            text-align: right;
        }

        .align-left {
            text-align: left;
        }

        .clear {
            clear: both;
        }

        .mt0 {
            margin-top: 0;
        }

        .mb0 {
            margin-bottom: 0;
        }

        .preheader {
            color: transparent;
            display: none;
            height: 0;
            max-height: 0;
            max-width: 0;
            opacity: 0;
            overflow: hidden;
            mso-hide: all;
            visibility: hidden;
            width: 0;
        }

        .powered-by a {
            text-decoration: none;
        }

        hr {
            border: 0;
            border-bottom: 1px solid #f6f6f6;
            margin: 20px 0;
        }

        /* -------------------------------------            PRESERVE THESE STYLES IN THE HEAD        ------------------------------------- */
        @media all {
            .ExternalClass {
                width: 100%;
            }

            .ExternalClass,
            .ExternalClass p,
            .ExternalClass span,
            .ExternalClass font,
            .ExternalClass td,
            .ExternalClass div {
                line-height: 100%;
            }

            .apple-link a {
                color: inherit !important;
                font-family: inherit !important;
                font-size: inherit !important;
                font-weight: inherit !important;
                line-height: inherit !important;
                text-decoration: none !important;
            }

            #MessageViewBody a {
                color: inherit;
                text-decoration: none;
                font-size: inherit;
                font-family: inherit;
                font-weight: inherit;
                line-height: inherit;
            }
        }
    </style>
</head>

<body class="">
    <table role="presentation" border="0" cellpadding="0" cellspacing="0" class="body">
        <tr>
            <td>&nbsp;</td>
            <td class="container">
                <div class="content">
                    <!-- START CENTERED WHITE CONTAINER -->
                    <table role="presentation" class="main">
                        <!-- START MAIN CONTENT AREA -->
                        <tr>
                            <td class="wrapper">
                                <table role="presentation" border="0" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td>
                                            <p>Hi $UserFirstName$,</p>
                                            <p>$Introduction$</p>
                                            <table role="presentation" border="0" cellpadding="0" cellspacing="0"
                                                class="btn btn-primary">
                                                <tbody>
                                                    <tr> </tr>
                                                </tbody>
                                            </table>
                                            <p>This is an autogenerated email. Please do not reply to this email.</p>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </div>
            </td>
            <td>&nbsp;</td>
        </tr>
    </table> <span style="display: none;">68334063-0B56-4D9F-8E23-3282507E1575</span>
</body>

</html>')
GO
INSERT [dbo].[Email_Template] ([ID], [Category], [Content]) VALUES (9, N'NewUserToClient', N'<!doctype html>
<html>

<head>
    <meta name="viewport" content="width=device-width" />
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <title>Simple Transactional Email</title>
    <style>
        /*//////////////////////////////////////////////////////////////////           [ FONT ]*/
        @font-face {
            font-family: OpenSans-Regular;
        }

        /*//////////////////////////////////////////////////////////////////           [ RESTYLE TAG ]*/
        * {
            margin: 0px;
            padding: 0px;
            box-sizing: border-box;
        }

        /* ------------------------------------ */
        a {
            margin: 0px;
            transition: all 0.4s;
            -webkit-transition: all 0.4s;
            -o-transition: all 0.4s;
            -moz-transition: all 0.4s;
        }

        a:focus {
            outline: none !important;
        }

        /* ------------------------------------ */
        h1,
        h2,
        h3,
        h4,
        h5,
        h6 {
            margin: 0px;
        }

        p {
            margin: 0px;
        }

        ul,
        li {
            margin: 0px;
            list-style-type: none;
        }

        /* ------------------------------------ */
        input {
            display: block;
            outline: none;
            border: none !important;
        }

        textarea {
            display: block;
            outline: none;
        }

        textarea:focus,
        input:focus {
            border-color: transparent !important;
        }

        /* ------------------------------------ */
        button {
            outline: none !important;
            border: none;
            background: transparent;
        }

        button:hover {
            cursor: pointer;
        }

        iframe {
            border: none !important;
        }

        /*//////////////////////////////////////////////////////////////////           [ Utiliti ]*/
        /*//////////////////////////////////////////////////////////////////           [ Table ]*/
        .limiter {
            width: 100%;
            margin: 0 auto;
        }

        .container-table100 {
            width: 100%;
            min-height: 10vh;
            display: -webkit-box;
            display: -webkit-flex;
            display: -moz-box;
            display: -ms-flexbox;
            display: flex;
            align-items: center;
            justify-content: center;
            flex-wrap: wrap;
            padding-bottom: 10px;
        }

        .wrap-table100 {
            width: 100%;
        }

        table {
            border-spacing: 1;
            border-collapse: collapse;
            background: white;
            border-radius: 10px;
            overflow: hidden;
            width: 100%;
            margin: 0 auto;
            position: relative;
        }

        table * {
            position: relative;
        }

        table td,
        table th {
            padding-left: 8px;
        }

        table thead tr {
            height: 60px;
            background: #36304a;
        }

        table tbody tr {
            height: 50px;
        }

        table tbody tr:last-child {
            border: 0;
        }

        table td,
        table th {
            text-align: left;
        }

        table td.l,
        table th.l {
            text-align: right;
        }

        table td.c,
        table th.c {
            text-align: center;
        }

        table td.r,
        table th.r {
            text-align: center;
        }

        .table100-head th {
            font-family: OpenSans-Regular;
            font-size: 18px;
            color: #fff;
            line-height: 1.2;
            font-weight: unset;
        }

        .table100 tbody {
            background-color: #eaeaea
        }

        tbody tr:nth-child(even) {
            background-color: grey
        }

        tbody tr {
            font-family: OpenSans-Regular;
            font-size: 15px;
            color: #808080;
            line-height: 1.2;
            font-weight: unset;
        }

        .column1 {
            width: 260px;
            padding-left: 40px;
        }

        .column4 {
            text-align: left;
        }

        .column5 {
            width: 170px;
            text-align: right;
        }

        .column6 {
            width: 222px;
            text-align: right;
            padding-right: 62px;
        }

        @media screen and (max-width: 992px) {
            table {
                display: block;
            }

            table>*,
            table tr,
            table td,
            table th {
                display: block;
            }

            table thead {
                display: none;
            }

            table tbody tr {
                height: auto;
                padding: 37px 0;
            }

            table tbody tr td {
                padding-left: 40% !important;
                margin-bottom: 24px;
            }

            table tbody tr td:last-child {
                margin-bottom: 0;
            }

            table tbody tr td:before {
                font-family: OpenSans-Regular;
                font-size: 14px;
                color: #999999;
                line-height: 1.2;
                font-weight: unset;
                position: absolute;
                width: 40%;
                left: 30px;
                top: 0;
            }

            table tbody tr td:nth-child(1):before {
                content: "Date";
            }

            table tbody tr td:nth-child(2):before {
                content: "Order ID";
            }

            table tbody tr td:nth-child(3):before {
                content: "Name";
            }

            table tbody tr td:nth-child(4):before {
                content: "Price";
            }

            table tbody tr td:nth-child(5):before {
                content: "Quantity";
            }

            table tbody tr td:nth-child(6):before {
                content: "Total";
            }

            .column4,
            .column5,
            .column6 {
                text-align: left;
            }

            .column4,
            .column5,
            .column6,
            .column1,
            .column2,
            .column3 {
                width: 100%;
            }

            tbody tr {
                font-size: 14px;
            }
        }

        @media (max-width: 576px) {
            .container-table100 {
                padding-left: 15px;
                padding-right: 15px;
            }
        }

        /* -------------------------------------            GLOBAL RESETS        ------------------------------------- */
        /*All the styling goes here*/
        img {
            border: none;
            -ms-interpolation-mode: bicubic;
            max-width: 100%;
        }

        body {
            background-color: #f6f6f6;
            font-family: sans-serif;
            -webkit-font-smoothing: antialiased;
            font-size: 14px;
            line-height: 1.4;
            margin: 0;
            padding: 0;
            -ms-text-size-adjust: 100%;
            -webkit-text-size-adjust: 100%;
        }

        table {
            border-collapse: separate;
            mso-table-lspace: 0pt;
            mso-table-rspace: 0pt;
            width: 100%;
        }

        table td {
            font-family: sans-serif;
            font-size: 14px;
            vertical-align: top;
        }

        /* -------------------------------------            BODY & CONTAINER        ------------------------------------- */
        .body {
            background-color: #f6f6f6;
            width: 100%;
        }

        /* Set a max-width, and make it display as block so it will automatically stretch to that width, but will also shrink down on a phone or something */
        .container {
            display: block;
            margin: 0 auto !important;
            padding: 10px;
            width: 100%;
        }

        /* This should also be a block element, so that it will fill 100% of the .container */
        .content {
            box-sizing: border-box;
            display: block;
            margin: 0 auto;
            padding: 10px;
        }

        /* -------------------------------------            HEADER, FOOTER, MAIN        ------------------------------------- */
        .main {
            background: #ffffff;
            border-radius: 3px;
            width: 100%;
        }

        .wrapper {
            box-sizing: border-box;
            padding: 20px;
        }

        .content-block {
            padding-bottom: 10px;
            padding-top: 10px;
        }

        .footer {
            clear: both;
            margin-top: 10px;
            text-align: center;
            width: 100%;
        }

        .footer td,
        .footer p,
        .footer span,
        .footer a {
            color: #999999;
            font-size: 12px;
            text-align: center;
        }

        /* -------------------------------------            TYPOGRAPHY        ------------------------------------- */
        h1,
        h2,
        h3,
        h4 {
            color: #000000;
            font-family: sans-serif;
            font-weight: 400;
            line-height: 1.4;
            margin: 0;
            margin-bottom: 30px;
        }

        h1 {
            font-size: 35px;
            font-weight: 300;
            text-align: center;
            text-transform: capitalize;
        }

        p,
        ul,
        ol {
            font-family: sans-serif;
            font-size: 14px;
            font-weight: normal;
            margin: 0;
            margin-bottom: 15px;
        }

        p li,
        ul li,
        ol li {
            list-style-position: inside;
            margin-left: 5px;
        }

        a {
            color: #3498db;
            text-decoration: underline;
        }

        /* -------------------------------------            BUTTONS        ------------------------------------- */
        .btn {
            box-sizing: border-box;
            width: 100%;
        }

        .btn>tbody>tr>td {
            padding-bottom: 15px;
        }

        .btn table {
            width: auto;
        }

        .btn table td {
            background-color: #ffffff;
            border-radius: 5px;
            text-align: center;
        }

        .btn a {
            background-color: #ffffff;
            border: solid 1px #3498db;
            border-radius: 5px;
            box-sizing: border-box;
            color: #3498db;
            cursor: pointer;
            display: inline-block;
            font-size: 14px;
            font-weight: bold;
            margin: 0;
            padding: 12px 25px;
            text-decoration: none;
            text-transform: capitalize;
        }

        .btn-primary table td {
            background-color: #3498db;
        }

        .btn-primary a {
            background-color: #3498db;
            border-color: #3498db;
            color: #ffffff;
        }

        /* -------------------------------------            OTHER STYLES THAT MIGHT BE USEFUL        ------------------------------------- */
        .last {
            margin-bottom: 0;
        }

        .first {
            margin-top: 0;
        }

        .align-center {
            text-align: center;
        }

        .align-right {
            text-align: right;
        }

        .align-left {
            text-align: left;
        }

        .clear {
            clear: both;
        }

        .mt0 {
            margin-top: 0;
        }

        .mb0 {
            margin-bottom: 0;
        }

        .preheader {
            color: transparent;
            display: none;
            height: 0;
            max-height: 0;
            max-width: 0;
            opacity: 0;
            overflow: hidden;
            mso-hide: all;
            visibility: hidden;
            width: 0;
        }

        .powered-by a {
            text-decoration: none;
        }

        hr {
            border: 0;
            border-bottom: 1px solid #f6f6f6;
            margin: 20px 0;
        }

        /* -------------------------------------            PRESERVE THESE STYLES IN THE HEAD        ------------------------------------- */
        @media all {
            .ExternalClass {
                width: 100%;
            }

            .ExternalClass,
            .ExternalClass p,
            .ExternalClass span,
            .ExternalClass font,
            .ExternalClass td,
            .ExternalClass div {
                line-height: 100%;
            }

            .apple-link a {
                color: inherit !important;
                font-family: inherit !important;
                font-size: inherit !important;
                font-weight: inherit !important;
                line-height: inherit !important;
                text-decoration: none !important;
            }

            #MessageViewBody a {
                color: inherit;
                text-decoration: none;
                font-size: inherit;
                font-family: inherit;
                font-weight: inherit;
                line-height: inherit;
            }
        }
    </style>
</head>

<body class="">
    <table role="presentation" border="0" cellpadding="0" cellspacing="0" class="body">
        <tr>
            <td>&nbsp;</td>
            <td class="container">
                <div class="content">
                    <!-- START CENTERED WHITE CONTAINER -->
                    <table role="presentation" class="main">
                        <!-- START MAIN CONTENT AREA -->
                        <tr>
                            <td class="wrapper">
                                <table role="presentation" border="0" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td>
                                            <p>Hi $UserFirstName$,</p>
                                            <p>$Introduction$</p>
                                            <table role="presentation" border="0" cellpadding="0" cellspacing="0"
                                                class="btn btn-primary">
                                                <tbody>
                                                    <tr> </tr>
                                                </tbody>
                                            </table>
                                            <p>This is an autogenerated email. Please do not reply to this email.</p>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </div>
            </td>
            <td>&nbsp;</td>
        </tr>
    </table> <span style="display: none;">68334063-0B56-4D9F-8E23-3282507E1575</span>
</body>

</html>')
GO
INSERT [dbo].[Email_Template] ([ID], [Category], [Content]) VALUES (10, N'NewUserRegistration', N'<!doctype html>  <html>    <head>      <meta name="viewport" content="width=device-width" />      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />      <title>Simple Transactional Email</title>      <style>          /*//////////////////////////////////////////////////////////////////           [ FONT ]*/          @font-face {              font-family: OpenSans-Regular;          }            /*//////////////////////////////////////////////////////////////////           [ RESTYLE TAG ]*/          * {              margin: 0px;              padding: 0px;              box-sizing: border-box;          }            /* ------------------------------------ */          a {              margin: 0px;              transition: all 0.4s;              -webkit-transition: all 0.4s;              -o-transition: all 0.4s;              -moz-transition: all 0.4s;          }            a:focus {              outline: none !important;          }            /* ------------------------------------ */          h1,          h2,          h3,          h4,          h5,          h6 {              margin: 0px;          }            p {              margin: 0px;          }            ul,          li {              margin: 0px;              list-style-type: none;          }            /* ------------------------------------ */          input {              display: block;              outline: none;              border: none !important;          }            textarea {              display: block;              outline: none;          }            textarea:focus,          input:focus {              border-color: transparent !important;          }            /* ------------------------------------ */          button {              outline: none !important;              border: none;              background: transparent;          }            button:hover {              cursor: pointer;          }            iframe {              border: none !important;          }            /*//////////////////////////////////////////////////////////////////           [ Utiliti ]*/          /*//////////////////////////////////////////////////////////////////           [ Table ]*/          .limiter {              width: 100%;              margin: 0 auto;          }            .container-table100 {              width: 100%;              min-height: 10vh;              display: -webkit-box;              display: -webkit-flex;              display: -moz-box;              display: -ms-flexbox;              display: flex;              align-items: center;              justify-content: center;              flex-wrap: wrap;              padding-bottom: 10px;          }            .wrap-table100 {              width: 100%;          }            table {              border-spacing: 1;              border-collapse: collapse;              background: white;              border-radius: 10px;              overflow: hidden;              width: 100%;              margin: 0 auto;              position: relative;          }            table * {              position: relative;          }            table td,          table th {              padding-left: 8px;          }            table thead tr {              height: 60px;              background: #36304a;          }            table tbody tr {              height: 50px;          }            table tbody tr:last-child {              border: 0;          }            table td,          table th {              text-align: left;          }            table td.l,          table th.l {              text-align: right;          }            table td.c,          table th.c {              text-align: center;          }            table td.r,          table th.r {              text-align: center;          }            .table100-head th {              font-family: OpenSans-Regular;              font-size: 18px;              color: #fff;              line-height: 1.2;              font-weight: unset;          }            .table100 tbody {              background-color: #eaeaea          }            tbody tr:nth-child(even) {              background-color: grey          }            tbody tr {              font-family: OpenSans-Regular;              font-size: 15px;              color: #808080;              line-height: 1.2;              font-weight: unset;          }            .column1 {              width: 260px;              padding-left: 40px;          }            .column4 {              text-align: left;          }            .column5 {              width: 170px;              text-align: right;          }            .column6 {              width: 222px;              text-align: right;              padding-right: 62px;          }            @media screen and (max-width: 992px) {              table {                  display: block;              }                table>*,              table tr,              table td,              table th {                  display: block;              }                table thead {                  display: none;              }                table tbody tr {                  height: auto;                  padding: 37px 0;              }                table tbody tr td {                  padding-left: 40% !important;                  margin-bottom: 24px;              }                table tbody tr td:last-child {                  margin-bottom: 0;              }                table tbody tr td:before {                  font-family: OpenSans-Regular;                  font-size: 14px;                  color: #999999;                  line-height: 1.2;                  font-weight: unset;                  position: absolute;                  width: 40%;                  left: 30px;                  top: 0;              }                table tbody tr td:nth-child(1):before {                  content: "Date";              }                table tbody tr td:nth-child(2):before {                  content: "Order ID";              }                table tbody tr td:nth-child(3):before {                  content: "Name";              }                table tbody tr td:nth-child(4):before {                  content: "Price";              }                table tbody tr td:nth-child(5):before {                  content: "Quantity";              }                table tbody tr td:nth-child(6):before {                  content: "Total";              }                .column4,              .column5,              .column6 {                  text-align: left;              }                .column4,              .column5,              .column6,              .column1,              .column2,              .column3 {                  width: 100%;              }                tbody tr {                  font-size: 14px;              }          }            @media (max-width: 576px) {              .container-table100 {                  padding-left: 15px;                  padding-right: 15px;              }          }            /* -------------------------------------            GLOBAL RESETS        ------------------------------------- */          /*All the styling goes here*/          img {              border: none;              -ms-interpolation-mode: bicubic;              max-width: 100%;          }            body {              background-color: #f6f6f6;              font-family: sans-serif;              -webkit-font-smoothing: antialiased;              font-size: 14px;              line-height: 1.4;              margin: 0;              padding: 0;              -ms-text-size-adjust: 100%;              -webkit-text-size-adjust: 100%;          }            table {              border-collapse: separate;              mso-table-lspace: 0pt;              mso-table-rspace: 0pt;              width: 100%;          }            table td {              font-family: sans-serif;              font-size: 14px;              vertical-align: top;          }            /* -------------------------------------            BODY & CONTAINER        ------------------------------------- */          .body {              background-color: #f6f6f6;              width: 100%;          }            /* Set a max-width, and make it display as block so it will automatically stretch to that width, but will also shrink down on a phone or something */          .container {              display: block;              margin: 0 auto !important;              padding: 10px;              width: 100%;          }            /* This should also be a block element, so that it will fill 100% of the .container */          .content {              box-sizing: border-box;              display: block;              margin: 0 auto;              padding: 10px;          }            /* -------------------------------------            HEADER, FOOTER, MAIN        ------------------------------------- */          .main {              background: #ffffff;              border-radius: 3px;              width: 100%;          }            .wrapper {              box-sizing: border-box;              padding: 20px;          }            .content-block {              padding-bottom: 10px;              padding-top: 10px;          }            .footer {              clear: both;              margin-top: 10px;              text-align: center;              width: 100%;          }            .footer td,          .footer p,          .footer span,          .footer a {              color: #999999;              font-size: 12px;              text-align: center;          }            /* -------------------------------------            TYPOGRAPHY        ------------------------------------- */          h1,          h2,          h3,          h4 {              color: #000000;              font-family: sans-serif;              font-weight: 400;              line-height: 1.4;              margin: 0;              margin-bottom: 30px;          }            h1 {              font-size: 35px;              font-weight: 300;              text-align: center;              text-transform: capitalize;          }            p,          ul,          ol {              font-family: sans-serif;              font-size: 14px;              font-weight: normal;              margin: 0;              margin-bottom: 15px;          }            p li,          ul li,          ol li {              list-style-position: inside;              margin-left: 5px;          }            a {              color: #3498db;              text-decoration: underline;          }            /* -------------------------------------            BUTTONS        ------------------------------------- */          .btn {              box-sizing: border-box;              width: 100%;          }            .btn>tbody>tr>td {              padding-bottom: 15px;          }            .btn table {              width: auto;          }            .btn table td {              background-color: #ffffff;              border-radius: 5px;              text-align: center;          }            .btn a {              background-color: #ffffff;              border: solid 1px #3498db;              border-radius: 5px;              box-sizing: border-box;              color: #3498db;              cursor: pointer;              display: inline-block;              font-size: 14px;              font-weight: bold;              margin: 0;              padding: 12px 25px;              text-decoration: none;              text-transform: capitalize;          }            .btn-primary table td {              background-color: #3498db;          }            .btn-primary a {              background-color: #3498db;              border-color: #3498db;              color: #ffffff;          }            /* -------------------------------------            OTHER STYLES THAT MIGHT BE USEFUL        ------------------------------------- */          .last {              margin-bottom: 0;          }            .first {              margin-top: 0;          }            .align-center {              text-align: center;          }            .align-right {              text-align: right;          }            .align-left {              text-align: left;          }            .clear {              clear: both;          }            .mt0 {              margin-top: 0;          }            .mb0 {              margin-bottom: 0;          }            .preheader {              color: transparent;              display: none;              height: 0;              max-height: 0;              max-width: 0;              opacity: 0;              overflow: hidden;              mso-hide: all;              visibility: hidden;              width: 0;          }            .powered-by a {              text-decoration: none;          }            hr {              border: 0;              border-bottom: 1px solid #f6f6f6;              margin: 20px 0;          }            /* -------------------------------------            PRESERVE THESE STYLES IN THE HEAD        ------------------------------------- */          @media all {              .ExternalClass {                  width: 100%;              }                .ExternalClass,              .ExternalClass p,              .ExternalClass span,              .ExternalClass font,              .ExternalClass td,              .ExternalClass div {                  line-height: 100%;              }                .apple-link a {                  color: inherit !important;                  font-family: inherit !important;                  font-size: inherit !important;                  font-weight: inherit !important;                  line-height: inherit !important;                  text-decoration: none !important;              }                #MessageViewBody a {                  color: inherit;                  text-decoration: none;                  font-size: inherit;                  font-family: inherit;                  font-weight: inherit;                  line-height: inherit;              }          }      </style>  </head>    <body class="">      <table role="presentation" border="0" cellpadding="0" cellspacing="0" class="body">          <tr>              <td>&nbsp;</td>              <td class="container">                  <div class="content">                      <!-- START CENTERED WHITE CONTAINER -->                      <table role="presentation" class="main">                          <!-- START MAIN CONTENT AREA -->                          <tr>                              <td class="wrapper">                                  <table role="presentation" border="0" cellpadding="0" cellspacing="0">                                      <tr>                                          <td>                                              <p>Hi $UserFirstName$,</p>                                              <p>$Introduction$</p>                                              <table role="presentation" border="0" cellpadding="0" cellspacing="0"                                                  class="btn btn-primary">                                                  <tbody>                                                      <tr>                                                          <td align="left">                                                              <table role="presentation" border="0" cellpadding="0"                                                                  cellspacing="0">                                                                  <tbody>                                                                      <tr>                                                                          <td> <a href="$url$"                                                                                  target="_blank">$ActionName$</a> </td>                                                                      </tr>                                                                  </tbody>                                                              </table>                                                          </td>                                                      </tr>                                                  </tbody>                                              </table>                                              <p>This is an autogenerated email. Please do not reply to this email.</p>                                          </td>                                      </tr>                                  </table>                              </td>                          </tr>                      </table>                  </div>              </td>              <td>&nbsp;</td>          </tr>      </table> <span style="display: none;">$random$</span>  </body>    </html>')
GO
INSERT [dbo].[Email_Template] ([ID], [Category], [Content]) VALUES (11, N'BidShareHolderApproveToAdmin', N'<!doctype html>
<html>

<head>
    <meta name="viewport" content="width=device-width" />
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <title>Simple Transactional Email</title>
    <style>
        /*//////////////////////////////////////////////////////////////////           [ FONT ]*/
        @font-face {
            font-family: OpenSans-Regular;
        }

        /*//////////////////////////////////////////////////////////////////           [ RESTYLE TAG ]*/
        * {
            margin: 0px;
            padding: 0px;
            box-sizing: border-box;
        }

        /* ------------------------------------ */
        a {
            margin: 0px;
            transition: all 0.4s;
            -webkit-transition: all 0.4s;
            -o-transition: all 0.4s;
            -moz-transition: all 0.4s;
        }

        a:focus {
            outline: none !important;
        }

        /* ------------------------------------ */
        h1,
        h2,
        h3,
        h4,
        h5,
        h6 {
            margin: 0px;
        }

        p {
            margin: 0px;
        }

        ul,
        li {
            margin: 0px;
            list-style-type: none;
        }

        /* ------------------------------------ */
        input {
            display: block;
            outline: none;
            border: none !important;
        }

        textarea {
            display: block;
            outline: none;
        }

        textarea:focus,
        input:focus {
            border-color: transparent !important;
        }

        /* ------------------------------------ */
        button {
            outline: none !important;
            border: none;
            background: transparent;
        }

        button:hover {
            cursor: pointer;
        }

        iframe {
            border: none !important;
        }

        /*//////////////////////////////////////////////////////////////////           [ Utiliti ]*/
        /*//////////////////////////////////////////////////////////////////           [ Table ]*/
        .limiter {
            width: 100%;
            margin: 0 auto;
        }

        .container-table100 {
            width: 100%;
            min-height: 10vh;
            display: -webkit-box;
            display: -webkit-flex;
            display: -moz-box;
            display: -ms-flexbox;
            display: flex;
            align-items: center;
            justify-content: center;
            flex-wrap: wrap;
            padding-bottom: 10px;
        }

        .wrap-table100 {
            width: 100%;
        }

        table {
            border-spacing: 1;
            border-collapse: collapse;
            background: white;
            border-radius: 10px;
            overflow: hidden;
            width: 100%;
            margin: 0 auto;
            position: relative;
        }

        table * {
            position: relative;
        }

        table td,
        table th {
            padding-left: 8px;
        }

        table thead tr {
            height: 60px;
            background: #36304a;
        }

        table tbody tr {
            height: 50px;
        }

        table tbody tr:last-child {
            border: 0;
        }

        table td,
        table th {
            text-align: left;
        }

        table td.l,
        table th.l {
            text-align: right;
        }

        table td.c,
        table th.c {
            text-align: center;
        }

        table td.r,
        table th.r {
            text-align: center;
        }

        .table100-head th {
            font-family: OpenSans-Regular;
            font-size: 18px;
            color: #fff;
            line-height: 1.2;
            font-weight: unset;
        }

        .table100 tbody {
            background-color: #eaeaea
        }

        tbody tr:nth-child(even) {
            background-color: grey
        }

        tbody tr {
            font-family: OpenSans-Regular;
            font-size: 15px;
            color: #808080;
            line-height: 1.2;
            font-weight: unset;
        }

        .column1 {
            width: 260px;
            padding-left: 40px;
        }

        .column4 {
            text-align: left;
        }

        .column5 {
            width: 170px;
            text-align: right;
        }

        .column6 {
            width: 222px;
            text-align: right;
            padding-right: 62px;
        }

        @media screen and (max-width: 992px) {
            table {
                display: block;
            }

            table>*,
            table tr,
            table td,
            table th {
                display: block;
            }

            table thead {
                display: none;
            }

            table tbody tr {
                height: auto;
                padding: 37px 0;
            }

            table tbody tr td {
                padding-left: 40% !important;
                margin-bottom: 24px;
            }

            table tbody tr td:last-child {
                margin-bottom: 0;
            }

            table tbody tr td:before {
                font-family: OpenSans-Regular;
                font-size: 14px;
                color: #999999;
                line-height: 1.2;
                font-weight: unset;
                position: absolute;
                width: 40%;
                left: 30px;
                top: 0;
            }

            table tbody tr td:nth-child(1):before {
                content: "Date";
            }

            table tbody tr td:nth-child(2):before {
                content: "Order ID";
            }

            table tbody tr td:nth-child(3):before {
                content: "Name";
            }

            table tbody tr td:nth-child(4):before {
                content: "Price";
            }

            table tbody tr td:nth-child(5):before {
                content: "Quantity";
            }

            table tbody tr td:nth-child(6):before {
                content: "Total";
            }

            .column4,
            .column5,
            .column6 {
                text-align: left;
            }

            .column4,
            .column5,
            .column6,
            .column1,
            .column2,
            .column3 {
                width: 100%;
            }

            tbody tr {
                font-size: 14px;
            }
        }

        @media (max-width: 576px) {
            .container-table100 {
                padding-left: 15px;
                padding-right: 15px;
            }
        }

        /* -------------------------------------            GLOBAL RESETS        ------------------------------------- */
        /*All the styling goes here*/
        img {
            border: none;
            -ms-interpolation-mode: bicubic;
            max-width: 100%;
        }

        body {
            background-color: #f6f6f6;
            font-family: sans-serif;
            -webkit-font-smoothing: antialiased;
            font-size: 14px;
            line-height: 1.4;
            margin: 0;
            padding: 0;
            -ms-text-size-adjust: 100%;
            -webkit-text-size-adjust: 100%;
        }

        table {
            border-collapse: separate;
            mso-table-lspace: 0pt;
            mso-table-rspace: 0pt;
            width: 100%;
        }

        table td {
            font-family: sans-serif;
            font-size: 14px;
            vertical-align: top;
        }

        /* -------------------------------------            BODY & CONTAINER        ------------------------------------- */
        .body {
            background-color: #f6f6f6;
            width: 100%;
        }

        /* Set a max-width, and make it display as block so it will automatically stretch to that width, but will also shrink down on a phone or something */
        .container {
            display: block;
            margin: 0 auto !important;
            padding: 10px;
            width: 100%;
        }

        /* This should also be a block element, so that it will fill 100% of the .container */
        .content {
            box-sizing: border-box;
            display: block;
            margin: 0 auto;
            padding: 10px;
        }

        /* -------------------------------------            HEADER, FOOTER, MAIN        ------------------------------------- */
        .main {
            background: #ffffff;
            border-radius: 3px;
            width: 100%;
        }

        .wrapper {
            box-sizing: border-box;
            padding: 20px;
        }

        .content-block {
            padding-bottom: 10px;
            padding-top: 10px;
        }

        .footer {
            clear: both;
            margin-top: 10px;
            text-align: center;
            width: 100%;
        }

        .footer td,
        .footer p,
        .footer span,
        .footer a {
            color: #999999;
            font-size: 12px;
            text-align: center;
        }

        /* -------------------------------------            TYPOGRAPHY        ------------------------------------- */
        h1,
        h2,
        h3,
        h4 {
            color: #000000;
            font-family: sans-serif;
            font-weight: 400;
            line-height: 1.4;
            margin: 0;
            margin-bottom: 30px;
        }

        h1 {
            font-size: 35px;
            font-weight: 300;
            text-align: center;
            text-transform: capitalize;
        }

        p,
        ul,
        ol {
            font-family: sans-serif;
            font-size: 14px;
            font-weight: normal;
            margin: 0;
            margin-bottom: 15px;
        }

        p li,
        ul li,
        ol li {
            list-style-position: inside;
            margin-left: 5px;
        }

        a {
            color: #3498db;
            text-decoration: underline;
        }

        /* -------------------------------------            BUTTONS        ------------------------------------- */
        .btn {
            box-sizing: border-box;
            width: 100%;
        }

        .btn>tbody>tr>td {
            padding-bottom: 15px;
        }

        .btn table {
            width: auto;
        }

        .btn table td {
            background-color: #ffffff;
            border-radius: 5px;
            text-align: center;
        }

        .btn a {
            background-color: #ffffff;
            border: solid 1px #3498db;
            border-radius: 5px;
            box-sizing: border-box;
            color: #3498db;
            cursor: pointer;
            display: inline-block;
            font-size: 14px;
            font-weight: bold;
            margin: 0;
            padding: 12px 25px;
            text-decoration: none;
            text-transform: capitalize;
        }

        .btn-primary table td {
            background-color: #3498db;
        }

        .btn-primary a {
            background-color: #3498db;
            border-color: #3498db;
            color: #ffffff;
        }

        /* -------------------------------------            OTHER STYLES THAT MIGHT BE USEFUL        ------------------------------------- */
        .last {
            margin-bottom: 0;
        }

        .first {
            margin-top: 0;
        }

        .align-center {
            text-align: center;
        }

        .align-right {
            text-align: right;
        }

        .align-left {
            text-align: left;
        }

        .clear {
            clear: both;
        }

        .mt0 {
            margin-top: 0;
        }

        .mb0 {
            margin-bottom: 0;
        }

        .preheader {
            color: transparent;
            display: none;
            height: 0;
            max-height: 0;
            max-width: 0;
            opacity: 0;
            overflow: hidden;
            mso-hide: all;
            visibility: hidden;
            width: 0;
        }

        .powered-by a {
            text-decoration: none;
        }

        hr {
            border: 0;
            border-bottom: 1px solid #f6f6f6;
            margin: 20px 0;
        }

        /* -------------------------------------            PRESERVE THESE STYLES IN THE HEAD        ------------------------------------- */
        @media all {
            .ExternalClass {
                width: 100%;
            }

            .ExternalClass,
            .ExternalClass p,
            .ExternalClass span,
            .ExternalClass font,
            .ExternalClass td,
            .ExternalClass div {
                line-height: 100%;
            }

            .apple-link a {
                color: inherit !important;
                font-family: inherit !important;
                font-size: inherit !important;
                font-weight: inherit !important;
                line-height: inherit !important;
                text-decoration: none !important;
            }

            #MessageViewBody a {
                color: inherit;
                text-decoration: none;
                font-size: inherit;
                font-family: inherit;
                font-weight: inherit;
                line-height: inherit;
            }
        }
    </style>
</head>

<body class="">
    <table role="presentation" border="0" cellpadding="0" cellspacing="0" class="body">
        <tr>
            <td>&nbsp;</td>
            <td class="container">
                <div class="content">
                    <!-- START CENTERED WHITE CONTAINER -->
                    <table role="presentation" class="main">
                        <!-- START MAIN CONTENT AREA -->
                        <tr>
                            <td class="wrapper">
                                <table role="presentation" border="0" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td>
                                            <p>Hi $UserFirstName$,</p>
                                            <p>$Introduction$</p>
                                            <p>Sale Details</p>
                                            <div class="container-table100">
                                                <div class="wrap-table100">
                                                    <div class="table100">
                                                        <table>
                                                            <thead>
                                                                <tr class="table100-head">
                                                                    <th class="column2">Share Holder</th>
                                                                    <th class="column2">Number Of Shares</th>
                                                                    <th class="column3">Unit Price</th>
                                                                    <th class="column4">Sale Date</th>
                                                                </tr>
                                                            </thead>
                                                            <tbody>
                                                                <tr>
                                                                    <td class="column2">$ShareHolderName$</td>
                                                                    <td class="column2">$NUmberOfShares$</td>
                                                                    <td class="column3">$UnitPrice$</td>
                                                                    <td class="column4">$SaleCreatedDate$</td>
                                                                </tr>
                                                            </tbody>
                                                        </table>
                                                    </div>
                                                </div>
                                            </div>
                                            <p>Bid Details</p>
                                            <div class="container-table100">
                                                <div class="wrap-table100">
                                                    <div class="table100">
                                                        <table>
                                                            <thead>
                                                                <tr class="table100-head">
                                                                    <th class="column1">Bidder Name</th>
                                                                    <th class="column2">Bid Unit</th>
                                                                    <th class="column3">Bid Price</th>
                                                                    <th class="column4">Bid Date</th>
                                                                </tr>
                                                            </thead>
                                                            <tbody>
                                                                <tr>
                                                                    <td class="column1">$BidderName$</td>
                                                                    <td class="column2">$BidUnit$</td>
                                                                    <td class="column3">$BidPrice$</td>
                                                                    <td class="column4">$BidDate$</td>
                                                                </tr>
                                                            </tbody>
                                                        </table>
                                                    </div>
                                                </div>
                                            </div>
                                            <table role="presentation" border="0" cellpadding="0" cellspacing="0"
                                                class="btn btn-primary">
                                                <tbody>
                                                    <tr>
                                                        <td align="left">
                                                            <table role="presentation" border="0" cellpadding="0"
                                                                cellspacing="0">
                                                                <tbody>
                                                                    <tr>
                                                                        <td> <a href="$url$"
                                                                                target="_blank">$ActionName$</a> </td>
                                                                    </tr>
                                                                </tbody>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                            <p>This is an autogenerated email. Please do not reply to this email.</p>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr> <!-- END MAIN CONTENT AREA -->
                    </table> <!-- END CENTERED WHITE CONTAINER -->
                </div>
            </td>
            <td>&nbsp;</td>
        </tr>
    </table> <span style="display: none;">$random$</span>
</body>

</html>')
GO
SET IDENTITY_INSERT [dbo].[Email_Template] OFF
GO
SET IDENTITY_INSERT [dbo].[Proposal_Status] ON 
GO
INSERT [dbo].[Proposal_Status] ([StatusId], [StatusDescription]) VALUES (1, N'Submitted')
GO
INSERT [dbo].[Proposal_Status] ([StatusId], [StatusDescription]) VALUES (2, N'ShareHolder Approved')
GO
INSERT [dbo].[Proposal_Status] ([StatusId], [StatusDescription]) VALUES (3, N'ShareHolder Rejected')
GO
INSERT [dbo].[Proposal_Status] ([StatusId], [StatusDescription]) VALUES (4, N'Admin Approved')
GO
INSERT [dbo].[Proposal_Status] ([StatusId], [StatusDescription]) VALUES (5, N'Admin Rejected')
GO
SET IDENTITY_INSERT [dbo].[Proposal_Status] OFF
GO
SET IDENTITY_INSERT [dbo].[Sale_Status] ON 
GO
INSERT [dbo].[Sale_Status] ([StatusId], [StatusDescription]) VALUES (1, N'Submitted')
GO
INSERT [dbo].[Sale_Status] ([StatusId], [StatusDescription]) VALUES (2, N'Cancelled')
GO
INSERT [dbo].[Sale_Status] ([StatusId], [StatusDescription]) VALUES (3, N'Completed')
GO
SET IDENTITY_INSERT [dbo].[Sale_Status] OFF
GO
SET IDENTITY_INSERT [dbo].[Share_Details] ON 
GO
INSERT [dbo].[Share_Details] ([ShareDetailsId], [UserId], [QID], [ShareholderID], [AvailableShares], [Description], [UniqueID], [CreatedDt], [CreatedBy], [UpdatedDt], [UpdatedBy], [IsActive]) VALUES (1, 0, N'12345678902', 1, 20460, NULL, NULL, CAST(N'2020-11-28T10:48:59.793' AS DateTime), 1, NULL, NULL, 1)
GO
SET IDENTITY_INSERT [dbo].[Share_Details] OFF
GO
SET IDENTITY_INSERT [dbo].[User] ON 
GO
INSERT [dbo].[User] ([UserId], [UserName], [Password], [CreatedDt], [CreatedBy], [UpdatedDt], [UpdatedBy], [IsActive], [IsAdmin], [IsAdminApproved]) VALUES (1, N'admin', N'admin', CAST(N'2020-08-20T14:52:10.163' AS DateTime), 1, CAST(N'2020-10-02T14:42:02.163' AS DateTime), 1, 1, 1, 1)
GO
INSERT [dbo].[User] ([UserId], [UserName], [Password], [CreatedDt], [CreatedBy], [UpdatedDt], [UpdatedBy], [IsActive], [IsAdmin], [IsAdminApproved]) VALUES (45, N'Sam', N'Demo1!', CAST(N'2020-11-16T14:49:26.153' AS DateTime), 0, NULL, NULL, 1, 0, 1)
GO
SET IDENTITY_INSERT [dbo].[User] OFF
GO
SET IDENTITY_INSERT [dbo].[User_Info] ON 
GO
INSERT [dbo].[User_Info] ([UserInfoId], [UserId], [First_Name], [Last_Name], [Email_Address], [Contact_Number], [QID_Number], [Shareholder_ID]) VALUES (1, 1, N'Admin', N' User', N'admin@admin.com', N'12345678', N'12345678901', N'0')
GO
INSERT [dbo].[User_Info] ([UserInfoId], [UserId], [First_Name], [Last_Name], [Email_Address], [Contact_Number], [QID_Number], [Shareholder_ID]) VALUES (2, 45, N'john', N'mani', N'dem@demo.com', N'12345678', N'12345678902', N'1')
GO
SET IDENTITY_INSERT [dbo].[User_Info] OFF
GO
ALTER TABLE [dbo].[Proposal_Details]  WITH CHECK ADD  CONSTRAINT [FK_Proposal_Details_Proposal_Status] FOREIGN KEY([Status])
REFERENCES [dbo].[Proposal_Status] ([StatusId])
GO
ALTER TABLE [dbo].[Proposal_Details] CHECK CONSTRAINT [FK_Proposal_Details_Proposal_Status]
GO
ALTER TABLE [dbo].[Proposal_Details]  WITH CHECK ADD  CONSTRAINT [FK_Proposal_Details_User] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[User] ([UserId])
GO
ALTER TABLE [dbo].[Proposal_Details] CHECK CONSTRAINT [FK_Proposal_Details_User]
GO
ALTER TABLE [dbo].[Proposal_Details]  WITH CHECK ADD  CONSTRAINT [FK_Proposal_Details_User1] FOREIGN KEY([UpdatedBy])
REFERENCES [dbo].[User] ([UserId])
GO
ALTER TABLE [dbo].[Proposal_Details] CHECK CONSTRAINT [FK_Proposal_Details_User1]
GO
ALTER TABLE [dbo].[Share_Details]  WITH CHECK ADD  CONSTRAINT [FK_Share_Details_User] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[User] ([UserId])
GO
ALTER TABLE [dbo].[Share_Details] CHECK CONSTRAINT [FK_Share_Details_User]
GO
ALTER TABLE [dbo].[Share_Details]  WITH CHECK ADD  CONSTRAINT [FK_Share_Details_User1] FOREIGN KEY([UpdatedBy])
REFERENCES [dbo].[User] ([UserId])
GO
ALTER TABLE [dbo].[Share_Details] CHECK CONSTRAINT [FK_Share_Details_User1]
GO
ALTER TABLE [dbo].[User_Info]  WITH CHECK ADD  CONSTRAINT [FK_User_Info_User] FOREIGN KEY([UserId])
REFERENCES [dbo].[User] ([UserId])
GO
ALTER TABLE [dbo].[User_Info] CHECK CONSTRAINT [FK_User_Info_User]
GO
/****** Object:  StoredProcedure [dbo].[Approve_Bid]    Script Date: 21-06-2021 11:53:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
-- [dbo].[Approve_Bid] 15, 4
CREATE PROCEDURE [dbo].[Approve_Bid] 
	@BidID int,
	@SaleID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @ShareId int = 0
	DECLARE @Byuer_QID VARCHAR(100)
	DECLARE @Seller_QID VARCHAR(100)
	DECLARE @Byuer_UserID int = 0
	DECLARE @Seller_UserID int = 0
	DECLARE @Share_UID varchar(max) = 0
	declare @ShareExistsCnt INT
	declare @PrposedShares INT
	declare @availableShares INT
	declare @ShareDesc varchar(max)
	declare @fromShareId int
	declare @toShareId int
	declare @numberOfSharesAfterApproval INT

    -- Insert statements for procedure here
	SELECT 
		@BidID = t.ProposalId, 
		@Byuer_QID = u.QID_Number, 
		@Byuer_UserID = t.CreatedBy, 
		@PrposedShares = t.BidUnit 
	FROM Proposal_Details t JOIN vw_User_info u ON T.CreatedBy = U.UserId where t.ProposalId = @BidID

	SELECT 
		@ShareId = t.ShareDetailsId from Sale_Details t JOIN vw_User_info u ON T.CreatedBy = U.UserId where t.SaleId = @SaleID

	SELECT 
		@Share_UID = t.UniqueID,
		@Seller_QID = t.QID, 
		@ShareDesc = t.[Description] ,
		@availableShares = t.AvailableShares
	FROM Share_Details t where t.ShareDetailsId = @ShareId

	IF (@PrposedShares > @availableShares )
		BEGIN
			RAISERROR('Available shares cannot be less than number of shares in bid.',16,1)
		END
	
		SELECT @ShareExistsCnt = COUNT(1) FROM Share_Details t where  t.QID = @Byuer_QID		
	
	IF (@ShareExistsCnt > 0)
		BEGIN
			UPDATE Share_Details  set AvailableShares = AvailableShares + @PrposedShares WHERE  QID = @Byuer_QID
		END
	ELSE
		BEGIN
			INSERT INTO [dbo].[Share_Details]
					   ([UserId]
					   ,[QID]
					   ,[AvailableShares]
					   ,[Description]
					   --,[UniqueID]
					   ,[CreatedDt]
					   ,[CreatedBy]
					   ,[UpdatedDt]
					   ,[UpdatedBy]
					   ,[IsActive])
				 VALUES
					   (null
					   ,@Byuer_QID
					   ,@PrposedShares
					   ,@ShareDesc
					   --,@Share_UID
					   ,GETDATE()
					   ,1
					   ,null
					   ,null
					   ,1)
		END

		UPDATE Share_Details  set AvailableShares = AvailableShares - @PrposedShares, [UpdatedDt] = GETDATE() WHERE  QID = @Seller_QID 

		UPDATE Proposal_Details SET [Status] = 4, StatusComments='Bid has been approved by Admin', [UpdatedDt] = GETDATE() WHERE ProposalId = @BidID		

		UPDATE Sale_Details SET [NumberOfShares] = [NumberOfShares] - @PrposedShares, [UpdatedDt] = GETDATE() WHERE SaleId = @SaleID

		SELECT @numberOfSharesAfterApproval =  sum(t.NumberOfShares) FROM Sale_Details t WHERE SaleId = @SaleID
		

		IF(@numberOfSharesAfterApproval =0 )
			BEGIN
				UPDATE Sale_Details SET [Status] = 3 WHERE SaleId = @SaleID -- Mark sale as completed if complete shares in the sale were purchased 
			END


		/******************* Audit Table when share is moved from one user to another*************************/

		IF (@ShareExistsCnt > 0)
		BEGIN
				SELECT 	@fromShareId = t.ShareDetailsId from Sale_Details t JOIN vw_User_info u ON T.CreatedBy = U.UserId where t.SaleId = @SaleID
				SELECT  @toShareId = t.ShareDetailsId FROM Share_Details t where  t.QID = @Byuer_QID
			
				INSERT INTO [dbo].[Share_Details_Update_Audit]
						   ([SellerQID]
						   ,[BuyerQID]
						   ,[AvailableShares]
						   ,[ProposedShares]
						   ,[TransactionDate]
						   ,[FromShareId]
						   ,[ToShareId])
					 VALUES
						   (@Seller_QID
						   ,@Byuer_QID
						   ,@availableShares
						   ,@PrposedShares
						   ,getdate()
						   ,@fromShareId
						   ,@toShareId)
		END
		
		

END
GO
/****** Object:  StoredProcedure [dbo].[Get_BidDetails]    Script Date: 21-06-2021 11:53:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Get_BidDetails] 
	@Bid_Id int = 0,
	@CreatedBy int 
AS
BEGIN
	SET fmtonly OFF   
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	Declare @IsAdmin INT = (SELECT COUNT(1) FROM vw_User_info T WHERE T.UserId = @CreatedBy AND T.IsAdmin = 1 )

	IF( @IsAdmin > 0)
		BEGIN
			SELECT 
					   Bid.ProposalId AS ProposalId
					  ,Bid.SaleId AS SaleId
					  ,Bid.BidPrice AS BidPrice
					  ,Bid.BidUnit AS BidUnit
					  ,Bid.[Status]
					  ,PS.StatusDescription AS StatusDescription
					  ,Bid.StatusComments AS StatusComments
					  ,Bid.CreatedDt AS BidCreatedDt
					  ,Bid.UpdatedDt AS BidUpdatedDt
					  ,CreatedByUser.Full_Name AS BidCreatedBy
					  ,UpdatedByUser.Full_Name AS BidUpdatedBy						  
					  ,Share.[Description] AS ShareDescription  
					  ,CAST(SaleUser.Contact_Number AS VARCHAR) as ShareholderContactNumber
					  ,SaleUser.Full_Name AS Seller
					  ,CreatedByUser.Full_Name AS Buyer
					  ,share.AvailableShares AS SellerAvailableShares
				  FROM [dbo].[Proposal_Details] Bid 
				  INNER JOIN [dbo].[Proposal_Status] PS ON PS.StatusId = Bid.[Status]
				  INNER JOIN [dbo].[Sale_Details] Sale ON Bid.SaleId = Sale.SaleId
				  INNER JOIN [dbo].[Share_Details] Share ON Share.ShareDetailsId = Sale.ShareDetailsId
				  LEFT JOIN [dbo].[vw_User_info] CreatedByUser ON CreatedByUser.UserId = Bid.CreatedBy
				  LEFT JOIN [dbo].[vw_User_info] UpdatedByUser ON UpdatedByUser.UserId = Bid.UpdatedBy
				  LEFT JOIN [dbo].[vw_User_info] SaleUser ON SaleUser.UserId = Sale.CreatedBy
				  WHERE Bid.IsActive = 1 
				  AND Bid.ProposalId = 
							CASE WHEN @Bid_Id <> 0 THEN @Bid_Id
							ELSE Bid.ProposalId
							END			
				  AND Bid.[Status] in(2,4,5)
		END
	ELSE
		BEGIN
			SELECT 
					   Bid.ProposalId AS ProposalId
					  ,Bid.SaleId AS SaleId
					  ,Bid.BidPrice AS BidPrice
					  ,Bid.BidUnit AS BidUnit
					  ,Bid.[Status]
					  ,PS.StatusDescription AS StatusDescription
					  ,Bid.StatusComments AS StatusComments
					  ,Bid.CreatedDt AS BidCreatedDt
					  ,Bid.UpdatedDt AS BidUpdatedDt
					  ,CreatedByUser.Full_Name AS BidCreatedBy
					  ,UpdatedByUser.Full_Name AS BidUpdatedBy						  
					  ,Share.[Description] AS ShareDescription  
					  ,CAST(SaleUser.Contact_Number AS VARCHAR) as ShareholderContactNumber
					  ,SaleUser.Full_Name AS Seller
					  ,CreatedByUser.Full_Name AS Buyer
					  ,share.AvailableShares AS SellerAvailableShares
				  FROM [dbo].[Proposal_Details] Bid 
				  INNER JOIN [dbo].[Proposal_Status] PS ON PS.StatusId = Bid.[Status]
				  INNER JOIN [dbo].[Sale_Details] Sale ON Bid.SaleId = Sale.SaleId
				  INNER JOIN [dbo].[Share_Details] Share ON Share.ShareDetailsId = Sale.ShareDetailsId
				  LEFT JOIN [dbo].[vw_User_info] CreatedByUser ON CreatedByUser.UserId = Bid.CreatedBy
				  LEFT JOIN [dbo].[vw_User_info] UpdatedByUser ON UpdatedByUser.UserId = Bid.UpdatedBy
				  LEFT JOIN [dbo].[vw_User_info] SaleUser ON SaleUser.UserId = Sale.CreatedBy
				  WHERE Bid.IsActive = 1 
				  AND Bid.ProposalId = 
							CASE WHEN @Bid_Id <> 0 THEN @Bid_Id
							ELSE Bid.ProposalId
							END			
				  AND Bid.CreatedBy = 
							CASE WHEN @CreatedBy <> 0 THEN @CreatedBy
							ELSE Bid.CreatedBy
							END
		END


				
END
GO
/****** Object:  StoredProcedure [dbo].[Get_BidDetails_Report]    Script Date: 21-06-2021 11:53:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Get_BidDetails_Report] 
AS
BEGIN
	SET fmtonly OFF   
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	SELECT 
					   
					   Bid.SaleId AS SaleId
					  ,Bid.ProposalId AS ProposalId
					  ,Bid.BidPrice AS BidPrice
					  ,Bid.BidUnit AS BidUnit
					  ,Sale.UnitPrice AS SaleUnitPrice
					  ,PS.StatusDescription AS BidStatus
					  ,Bid.CreatedDt AS BidCreatedDate
					  ,Bid.UpdatedDt AS BidUpdatedDate
					  ,UpdatedByUser.Full_Name AS BidUpdatedBy	
					  ,CreatedByUser.Full_Name AS Buyer
					  ,SaleUser.Full_Name AS Seller
					  ,CAST(SaleUser.Contact_Number AS VARCHAR) as SellerContactNumber
					  ,share.AvailableShares AS SellerAvailableShares
				  FROM [dbo].[Proposal_Details] Bid 
				  INNER JOIN [dbo].[Proposal_Status] PS ON PS.StatusId = Bid.[Status]
				  INNER JOIN [dbo].[Sale_Details] Sale ON Bid.SaleId = Sale.SaleId
				  INNER JOIN [dbo].[Share_Details] Share ON Share.ShareDetailsId = Sale.ShareDetailsId
				  LEFT JOIN [dbo].[vw_User_info] CreatedByUser ON CreatedByUser.UserId = Bid.CreatedBy
				  LEFT JOIN [dbo].[vw_User_info] UpdatedByUser ON UpdatedByUser.UserId = Bid.UpdatedBy
				  LEFT JOIN [dbo].[vw_User_info] SaleUser ON SaleUser.UserId = Sale.CreatedBy
				  WHERE Bid.IsActive = 1 
				
END
GO
/****** Object:  StoredProcedure [dbo].[Get_Certificates]    Script Date: 21-06-2021 11:53:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Get_Certificates] 
	@UserID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DECLARE @IsAdmin INT = 0

	SELECT @IsAdmin = t.IsAdmin FROM vw_User_info t where t.UserId = @UserID

	IF (@IsAdmin =1)
		BEGIN
			SELECT t.[CertificateId]
				  ,t.[UserId]
				  ,t.[Path]
				  ,t.[UploadedDt]
				  ,u.Full_Name
			  FROM [dbo].[Certificates] t
			  INNER JOIN [dbo].[vw_User_info] u on t.[UserId] = u.[UserId]
		END
	ELSE
		BEGIN
	
			SELECT t.[CertificateId]
				  ,t.[UserId]
				  ,t.[Path]
				  ,t.[UploadedDt]
				  ,u.Full_Name
			  FROM [dbo].[Certificates] t
			  INNER JOIN [dbo].[vw_User_info] u on t.[UserId] = u.[UserId]
			  WHERE t.UserId = @UserID
		END



END
GO
/****** Object:  StoredProcedure [dbo].[Get_EmailContent]    Script Date: 21-06-2021 11:53:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
--Get_EmailContent 1,0,0,'NewUserRegistration'
CREATE PROCEDURE [dbo].[Get_EmailContent] 
	@UserId int = 0,
	@ProposalId int,
	@SaleId int,
	@Category VARCHAR(50)
AS
BEGIN

	SET fmtonly OFF   

	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    DECLARE @UserName NVARCHAR(100)
    DECLARE @intro NVARCHAR(MAX)
    DECLARE @body NVARCHAR(MAX)
	DECLARE @ActionName NVARCHAR(25)
    DECLARE @ShareDescription NVARCHAR(100)
    DECLARE @NumberOfShares NVARCHAR(100)
    DECLARE @UnitPrice NVARCHAR(100)
    DECLARE @SaleCreatedDate NVARCHAR(100)
    DECLARE @BidderName NVARCHAR(100)
    DECLARE @ShareHolderName NVARCHAR(100)
    DECLARE @BidUnit NVARCHAR(100)
    DECLARE @BidPrice NVARCHAR(100)
    DECLARE @BidDate NVARCHAR(100)
	DECLARE @SaleCreatedBy INT
	DECLARE @BidCreatedBy INT
	DECLARE @EmailAddress NVARCHAR(100)
	DECLARE @EmailSubject NVARCHAR(100)
	DECLARE @Random	NVARCHAR(500)
	DECLARE @Password NVARCHAR(100)
		
	DECLARE @First_Name NVARCHAR(100)
	DECLARE @Last_Name NVARCHAR(100)
	DECLARE @Contact_Number NVARCHAR(100)
	DECLARE @UserEmailAddress NVARCHAR(100)

	DECLARE @PurchaseInterestShare BIGINT
	DECLARE @PurchaseInterestPrice DECIMAL


	DECLARE @IsLocal BIT = 0
	DECLARE @Url NVARCHAR(50) = 'http://shailshiptrade.com/'

	IF (@IsLocal = 0 )
	BEGIN
		SET @Url = 'http://localhost:4200/'
	END

	
				SELECT @Random = CONVERT(NVARCHAR(255), NEWID())

				SELECT @UserName = t.First_Name, 
				@EmailAddress = T.Email_Address,
				@UserEmailAddress = T.Email_Address,
				@Password = t.[Password],  
				@First_Name = t.First_Name,
				@Last_Name = t.Last_Name,
				@Contact_Number = t.Contact_Number
				FROM vw_User_info t WHERE t.UserId = @UserId;



	IF(@UserId != 0 AND @Category='ForgotPassword' )
		BEGIN
				SELECT @body = [Content] FROM [dbo].[Email_Template] WHERE Category='ForgotPassword'


				SET @ActionName ='Login'
				SET @intro='Your Password is : ' + @Password 
				SELECT @body = REPLACE (@body,'$Introduction$',@intro)
				SELECT @body = REPLACE (@body,'$UserFirstName$',@UserName)
				SELECT @body = REPLACE (@body,'$ActionName$',@ActionName)
				SELECT @body = REPLACE (@body,'$random$',@Random)
				SET @EmailSubject ='SHail Share Management System'

		END

	ELSE IF (@Category='NewSale')
		BEGIN
		SELECT @body = [Content] FROM [dbo].[Email_Template] WHERE Category='NewSale'
						
				SELECT 
					@NumberOfShares = t.NumberOfShares,
					@UnitPrice = t.UnitPrice,
					@SaleCreatedDate = CAST(t.CreatedDt AS NVARCHAR),
					@SaleCreatedBy = t.CreatedBy
				FROM [dbo].[Sale_Details] t JOIN
				[dbo].[Share_Details] u ON t.ShareDetailsId = u.ShareDetailsId
				WHERE t.SaleId = @SaleId
				
				SET @ActionName ='View Sales'
				SET @intro='A new sale has been submitted. Please see the details of the sale below,'

				SELECT @body = REPLACE (@body,'$Introduction$',@intro)
				SELECT @body = REPLACE (@body,'$ActionName$',@ActionName)
				SELECT @body = REPLACE (@body,'$random$',@Random)
				SELECT @body = REPLACE (@body,'$NUmberOfShares$',@NumberOfShares)
				SELECT @body = REPLACE (@body,'$UnitPrice$',@UnitPrice)
				SELECT @body = REPLACE (@body,'$SaleCreatedDate$',@SaleCreatedDate)
				SELECT @body = REPLACE (@body,'$url$',@Url)

				 
				SET @EmailSubject ='SHail Share Management System - New Sale'
			
		END

	ELSE IF (@Category='PurchaseInterest')
		BEGIN

		SELECT @body = [Content] FROM [dbo].[Email_Template] WHERE Category='PurchaseInterest'

		SELECT 
				@PurchaseInterestShare = Share, 
				@PurchaseInterestPrice = Price FROM [dbo].[Purchase_Interest_Notification] WHERE CreatedBy = @UserId						
				
				IF @PurchaseInterestShare = 0
					BEGIN
						SELECT @body = REPLACE (@body,'$InterestedShare$','Not given') 
					END
				ELSE
					SELECT @body = REPLACE (@body,'$InterestedShare$',@PurchaseInterestShare) 

				IF @PurchaseInterestPrice = 0
					BEGIN
						SELECT @body = REPLACE (@body,'$InterestedPrice$','Not given') 
					END
				ELSE
					SELECT @body = REPLACE (@body,'$InterestedPrice$',@PurchaseInterestPrice) 

				SET @ActionName ='Login'
				SET @intro= @UserName + ' has submitted an interest to purchase shares.'
				SELECT @body = REPLACE (@body,'$Introduction$',@intro)
				SELECT @body = REPLACE (@body,'$ActionName$',@ActionName)
				SELECT @body = REPLACE (@body,'$random$',@Random)
				SELECT @body = REPLACE (@body,'$url$',@Url)

				 
				SET @EmailSubject ='SHail Share Management System - Buy Share'
			
		END
	ELSE IF (@Category='NewUserRegistration')
		BEGIN
		SELECT @body = [Content] FROM [dbo].[Email_Template] WHERE Category='NewUserRegistration'
						
				
				SET @ActionName ='Login'
				SET @intro= 'Your registraion was successful. '
				SELECT @body = REPLACE (@body,'$Introduction$',@intro)
				SELECT @body = REPLACE (@body,'$ActionName$',@ActionName)
				SELECT @body = REPLACE (@body,'$random$',@Random)
				SELECT @body = REPLACE (@body,'$url$',@Url)
				SELECT @body = REPLACE (@body,'$UserFirstName$',@UserName)

				 
				SET @EmailSubject ='SHail Share Management System - Buy Share'
			
		END
	ELSE IF (@Category='NewUser')
		BEGIN
		SELECT @body = [Content] FROM [dbo].[Email_Template] WHERE Category='NewUser'					
				
				SELECT @EmailAddress = T.Email_Address  FROM vw_User_info t WHERE t.IsAdmin = 1 

				SET @ActionName ='Login'
				SET @intro= @UserName + ' has registered in the applciation.'

				SELECT @body = REPLACE (@body,'$Introduction$',@intro)
				SELECT @body = REPLACE (@body,'$ActionName$',@ActionName)
				SELECT @body = REPLACE (@body,'$random$',@Random)
				
				SELECT @body = REPLACE (@body,'$UserFirstName$','Admin')
				SELECT @body = REPLACE (@body,'$FirstName$',@First_Name)				
				SELECT @body = REPLACE (@body,'$LastName$',@Last_Name)				
				SELECT @body = REPLACE (@body,'$EmailAddress$',@UserEmailAddress)				
				SELECT @body = REPLACE (@body,'$ConactNumber$',@Contact_Number)

				SELECT @body = REPLACE (@body,'$url$',@Url)



				 
				SET @EmailSubject ='SHail Share Management System - New User'
			
		END
	ELSE IF (@Category='NewUserToClient')--Email to registered user
		BEGIN
		SELECT @body = [Content] FROM [dbo].[Email_Template] WHERE Category='NewUserToClient'					
				
				
				SET @ActionName ='Login'
				SET @intro= 'Your registration was successfull. Your registration request has already sent to Admin for approval.'

				SELECT @body = REPLACE (@body,'$UserFirstName$',@UserName)
				SELECT @body = REPLACE (@body,'$Introduction$',@intro)
				SELECT @body = REPLACE (@body,'$ActionName$',@ActionName)
				SELECT @body = REPLACE (@body,'$random$',@Random)				

				SELECT @body = REPLACE (@body,'$url$',@Url)

				 
				SET @EmailSubject ='SHail Share Management System - Your Profile'
			
		END
	ELSE IF (@Category='AdminApprovedUser')
		BEGIN
		SELECT @body = [Content] FROM [dbo].[Email_Template] WHERE Category='AdminApprovedUser'					
				
				
				SET @ActionName ='Login'
				SET @intro= 'Admin has approved your profile. Please login to the application with your credentials'

				SELECT @body = REPLACE (@body,'$UserFirstName$',@UserName)
				SELECT @body = REPLACE (@body,'$Introduction$',@intro)
				SELECT @body = REPLACE (@body,'$ActionName$',@ActionName)
				SELECT @body = REPLACE (@body,'$random$',@Random)				

				SELECT @body = REPLACE (@body,'$url$',@Url)

				 
				SET @EmailSubject ='SHail Share Management System - Your Profile'
			
		END

	ELSE IF (@Category='AdminRejectedUser')
		BEGIN
		SELECT @body = [Content] FROM [dbo].[Email_Template] WHERE Category='AdminRejectedUser'					
				
				SET @ActionName ='Login'
				SET @intro= 'Admin has rejected/disabled your profile. You will not be able to login to the application now onwards.'

				SELECT @body = REPLACE (@body,'$UserFirstName$',@UserName)
				SELECT @body = REPLACE (@body,'$Introduction$',@intro)
				SELECT @body = REPLACE (@body,'$ActionName$',@ActionName)
				SELECT @body = REPLACE (@body,'$random$',@Random)				

				SELECT @body = REPLACE (@body,'$url$',@Url)

				 
				SET @EmailSubject ='SHail Share Management System - Your Profile'
			
		END
	
	ELSE IF (@Category = 'BidApprovedToAdmin' )		
		BEGIN
			   SELECT @body = [Content] FROM [dbo].[Email_Template] WHERE Category='BidShareHolderApproveToAdmin'

				SELECT 
				    @ShareHolderName = z.Full_Name,
					@NumberOfShares = t.NumberOfShares,
					@UnitPrice = t.UnitPrice,
					@SaleCreatedDate = CAST(t.CreatedDt AS NVARCHAR),
					@SaleCreatedBy = t.CreatedBy
				FROM [dbo].[Sale_Details] t JOIN
				[dbo].[Share_Details] u ON t.ShareDetailsId = u.ShareDetailsId
				JOIN [dbo].[vw_User_info] z 
				ON t.CreatedBy =  z.UserId
				WHERE t.SaleId = @SaleId
	
				SELECT 
					@BidderName = U.Full_Name,
					@BidUnit = t.BidUnit,
					@BidPrice = t.BidPrice,
					@BidDate = CAST(t.CreatedDt AS NVARCHAR),
					@BidCreatedBy = t.CreatedBy
				FROM [dbo].[Proposal_Details] t
				JOIN [dbo].[vw_User_info] u 
				ON t.CreatedBy =  u.UserId
				WHERE t.ProposalId = @ProposalId

				SELECT @UserName = t.First_Name  FROM vw_User_info t WHERE t.UserId = @BidCreatedBy
				SET @intro = 'A bid has been approved by shareholder. Please find below the sale details and bid details.' 
				SET @ActionName ='Login'
				SET @EmailSubject ='SHail Share Management System - Your bid was approved'								
				SELECT  @UserName = 'Admin', @EmailAddress = T.Email_Address  FROM vw_User_info t WHERE t.UserId = 1 --Admin details
				
				SELECT @body = REPLACE (@body,'$UserFirstName$',@UserName)
				 --SELECT @body = REPLACE (@body,'$ShareDescription$',@ShareDescription)
				 SELECT @body = REPLACE (@body,'$NUmberOfShares$',@NumberOfShares)
				 SELECT @body = REPLACE (@body,'$UnitPrice$',@UnitPrice)
				 SELECT @body = REPLACE (@body,'$SaleCreatedDate$',@SaleCreatedDate)
				 SELECT @body = REPLACE (@body,'$BidderName$',@BidderName)
				 SELECT @body = REPLACE (@body,'$ShareHolderName$',@ShareHolderName)
				 SELECT @body = REPLACE (@body,'$BidUnit$',@BidUnit)
				 SELECT @body = REPLACE (@body,'$BidPrice$',@BidPrice)
				 SELECT @body = REPLACE (@body,'$BidDate$',@BidDate)
				 SELECT @body = REPLACE (@body,'$Introduction$',@intro)
				 SELECT @body = REPLACE (@body,'$ActionName$',@ActionName)
				 SELECT @body = REPLACE (@body,'$random$',@Random)
				 SELECT @body = REPLACE (@body,'$url$',@Url)
		END
	ELSE
		BEGIN

				SELECT @body = [Content] FROM [dbo].[Email_Template] WHERE Category='Bid'

				SELECT 
					@ShareHolderName = z.Full_Name,
					@NumberOfShares = t.NumberOfShares,
					@UnitPrice = t.UnitPrice,
					@SaleCreatedDate = CAST(t.CreatedDt AS NVARCHAR),
					@SaleCreatedBy = t.CreatedBy
				FROM [dbo].[Sale_Details] t 
				JOIN [dbo].[Share_Details] u ON t.ShareDetailsId = u.ShareDetailsId				
				JOIN [dbo].[vw_User_info] z ON t.CreatedBy =  z.UserId
				WHERE t.SaleId = @SaleId
	
				SELECT 
					@BidderName = U.Full_Name,
					@BidUnit = t.BidUnit,
					@BidPrice = t.BidPrice,
					@BidDate = CAST(t.CreatedDt AS NVARCHAR),
					@BidCreatedBy = t.CreatedBy
				FROM [dbo].[Proposal_Details] t
				JOIN [dbo].[vw_User_info] u 
				ON t.CreatedBy =  u.UserId
				WHERE t.ProposalId = @ProposalId
	  
				 IF(@Category = 'BidSubmitted' )			
							BEGIN
								SELECT @UserName = t.First_Name, @EmailAddress = T.Email_Address  FROM vw_User_info t WHERE t.UserId = @SaleCreatedBy
								SET @intro='A bid has been submitted against your sale. Please find below the sale details and bid details.' 
								SET @ActionName ='Approve/Reject Bid'
								SET @EmailSubject ='SHail Share Management System - Bid has been submitted for your sale'
							END
				 ELSE IF (@Category = 'BidApproved' )		
							BEGIN
								SELECT @UserName = t.First_Name, @EmailAddress = T.Email_Address  FROM vw_User_info t WHERE t.UserId = @BidCreatedBy
								SET @intro='Your bid has been approved by '+@ShareHolderName+'. Please find below the sale details and bid details.' 
								SET @ActionName ='View Bid Details'
								SET @EmailSubject ='SHail Share Management System - Your bid was approved'
							END
				 ELSE IF (@Category = 'BidApprovedToSeller' )		
							BEGIN
								SELECT @UserName = t.First_Name, @EmailAddress = T.Email_Address  FROM vw_User_info t WHERE t.UserId = @SaleCreatedBy
								SET @intro='Please contact shailship office for further transactions. contact no: +974 77998131. Please find below the sale details and bid details.' 
								SET @ActionName ='Login'
								SET @EmailSubject ='SHail Share Management System - Bid Approved Successfully.'
							END
				 ELSE IF (@Category = 'BidRejected' )		
							BEGIN
								SELECT @UserName = t.First_Name, @EmailAddress = T.Email_Address  FROM vw_User_info t WHERE t.UserId = @BidCreatedBy
								SET @intro='Your bid has been rejected by shareholder. Please find below the sale details and bid details.' 
								SET @ActionName ='View Rejection Reason'
								SET @EmailSubject ='SHail Share Management System - Your bid was rejected'
							END	 
				ELSE IF (@Category = 'AdminApprovedBuyer' )		
							BEGIN
								SELECT @UserName = t.First_Name, @EmailAddress = T.Email_Address  FROM vw_User_info t WHERE t.UserId = @BidCreatedBy
								SET @intro='Your bid has been approved by Admin. Please find below the sale details and bid details.' 
								SET @ActionName ='View Bid Details'
								SET @EmailSubject ='SHail Share Management System - Your bid was approved'
							END
				ELSE IF (@Category = 'AdminApprovedSeller' )		
							BEGIN
								SELECT @UserName = t.First_Name, @EmailAddress = T.Email_Address  FROM vw_User_info t WHERE t.UserId = @SaleCreatedBy
								SET @intro='Your sale has been approved by Admin. Please find below the sale details and bid details.' 
								SET @ActionName ='View Bid Details'
								SET @EmailSubject ='SHail Share Management System - Your bid was approved'
							END
				ELSE IF (@Category = 'AdminRejectedBuyer' )		
							BEGIN
								SELECT @UserName = t.First_Name, @EmailAddress = T.Email_Address  FROM vw_User_info t WHERE t.UserId = @BidCreatedBy
								SET @intro='Your bid has been rejected by Admin. Please find below the sale details and bid details.' 
								SET @ActionName ='View Rejection Reason'
								SET @EmailSubject ='SHail Share Management System - Your bid was rejected'
							END	 
				ELSE IF (@Category = 'AdminRejectedSeller' )		
							BEGIN
								SELECT @UserName = t.First_Name, @EmailAddress = T.Email_Address  FROM vw_User_info t WHERE t.UserId = @SaleCreatedBy
								SET @intro='Your sale has been rejected by Admin. Please find below the sale details and bid details.' 
								SET @ActionName ='View Rejection Reason'
								SET @EmailSubject ='SHail Share Management System - Your bid was rejected'
							END	 	 
							
				
				 SELECT @body = REPLACE (@body,'$UserFirstName$',@UserName)
				 --SELECT @body = REPLACE (@body,'$ShareDescription$',@ShareDescription)
				 SELECT @body = REPLACE (@body,'$NUmberOfShares$',@NumberOfShares)
				 SELECT @body = REPLACE (@body,'$UnitPrice$',@UnitPrice)
				 SELECT @body = REPLACE (@body,'$SaleCreatedDate$',@SaleCreatedDate)
				 SELECT @body = REPLACE (@body,'$BidderName$',@BidderName)
				 SELECT @body = REPLACE (@body,'$BidUnit$',@BidUnit)
				 SELECT @body = REPLACE (@body,'$BidPrice$',@BidPrice)
				 SELECT @body = REPLACE (@body,'$BidDate$',@BidDate)
				 SELECT @body = REPLACE (@body,'$Introduction$',@intro)
				 SELECT @body = REPLACE (@body,'$ActionName$',@ActionName)
				 SELECT @body = REPLACE (@body,'$random$',@Random)
				 SELECT @body = REPLACE (@body,'$url$',@Url)
		END
	

	 SELECT @body AS EmailContent, @EmailAddress AS ToAddress, @EmailSubject AS EmailSubject
END
GO
/****** Object:  StoredProcedure [dbo].[Get_Purchase_Interest_Notification]    Script Date: 21-06-2021 11:53:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
-- [Get_Purchase_Interest_Notification] 2
CREATE PROCEDURE [dbo].[Get_Purchase_Interest_Notification] 
	@UserId INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @text VARCHAR(MAX) 

	SELECT 
		t.[NotificationId],
		u.Full_Name COLLATE Latin1_General_CI_AI+' (Contact Number '+u.Contact_Number+') has submitted an interest to purchase shares on '
		+convert(varchar(20),t.[CreatedDt],107)+'. Request will expire in ' +CAST (DATEDIFF(DAY, CONVERT(DATE,t.[CreatedDt] + 5), CONVERT(DATE,GETDATE())) AS VARCHAR)+' days'   AS NotificationText, 
		t.[CreatedDt] 
	FROM [dbo].[Purchase_Interest_Notification] t
	INNER JOIN vw_User_info u on t.[CreatedBy] = u.UserId
	WHERE t.[CreatedBy] != @UserId
	AND CONVERT(DATE,t.[CreatedDt] + 5)  >= CONVERT(DATE, GETDATE())
	ORDER BY t.[CreatedDt]  DESC

END
GO
/****** Object:  StoredProcedure [dbo].[Get_Quorum]    Script Date: 21-06-2021 11:53:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Get_Quorum]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DECLARE @PersonallyAttended INT = 0
	DECLARE @ProvidedProxy INT = 0
	DECLARE @TotalAttendance INT = 0
	DECLARE @Quorum VARCHAR(100) ='0%'

	SELECT @ProvidedProxy = COUNT(1)
	FROM [ShareTrade].[dbo].[Quorum] WHERE isProxy = 1

	SELECT @PersonallyAttended = COUNT(1)
	FROM [ShareTrade].[dbo].[Quorum] WHERE isProxy = 0

	
	SELECT @TotalAttendance = COUNT(1)
	FROM [ShareTrade].[dbo].[Quorum]

	
	SELECT @Quorum = SUM(CAST(replace ([SharePercentage],'%','') AS decimal(12,5)))
	FROM [ShareTrade].[dbo].[Quorum] 

	SELECT 
	@ProvidedProxy AS ProvidedProxy,
	@PersonallyAttended AS PersonallyAttended,
	@TotalAttendance AS TotalAttendance,
	@Quorum AS Quorum



END
GO
/****** Object:  StoredProcedure [dbo].[Get_SaleBidDetails]    Script Date: 21-06-2021 11:53:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Get_SaleBidDetails]
	-- Add the parameters for the stored procedure here
	@SaleId int = 0
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here

		SELECT [ProposalId]
			  ,PD.[SaleId]
			  ,PD.[BidPrice]
			  ,PD.[BidUnit]
			  ,Sale.[NumberOfShares]
			  ,Sale.[UnitPrice]
			  ,Sale.ValidTo
			  ,Share.[Description] AS ShareDescription
			  ,PD.[CreatedDt]
			  ,PD.[CreatedBy]
			  ,PD.[UpdatedDt]
			  ,PD.[UpdatedBy]
			  ,PD.[Status]
			  ,PS.StatusDescription AS StatusDescription
			  ,PD.[StatusComments]
			  ,CreatedByUser.Full_Name AS [CreatedBy_string]
			  ,UpdatedByUser.Full_Name AS [UpdatedBy_string]
			  ,SaleUser.Contact_Number as ShareholderContactNumber
		  FROM [dbo].[Proposal_Details] PD
		  INNER JOIN [dbo].[Proposal_Status] PS ON PS.StatusId = PD.[Status]
		  INNER JOIN [dbo].[Sale_Details] Sale ON PD.SaleId = Sale.SaleId
		  INNER JOIN [dbo].[Share_Details] Share ON Share.ShareDetailsId = Sale.ShareDetailsId
		  LEFT JOIN [dbo].[vw_User_info] CreatedByUser ON CreatedByUser.UserId = PD.CreatedBy
		  LEFT JOIN [dbo].[vw_User_info] UpdatedByUser ON UpdatedByUser.UserId = PD.UpdatedBy
		  LEFT JOIN [dbo].[vw_User_info] SaleUser ON SaleUser.UserId = Sale.CreatedBy
		  WHERE  PD.[IsActive] = 1
		  AND PD.SaleId = 
							CASE WHEN @SaleId <> 0 THEN @SaleId
							ELSE PD.SaleId
							END


END

GO
/****** Object:  StoredProcedure [dbo].[Get_SaleDetails]    Script Date: 21-06-2021 11:53:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
--[dbo].[Get_SaleDetails]  0,34
CREATE PROCEDURE [dbo].[Get_SaleDetails]  
	@Sale_Id int = 0,
	@CreatedBy int = 0
AS
BEGIN
	SET fmtonly OFF   
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @isAdmin BIT
	SELECT @isAdmin = t.IsAdmin FROM vw_User_info t WHERE t.UserId = @CreatedBy
	IF (@isAdmin = 1)
		BEGIN
			SET @CreatedBy = 0
			SET @Sale_Id = 0
			SELECT 
					   Sale.SaleId AS SaleId
					  ,Sale.ShareDetailsId AS ShareDetailsId
					  ,0 as ProposalId
					  ,Sale.SaleRemarks AS SaleRemarks
					  ,Sale.NumberOfShares AS NumberOfShares
					  ,Sale.UnitPrice AS ShareUnitPrice
					  ,Sale.[Status] AS ApplicationStatus
					  ,Sale.StatusComments AS ApplicationStatusComments
					  ,Sale.IsNegotiable AS IsNegotiable
					  ,Sale.ValidTo
					  ,SS.StatusDescription AS StatusDescription
					  ,SD.AvailableShares AS AvailableShares
					  ,SD.[Description] AS ShareDescription
					  ,Sale.CreatedDt AS SaleCreatedDt
					  ,Sale.UpdatedDt AS SaleUpdatedDt
					  ,SD.CreatedDt AS ShareCreatedDt
					  ,CreatedByUser.Full_Name AS SaleCreatedBy
					  ,CreatedByUser.Contact_Number AS SellerContactNumber
					  ,UpdatedByUser.Full_Name AS SaleUpdatedBy	  
					  ,ShareDetailsCreatedByUser.Full_Name AS ShareCreatedBy  
					  ,0 AS BidCount
					  ,sale.CreatedBy
					  ,sale.UpdatedBy
					  ,CreatedByUser.Contact_Number AS ShareholderContactNumber
				  FROM [dbo].[Sale_Details] Sale 
				  INNER join [dbo].[Share_Details] SD ON Sale.ShareDetailsId = SD.ShareDetailsId
				  INNER join [dbo].[Sale_Status] SS ON Sale.Status = SS.StatusId
				  --LEFT JOIN [dbo].[Proposal_Details] PD on PD.SaleId = Sale.SaleId
				  LEFT JOIN [dbo].[vw_User_info] CreatedByUser ON CreatedByUser.UserId = Sale.CreatedBy
				  LEFT JOIN [dbo].[vw_User_info] UpdatedByUser ON UpdatedByUser.UserId = Sale.UpdatedBy
				  LEFT JOIN [dbo].[vw_User_info] ShareDetailsCreatedByUser ON ShareDetailsCreatedByUser.UserId = SD.CreatedBy
				  WHERE Sale.IsActive = 1 
				  AND CONVERT(DATE,Sale.ValidTo) >= CONVERT(DATE,GETDATE())
				  AND SD.IsActive = 1
		END
	ELSE
		BEGIN
			SELECT 
					   Sale.SaleId AS SaleId
					  ,Sale.ShareDetailsId AS ShareDetailsId
					  ,0 as ProposalId
					  ,Sale.SaleRemarks AS SaleRemarks
					  ,Sale.NumberOfShares AS NumberOfShares
					  ,Sale.UnitPrice AS ShareUnitPrice
					  ,Sale.[Status] AS ApplicationStatus
					  ,Sale.StatusComments AS ApplicationStatusComments
					  ,Sale.IsNegotiable AS IsNegotiable	
					  ,Sale.ValidTo				  
					  ,SS.StatusDescription AS StatusDescription
					  ,SD.AvailableShares AS AvailableShares
					  ,SD.[Description] AS ShareDescription
					  ,Sale.CreatedDt AS SaleCreatedDt
					  ,Sale.UpdatedDt AS SaleUpdatedDt
					  ,SD.CreatedDt AS ShareCreatedDt
					  ,CreatedByUser.Full_Name AS SaleCreatedBy
					  ,CreatedByUser.Contact_Number AS SellerContactNumber
					  ,UpdatedByUser.Full_Name AS SaleUpdatedBy	  
					  ,ShareDetailsCreatedByUser.Full_Name AS ShareCreatedBy  
					  ,0 AS BidCount
					  ,sale.CreatedBy
					  ,sale.UpdatedBy
					  ,CreatedByUser.Contact_Number AS ShareholderContactNumber
				  FROM [dbo].[Sale_Details] Sale 
				  INNER join [dbo].[Share_Details] SD ON Sale.ShareDetailsId = SD.ShareDetailsId
				  INNER join [dbo].[Sale_Status] SS ON Sale.Status = SS.StatusId
				  --LEFT JOIN [dbo].[Proposal_Details] PD on PD.SaleId = Sale.SaleId
				  LEFT JOIN [dbo].[vw_User_info] CreatedByUser ON CreatedByUser.UserId = Sale.CreatedBy
				  LEFT JOIN [dbo].[vw_User_info] UpdatedByUser ON UpdatedByUser.UserId = Sale.UpdatedBy
				  LEFT JOIN [dbo].[vw_User_info] ShareDetailsCreatedByUser ON ShareDetailsCreatedByUser.UserId = SD.CreatedBy
				  WHERE Sale.IsActive = 1 
				  AND SD.IsActive = 1
				  AND Sale.Status !=3
				  AND Sale.SaleId = 
							CASE WHEN @Sale_Id <> 0 THEN @Sale_Id
							ELSE Sale.SaleId
							END				
				  AND Sale.CreatedBy = 
							CASE WHEN @CreatedBy <> 0 THEN @CreatedBy
							ELSE Sale.CreatedBy
							END
				 AND CONVERT(DATE,Sale.ValidTo) >= CONVERT(DATE,GETDATE())

		END
				
END
GO
/****** Object:  StoredProcedure [dbo].[Get_SaleDetails_Report]    Script Date: 21-06-2021 11:53:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
--[dbo].[Get_SaleDetails]  0,34
CREATE PROCEDURE [dbo].[Get_SaleDetails_Report]  
AS
BEGIN
	SET fmtonly OFF   
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT 
					   Sale.SaleId AS SaleId
					  
					  ,Sale.NumberOfShares AS NumberOfShares
					  ,Sale.UnitPrice AS UnitPrice
					  ,Sale.IsNegotiable AS PriceNegotiable
					  ,Sale.ValidTo AS ExpiryDate
					  ,Sale.StatusComments AS SaleStatus
					  ,SS.StatusDescription AS StatusDescription
					  ,Sale.CreatedDt AS SaleCreatedDate
					  ,Sale.UpdatedDt AS SaleUpdatedDate
					  ,CreatedByUser.Full_Name AS Seller
					  ,CreatedByUser.Contact_Number AS SellerContactNumber
					  ,Purchase.BidCount AS BidCount
				  FROM [dbo].[Sale_Details] Sale 
				  INNER join [dbo].[Share_Details] SD ON Sale.ShareDetailsId = SD.ShareDetailsId
				  INNER join [dbo].[Sale_Status] SS ON Sale.Status = SS.StatusId

				  LEFT JOIN ( SELECT PD.SaleId, COUNT(1) AS BidCount FROM [dbo].[Proposal_Details] PD GROUP BY PD.SaleId ) AS Purchase on Purchase.SaleId = Sale.SaleId

				  LEFT JOIN [dbo].[vw_User_info] CreatedByUser ON CreatedByUser.UserId = Sale.CreatedBy
				  LEFT JOIN [dbo].[vw_User_info] UpdatedByUser ON UpdatedByUser.UserId = Sale.UpdatedBy
				  LEFT JOIN [dbo].[vw_User_info] ShareDetailsCreatedByUser ON ShareDetailsCreatedByUser.UserId = SD.CreatedBy
				  WHERE Sale.IsActive = 1 
				  AND SD.IsActive = 1
				
END
GO
/****** Object:  StoredProcedure [dbo].[Get_SaleDetails_v1]    Script Date: 21-06-2021 11:53:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Get_SaleDetails_v1]  
	@Sale_Id int = 0,
	@CreatedBy int = 0
AS
BEGIN
	SET fmtonly OFF   
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @isAdmin BIT
	SELECT @isAdmin = t.IsAdmin FROM vw_User_info t WHERE t.UserId = @CreatedBy
	IF (@isAdmin = 1)
		BEGIN
			SET @CreatedBy = 0
			SET @Sale_Id = 0
		END
				SELECT 
					   Sale.SaleId AS SaleId
					  ,Sale.ShareDetailsId AS ShareDetailsId
					  ,0 as ProposalId
					  ,Sale.SaleRemarks AS SaleRemarks
					  ,Sale.NumberOfShares AS NumberOfShares
					  ,Sale.UnitPrice AS ShareUnitPrice
					  ,Sale.[Status] AS ApplicationStatus
					  ,Sale.StatusComments AS ApplicationStatusComments
					  ,SD.AvailableShares AS AvailableShares
					  ,SD.[Description] AS ShareDescription
					  ,Sale.CreatedDt AS SaleCreatedDt
					  ,Sale.UpdatedDt AS SaleUpdatedDt
					  ,SD.CreatedDt AS ShareCreatedDt
					  ,CreatedByUser.Full_Name AS SaleCreatedBy
					  ,UpdatedByUser.Full_Name AS SaleUpdatedBy	  
					  ,ShareDetailsCreatedByUser.Full_Name AS ShareCreatedBy  
					  ,0 AS BidCount
				  FROM [dbo].[Sale_Details] Sale 
				  INNER join [dbo].[Share_Details] SD ON Sale.ShareDetailsId = SD.ShareDetailsId
				  INNER join [dbo].[User] SaleCreatedBy ON SaleCreatedBy.UserId = Sale.CreatedBy
				  --LEFT JOIN [dbo].[Proposal_Details] PD on PD.SaleId = Sale.SaleId
				  LEFT JOIN [dbo].[vw_User_info] CreatedByUser ON CreatedByUser.UserId = Sale.CreatedBy
				  LEFT JOIN [dbo].[vw_User_info] UpdatedByUser ON UpdatedByUser.UserId = Sale.UpdatedBy
				  LEFT JOIN [dbo].[vw_User_info] ShareDetailsCreatedByUser ON ShareDetailsCreatedByUser.UserId = SD.CreatedBy
				  WHERE Sale.IsActive = 1 
				  AND SD.IsActive = 1
				  AND Sale.SaleId = 
							CASE WHEN @Sale_Id <> 0 THEN @Sale_Id
							ELSE Sale.SaleId
							END				
				  AND Sale.CreatedBy = 
							CASE WHEN @CreatedBy <> 0 THEN @CreatedBy
							ELSE Sale.CreatedBy
							END
END
GO
/****** Object:  StoredProcedure [dbo].[Get_ShareDetails]    Script Date: 21-06-2021 11:53:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Get_ShareDetails] 
@ShareId INT = 0,
@CreatedBy int = 0
AS
BEGIN
	SET fmtonly OFF   
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @isAdmin BIT
	DECLARE @QID  VARCHAR(100)
	SELECT @isAdmin = t.IsAdmin FROM vw_User_info t WHERE t.UserId = @CreatedBy

	IF (@isAdmin = 1)
		BEGIN
			
		SELECT share.[ShareDetailsId]
			  ,share.[AvailableShares]
			  ,share.[UserId]
			  ,share.[QID]
			  ,share.[UniqueID]
			  ,share.[Description]
			  ,share.[ShareholderID]
			  ,share.[CreatedDt]
			  ,share.[CreatedBy]
			  ,share.[UpdatedDt]
			  ,share.[UpdatedBy]
			  ,CreatedByUser.Full_Name AS ShareCreatedBy
			  ,UpdatedByUser.Full_Name AS ShareUpdatedBy
			  ,CASE WHEN U.Full_Name IS NULL THEN 'N/A' ELSE U.Full_Name END AS AssignedUser	  
		  FROM [dbo].[Share_Details] share
		  LEFT JOIN [dbo].[vw_User_info] U ON U.QID_Number = share.QID
		  LEFT JOIN [dbo].[vw_User_info] CreatedByUser ON CreatedByUser.UserId = share.CreatedBy
		  LEFT JOIN [dbo].[vw_User_info] UpdatedByUser ON UpdatedByUser.UserId = share.UpdatedBy
		  WHERE share.[IsActive] = 1
		  AND share.[ShareDetailsId] = 
							CASE WHEN @ShareId <> 0 THEN @ShareId
							ELSE share.[ShareDetailsId]
							END
		   AND share.[CreatedBy] = 
							CASE WHEN @CreatedBy <> 0 THEN @CreatedBy
							ELSE share.[CreatedBy]
							END
		END
	ELSE
		BEGIN
		
			SELECT @QID = t.QID_Number FROM vw_User_info t WHERE t.UserId = @CreatedBy

			SELECT share.[ShareDetailsId]
				  ,share.[AvailableShares]
				  ,share.[UserId]
				  ,share.[QID]
				  ,share.[UniqueID]
				  ,share.[Description]
				  ,share.[ShareholderID]
				  ,share.[CreatedDt]
				  ,share.[CreatedBy]
				  ,share.[UpdatedDt]
				  ,share.[UpdatedBy]
				  ,CreatedByUser.Full_Name AS ShareCreatedBy
				  ,UpdatedByUser.Full_Name AS ShareUpdatedBy
				  ,CASE WHEN U.Full_Name IS NULL THEN 'N/A' ELSE U.Full_Name END AS AssignedUser	  
			  FROM [dbo].[Share_Details] share
			  LEFT JOIN [dbo].[vw_User_info] U ON U.UserId = share.UserId
			  LEFT JOIN [dbo].[vw_User_info] CreatedByUser ON CreatedByUser.UserId = share.CreatedBy
			  LEFT JOIN [dbo].[vw_User_info] UpdatedByUser ON UpdatedByUser.UserId = share.UpdatedBy
			  WHERE share.[IsActive] = 1
			  AND share.[ShareDetailsId] = 
								CASE WHEN @ShareId <> 0 THEN @ShareId
								ELSE share.[ShareDetailsId]
								END
			   AND share.QID = @QID
		END



END
GO
/****** Object:  StoredProcedure [dbo].[Get_ShareSaleDetails]    Script Date: 21-06-2021 11:53:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Get_ShareSaleDetails] 
	@Application_Id int = 0
AS
BEGIN
	SET fmtonly OFF   
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

				SELECT 
					   AD.SaleId AS SaleId
					  ,SD.ShareDetailsId AS ShareDetailsId
					  ,PD.ProposalId AS ProposalId
					  ,AD.SaleRemarks AS ApplicationRemarks
					  ,AD.NumberOfShares AS NumberOfShares
					  ,AD.UnitPrice AS ShareUnitPrice
					  ,SD.Description AS ShareDescription
					  ,AD.Status AS ApplicationStatus
					  ,AD.StatusComments AS ApplicationStatusComments
					  ,PD.BidPrice AS BidPrice
					  ,PD.BidUnit AS BidUnit
					  ,PD.Status AS BidStatus
					  ,PD.StatusComments AS BidStatusComments
					  ,AD.CreatedDt AS SaleCreatedDt
					  ,AD.UpdatedDt AS SaleUpdatedDt
					  ,SD.CreatedDt AS ShareCreatedDt
					  ,PD.CreatedDt AS ProposalCreatedDt
					  ,U_AD.Full_Name AS SaleCreatedBy
					  ,U_AD_1.Full_Name AS SaleUpdatedBy	  
					  ,U_SD.Full_Name AS ShareCreatedBy  
					  ,U_PD.Full_Name AS ProposalCreatedBy
					  ,AD.ValidTo
				  FROM [dbo].[Sale_Details] AD 
				  INNER join [dbo].[Share_Details] SD ON AD.ShareDetailsId = SD.ShareDetailsId
				  LEFT JOIN [dbo].[Proposal_Details] PD ON AD.SaleId = PD.SaleId
				  INNER JOIN [dbo].[vw_User_info] U_AD ON U_AD.UserId = AD.CreatedBy
				  INNER JOIN [dbo].[vw_User_info] U_AD_1 ON U_AD_1.UserId = AD.UpdatedBy
				  INNER JOIN [dbo].[vw_User_info] U_SD ON U_SD.UserId = SD.CreatedBy
				  INNER JOIN [dbo].[vw_User_info] U_PD ON U_PD.UserId = PD.CreatedBy
				  WHERE AD.SaleId = 
							CASE WHEN @Application_Id <> 0 THEN @Application_Id
							ELSE AD.SaleId
							END
END
GO
/****** Object:  StoredProcedure [dbo].[Get_Summary]    Script Date: 21-06-2021 11:53:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
--Get_Summary 34
CREATE PROCEDURE [dbo].[Get_Summary] 
	-- Add the parameters for the stored procedure here
		@userId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @AvailableShares BIGINT
	DECLARE @SaleRegisteredForSale BIGINT
	DECLARE @QID BIGINT
	
	SELECT @QID = V.QID_Number FROM vw_User_info V WHERE V.UserId = @userId


	SELECT @AvailableShares = T.AvailableShares FROM Share_Details T WHERE T.QID = @QID

	SELECT @SaleRegisteredForSale = ISNULL(SUM(T.NumberOfShares),0) FROM Sale_Details T where t.CreatedBy = @userId and IsActive = 1

	SELECT @QID AS QID, ISNULL(@AvailableShares,0) AS AvailableShares, @SaleRegisteredForSale AS SaleRegisteredForSale

    
END
GO
/****** Object:  StoredProcedure [dbo].[Get_Summary_BidReceived]    Script Date: 21-06-2021 11:53:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Get_Summary_BidReceived] 
	-- Add the parameters for the stored procedure here
	@userID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here

			SELECT sale.[SaleId]
				  ,sale.[ShareDetailsId]
				  ,sale.[NumberOfShares]
				  ,sale.[UnitPrice]
				  ,sale.[SaleRemarks]
				  ,sale.[CreatedDt]
				  ,sale.[CreatedBy]
				  ,sale.[UpdatedDt]
				  ,sale.[UpdatedBy]
				  ,sale.[Status]
				  ,sale.[StatusComments]
				  ,sale.[IsActive]
				  ,sale.ValidTo
				  ,v.Full_Name AS BidderName
				  ,bid.BidPrice
				  ,v.Contact_Number AS BidderContactNumber
			  FROM [dbo].[Sale_Details] sale
			  INNER JOIN Proposal_Details bid on sale.SaleId = bid.SaleId
			  INNER JOIN vw_User_info v on v.UserId = bid.CreatedBy
			  WHERE sale.CreatedBy = @userID
			  AND bid.[Status] = 1 --Submitted
			  AND sale.[IsActive] = 1


END
GO
/****** Object:  StoredProcedure [dbo].[Get_Summary_BidSubmitted]    Script Date: 21-06-2021 11:53:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Get_Summary_BidSubmitted] 
	-- Add the parameters for the stored procedure here
	@userID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here

			SELECT [ProposalId]
				  ,t.[SaleId]
				  ,[BidPrice]
				  ,[BidUnit]
				  ,t.[CreatedDt]
				  ,t.[CreatedBy]
				  ,t.[UpdatedDt]
				  ,t.[UpdatedBy]
				  ,P.[StatusDescription]
				  ,t.[StatusComments]
				  ,t.[IsActive]
				  ,v.Full_Name AS ShareHolderName
			  FROM [dbo].[Proposal_Details] t 
			  INNER JOIN Sale_Details u on t.SaleId = u.SaleId
			  INNER JOIN vw_User_info v on v.UserId = u.CreatedBy
			  INNER JOIN Proposal_Status P ON P.StatusId = T.Status
			  WHERE t.CreatedBy = @userID 
			  AND t.IsActive = 1


END
GO
/****** Object:  StoredProcedure [dbo].[Get_UserList]    Script Date: 21-06-2021 11:53:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
--[dbo].[Get_UserList] 'admin','admin!'
CREATE PROCEDURE [dbo].[Get_UserList] 
	@userName VARCHAR(100) = NULL,
	@Password VARCHAR(100) = NULL
AS
BEGIN
	SET fmtonly OFF   
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	IF (@userName IS NULL OR @Password IS NULL)
		BEGIN
			SELECT UI.[UserInfoId]
					  ,UI.[UserId]
					  ,UI.[UserName]
					  ,UI.[Password]
					  ,UI.[IsAdmin]
					  ,UI.[First_Name]
					  ,UI.[Last_Name]
					  ,UI.[Full_Name]
					  ,UI.[Email_Address]
					  ,UI.[Contact_Number]
					  ,UI.[QID_Number]
					  ,UI.[Shareholder_ID]
					  ,UI.[CreatedDt]
					  ,UI.[CreatedBy]
					  ,UI.[UpdatedDt]
					  ,UI.[UpdatedBy]
					  ,Created_User.[First_Name] + Created_User.[Last_Name] AS [CreatedBy_Name]
					  ,Updated_User.[First_Name] + Updated_User.[Last_Name] AS [UpdatedBy_Name]
					  ,UI.[IsActive]
					  ,UI.IsAdminApproved
					  ,0 AS AvailableShares
				      FROM  [dbo].[vw_User_info] UI
				LEFT JOIN [dbo].[User_Info] Created_User on UI.[CreatedBy] =  Created_User.[UserId]
				LEFT JOIN [dbo].[User_Info] Updated_User on UI.[UpdatedBy] =  Updated_User.[UserId]
				WHERE UI.IsActive = 1
		END
	ELSE
		BEGIN

		DECLARE @UserId INT = 0;
		DECLARE @QID BIGINT = 0;
		DECLARE @ShareCount INT = 0;

		SELECT 
		@UserId = UI.[UserId],
		@QID = UI.QID_Number 
		FROM  [dbo].[vw_User_info] UI WHERE UI.UserName = @userName 
				AND UI.Password = @Password COLLATE SQL_Latin1_General_CP1_CS_AS				
				AND UI.IsActive = 1

		SELECT @ShareCount = T.AvailableShares FROM Share_Details T where t.QID = CAST(@QID AS VARCHAR)

			SELECT	   UI.[UserInfoId]
					  ,UI.[UserId]
					  ,UI.[UserName]
					  ,UI.[Password]
					  ,UI.[IsAdmin]
					  ,UI.[First_Name]
					  ,UI.[Last_Name]
					  ,UI.[Full_Name]
					  ,UI.[Email_Address]
					  ,UI.[Contact_Number]
					  ,UI.[QID_Number]
					  ,UI.[Shareholder_ID]
					  ,UI.[CreatedDt]
					  ,UI.[CreatedBy]
					  ,UI.[UpdatedDt]
					  ,UI.[UpdatedBy]
					  ,Created_User.[First_Name] + Created_User.[Last_Name] AS [CreatedBy_Name]
					  ,Updated_User.[First_Name] + Updated_User.[Last_Name] AS [UpdatedBy_Name]
					  ,UI.[IsActive]
					  ,UI.IsAdminApproved
					  ,ISNULL(@ShareCount,0) AS AvailableShares
				      FROM  [dbo].[vw_User_info] UI
				LEFT JOIN [dbo].[User_Info] Created_User on UI.[CreatedBy] =  Created_User.[UserId]
				LEFT JOIN [dbo].[User_Info] Updated_User on UI.[UpdatedBy] =  Updated_User.[UserId]
				WHERE UI.[UserId] = @UserId
		END

				
				
END
GO
