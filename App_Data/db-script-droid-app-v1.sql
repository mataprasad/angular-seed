USE [DbDroid]
GO
/****** Object:  Table [dbo].[Droid_Account]    Script Date: 03/19/2015 01:30:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Droid_Account](
	[ID] [uniqueidentifier] NOT NULL,
	[Name] [varchar](50) NULL,
	[Email] [varchar](50) NULL,
	[ContactNo] [varchar](50) NULL,
	[Owner] [uniqueidentifier] NULL,
 CONSTRAINT [PK_Droid_Accounts] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Droid_Transaction]    Script Date: 03/19/2015 01:30:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Droid_Transaction](
	[ID] [uniqueidentifier] NOT NULL,
	[Account] [uniqueidentifier] NULL,
	[Amount] [numeric](12, 2) NULL,
	[Effect] [int] NULL,
	[Date] [smalldatetime] NULL,
	[Remark] [varchar](250) NULL,
 CONSTRAINT [PK_Droid_Transaction] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Droid_Member]    Script Date: 03/19/2015 01:30:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Droid_Member](
	[ID] [uniqueidentifier] NOT NULL,
	[Name] [varchar](50) NULL,
	[Email] [varchar](50) NULL,
	[Password] [varchar](20) NULL,
	[Active] [bit] NULL,
	[CreatedOn] [smalldatetime] NULL,
 CONSTRAINT [PK_Droid_Member] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  View [dbo].[Droid_Data]    Script Date: 03/19/2015 01:30:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Droid_Data]
AS
SELECT     A.ID AS MembeID, A.Name, A.Email, A.Password, A.Active, A.CreatedOn, B.ID AS AccountID, B.Name AS Expr2, B.Email AS Expr3, B.ContactNo, B.Owner, C.ID AS TransactionID, C.Account, C.Amount, 
                      C.Effect, C.Date, C.Remark
FROM         dbo.Droid_Member AS A INNER JOIN
                      dbo.Droid_Account AS B ON A.ID = B.Owner LEFT OUTER JOIN
                      dbo.Droid_Transaction AS C ON C.Account = B.ID
GO
