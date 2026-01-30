USE [master];
GO

-- Nếu DB đã tồn tại thì xoá (tuỳ chọn: để tránh lỗi khi chạy lại)
IF DB_ID(N'FPTEventManagement') IS NOT NULL
BEGIN
    ALTER DATABASE [FPTEventManagement] SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE [FPTEventManagement];
END
GO

-- Tạo DB mới: KHÔNG chỉ định FILENAME để máy khác chạy được
CREATE DATABASE [FPTEventManagement]
CONTAINMENT = NONE;
GO

ALTER DATABASE [FPTEventManagement] SET COMPATIBILITY_LEVEL = 150;
GO

USE [FPTEventManagement];
GO

-- Fulltext (giữ nguyên logic của bạn)
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
BEGIN
    EXEC [FPTEventManagement].[dbo].[sp_fulltext_database] @action = 'enable';
END
GO

-- Các thiết lập DB (giữ nguyên như script của bạn)
ALTER DATABASE [FPTEventManagement] SET ANSI_NULL_DEFAULT OFF;
ALTER DATABASE [FPTEventManagement] SET ANSI_NULLS OFF;
ALTER DATABASE [FPTEventManagement] SET ANSI_PADDING OFF;
ALTER DATABASE [FPTEventManagement] SET ANSI_WARNINGS OFF;
ALTER DATABASE [FPTEventManagement] SET ARITHABORT OFF;
ALTER DATABASE [FPTEventManagement] SET AUTO_CLOSE OFF;
ALTER DATABASE [FPTEventManagement] SET AUTO_SHRINK OFF;
ALTER DATABASE [FPTEventManagement] SET AUTO_UPDATE_STATISTICS ON;
ALTER DATABASE [FPTEventManagement] SET CURSOR_CLOSE_ON_COMMIT OFF;
ALTER DATABASE [FPTEventManagement] SET CURSOR_DEFAULT  GLOBAL;
ALTER DATABASE [FPTEventManagement] SET CONCAT_NULL_YIELDS_NULL OFF;
ALTER DATABASE [FPTEventManagement] SET NUMERIC_ROUNDABORT OFF;
ALTER DATABASE [FPTEventManagement] SET QUOTED_IDENTIFIER OFF;
ALTER DATABASE [FPTEventManagement] SET RECURSIVE_TRIGGERS OFF;
ALTER DATABASE [FPTEventManagement] SET ENABLE_BROKER;
ALTER DATABASE [FPTEventManagement] SET AUTO_UPDATE_STATISTICS_ASYNC OFF;
ALTER DATABASE [FPTEventManagement] SET DATE_CORRELATION_OPTIMIZATION OFF;
ALTER DATABASE [FPTEventManagement] SET TRUSTWORTHY OFF;
ALTER DATABASE [FPTEventManagement] SET ALLOW_SNAPSHOT_ISOLATION OFF;
ALTER DATABASE [FPTEventManagement] SET PARAMETERIZATION SIMPLE;
ALTER DATABASE [FPTEventManagement] SET READ_COMMITTED_SNAPSHOT OFF;
ALTER DATABASE [FPTEventManagement] SET HONOR_BROKER_PRIORITY OFF;
ALTER DATABASE [FPTEventManagement] SET RECOVERY FULL;
ALTER DATABASE [FPTEventManagement] SET MULTI_USER;
ALTER DATABASE [FPTEventManagement] SET PAGE_VERIFY CHECKSUM;
ALTER DATABASE [FPTEventManagement] SET DB_CHAINING OFF;
ALTER DATABASE [FPTEventManagement] SET FILESTREAM(NON_TRANSACTED_ACCESS = OFF);
ALTER DATABASE [FPTEventManagement] SET TARGET_RECOVERY_TIME = 60 SECONDS;
ALTER DATABASE [FPTEventManagement] SET DELAYED_DURABILITY = DISABLED;
ALTER DATABASE [FPTEventManagement] SET ACCELERATED_DATABASE_RECOVERY = OFF;
GO

EXEC sys.sp_db_vardecimal_storage_format N'FPTEventManagement', N'ON';
GO

ALTER DATABASE [FPTEventManagement] SET QUERY_STORE = OFF;
GO

/****** Object:  Table [dbo].[Bill]    Script Date: 22/12/2025 2:25:25 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Bill](
	[bill_id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NOT NULL,
	[total_amount] [decimal](18, 2) NOT NULL,
	[currency] [nvarchar](10) NOT NULL,
	[payment_method] [nvarchar](50) NULL,
	[payment_status] [nvarchar](20) NOT NULL,
	[created_at] [datetime2](7) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[bill_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Category_Ticket]    Script Date: 22/12/2025 2:25:26 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Category_Ticket](
	[category_ticket_id] [int] IDENTITY(1,1) NOT NULL,
	[event_id] [int] NOT NULL,
	[name] [nvarchar](50) NOT NULL,
	[description] [nvarchar](255) NULL,
	[price] [decimal](18, 2) NOT NULL,
	[max_quantity] [int] NULL,
	[status] [nvarchar](20) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[category_ticket_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Event]    Script Date: 22/12/2025 2:25:26 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Event](
	[event_id] [int] IDENTITY(1,1) NOT NULL,
	[title] [nvarchar](200) NOT NULL,
	[description] [nvarchar](max) NULL,
	[start_time] [datetime2](7) NOT NULL,
	[end_time] [datetime2](7) NOT NULL,
	[speaker_id] [int] NULL,
	[max_seats] [int] NULL,
	[status] [nvarchar](20) NOT NULL,
	[created_by] [int] NULL,
	[created_at] [datetime2](7) NOT NULL,
	[area_id] [int] NULL,
	[banner_url] [nvarchar](500) NULL,
PRIMARY KEY CLUSTERED 
(
	[event_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Event_Request]    Script Date: 22/12/2025 2:25:26 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Event_Request](
	[request_id] [int] IDENTITY(1,1) NOT NULL,
	[requester_id] [int] NOT NULL,
	[title] [nvarchar](200) NOT NULL,
	[description] [nvarchar](max) NULL,
	[preferred_start_time] [datetime2](7) NULL,
	[preferred_end_time] [datetime2](7) NULL,
	[expected_capacity] [int] NULL,
	[status] [nvarchar](20) NOT NULL,
	[created_at] [datetime2](7) NOT NULL,
	[processed_by] [int] NULL,
	[processed_at] [datetime2](7) NULL,
	[organizer_note] [nvarchar](500) NULL,
	[created_event_id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[request_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Event_Seat_Layout]    Script Date: 22/12/2025 2:25:26 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Event_Seat_Layout](
	[event_id] [int] NOT NULL,
	[seat_id] [int] NOT NULL,
	[seat_type] [nvarchar](20) NOT NULL,
	[status] [nvarchar](20) NOT NULL,
 CONSTRAINT [PK_Event_Seat_Layout] PRIMARY KEY CLUSTERED 
(
	[event_id] ASC,
	[seat_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Report]    Script Date: 22/12/2025 2:25:26 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Report](
	[report_id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NOT NULL,
	[ticket_id] [int] NOT NULL,
	[title] [nvarchar](200) NULL,
	[description] [nvarchar](2000) NOT NULL,
	[image_url] [nvarchar](500) NULL,
	[created_at] [datetime2](7) NOT NULL,
	[status] [nvarchar](20) NOT NULL,
	[processed_by] [int] NULL,
	[processed_at] [datetime2](7) NULL,
	[refund_amount] [decimal](18, 2) NULL,
	[staff_note] [nvarchar](1000) NULL,
PRIMARY KEY CLUSTERED 
(
	[report_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Seat]    Script Date: 22/12/2025 2:25:26 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Seat](
	[seat_id] [int] IDENTITY(1,1) NOT NULL,
	[seat_code] [nvarchar](20) NOT NULL,
	[row_no] [nvarchar](10) NULL,
	[col_no] [nvarchar](10) NULL,
	[status] [nvarchar](20) NOT NULL,
	[area_id] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[seat_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Speaker]    Script Date: 22/12/2025 2:25:26 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Speaker](
	[speaker_id] [int] IDENTITY(1,1) NOT NULL,
	[full_name] [nvarchar](100) NOT NULL,
	[bio] [nvarchar](max) NULL,
	[email] [nvarchar](100) NULL,
	[phone] [nvarchar](20) NULL,
	[avatar_url] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[speaker_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Ticket]    Script Date: 22/12/2025 2:25:26 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ticket](
	[ticket_id] [int] IDENTITY(1,1) NOT NULL,
	[event_id] [int] NOT NULL,
	[user_id] [int] NOT NULL,
	[category_ticket_id] [int] NOT NULL,
	[bill_id] [int] NULL,
	[seat_id] [int] NULL,
	[qr_code_value] [nvarchar](max) NOT NULL,
	[qr_issued_at] [datetime2](7) NOT NULL,
	[status] [nvarchar](20) NOT NULL,
	[checkin_time] [datetime2](7) NULL,
	[check_out_time] [datetime2](7) NULL,
PRIMARY KEY CLUSTERED 
(
	[ticket_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 22/12/2025 2:25:26 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[user_id] [int] IDENTITY(1,1) NOT NULL,
	[full_name] [nvarchar](100) NOT NULL,
	[email] [nvarchar](100) NOT NULL,
	[phone] [nvarchar](20) NULL,
	[password_hash] [nvarchar](255) NOT NULL,
	[role] [nvarchar](20) NOT NULL,
	[status] [nvarchar](20) NOT NULL,
	[created_at] [datetime2](7) NOT NULL,
	[Wallet] [decimal](18, 2) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[user_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Venue]    Script Date: 22/12/2025 2:25:26 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Venue](
	[venue_id] [int] IDENTITY(1,1) NOT NULL,
	[venue_name] [nvarchar](200) NOT NULL,
	[location] [nvarchar](255) NULL,
	[status] [nvarchar](20) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[venue_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Venue_Area]    Script Date: 22/12/2025 2:25:26 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Venue_Area](
	[area_id] [int] IDENTITY(1,1) NOT NULL,
	[venue_id] [int] NOT NULL,
	[area_name] [nvarchar](200) NOT NULL,
	[floor] [nvarchar](50) NULL,
	[capacity] [int] NOT NULL,
	[status] [nvarchar](20) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[area_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Bill] ON 

INSERT [dbo].[Bill] ([bill_id], [user_id], [total_amount], [currency], [payment_method], [payment_status], [created_at]) VALUES (34, 7, CAST(100000.00 AS Decimal(18, 2)), N'VND', N'VNPAY', N'PAID', CAST(N'2025-12-11T09:02:10.9760000' AS DateTime2))
INSERT [dbo].[Bill] ([bill_id], [user_id], [total_amount], [currency], [payment_method], [payment_status], [created_at]) VALUES (38, 7, CAST(20000.00 AS Decimal(18, 2)), N'VND', N'VNPAY', N'PAID', CAST(N'2025-12-11T09:27:07.7390000' AS DateTime2))
INSERT [dbo].[Bill] ([bill_id], [user_id], [total_amount], [currency], [payment_method], [payment_status], [created_at]) VALUES (39, 1, CAST(10000.00 AS Decimal(18, 2)), N'VND', N'VNPAY', N'PAID', CAST(N'2025-12-11T10:08:16.9180000' AS DateTime2))
INSERT [dbo].[Bill] ([bill_id], [user_id], [total_amount], [currency], [payment_method], [payment_status], [created_at]) VALUES (40, 7, CAST(20000.00 AS Decimal(18, 2)), N'VND', N'VNPAY', N'PAID', CAST(N'2025-12-11T12:41:44.2710000' AS DateTime2))
INSERT [dbo].[Bill] ([bill_id], [user_id], [total_amount], [currency], [payment_method], [payment_status], [created_at]) VALUES (41, 7, CAST(10000.00 AS Decimal(18, 2)), N'VND', N'VNPAY', N'PAID', CAST(N'2025-12-11T12:50:43.9300000' AS DateTime2))
INSERT [dbo].[Bill] ([bill_id], [user_id], [total_amount], [currency], [payment_method], [payment_status], [created_at]) VALUES (42, 7, CAST(30000.00 AS Decimal(18, 2)), N'VND', N'VNPAY', N'PAID', CAST(N'2025-12-11T23:07:46.7160000' AS DateTime2))
INSERT [dbo].[Bill] ([bill_id], [user_id], [total_amount], [currency], [payment_method], [payment_status], [created_at]) VALUES (43, 7, CAST(30000.00 AS Decimal(18, 2)), N'VND', N'VNPAY', N'PAID', CAST(N'2025-12-12T08:25:45.3170000' AS DateTime2))
INSERT [dbo].[Bill] ([bill_id], [user_id], [total_amount], [currency], [payment_method], [payment_status], [created_at]) VALUES (44, 7, CAST(20000.00 AS Decimal(18, 2)), N'VND', N'VNPAY', N'PAID', CAST(N'2025-12-12T10:09:36.9330000' AS DateTime2))
INSERT [dbo].[Bill] ([bill_id], [user_id], [total_amount], [currency], [payment_method], [payment_status], [created_at]) VALUES (45, 7, CAST(200000.00 AS Decimal(18, 2)), N'VND', N'VNPAY', N'PAID', CAST(N'2025-12-12T13:25:19.6050000' AS DateTime2))
INSERT [dbo].[Bill] ([bill_id], [user_id], [total_amount], [currency], [payment_method], [payment_status], [created_at]) VALUES (46, 7, CAST(200000.00 AS Decimal(18, 2)), N'VND', N'VNPAY', N'PAID', CAST(N'2025-12-13T20:47:03.4360000' AS DateTime2))
INSERT [dbo].[Bill] ([bill_id], [user_id], [total_amount], [currency], [payment_method], [payment_status], [created_at]) VALUES (47, 7, CAST(30000.00 AS Decimal(18, 2)), N'VND', N'VNPAY', N'PAID', CAST(N'2025-12-15T10:11:31.1820000' AS DateTime2))
INSERT [dbo].[Bill] ([bill_id], [user_id], [total_amount], [currency], [payment_method], [payment_status], [created_at]) VALUES (48, 7, CAST(30000.00 AS Decimal(18, 2)), N'VND', N'VNPAY', N'PAID', CAST(N'2025-12-16T09:45:22.8110000' AS DateTime2))
INSERT [dbo].[Bill] ([bill_id], [user_id], [total_amount], [currency], [payment_method], [payment_status], [created_at]) VALUES (49, 7, CAST(200000.00 AS Decimal(18, 2)), N'VND', N'VNPAY', N'PAID', CAST(N'2025-12-16T09:49:56.4200000' AS DateTime2))
INSERT [dbo].[Bill] ([bill_id], [user_id], [total_amount], [currency], [payment_method], [payment_status], [created_at]) VALUES (50, 7, CAST(100000.00 AS Decimal(18, 2)), N'VND', N'VNPAY', N'PAID', CAST(N'2025-12-17T08:23:11.4270000' AS DateTime2))
INSERT [dbo].[Bill] ([bill_id], [user_id], [total_amount], [currency], [payment_method], [payment_status], [created_at]) VALUES (51, 7, CAST(20000.00 AS Decimal(18, 2)), N'VND', N'VNPAY', N'PAID', CAST(N'2025-12-18T21:34:26.3450000' AS DateTime2))
INSERT [dbo].[Bill] ([bill_id], [user_id], [total_amount], [currency], [payment_method], [payment_status], [created_at]) VALUES (52, 7, CAST(35000.00 AS Decimal(18, 2)), N'VND', N'VNPAY', N'PAID', CAST(N'2025-12-20T19:13:33.8650000' AS DateTime2))
INSERT [dbo].[Bill] ([bill_id], [user_id], [total_amount], [currency], [payment_method], [payment_status], [created_at]) VALUES (53, 7, CAST(50000.00 AS Decimal(18, 2)), N'VND', N'VNPAY', N'PAID', CAST(N'2025-12-20T19:24:22.9240000' AS DateTime2))
INSERT [dbo].[Bill] ([bill_id], [user_id], [total_amount], [currency], [payment_method], [payment_status], [created_at]) VALUES (54, 7, CAST(55000.00 AS Decimal(18, 2)), N'VND', N'VNPAY', N'PAID', CAST(N'2025-12-20T20:12:59.2090000' AS DateTime2))
INSERT [dbo].[Bill] ([bill_id], [user_id], [total_amount], [currency], [payment_method], [payment_status], [created_at]) VALUES (55, 7, CAST(190000.00 AS Decimal(18, 2)), N'VND', N'VNPAY', N'PAID', CAST(N'2025-12-21T21:07:10.8720000' AS DateTime2))
INSERT [dbo].[Bill] ([bill_id], [user_id], [total_amount], [currency], [payment_method], [payment_status], [created_at]) VALUES (56, 7, CAST(110000.00 AS Decimal(18, 2)), N'VND', N'VNPAY', N'PAID', CAST(N'2026-01-01T13:19:29.9170000' AS DateTime2))
INSERT [dbo].[Bill] ([bill_id], [user_id], [total_amount], [currency], [payment_method], [payment_status], [created_at]) VALUES (61, 10, CAST(140000.00 AS Decimal(18, 2)), N'VND', N'VNPAY', N'PAID', CAST(N'2025-12-22T00:06:10.5850000' AS DateTime2))
INSERT [dbo].[Bill] ([bill_id], [user_id], [total_amount], [currency], [payment_method], [payment_status], [created_at]) VALUES (62, 10, CAST(340000.00 AS Decimal(18, 2)), N'VND', N'VNPAY', N'PAID', CAST(N'2025-12-22T00:07:26.1400000' AS DateTime2))
INSERT [dbo].[Bill] ([bill_id], [user_id], [total_amount], [currency], [payment_method], [payment_status], [created_at]) VALUES (63, 7, CAST(340000.00 AS Decimal(18, 2)), N'VND', N'VNPAY', N'PAID', CAST(N'2025-12-22T07:07:55.2000000' AS DateTime2))
INSERT [dbo].[Bill] ([bill_id], [user_id], [total_amount], [currency], [payment_method], [payment_status], [created_at]) VALUES (64, 7, CAST(140000.00 AS Decimal(18, 2)), N'VND', N'VNPAY', N'PAID', CAST(N'2025-12-22T07:13:07.6980000' AS DateTime2))
INSERT [dbo].[Bill] ([bill_id], [user_id], [total_amount], [currency], [payment_method], [payment_status], [created_at]) VALUES (65, 7, CAST(140000.00 AS Decimal(18, 2)), N'VND', N'VNPAY', N'PAID', CAST(N'2025-12-22T07:18:41.5740000' AS DateTime2))
INSERT [dbo].[Bill] ([bill_id], [user_id], [total_amount], [currency], [payment_method], [payment_status], [created_at]) VALUES (66, 7, CAST(200000.00 AS Decimal(18, 2)), N'VND', N'VNPAY', N'PAID', CAST(N'2025-12-22T08:35:46.6160000' AS DateTime2))
INSERT [dbo].[Bill] ([bill_id], [user_id], [total_amount], [currency], [payment_method], [payment_status], [created_at]) VALUES (67, 7, CAST(6000000.00 AS Decimal(18, 2)), N'VND', N'VNPAY', N'PAID', CAST(N'2025-12-22T09:37:35.0370000' AS DateTime2))
INSERT [dbo].[Bill] ([bill_id], [user_id], [total_amount], [currency], [payment_method], [payment_status], [created_at]) VALUES (68, 7, CAST(6000000.00 AS Decimal(18, 2)), N'VND', N'VNPAY', N'PAID', CAST(N'2025-12-22T09:38:38.7340000' AS DateTime2))
SET IDENTITY_INSERT [dbo].[Bill] OFF
GO
SET IDENTITY_INSERT [dbo].[Category_Ticket] ON 

INSERT [dbo].[Category_Ticket] ([category_ticket_id], [event_id], [name], [description], [price], [max_quantity], [status]) VALUES (13, 7, N'VIP', N'VIP', CAST(100000.00 AS Decimal(18, 2)), 5, N'ACTIVE')
INSERT [dbo].[Category_Ticket] ([category_ticket_id], [event_id], [name], [description], [price], [max_quantity], [status]) VALUES (14, 7, N'STANDARD', N'Standard ', CAST(50000.00 AS Decimal(18, 2)), 45, N'ACTIVE')
INSERT [dbo].[Category_Ticket] ([category_ticket_id], [event_id], [name], [description], [price], [max_quantity], [status]) VALUES (15, 8, N'VIP', N'VIP', CAST(20000.00 AS Decimal(18, 2)), 30, N'ACTIVE')
INSERT [dbo].[Category_Ticket] ([category_ticket_id], [event_id], [name], [description], [price], [max_quantity], [status]) VALUES (16, 8, N'STANDARD', N'Standard ', CAST(10000.00 AS Decimal(18, 2)), 20, N'ACTIVE')
INSERT [dbo].[Category_Ticket] ([category_ticket_id], [event_id], [name], [description], [price], [max_quantity], [status]) VALUES (19, 10, N'VIP', N'IGHG', CAST(3999999.00 AS Decimal(18, 2)), 10, N'ACTIVE')
INSERT [dbo].[Category_Ticket] ([category_ticket_id], [event_id], [name], [description], [price], [max_quantity], [status]) VALUES (20, 10, N'STANDARD', N'FFF', CAST(12000.00 AS Decimal(18, 2)), 30, N'ACTIVE')
INSERT [dbo].[Category_Ticket] ([category_ticket_id], [event_id], [name], [description], [price], [max_quantity], [status]) VALUES (21, 17, N'VIP', N'Vé VIP bao gồm quyền ngồi hàng ghế đầu, tài liệu chuyên sâu nâng cao về xây dựng chatbot AI, voucher giảm 30% khóa học AI nâng cao, giấy chứng nhận VIP và cơ hội networking riêng với diễn giả sau sự kiện.', CAST(200000.00 AS Decimal(18, 2)), 30, N'INACTIVE')
INSERT [dbo].[Category_Ticket] ([category_ticket_id], [event_id], [name], [description], [price], [max_quantity], [status]) VALUES (22, 17, N'STANDARD', N'Tham dự workshop, nhận tài liệu cơ bản, tham gia thực hành xây dựng chatbot và nhận chứng nhận tham dự.', CAST(120000.00 AS Decimal(18, 2)), 30, N'INACTIVE')
INSERT [dbo].[Category_Ticket] ([category_ticket_id], [event_id], [name], [description], [price], [max_quantity], [status]) VALUES (23, 16, N'VIP', N'Bao gồm chỗ ngồi ưu tiên, tài liệu nâng cao về Python + AI (file PDF), 1 giờ mentoring online sau workshop, giấy chứng nhận VIP, và bộ notebook code mẫu độc quyền.', CAST(95000.00 AS Decimal(18, 2)), 10, N'ACTIVE')
INSERT [dbo].[Category_Ticket] ([category_ticket_id], [event_id], [name], [description], [price], [max_quantity], [status]) VALUES (24, 16, N'STANDARD', N'Tham dự workshop, nhận tài liệu cơ bản, tham gia thực hành viết Python và mô hình ML đơn giản, nhận chứng nhận tham dự.', CAST(50000.00 AS Decimal(18, 2)), 30, N'ACTIVE')
INSERT [dbo].[Category_Ticket] ([category_ticket_id], [event_id], [name], [description], [price], [max_quantity], [status]) VALUES (25, 15, N'VIP', N'Bao gồm quyền tham gia khu vực networking riêng với chuyên gia HR & Tech Recruiter, gói phân tích CV chi tiết, mock interview 1:1 miễn phí sau sự kiện, tài liệu hướng nghiệp nâng cao.', CAST(125000.00 AS Decimal(18, 2)), 10, N'INACTIVE')
INSERT [dbo].[Category_Ticket] ([category_ticket_id], [event_id], [name], [description], [price], [max_quantity], [status]) VALUES (26, 15, N'STANDARD', N'Tham dự hội thảo, được nghe chia sẻ từ các chuyên gia tuyển dụng, tham gia các phiên hỏi đáp, nhận bộ tài liệu "IT Career Handbook 2026".', CAST(100000.00 AS Decimal(18, 2)), 40, N'INACTIVE')
INSERT [dbo].[Category_Ticket] ([category_ticket_id], [event_id], [name], [description], [price], [max_quantity], [status]) VALUES (27, 14, N'VIP', N'Bao gồm chỗ ngồi ưu tiên, tài liệu Masterbook chuyên sâu, video khóa học “Art of Presentation”, 1 buổi coaching cá nhân 30 phút sau workshop, chứng nhận VIP.', CAST(30000.00 AS Decimal(18, 2)), 20, N'INACTIVE')
INSERT [dbo].[Category_Ticket] ([category_ticket_id], [event_id], [name], [description], [price], [max_quantity], [status]) VALUES (1021, 1014, N'VIP', N'Ngồi hàng đầu dễ dàng xem tranh, giao lưu với host', CAST(35000.00 AS Decimal(18, 2)), 40, N'ACTIVE')
INSERT [dbo].[Category_Ticket] ([category_ticket_id], [event_id], [name], [description], [price], [max_quantity], [status]) VALUES (1022, 1014, N'STANDARD', N'Ngồi ở vị trí xa khó quan sát được tranh', CAST(20000.00 AS Decimal(18, 2)), 40, N'ACTIVE')
INSERT [dbo].[Category_Ticket] ([category_ticket_id], [event_id], [name], [description], [price], [max_quantity], [status]) VALUES (1061, 1028, N'VIP', N'Ghế ngồi hàng đầu
Tài liệu workshop đầy đủ (PDF + source code)
Được hỏi đáp trực tiếp với diễn giả
Chứng nhận tham gia (Certificate)', CAST(200000.00 AS Decimal(18, 2)), 20, N'ACTIVE')
INSERT [dbo].[Category_Ticket] ([category_ticket_id], [event_id], [name], [description], [price], [max_quantity], [status]) VALUES (1062, 1028, N'STANDARD', N'Tham gia toàn bộ workshop
Tài liệu học tập cơ bản
Hỏi đáp chung cuối chương trình', CAST(140000.00 AS Decimal(18, 2)), 40, N'ACTIVE')
INSERT [dbo].[Category_Ticket] ([category_ticket_id], [event_id], [name], [description], [price], [max_quantity], [status]) VALUES (1063, 1029, N'VIP', N'Vé VIP bao gồm quyền ngồi hàng ghế đầu, tài liệu chuyên sâu nâng cao về các công nghệ mới như machine learning, và cơ hội networking riêng với diễn giả sau sự kiện.
', CAST(1500000.00 AS Decimal(18, 2)), 20, N'ACTIVE')
INSERT [dbo].[Category_Ticket] ([category_ticket_id], [event_id], [name], [description], [price], [max_quantity], [status]) VALUES (1064, 1029, N'STANDARD', N'
Tham dự workshop, nhận tài liệu cơ bản.', CAST(100000.00 AS Decimal(18, 2)), 30, N'ACTIVE')
SET IDENTITY_INSERT [dbo].[Category_Ticket] OFF
GO
SET IDENTITY_INSERT [dbo].[Event] ON 

INSERT [dbo].[Event] ([event_id], [title], [description], [start_time], [end_time], [speaker_id], [max_seats], [status], [created_by], [created_at], [area_id], [banner_url]) VALUES (7, N'Sự kiện mừng xuân - 2026', N'Mừng xuân đón tết', CAST(N'2026-01-01T10:00:00.0000000' AS DateTime2), CAST(N'2026-01-01T17:00:00.0000000' AS DateTime2), 8, 50, N'OPEN', 4, CAST(N'2025-12-08T00:55:02.0952644' AS DateTime2), 1, N'https://img.freepik.com/premium-vector/talk-show-banner-template_791789-63.jpg?w=2000')
INSERT [dbo].[Event] ([event_id], [title], [description], [start_time], [end_time], [speaker_id], [max_seats], [status], [created_by], [created_at], [area_id], [banner_url]) VALUES (8, N'Buổi dạy Thư Pháp Ngày Xuân 2026', N'Đánh bài tiến lên', CAST(N'2026-01-01T18:00:00.0000000' AS DateTime2), CAST(N'2026-01-01T22:00:00.0000000' AS DateTime2), 9, 50, N'OPEN', 4, CAST(N'2025-12-08T01:18:54.1797513' AS DateTime2), 1, N'https://img.freepik.com/premium-vector/talk-show-banner-template_791789-63.jpg?w=2000')
INSERT [dbo].[Event] ([event_id], [title], [description], [start_time], [end_time], [speaker_id], [max_seats], [status], [created_by], [created_at], [area_id], [banner_url]) VALUES (10, N'chz', N'csxx', CAST(N'2025-12-10T08:00:00.0000000' AS DateTime2), CAST(N'2025-12-10T10:00:00.0000000' AS DateTime2), 11, 50, N'CLOSED', 4, CAST(N'2025-12-09T09:34:37.7433372' AS DateTime2), 1, N'https://oihlyoeuwpcfnoywboyg.supabase.co/storage/v1/object/public/user-uploads/1765247813727-umfdwj.jfif')
INSERT [dbo].[Event] ([event_id], [title], [description], [start_time], [end_time], [speaker_id], [max_seats], [status], [created_by], [created_at], [area_id], [banner_url]) VALUES (14, N'Workshop “Kỹ năng Thuyết Trình Chuyên Nghiệp”', N'Buổi chia sẻ chuyên sâu về cách nói chuyện trước đám đông, xử lý tâm lý lo âu, và thực hành trực tiếp.', CAST(N'2025-12-18T08:00:00.0000000' AS DateTime2), CAST(N'2025-12-18T10:30:00.0000000' AS DateTime2), 17, 20, N'CLOSED', 4, CAST(N'2025-12-11T13:44:19.5062373' AS DateTime2), 9, N'https://oihlyoeuwpcfnoywboyg.supabase.co/storage/v1/object/public/user-uploads/1765438366693-tc8r6u.jpg')
INSERT [dbo].[Event] ([event_id], [title], [description], [start_time], [end_time], [speaker_id], [max_seats], [status], [created_by], [created_at], [area_id], [banner_url]) VALUES (15, N'Hội Thảo Tuyển Dụng IT Career Day', N'Gặp gỡ doanh nghiệp công nghệ, phỏng vấn thử, chia sẻ career path.', CAST(N'2025-12-18T16:00:00.0000000' AS DateTime2), CAST(N'2025-12-18T19:00:00.0000000' AS DateTime2), 14, 70, N'CLOSED', 4, CAST(N'2025-12-11T13:44:45.5163901' AS DateTime2), 7, N'https://oihlyoeuwpcfnoywboyg.supabase.co/storage/v1/object/public/user-uploads/1765436238531-c6x1op.jfif')
INSERT [dbo].[Event] ([event_id], [title], [description], [start_time], [end_time], [speaker_id], [max_seats], [status], [created_by], [created_at], [area_id], [banner_url]) VALUES (16, N'Workshop “Lập trình AI với Python dành cho người mới”', N'Hướng dẫn các khái niệm nền tảng về Machine Learning, thư viện NumPy, Pandas, scikit-learn, TensorFlow; thực hành dự án nhỏ.', CAST(N'2025-12-25T10:00:00.0000000' AS DateTime2), CAST(N'2025-12-25T14:00:00.0000000' AS DateTime2), 13, 40, N'OPEN', 4, CAST(N'2025-12-11T13:45:01.8959536' AS DateTime2), 6, N'https://oihlyoeuwpcfnoywboyg.supabase.co/storage/v1/object/public/user-uploads/1765436086099-ap7pf.jfif')
INSERT [dbo].[Event] ([event_id], [title], [description], [start_time], [end_time], [speaker_id], [max_seats], [status], [created_by], [created_at], [area_id], [banner_url]) VALUES (17, N'Workshop “Xây dựng ứng dụng Chatbot AI đa ngôn ngữ”', N'Hướng dẫn cách dùng OpenAI, Gemini, HuggingFace; tích hợp giọng nói – text – API; triển khai chatbot vào website.', CAST(N'2025-12-22T18:00:00.0000000' AS DateTime2), CAST(N'2025-12-22T20:00:00.0000000' AS DateTime2), 12, 60, N'CLOSED', 4, CAST(N'2025-12-11T13:45:08.3846909' AS DateTime2), 1, N'https://oihlyoeuwpcfnoywboyg.supabase.co/storage/v1/object/public/user-uploads/1765435908899-2y8hj9n.jpg')
INSERT [dbo].[Event] ([event_id], [title], [description], [start_time], [end_time], [speaker_id], [max_seats], [status], [created_by], [created_at], [area_id], [banner_url]) VALUES (1014, N'Sự Kiện vẽ tranh 2', N'Vẽ tranh', CAST(N'2026-01-01T13:00:00.0000000' AS DateTime2), CAST(N'2026-01-01T16:00:00.0000000' AS DateTime2), 1012, 80, N'OPEN', 4, CAST(N'2025-12-12T07:36:12.1989596' AS DateTime2), 8, N'https://oihlyoeuwpcfnoywboyg.supabase.co/storage/v1/object/public/user-uploads/1765503746601-0ciozh.jfif')
INSERT [dbo].[Event] ([event_id], [title], [description], [start_time], [end_time], [speaker_id], [max_seats], [status], [created_by], [created_at], [area_id], [banner_url]) VALUES (1028, N'Workshop “Lập trình Web Fullstack với Java – Từ Cơ Bản đến Thực Tế”', N'Workshop được tổ chức nhằm cung cấp cho sinh viên kiến thức nền tảng và thực hành về lập trình Web Fullstack sử dụng Java.
Nội dung bao gồm:
Giới thiệu tổng quan về kiến trúc Web (Frontend – Backend)
Làm quen với Java Servlet, JSP và JDBC
Kết nối CSDL và xây dựng các chức năng cơ bản', CAST(N'2025-12-26T14:00:00.0000000' AS DateTime2), CAST(N'2025-12-26T16:00:00.0000000' AS DateTime2), 1036, 60, N'OPEN', 4, CAST(N'2025-12-21T23:58:26.2765088' AS DateTime2), 1, N'https://oihlyoeuwpcfnoywboyg.supabase.co/storage/v1/object/public/user-uploads/1766336508787-qtmp12.jfif')
INSERT [dbo].[Event] ([event_id], [title], [description], [start_time], [end_time], [speaker_id], [max_seats], [status], [created_by], [created_at], [area_id], [banner_url]) VALUES (1029, N'Talk Show: Công Nghệ Thời Đại 4.0 – Cơ Hội & Thách Thức', N'Talk Show “Công Nghệ Thời Đại 4.0” là sự kiện chia sẻ và trao đổi xoay quanh những xu hướng công nghệ nổi bật trong kỷ nguyên số như Trí tuệ nhân tạo (AI), Dữ liệu lớn (Big Data), Internet vạn vật (IoT) và Chuyển đổi số.', CAST(N'2025-12-28T14:00:00.0000000' AS DateTime2), CAST(N'2025-12-28T16:00:00.0000000' AS DateTime2), 1037, 50, N'OPEN', 4, CAST(N'2025-12-22T09:29:33.8466147' AS DateTime2), 1, N'https://oihlyoeuwpcfnoywboyg.supabase.co/storage/v1/object/public/user-uploads/1766370747441-8huj69.jfif')
SET IDENTITY_INSERT [dbo].[Event] OFF
GO
SET IDENTITY_INSERT [dbo].[Event_Request] ON 

INSERT [dbo].[Event_Request] ([request_id], [requester_id], [title], [description], [preferred_start_time], [preferred_end_time], [expected_capacity], [status], [created_at], [processed_by], [processed_at], [organizer_note], [created_event_id]) VALUES (6, 3, N'Sự kiện mừng xuân - 2026', N'Mừng xuân đón tết', CAST(N'2026-01-01T10:00:00.0000000' AS DateTime2), CAST(N'2026-01-01T17:00:00.0000000' AS DateTime2), 50, N'APPROVED', CAST(N'2025-12-08T00:54:26.9565068' AS DateTime2), 4, CAST(N'2025-12-08T00:55:02.0975519' AS DateTime2), N'Yêu cầu của bạn đã được phê duyệt tổ.', 7)
INSERT [dbo].[Event_Request] ([request_id], [requester_id], [title], [description], [preferred_start_time], [preferred_end_time], [expected_capacity], [status], [created_at], [processed_by], [processed_at], [organizer_note], [created_event_id]) VALUES (7, 3, N'Buổi dạy Thư Pháp Ngày Xuân 2026', N'Đánh bài tiến lên', CAST(N'2026-01-01T18:00:00.0000000' AS DateTime2), CAST(N'2026-01-01T22:00:00.0000000' AS DateTime2), 50, N'APPROVED', CAST(N'2025-12-08T01:18:34.6553303' AS DateTime2), 4, CAST(N'2025-12-08T01:18:54.1850797' AS DateTime2), NULL, 8)
INSERT [dbo].[Event_Request] ([request_id], [requester_id], [title], [description], [preferred_start_time], [preferred_end_time], [expected_capacity], [status], [created_at], [processed_by], [processed_at], [organizer_note], [created_event_id]) VALUES (17, 3, N'Workshop “Kỹ năng Thuyết Trình Chuyên Nghiệp”', N'Buổi chia sẻ chuyên sâu về cách nói chuyện trước đám đông, xử lý tâm lý lo âu, và thực hành trực tiếp.', CAST(N'2025-12-18T08:00:00.0000000' AS DateTime2), CAST(N'2025-12-18T10:30:00.0000000' AS DateTime2), 20, N'APPROVED', CAST(N'2025-12-11T13:38:09.2479148' AS DateTime2), 4, CAST(N'2025-12-11T13:44:19.5196845' AS DateTime2), N'', 14)
INSERT [dbo].[Event_Request] ([request_id], [requester_id], [title], [description], [preferred_start_time], [preferred_end_time], [expected_capacity], [status], [created_at], [processed_by], [processed_at], [organizer_note], [created_event_id]) VALUES (18, 3, N'Hội Thảo Tuyển Dụng IT Career Day', N'Gặp gỡ doanh nghiệp công nghệ, phỏng vấn thử, chia sẻ career path.', CAST(N'2025-12-18T16:00:00.0000000' AS DateTime2), CAST(N'2025-12-18T19:00:00.0000000' AS DateTime2), 70, N'APPROVED', CAST(N'2025-12-11T13:39:08.1563307' AS DateTime2), 4, CAST(N'2025-12-11T13:44:45.5163901' AS DateTime2), N'', 15)
INSERT [dbo].[Event_Request] ([request_id], [requester_id], [title], [description], [preferred_start_time], [preferred_end_time], [expected_capacity], [status], [created_at], [processed_by], [processed_at], [organizer_note], [created_event_id]) VALUES (19, 3, N'Workshop “Lập trình AI với Python dành cho người mới”', N'Hướng dẫn các khái niệm nền tảng về Machine Learning, thư viện NumPy, Pandas, scikit-learn, TensorFlow; thực hành dự án nhỏ.', CAST(N'2025-12-25T10:00:00.0000000' AS DateTime2), CAST(N'2025-12-25T14:00:00.0000000' AS DateTime2), 40, N'APPROVED', CAST(N'2025-12-11T13:41:35.3405548' AS DateTime2), 4, CAST(N'2025-12-11T13:45:01.9053816' AS DateTime2), N'', 16)
INSERT [dbo].[Event_Request] ([request_id], [requester_id], [title], [description], [preferred_start_time], [preferred_end_time], [expected_capacity], [status], [created_at], [processed_by], [processed_at], [organizer_note], [created_event_id]) VALUES (20, 3, N'Workshop “Xây dựng ứng dụng Chatbot AI đa ngôn ngữ”', N'Hướng dẫn cách dùng OpenAI, Gemini, HuggingFace; tích hợp giọng nói – text – API; triển khai chatbot vào website.', CAST(N'2025-12-22T18:00:00.0000000' AS DateTime2), CAST(N'2025-12-22T20:00:00.0000000' AS DateTime2), 60, N'APPROVED', CAST(N'2025-12-11T13:42:52.6500253' AS DateTime2), 4, CAST(N'2025-12-11T13:45:08.3846909' AS DateTime2), N'', 17)
INSERT [dbo].[Event_Request] ([request_id], [requester_id], [title], [description], [preferred_start_time], [preferred_end_time], [expected_capacity], [status], [created_at], [processed_by], [processed_at], [organizer_note], [created_event_id]) VALUES (1018, 3, N'Sự Kiện vẽ tranh 2', N'Vẽ tranh', CAST(N'2026-01-01T13:00:00.0000000' AS DateTime2), CAST(N'2026-01-01T16:00:00.0000000' AS DateTime2), 80, N'APPROVED', CAST(N'2025-12-12T07:35:06.8235902' AS DateTime2), 4, CAST(N'2025-12-12T07:36:12.2104567' AS DateTime2), N'Phê duyệt tổ chức sự kiện', 1014)
INSERT [dbo].[Event_Request] ([request_id], [requester_id], [title], [description], [preferred_start_time], [preferred_end_time], [expected_capacity], [status], [created_at], [processed_by], [processed_at], [organizer_note], [created_event_id]) VALUES (1033, 3, N'Workshop “Lập trình Web Fullstack với Java – Từ Cơ Bản đến Thực Tế”', N'Workshop được tổ chức nhằm cung cấp cho sinh viên kiến thức nền tảng và thực hành về lập trình Web Fullstack sử dụng Java.
Nội dung bao gồm:
Giới thiệu tổng quan về kiến trúc Web (Frontend – Backend)
Làm quen với Java Servlet, JSP và JDBC
Kết nối CSDL và xây dựng các chức năng cơ bản', CAST(N'2025-12-26T14:00:00.0000000' AS DateTime2), CAST(N'2025-12-26T16:00:00.0000000' AS DateTime2), 60, N'APPROVED', CAST(N'2025-12-21T23:57:52.6244890' AS DateTime2), 4, CAST(N'2025-12-21T23:58:26.2850165' AS DateTime2), N'Yêu cầu của bạn đã được chấp nhận', 1028)
INSERT [dbo].[Event_Request] ([request_id], [requester_id], [title], [description], [preferred_start_time], [preferred_end_time], [expected_capacity], [status], [created_at], [processed_by], [processed_at], [organizer_note], [created_event_id]) VALUES (1034, 3, N'Talk Show: Công Nghệ Thời Đại 4.0 – Cơ Hội & Thách Thức', N'Talk Show “Công Nghệ Thời Đại 4.0” là sự kiện chia sẻ và trao đổi xoay quanh những xu hướng công nghệ nổi bật trong kỷ nguyên số như Trí tuệ nhân tạo (AI), Dữ liệu lớn (Big Data), Internet vạn vật (IoT) và Chuyển đổi số.', CAST(N'2025-12-28T14:00:00.0000000' AS DateTime2), CAST(N'2025-12-28T16:00:00.0000000' AS DateTime2), 50, N'APPROVED', CAST(N'2025-12-22T09:28:13.8540250' AS DateTime2), 4, CAST(N'2025-12-22T09:29:33.8606455' AS DateTime2), N'Đồng ý phê duyệt yêu cầu.', 1029)
SET IDENTITY_INSERT [dbo].[Event_Request] OFF
GO
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (7, 2, N'VIP', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (7, 3, N'VIP', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (7, 4, N'VIP', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (7, 5, N'VIP', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (7, 6, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (7, 7, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (7, 8, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (7, 9, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (7, 10, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (7, 11, N'VIP', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (7, 12, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (7, 13, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (7, 14, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (7, 15, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (7, 16, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (7, 17, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (7, 18, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (7, 19, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (7, 20, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (7, 21, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (7, 22, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (7, 23, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (7, 24, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (7, 25, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (7, 26, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (7, 27, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (7, 28, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (7, 29, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (7, 30, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (7, 31, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (7, 32, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (7, 33, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (7, 34, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (7, 35, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (7, 36, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (7, 37, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (7, 38, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (7, 39, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (7, 40, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (7, 41, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (7, 42, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (7, 43, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (7, 44, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (7, 45, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (7, 46, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (7, 47, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (7, 48, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (7, 49, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (7, 50, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (7, 51, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (8, 2, N'VIP', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (8, 3, N'VIP', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (8, 4, N'VIP', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (8, 5, N'VIP', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (8, 6, N'VIP', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (8, 7, N'VIP', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (8, 8, N'VIP', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (8, 9, N'VIP', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (8, 10, N'VIP', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (8, 11, N'VIP', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (8, 12, N'VIP', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (8, 13, N'VIP', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (8, 14, N'VIP', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (8, 15, N'VIP', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (8, 16, N'VIP', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (8, 17, N'VIP', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (8, 18, N'VIP', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (8, 19, N'VIP', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (8, 20, N'VIP', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (8, 21, N'VIP', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (8, 22, N'VIP', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (8, 23, N'VIP', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (8, 24, N'VIP', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (8, 25, N'VIP', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (8, 26, N'VIP', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (8, 27, N'VIP', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (8, 28, N'VIP', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (8, 29, N'VIP', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (8, 30, N'VIP', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (8, 31, N'VIP', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (8, 32, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (8, 33, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (8, 34, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (8, 35, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (8, 36, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (8, 37, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (8, 38, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (8, 39, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (8, 40, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (8, 41, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (8, 42, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (8, 43, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (8, 44, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (8, 45, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (8, 46, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (8, 47, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (8, 48, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (8, 49, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (8, 50, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (8, 51, N'STANDARD', N'AVAILABLE')
GO
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (10, 2, N'VIP', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (10, 3, N'VIP', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (10, 4, N'VIP', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (10, 5, N'VIP', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (10, 6, N'VIP', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (10, 7, N'VIP', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (10, 8, N'VIP', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (10, 9, N'VIP', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (10, 10, N'VIP', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (10, 11, N'VIP', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (10, 12, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (10, 13, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (10, 14, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (10, 15, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (10, 16, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (10, 17, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (10, 18, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (10, 19, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (10, 20, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (10, 21, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (10, 22, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (10, 23, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (10, 24, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (10, 25, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (10, 26, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (10, 27, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (10, 28, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (10, 29, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (10, 30, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (10, 31, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (10, 32, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (10, 33, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (10, 34, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (10, 35, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (10, 36, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (10, 37, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (10, 38, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (10, 39, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (10, 40, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (10, 41, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (14, 312, N'VIP', N'INAVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (14, 313, N'VIP', N'INAVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (14, 314, N'VIP', N'INAVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (14, 315, N'VIP', N'INAVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (14, 316, N'VIP', N'INAVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (14, 317, N'VIP', N'INAVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (14, 318, N'VIP', N'INAVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (14, 319, N'VIP', N'INAVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (14, 320, N'VIP', N'INAVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (14, 321, N'VIP', N'INAVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (14, 322, N'VIP', N'INAVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (14, 323, N'VIP', N'INAVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (14, 324, N'VIP', N'INAVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (14, 325, N'VIP', N'INAVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (14, 326, N'VIP', N'INAVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (14, 327, N'VIP', N'INAVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (14, 328, N'VIP', N'INAVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (14, 329, N'VIP', N'INAVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (14, 330, N'VIP', N'INAVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (14, 331, N'VIP', N'INAVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (15, 112, N'VIP', N'INAVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (15, 113, N'VIP', N'INAVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (15, 114, N'VIP', N'INAVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (15, 115, N'VIP', N'INAVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (15, 116, N'VIP', N'INAVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (15, 117, N'VIP', N'INAVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (15, 118, N'VIP', N'INAVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (15, 119, N'VIP', N'INAVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (15, 120, N'VIP', N'INAVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (15, 121, N'VIP', N'INAVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (15, 122, N'STANDARD', N'INAVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (15, 123, N'STANDARD', N'INAVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (15, 124, N'STANDARD', N'INAVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (15, 125, N'STANDARD', N'INAVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (15, 126, N'STANDARD', N'INAVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (15, 127, N'STANDARD', N'INAVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (15, 128, N'STANDARD', N'INAVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (15, 129, N'STANDARD', N'INAVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (15, 130, N'STANDARD', N'INAVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (15, 131, N'STANDARD', N'INAVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (15, 132, N'STANDARD', N'INAVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (15, 133, N'STANDARD', N'INAVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (15, 134, N'STANDARD', N'INAVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (15, 135, N'STANDARD', N'INAVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (15, 136, N'STANDARD', N'INAVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (15, 137, N'STANDARD', N'INAVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (15, 138, N'STANDARD', N'INAVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (15, 139, N'STANDARD', N'INAVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (15, 140, N'STANDARD', N'INAVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (15, 141, N'STANDARD', N'INAVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (15, 142, N'STANDARD', N'INAVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (15, 143, N'STANDARD', N'INAVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (15, 144, N'STANDARD', N'INAVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (15, 145, N'STANDARD', N'INAVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (15, 146, N'STANDARD', N'INAVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (15, 147, N'STANDARD', N'INAVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (15, 148, N'STANDARD', N'INAVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (15, 149, N'STANDARD', N'INAVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (15, 150, N'STANDARD', N'INAVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (15, 151, N'STANDARD', N'INAVAILABLE')
GO
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (15, 152, N'STANDARD', N'INAVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (15, 153, N'STANDARD', N'INAVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (15, 154, N'STANDARD', N'INAVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (15, 155, N'STANDARD', N'INAVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (15, 156, N'STANDARD', N'INAVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (15, 157, N'STANDARD', N'INAVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (15, 158, N'STANDARD', N'INAVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (15, 159, N'STANDARD', N'INAVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (15, 160, N'STANDARD', N'INAVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (15, 161, N'STANDARD', N'INAVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (16, 62, N'VIP', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (16, 63, N'VIP', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (16, 64, N'VIP', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (16, 65, N'VIP', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (16, 66, N'VIP', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (16, 67, N'VIP', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (16, 68, N'VIP', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (16, 69, N'VIP', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (16, 70, N'VIP', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (16, 71, N'VIP', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (16, 72, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (16, 73, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (16, 74, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (16, 75, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (16, 76, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (16, 77, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (16, 78, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (16, 79, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (16, 80, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (16, 81, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (16, 82, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (16, 83, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (16, 84, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (16, 85, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (16, 86, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (16, 87, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (16, 88, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (16, 89, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (16, 90, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (16, 91, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (16, 92, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (16, 93, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (16, 94, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (16, 95, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (16, 96, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (16, 97, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (16, 98, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (16, 99, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (16, 100, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (16, 101, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (17, 2, N'VIP', N'INAVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (17, 3, N'VIP', N'INAVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (17, 4, N'VIP', N'INAVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (17, 5, N'VIP', N'INAVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (17, 6, N'VIP', N'INAVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (17, 7, N'VIP', N'INAVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (17, 8, N'VIP', N'INAVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (17, 9, N'VIP', N'INAVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (17, 10, N'VIP', N'INAVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (17, 11, N'VIP', N'INAVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (17, 12, N'VIP', N'INAVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (17, 13, N'VIP', N'INAVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (17, 14, N'VIP', N'INAVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (17, 15, N'VIP', N'INAVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (17, 16, N'VIP', N'INAVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (17, 17, N'VIP', N'INAVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (17, 18, N'VIP', N'INAVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (17, 19, N'VIP', N'INAVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (17, 20, N'VIP', N'INAVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (17, 21, N'VIP', N'INAVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (17, 22, N'VIP', N'INAVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (17, 23, N'VIP', N'INAVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (17, 24, N'VIP', N'INAVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (17, 25, N'VIP', N'INAVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (17, 26, N'VIP', N'INAVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (17, 27, N'VIP', N'INAVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (17, 28, N'VIP', N'INAVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (17, 29, N'VIP', N'INAVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (17, 30, N'VIP', N'INAVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (17, 31, N'VIP', N'INAVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (17, 32, N'STANDARD', N'INAVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (17, 33, N'STANDARD', N'INAVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (17, 34, N'STANDARD', N'INAVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (17, 35, N'STANDARD', N'INAVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (17, 36, N'STANDARD', N'INAVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (17, 37, N'STANDARD', N'INAVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (17, 38, N'STANDARD', N'INAVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (17, 39, N'STANDARD', N'INAVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (17, 40, N'STANDARD', N'INAVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (17, 41, N'STANDARD', N'INAVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (17, 42, N'STANDARD', N'INAVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (17, 43, N'STANDARD', N'INAVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (17, 44, N'STANDARD', N'INAVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (17, 45, N'STANDARD', N'INAVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (17, 46, N'STANDARD', N'INAVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (17, 47, N'STANDARD', N'INAVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (17, 48, N'STANDARD', N'INAVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (17, 49, N'STANDARD', N'INAVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (17, 50, N'STANDARD', N'INAVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (17, 51, N'STANDARD', N'INAVAILABLE')
GO
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (17, 52, N'STANDARD', N'INAVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (17, 53, N'STANDARD', N'INAVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (17, 54, N'STANDARD', N'INAVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (17, 55, N'STANDARD', N'INAVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (17, 56, N'STANDARD', N'INAVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (17, 57, N'STANDARD', N'INAVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (17, 58, N'STANDARD', N'INAVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (17, 59, N'STANDARD', N'INAVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (17, 60, N'STANDARD', N'INAVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (17, 61, N'STANDARD', N'INAVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1014, 212, N'VIP', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1014, 213, N'VIP', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1014, 214, N'VIP', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1014, 215, N'VIP', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1014, 216, N'VIP', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1014, 217, N'VIP', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1014, 218, N'VIP', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1014, 219, N'VIP', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1014, 220, N'VIP', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1014, 221, N'VIP', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1014, 222, N'VIP', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1014, 223, N'VIP', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1014, 224, N'VIP', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1014, 225, N'VIP', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1014, 226, N'VIP', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1014, 227, N'VIP', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1014, 228, N'VIP', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1014, 229, N'VIP', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1014, 230, N'VIP', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1014, 231, N'VIP', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1014, 232, N'VIP', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1014, 233, N'VIP', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1014, 234, N'VIP', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1014, 235, N'VIP', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1014, 236, N'VIP', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1014, 237, N'VIP', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1014, 238, N'VIP', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1014, 239, N'VIP', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1014, 240, N'VIP', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1014, 241, N'VIP', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1014, 242, N'VIP', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1014, 243, N'VIP', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1014, 244, N'VIP', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1014, 245, N'VIP', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1014, 246, N'VIP', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1014, 247, N'VIP', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1014, 248, N'VIP', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1014, 249, N'VIP', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1014, 250, N'VIP', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1014, 251, N'VIP', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1014, 252, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1014, 253, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1014, 254, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1014, 255, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1014, 256, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1014, 257, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1014, 258, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1014, 259, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1014, 260, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1014, 261, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1014, 262, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1014, 263, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1014, 264, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1014, 265, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1014, 266, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1014, 267, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1014, 268, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1014, 269, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1014, 270, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1014, 271, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1014, 272, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1014, 273, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1014, 274, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1014, 275, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1014, 276, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1014, 277, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1014, 278, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1014, 279, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1014, 280, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1014, 281, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1014, 282, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1014, 283, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1014, 284, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1014, 285, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1014, 286, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1014, 287, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1014, 288, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1014, 289, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1014, 290, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1014, 291, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1028, 2, N'VIP', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1028, 3, N'VIP', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1028, 4, N'VIP', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1028, 5, N'VIP', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1028, 6, N'VIP', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1028, 7, N'VIP', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1028, 8, N'VIP', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1028, 9, N'VIP', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1028, 10, N'VIP', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1028, 11, N'VIP', N'AVAILABLE')
GO
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1028, 12, N'VIP', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1028, 13, N'VIP', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1028, 14, N'VIP', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1028, 15, N'VIP', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1028, 16, N'VIP', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1028, 17, N'VIP', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1028, 18, N'VIP', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1028, 19, N'VIP', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1028, 20, N'VIP', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1028, 21, N'VIP', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1028, 22, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1028, 23, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1028, 24, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1028, 25, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1028, 26, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1028, 27, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1028, 28, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1028, 29, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1028, 30, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1028, 31, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1028, 32, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1028, 33, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1028, 34, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1028, 35, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1028, 36, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1028, 37, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1028, 38, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1028, 39, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1028, 40, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1028, 41, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1028, 42, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1028, 43, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1028, 44, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1028, 45, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1028, 46, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1028, 47, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1028, 48, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1028, 49, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1028, 50, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1028, 51, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1028, 52, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1028, 53, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1028, 54, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1028, 55, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1028, 56, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1028, 57, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1028, 58, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1028, 59, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1028, 60, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1028, 61, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1029, 2, N'VIP', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1029, 3, N'VIP', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1029, 4, N'VIP', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1029, 5, N'VIP', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1029, 6, N'VIP', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1029, 7, N'VIP', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1029, 8, N'VIP', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1029, 9, N'VIP', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1029, 10, N'VIP', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1029, 11, N'VIP', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1029, 12, N'VIP', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1029, 13, N'VIP', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1029, 14, N'VIP', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1029, 15, N'VIP', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1029, 16, N'VIP', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1029, 17, N'VIP', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1029, 18, N'VIP', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1029, 19, N'VIP', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1029, 20, N'VIP', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1029, 21, N'VIP', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1029, 22, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1029, 23, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1029, 24, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1029, 25, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1029, 26, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1029, 27, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1029, 28, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1029, 29, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1029, 30, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1029, 31, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1029, 32, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1029, 33, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1029, 34, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1029, 35, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1029, 36, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1029, 37, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1029, 38, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1029, 39, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1029, 40, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1029, 41, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1029, 42, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1029, 43, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1029, 44, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1029, 45, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1029, 46, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1029, 47, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1029, 48, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1029, 49, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1029, 50, N'STANDARD', N'AVAILABLE')
INSERT [dbo].[Event_Seat_Layout] ([event_id], [seat_id], [seat_type], [status]) VALUES (1029, 51, N'STANDARD', N'AVAILABLE')
GO
SET IDENTITY_INSERT [dbo].[Report] ON 

INSERT [dbo].[Report] ([report_id], [user_id], [ticket_id], [title], [description], [image_url], [created_at], [status], [processed_by], [processed_at], [refund_amount], [staff_note]) VALUES (2, 7, 161, N'Ghế hỏng', N'Ghế Hỏng', N'https://oihlyoeuwpcfnoywboyg.supabase.co/storage/v1/object/public/user-uploads/1766384617453-b94sn2.jfif', CAST(N'2025-12-22T06:23:40.8527331' AS DateTime2), N'APPROVED', 4, CAST(N'2025-12-22T06:56:46.0852963' AS DateTime2), CAST(200000.00 AS Decimal(18, 2)), N'Đồng ý hoàn tiền')
SET IDENTITY_INSERT [dbo].[Report] OFF
GO
SET IDENTITY_INSERT [dbo].[Seat] ON 

INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (2, N'A1', N'A', N'1', N'ACTIVE', 1)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (3, N'A2', N'A', N'2', N'ACTIVE', 1)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (4, N'A3', N'A', N'3', N'ACTIVE', 1)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (5, N'A4', N'A', N'4', N'ACTIVE', 1)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (6, N'A5', N'A', N'5', N'ACTIVE', 1)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (7, N'A6', N'A', N'6', N'ACTIVE', 1)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (8, N'A7', N'A', N'7', N'ACTIVE', 1)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (9, N'A8', N'A', N'8', N'ACTIVE', 1)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (10, N'A9', N'A', N'9', N'ACTIVE', 1)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (11, N'A10', N'A', N'10', N'ACTIVE', 1)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (12, N'B1', N'B', N'1', N'ACTIVE', 1)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (13, N'B2', N'B', N'2', N'ACTIVE', 1)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (14, N'B3', N'B', N'3', N'ACTIVE', 1)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (15, N'B4', N'B', N'4', N'ACTIVE', 1)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (16, N'B5', N'B', N'5', N'ACTIVE', 1)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (17, N'B6', N'B', N'6', N'ACTIVE', 1)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (18, N'B7', N'B', N'7', N'ACTIVE', 1)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (19, N'B8', N'B', N'8', N'ACTIVE', 1)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (20, N'B9', N'B', N'9', N'ACTIVE', 1)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (21, N'B10', N'B', N'10', N'ACTIVE', 1)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (22, N'C1', N'C', N'1', N'ACTIVE', 1)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (23, N'C2', N'C', N'2', N'ACTIVE', 1)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (24, N'C3', N'C', N'3', N'ACTIVE', 1)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (25, N'C4', N'C', N'4', N'ACTIVE', 1)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (26, N'C5', N'C', N'5', N'ACTIVE', 1)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (27, N'C6', N'C', N'6', N'ACTIVE', 1)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (28, N'C7', N'C', N'7', N'ACTIVE', 1)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (29, N'C8', N'C', N'8', N'ACTIVE', 1)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (30, N'C9', N'C', N'9', N'ACTIVE', 1)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (31, N'C10', N'C', N'10', N'ACTIVE', 1)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (32, N'D1', N'D', N'1', N'ACTIVE', 1)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (33, N'D2', N'D', N'2', N'ACTIVE', 1)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (34, N'D3', N'D', N'3', N'ACTIVE', 1)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (35, N'D4', N'D', N'4', N'ACTIVE', 1)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (36, N'D5', N'D', N'5', N'ACTIVE', 1)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (37, N'D6', N'D', N'6', N'ACTIVE', 1)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (38, N'D7', N'D', N'7', N'ACTIVE', 1)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (39, N'D8', N'D', N'8', N'ACTIVE', 1)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (40, N'D9', N'D', N'9', N'ACTIVE', 1)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (41, N'D10', N'D', N'10', N'ACTIVE', 1)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (42, N'E1', N'E', N'1', N'ACTIVE', 1)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (43, N'E2', N'E', N'2', N'ACTIVE', 1)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (44, N'E3', N'E', N'3', N'ACTIVE', 1)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (45, N'E4', N'E', N'4', N'ACTIVE', 1)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (46, N'E5', N'E', N'5', N'ACTIVE', 1)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (47, N'E6', N'E', N'6', N'ACTIVE', 1)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (48, N'E7', N'E', N'7', N'ACTIVE', 1)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (49, N'E8', N'E', N'8', N'ACTIVE', 1)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (50, N'E9', N'E', N'9', N'ACTIVE', 1)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (51, N'E10', N'E', N'10', N'ACTIVE', 1)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (52, N'F1', N'F', N'1', N'ACTIVE', 1)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (53, N'F2', N'F', N'2', N'ACTIVE', 1)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (54, N'F3', N'F', N'3', N'ACTIVE', 1)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (55, N'F4', N'F', N'4', N'ACTIVE', 1)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (56, N'F5', N'F', N'5', N'ACTIVE', 1)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (57, N'F6', N'F', N'6', N'ACTIVE', 1)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (58, N'F7', N'F', N'7', N'ACTIVE', 1)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (59, N'F8', N'F', N'8', N'ACTIVE', 1)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (60, N'F9', N'F', N'9', N'ACTIVE', 1)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (61, N'F10', N'F', N'10', N'ACTIVE', 1)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (62, N'A1', N'A', N'1', N'ACTIVE', 6)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (63, N'A2', N'A', N'2', N'ACTIVE', 6)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (64, N'A3', N'A', N'3', N'ACTIVE', 6)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (65, N'A4', N'A', N'4', N'ACTIVE', 6)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (66, N'A5', N'A', N'5', N'ACTIVE', 6)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (67, N'A6', N'A', N'6', N'ACTIVE', 6)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (68, N'A7', N'A', N'7', N'ACTIVE', 6)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (69, N'A8', N'A', N'8', N'ACTIVE', 6)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (70, N'A9', N'A', N'9', N'ACTIVE', 6)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (71, N'A10', N'A', N'10', N'ACTIVE', 6)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (72, N'B1', N'B', N'1', N'ACTIVE', 6)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (73, N'B2', N'B', N'2', N'ACTIVE', 6)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (74, N'B3', N'B', N'3', N'ACTIVE', 6)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (75, N'B4', N'B', N'4', N'ACTIVE', 6)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (76, N'B5', N'B', N'5', N'ACTIVE', 6)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (77, N'B6', N'B', N'6', N'ACTIVE', 6)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (78, N'B7', N'B', N'7', N'ACTIVE', 6)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (79, N'B8', N'B', N'8', N'ACTIVE', 6)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (80, N'B9', N'B', N'9', N'ACTIVE', 6)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (81, N'B10', N'B', N'10', N'ACTIVE', 6)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (82, N'C1', N'C', N'1', N'ACTIVE', 6)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (83, N'C2', N'C', N'2', N'ACTIVE', 6)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (84, N'C3', N'C', N'3', N'ACTIVE', 6)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (85, N'C4', N'C', N'4', N'ACTIVE', 6)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (86, N'C5', N'C', N'5', N'ACTIVE', 6)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (87, N'C6', N'C', N'6', N'ACTIVE', 6)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (88, N'C7', N'C', N'7', N'ACTIVE', 6)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (89, N'C8', N'C', N'8', N'ACTIVE', 6)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (90, N'C9', N'C', N'9', N'ACTIVE', 6)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (91, N'C10', N'C', N'10', N'ACTIVE', 6)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (92, N'D1', N'D', N'1', N'ACTIVE', 6)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (93, N'D2', N'D', N'2', N'ACTIVE', 6)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (94, N'D3', N'D', N'3', N'ACTIVE', 6)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (95, N'D4', N'D', N'4', N'ACTIVE', 6)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (96, N'D5', N'D', N'5', N'ACTIVE', 6)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (97, N'D6', N'D', N'6', N'ACTIVE', 6)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (98, N'D7', N'D', N'7', N'ACTIVE', 6)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (99, N'D8', N'D', N'8', N'ACTIVE', 6)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (100, N'D9', N'D', N'9', N'ACTIVE', 6)
GO
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (101, N'D10', N'D', N'10', N'ACTIVE', 6)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (102, N'E1', N'E', N'1', N'ACTIVE', 6)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (103, N'E2', N'E', N'2', N'ACTIVE', 6)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (104, N'E3', N'E', N'3', N'ACTIVE', 6)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (105, N'E4', N'E', N'4', N'ACTIVE', 6)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (106, N'E5', N'E', N'5', N'ACTIVE', 6)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (107, N'E6', N'E', N'6', N'ACTIVE', 6)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (108, N'E7', N'E', N'7', N'ACTIVE', 6)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (109, N'E8', N'E', N'8', N'ACTIVE', 6)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (110, N'E9', N'E', N'9', N'ACTIVE', 6)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (111, N'E10', N'E', N'10', N'ACTIVE', 6)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (112, N'A1', N'A', N'1', N'ACTIVE', 7)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (113, N'A2', N'A', N'2', N'ACTIVE', 7)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (114, N'A3', N'A', N'3', N'ACTIVE', 7)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (115, N'A4', N'A', N'4', N'ACTIVE', 7)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (116, N'A5', N'A', N'5', N'ACTIVE', 7)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (117, N'A6', N'A', N'6', N'ACTIVE', 7)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (118, N'A7', N'A', N'7', N'ACTIVE', 7)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (119, N'A8', N'A', N'8', N'ACTIVE', 7)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (120, N'A9', N'A', N'9', N'ACTIVE', 7)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (121, N'A10', N'A', N'10', N'ACTIVE', 7)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (122, N'B1', N'B', N'1', N'ACTIVE', 7)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (123, N'B2', N'B', N'2', N'ACTIVE', 7)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (124, N'B3', N'B', N'3', N'ACTIVE', 7)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (125, N'B4', N'B', N'4', N'ACTIVE', 7)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (126, N'B5', N'B', N'5', N'ACTIVE', 7)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (127, N'B6', N'B', N'6', N'ACTIVE', 7)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (128, N'B7', N'B', N'7', N'ACTIVE', 7)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (129, N'B8', N'B', N'8', N'ACTIVE', 7)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (130, N'B9', N'B', N'9', N'ACTIVE', 7)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (131, N'B10', N'B', N'10', N'ACTIVE', 7)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (132, N'C1', N'C', N'1', N'ACTIVE', 7)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (133, N'C2', N'C', N'2', N'ACTIVE', 7)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (134, N'C3', N'C', N'3', N'ACTIVE', 7)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (135, N'C4', N'C', N'4', N'ACTIVE', 7)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (136, N'C5', N'C', N'5', N'ACTIVE', 7)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (137, N'C6', N'C', N'6', N'ACTIVE', 7)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (138, N'C7', N'C', N'7', N'ACTIVE', 7)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (139, N'C8', N'C', N'8', N'ACTIVE', 7)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (140, N'C9', N'C', N'9', N'ACTIVE', 7)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (141, N'C10', N'C', N'10', N'ACTIVE', 7)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (142, N'D1', N'D', N'1', N'ACTIVE', 7)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (143, N'D2', N'D', N'2', N'ACTIVE', 7)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (144, N'D3', N'D', N'3', N'ACTIVE', 7)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (145, N'D4', N'D', N'4', N'ACTIVE', 7)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (146, N'D5', N'D', N'5', N'ACTIVE', 7)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (147, N'D6', N'D', N'6', N'ACTIVE', 7)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (148, N'D7', N'D', N'7', N'ACTIVE', 7)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (149, N'D8', N'D', N'8', N'ACTIVE', 7)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (150, N'D9', N'D', N'9', N'ACTIVE', 7)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (151, N'D10', N'D', N'10', N'ACTIVE', 7)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (152, N'E1', N'E', N'1', N'ACTIVE', 7)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (153, N'E2', N'E', N'2', N'ACTIVE', 7)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (154, N'E3', N'E', N'3', N'ACTIVE', 7)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (155, N'E4', N'E', N'4', N'ACTIVE', 7)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (156, N'E5', N'E', N'5', N'ACTIVE', 7)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (157, N'E6', N'E', N'6', N'ACTIVE', 7)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (158, N'E7', N'E', N'7', N'ACTIVE', 7)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (159, N'E8', N'E', N'8', N'ACTIVE', 7)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (160, N'E9', N'E', N'9', N'ACTIVE', 7)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (161, N'E10', N'E', N'10', N'ACTIVE', 7)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (162, N'F1', N'F', N'1', N'ACTIVE', 7)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (163, N'F2', N'F', N'2', N'ACTIVE', 7)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (164, N'F3', N'F', N'3', N'ACTIVE', 7)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (165, N'F4', N'F', N'4', N'ACTIVE', 7)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (166, N'F5', N'F', N'5', N'ACTIVE', 7)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (167, N'F6', N'F', N'6', N'ACTIVE', 7)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (168, N'F7', N'F', N'7', N'ACTIVE', 7)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (169, N'F8', N'F', N'8', N'ACTIVE', 7)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (170, N'F9', N'F', N'9', N'ACTIVE', 7)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (171, N'F10', N'F', N'10', N'ACTIVE', 7)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (172, N'G1', N'G', N'1', N'ACTIVE', 7)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (173, N'G2', N'G', N'2', N'ACTIVE', 7)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (174, N'G3', N'G', N'3', N'ACTIVE', 7)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (175, N'G4', N'G', N'4', N'ACTIVE', 7)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (176, N'G5', N'G', N'5', N'ACTIVE', 7)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (177, N'G6', N'G', N'6', N'ACTIVE', 7)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (178, N'G7', N'G', N'7', N'ACTIVE', 7)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (179, N'G8', N'G', N'8', N'ACTIVE', 7)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (180, N'G9', N'G', N'9', N'ACTIVE', 7)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (181, N'G10', N'G', N'10', N'ACTIVE', 7)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (182, N'H1', N'H', N'1', N'ACTIVE', 7)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (183, N'H2', N'H', N'2', N'ACTIVE', 7)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (184, N'H3', N'H', N'3', N'ACTIVE', 7)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (185, N'H4', N'H', N'4', N'ACTIVE', 7)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (186, N'H5', N'H', N'5', N'ACTIVE', 7)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (187, N'H6', N'H', N'6', N'ACTIVE', 7)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (188, N'H7', N'H', N'7', N'ACTIVE', 7)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (189, N'H8', N'H', N'8', N'ACTIVE', 7)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (190, N'H9', N'H', N'9', N'ACTIVE', 7)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (191, N'H10', N'H', N'10', N'ACTIVE', 7)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (192, N'I1', N'I', N'1', N'ACTIVE', 7)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (193, N'I2', N'I', N'2', N'ACTIVE', 7)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (194, N'I3', N'I', N'3', N'ACTIVE', 7)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (195, N'I4', N'I', N'4', N'ACTIVE', 7)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (196, N'I5', N'I', N'5', N'ACTIVE', 7)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (197, N'I6', N'I', N'6', N'ACTIVE', 7)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (198, N'I7', N'I', N'7', N'ACTIVE', 7)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (199, N'I8', N'I', N'8', N'ACTIVE', 7)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (200, N'I9', N'I', N'9', N'ACTIVE', 7)
GO
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (201, N'I10', N'I', N'10', N'ACTIVE', 7)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (202, N'J1', N'J', N'1', N'ACTIVE', 7)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (203, N'J2', N'J', N'2', N'ACTIVE', 7)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (204, N'J3', N'J', N'3', N'ACTIVE', 7)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (205, N'J4', N'J', N'4', N'ACTIVE', 7)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (206, N'J5', N'J', N'5', N'ACTIVE', 7)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (207, N'J6', N'J', N'6', N'ACTIVE', 7)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (208, N'J7', N'J', N'7', N'ACTIVE', 7)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (209, N'J8', N'J', N'8', N'ACTIVE', 7)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (210, N'J9', N'J', N'9', N'ACTIVE', 7)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (211, N'J10', N'J', N'10', N'ACTIVE', 7)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (212, N'A1', N'A', N'1', N'ACTIVE', 8)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (213, N'A2', N'A', N'2', N'ACTIVE', 8)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (214, N'A3', N'A', N'3', N'ACTIVE', 8)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (215, N'A4', N'A', N'4', N'ACTIVE', 8)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (216, N'A5', N'A', N'5', N'ACTIVE', 8)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (217, N'A6', N'A', N'6', N'ACTIVE', 8)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (218, N'A7', N'A', N'7', N'ACTIVE', 8)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (219, N'A8', N'A', N'8', N'ACTIVE', 8)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (220, N'A9', N'A', N'9', N'ACTIVE', 8)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (221, N'A10', N'A', N'10', N'ACTIVE', 8)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (222, N'B1', N'B', N'1', N'ACTIVE', 8)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (223, N'B2', N'B', N'2', N'ACTIVE', 8)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (224, N'B3', N'B', N'3', N'ACTIVE', 8)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (225, N'B4', N'B', N'4', N'ACTIVE', 8)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (226, N'B5', N'B', N'5', N'ACTIVE', 8)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (227, N'B6', N'B', N'6', N'ACTIVE', 8)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (228, N'B7', N'B', N'7', N'ACTIVE', 8)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (229, N'B8', N'B', N'8', N'ACTIVE', 8)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (230, N'B9', N'B', N'9', N'ACTIVE', 8)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (231, N'B10', N'B', N'10', N'ACTIVE', 8)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (232, N'C1', N'C', N'1', N'ACTIVE', 8)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (233, N'C2', N'C', N'2', N'ACTIVE', 8)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (234, N'C3', N'C', N'3', N'ACTIVE', 8)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (235, N'C4', N'C', N'4', N'ACTIVE', 8)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (236, N'C5', N'C', N'5', N'ACTIVE', 8)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (237, N'C6', N'C', N'6', N'ACTIVE', 8)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (238, N'C7', N'C', N'7', N'ACTIVE', 8)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (239, N'C8', N'C', N'8', N'ACTIVE', 8)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (240, N'C9', N'C', N'9', N'ACTIVE', 8)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (241, N'C10', N'C', N'10', N'ACTIVE', 8)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (242, N'D1', N'D', N'1', N'ACTIVE', 8)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (243, N'D2', N'D', N'2', N'ACTIVE', 8)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (244, N'D3', N'D', N'3', N'ACTIVE', 8)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (245, N'D4', N'D', N'4', N'ACTIVE', 8)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (246, N'D5', N'D', N'5', N'ACTIVE', 8)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (247, N'D6', N'D', N'6', N'ACTIVE', 8)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (248, N'D7', N'D', N'7', N'ACTIVE', 8)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (249, N'D8', N'D', N'8', N'ACTIVE', 8)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (250, N'D9', N'D', N'9', N'ACTIVE', 8)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (251, N'D10', N'D', N'10', N'ACTIVE', 8)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (252, N'E1', N'E', N'1', N'ACTIVE', 8)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (253, N'E2', N'E', N'2', N'ACTIVE', 8)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (254, N'E3', N'E', N'3', N'ACTIVE', 8)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (255, N'E4', N'E', N'4', N'ACTIVE', 8)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (256, N'E5', N'E', N'5', N'ACTIVE', 8)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (257, N'E6', N'E', N'6', N'ACTIVE', 8)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (258, N'E7', N'E', N'7', N'ACTIVE', 8)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (259, N'E8', N'E', N'8', N'ACTIVE', 8)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (260, N'E9', N'E', N'9', N'ACTIVE', 8)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (261, N'E10', N'E', N'10', N'ACTIVE', 8)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (262, N'F1', N'F', N'1', N'ACTIVE', 8)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (263, N'F2', N'F', N'2', N'ACTIVE', 8)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (264, N'F3', N'F', N'3', N'ACTIVE', 8)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (265, N'F4', N'F', N'4', N'ACTIVE', 8)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (266, N'F5', N'F', N'5', N'ACTIVE', 8)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (267, N'F6', N'F', N'6', N'ACTIVE', 8)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (268, N'F7', N'F', N'7', N'ACTIVE', 8)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (269, N'F8', N'F', N'8', N'ACTIVE', 8)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (270, N'F9', N'F', N'9', N'ACTIVE', 8)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (271, N'F10', N'F', N'10', N'ACTIVE', 8)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (272, N'G1', N'G', N'1', N'ACTIVE', 8)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (273, N'G2', N'G', N'2', N'ACTIVE', 8)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (274, N'G3', N'G', N'3', N'ACTIVE', 8)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (275, N'G4', N'G', N'4', N'ACTIVE', 8)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (276, N'G5', N'G', N'5', N'ACTIVE', 8)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (277, N'G6', N'G', N'6', N'ACTIVE', 8)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (278, N'G7', N'G', N'7', N'ACTIVE', 8)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (279, N'G8', N'G', N'8', N'ACTIVE', 8)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (280, N'G9', N'G', N'9', N'ACTIVE', 8)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (281, N'G10', N'G', N'10', N'ACTIVE', 8)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (282, N'H1', N'H', N'1', N'ACTIVE', 8)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (283, N'H2', N'H', N'2', N'ACTIVE', 8)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (284, N'H3', N'H', N'3', N'ACTIVE', 8)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (285, N'H4', N'H', N'4', N'ACTIVE', 8)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (286, N'H5', N'H', N'5', N'ACTIVE', 8)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (287, N'H6', N'H', N'6', N'ACTIVE', 8)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (288, N'H7', N'H', N'7', N'ACTIVE', 8)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (289, N'H8', N'H', N'8', N'ACTIVE', 8)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (290, N'H9', N'H', N'9', N'ACTIVE', 8)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (291, N'H10', N'H', N'10', N'ACTIVE', 8)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (292, N'I1', N'I', N'1', N'ACTIVE', 8)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (293, N'I2', N'I', N'2', N'ACTIVE', 8)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (294, N'I3', N'I', N'3', N'ACTIVE', 8)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (295, N'I4', N'I', N'4', N'ACTIVE', 8)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (296, N'I5', N'I', N'5', N'ACTIVE', 8)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (297, N'I6', N'I', N'6', N'ACTIVE', 8)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (298, N'I7', N'I', N'7', N'ACTIVE', 8)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (299, N'I8', N'I', N'8', N'ACTIVE', 8)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (300, N'I9', N'I', N'9', N'ACTIVE', 8)
GO
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (301, N'I10', N'I', N'10', N'ACTIVE', 8)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (302, N'J1', N'J', N'1', N'ACTIVE', 8)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (303, N'J2', N'J', N'2', N'ACTIVE', 8)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (304, N'J3', N'J', N'3', N'ACTIVE', 8)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (305, N'J4', N'J', N'4', N'ACTIVE', 8)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (306, N'J5', N'J', N'5', N'ACTIVE', 8)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (307, N'J6', N'J', N'6', N'ACTIVE', 8)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (308, N'J7', N'J', N'7', N'ACTIVE', 8)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (309, N'J8', N'J', N'8', N'ACTIVE', 8)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (310, N'J9', N'J', N'9', N'ACTIVE', 8)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (311, N'J10', N'J', N'10', N'ACTIVE', 8)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (312, N'A1', N'A', N'1', N'ACTIVE', 9)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (313, N'A2', N'A', N'2', N'ACTIVE', 9)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (314, N'A3', N'A', N'3', N'ACTIVE', 9)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (315, N'A4', N'A', N'4', N'ACTIVE', 9)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (316, N'A5', N'A', N'5', N'ACTIVE', 9)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (317, N'A6', N'A', N'6', N'ACTIVE', 9)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (318, N'A7', N'A', N'7', N'ACTIVE', 9)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (319, N'A8', N'A', N'8', N'ACTIVE', 9)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (320, N'A9', N'A', N'9', N'ACTIVE', 9)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (321, N'A10', N'A', N'10', N'ACTIVE', 9)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (322, N'B1', N'B', N'1', N'ACTIVE', 9)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (323, N'B2', N'B', N'2', N'ACTIVE', 9)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (324, N'B3', N'B', N'3', N'ACTIVE', 9)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (325, N'B4', N'B', N'4', N'ACTIVE', 9)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (326, N'B5', N'B', N'5', N'ACTIVE', 9)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (327, N'B6', N'B', N'6', N'ACTIVE', 9)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (328, N'B7', N'B', N'7', N'ACTIVE', 9)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (329, N'B8', N'B', N'8', N'ACTIVE', 9)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (330, N'B9', N'B', N'9', N'ACTIVE', 9)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (331, N'B10', N'B', N'10', N'ACTIVE', 9)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (332, N'C1', N'C', N'1', N'ACTIVE', 9)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (333, N'C2', N'C', N'2', N'ACTIVE', 9)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (334, N'C3', N'C', N'3', N'ACTIVE', 9)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (335, N'C4', N'C', N'4', N'ACTIVE', 9)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (336, N'C5', N'C', N'5', N'ACTIVE', 9)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (337, N'C6', N'C', N'6', N'ACTIVE', 9)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (338, N'C7', N'C', N'7', N'ACTIVE', 9)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (339, N'C8', N'C', N'8', N'ACTIVE', 9)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (340, N'C9', N'C', N'9', N'ACTIVE', 9)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (341, N'C10', N'C', N'10', N'ACTIVE', 9)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (342, N'D1', N'D', N'1', N'ACTIVE', 9)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (343, N'D2', N'D', N'2', N'ACTIVE', 9)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (344, N'D3', N'D', N'3', N'ACTIVE', 9)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (345, N'D4', N'D', N'4', N'ACTIVE', 9)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (346, N'D5', N'D', N'5', N'ACTIVE', 9)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (347, N'D6', N'D', N'6', N'ACTIVE', 9)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (348, N'D7', N'D', N'7', N'ACTIVE', 9)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (349, N'D8', N'D', N'8', N'ACTIVE', 9)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (350, N'D9', N'D', N'9', N'ACTIVE', 9)
INSERT [dbo].[Seat] ([seat_id], [seat_code], [row_no], [col_no], [status], [area_id]) VALUES (351, N'D10', N'D', N'10', N'ACTIVE', 9)
SET IDENTITY_INSERT [dbo].[Seat] OFF
GO
SET IDENTITY_INSERT [dbo].[Speaker] ON 

INSERT [dbo].[Speaker] ([speaker_id], [full_name], [bio], [email], [phone], [avatar_url]) VALUES (8, N'Nguyễn Võ Minh Châu', N'', N'long@email.com', N'0373253725', NULL)
INSERT [dbo].[Speaker] ([speaker_id], [full_name], [bio], [email], [phone], [avatar_url]) VALUES (9, N'Nguyễn Võ Minh Châu', N'', N'long@email.com', N'0373253725', NULL)
INSERT [dbo].[Speaker] ([speaker_id], [full_name], [bio], [email], [phone], [avatar_url]) VALUES (10, N'Châu', N'ffddd', N'chau@gmail.com', N'09123456', NULL)
INSERT [dbo].[Speaker] ([speaker_id], [full_name], [bio], [email], [phone], [avatar_url]) VALUES (11, N'bui ti duc', N'hfhf', N'hghd@gmail.com', N'012345689', N'')
INSERT [dbo].[Speaker] ([speaker_id], [full_name], [bio], [email], [phone], [avatar_url]) VALUES (12, N'Nguyễn Trọng Duy', N'Chuyên gia AI với hơn 8 năm kinh nghiệm trong lĩnh vực Natural Language Processing (NLP), Generative AI và xây dựng hệ thống Chatbot sử dụng LLM. Từng làm việc tại các công ty công nghệ lớn như FPT Software và Got It. Hiện đang là Technical Lead tại AI Vietnam Lab, phụ trách phát triển các mô hình đa ngôn ngữ và triển khai chatbot trong doanh nghiệp.', N'duy@gmail.com', N'0933307646', N'https://nguoinoitieng.tv/images/nnt/101/1/bfr0.jpg')
INSERT [dbo].[Speaker] ([speaker_id], [full_name], [bio], [email], [phone], [avatar_url]) VALUES (13, N'Trần Minh Khoa', N'Giảng viên và kỹ sư Machine Learning với hơn 6 năm kinh nghiệm trong xử lý dữ liệu, xây dựng mô hình AI và phát triển ứng dụng bằng Python. Từng làm việc tại VNG AI Team và hiện là Data Scientist tại LeapTech. Chuyên về nền tảng Python, scikit-learn, TensorFlow và triển khai mô hình AI thực tế cho doanh nghiệp.', N'minh.khoa.ds.tech@gmail.com', N'0932 557 124', N'https://nguoinoitieng.tv/images/nnt/0/2/mv.jpg')
INSERT [dbo].[Speaker] ([speaker_id], [full_name], [bio], [email], [phone], [avatar_url]) VALUES (14, N'Lê Quang Huy', N'Chuyên gia nhân sự cấp cao với hơn 10 năm kinh nghiệm trong tuyển dụng và xây dựng lộ trình nghề nghiệp trong lĩnh vực CNTT. Từng giữ vị trí Talent Acquisition Manager tại VNG và KMS Technology. Hiện đang là Head of Recruitment tại GlobalTech HR Hub, phụ trách tuyển dụng các vị trí Software Engineer, DevOps, AI Engineer và Product Manager.', N'huy.le.globaltech.hr@gmail.com', N'0911 864 739', N'https://nguoinoitieng.tv/images/nnt/1/0/am5.jpg')
INSERT [dbo].[Speaker] ([speaker_id], [full_name], [bio], [email], [phone], [avatar_url]) VALUES (17, N'Huỳnh Minh Thuận ', N'Chuyên gia đào tạo kỹ năng mềm với hơn 9 năm kinh nghiệm trong lĩnh vực thuyết trình, giao tiếp và phát triển cá nhân. Từng huấn luyện cho hơn 30 doanh nghiệp lớn như Viettel, MWG, FPT Telecom. Là Founder của “Present Mastery Academy” — học viện đào tạo kỹ năng thuyết trình được hơn 15.000 học viên theo học.', N'huynhminhthuan@gmail.com', N'0912345677', N'https://tse4.mm.bing.net/th/id/OIP.Cr8IpDXr1FZvDL-TQVhKggHaE7?pid=Api&P=0&h=220')
INSERT [dbo].[Speaker] ([speaker_id], [full_name], [bio], [email], [phone], [avatar_url]) VALUES (1012, N'Bùi Trí Đức', N'Nơi diễn ra Vẽ Tranh', N'duc@gmail.com', N'0912345678', N'')
INSERT [dbo].[Speaker] ([speaker_id], [full_name], [bio], [email], [phone], [avatar_url]) VALUES (1015, N'vvf', N'vfvsf', N'a@gmail.com', N'0912345678', N'https://oihlyoeuwpcfnoywboyg.supabase.co/storage/v1/object/public/user-uploads/1766402958087-4pgbph.jfif')
INSERT [dbo].[Speaker] ([speaker_id], [full_name], [bio], [email], [phone], [avatar_url]) VALUES (1016, N'Trần Tiến Phát', N'Anh Trần Tấn Phát là chuyên gia trong lĩnh vực Công nghệ Thông tin và Chuyển đổi số, với nhiều năm kinh nghiệm làm việc và triển khai các giải pháp công nghệ tại doanh nghiệp và tổ chức giáo dục.', N'trantienphat@gmail.com', N'0933307646', N'https://oihlyoeuwpcfnoywboyg.supabase.co/storage/v1/object/public/user-uploads/1765763816328-utgsze.jpg')
INSERT [dbo].[Speaker] ([speaker_id], [full_name], [bio], [email], [phone], [avatar_url]) VALUES (1017, N'vsvs', N'dccdc', N'a@gmail.com', N'0933307646', N'https://oihlyoeuwpcfnoywboyg.supabase.co/storage/v1/object/public/user-uploads/1765848469553-x7oj5j.jfif')
INSERT [dbo].[Speaker] ([speaker_id], [full_name], [bio], [email], [phone], [avatar_url]) VALUES (1018, N'gfgg', N'sggg', N'a@gmail.com', N'0933307646', N'https://oihlyoeuwpcfnoywboyg.supabase.co/storage/v1/object/public/user-uploads/1765849944559-1ljk4.jpg')
INSERT [dbo].[Speaker] ([speaker_id], [full_name], [bio], [email], [phone], [avatar_url]) VALUES (1019, N'xcxczcz', N'cvdc', N'a@gmail.com', N'093330724', N'https://oihlyoeuwpcfnoywboyg.supabase.co/storage/v1/object/public/user-uploads/1765894891898-ijss.jfif')
INSERT [dbo].[Speaker] ([speaker_id], [full_name], [bio], [email], [phone], [avatar_url]) VALUES (1020, N'Dr. Nguyen Van A', N'Chuyên gia công nghệ với hơn 10 năm kinh nghiệm trong lĩnh vực AI và Machine Learning', N'speaker@example.com', N'0901234567', N'')
INSERT [dbo].[Speaker] ([speaker_id], [full_name], [bio], [email], [phone], [avatar_url]) VALUES (1021, N'Nguyễn Võ Minh Châu', N'Cựu sinh viên trường FPT', N'chau@gmail.com', N'0373253725', N'https://oihlyoeuwpcfnoywboyg.supabase.co/storage/v1/object/public/user-uploads/1766049825869-8bz13r.jfif')
INSERT [dbo].[Speaker] ([speaker_id], [full_name], [bio], [email], [phone], [avatar_url]) VALUES (1022, N'Nguyễn Ngọc Minh Thư', N'Cựu sinh viên trườn FPT', N'thu@gmail.com', N'093334567', N'https://oihlyoeuwpcfnoywboyg.supabase.co/storage/v1/object/public/user-uploads/1766049928501-pa9axh.jfif')
INSERT [dbo].[Speaker] ([speaker_id], [full_name], [bio], [email], [phone], [avatar_url]) VALUES (1023, N'Nguyễn Võ Minh Châu', N'Cựu sinh viên trường FPT', N'chau@gmail.com', N'0933307646', N'https://oihlyoeuwpcfnoywboyg.supabase.co/storage/v1/object/public/user-uploads/1766050712291-cr2ccv.jfif')
INSERT [dbo].[Speaker] ([speaker_id], [full_name], [bio], [email], [phone], [avatar_url]) VALUES (1024, N'fvsvds', N'vddvd', N'a@gmail.com', N'0933307646', N'https://oihlyoeuwpcfnoywboyg.supabase.co/storage/v1/object/public/user-uploads/1766051685869-h5h1bh.jfif')
INSERT [dbo].[Speaker] ([speaker_id], [full_name], [bio], [email], [phone], [avatar_url]) VALUES (1025, N'fvsvds', N'vddjsjhvvfvfvofvofvufovdffvfvCCCCCCCCCCCCCCCCCCC VVFVFVFBGBBBGBDBDGBGBVNNHNHNH BGGBGBGGGBGBGBFFHN BGBDDBBGBHNHHHNFVDVBDBGBHNHNH BVDVFVDCADJCADHCDHVFU CHCHODOHSVBBVDSBVOSFB CDOCDCDVHIHIDFHIDWFH9W CHUADCHADOUCDURFRWUH', N'A@gmail.com', N'0933307646', N'https://oihlyoeuwpcfnoywboyg.supabase.co/storage/v1/object/public/user-uploads/1766051813587-habdkr.jfif')
INSERT [dbo].[Speaker] ([speaker_id], [full_name], [bio], [email], [phone], [avatar_url]) VALUES (1026, N'Dr. Nguyen Van A', N'Chuyên gia công nghệ với hơn 10 năm kinh nghiệm trong lĩnh vực AI và Machine Learning', N'speaker@example.com', N'0901234567', N'')
INSERT [dbo].[Speaker] ([speaker_id], [full_name], [bio], [email], [phone], [avatar_url]) VALUES (1027, N'Dr. Nguyen Van A', N'Chuyên gia công nghệ với hơn 10 năm kinh nghiệm trong lĩnh vực AI và Machine Learningcdnclcsncjcndskjcdncdscdcnkdkcdsnknvskcnslcndscjdndsjkcds vdsjvdsncdcndcldcndlcjdcnjdlaclndcnldlndsndcjnldsvnds', N'a@gmail.com', N'09333307646', N'https://oihlyoeuwpcfnoywboyg.supabase.co/storage/v1/object/public/user-uploads/1766052449389-i71zlf.jfif')
INSERT [dbo].[Speaker] ([speaker_id], [full_name], [bio], [email], [phone], [avatar_url]) VALUES (1028, N'Trần Tấn Phát', N'Anh Trần Tấn Phát là chuyên gia trong lĩnh vực Công nghệ Thông tin và Chuyển đổi số, với nhiều năm kinh nghiệm làm việc và triển khai các giải pháp công nghệ tại doanh nghiệp và tổ chức giáo dục.', N'phat@gmail.com', N'093331234', N'https://oihlyoeuwpcfnoywboyg.supabase.co/storage/v1/object/public/user-uploads/1766234589585-ohqk0l.jpg')
INSERT [dbo].[Speaker] ([speaker_id], [full_name], [bio], [email], [phone], [avatar_url]) VALUES (1031, N'Trần Tấn Phát', N'Anh Trần Tấn Phát là chuyên gia trong lĩnh vực Công nghệ Thông tin và Chuyển đổi số, với nhiều năm kinh nghiệm làm việc và triển khai các giải pháp công nghệ tại doanh nghiệp và tổ chức giáo dục.', N'phat@gmail.com', N'0933307646', N'https://oihlyoeuwpcfnoywboyg.supabase.co/storage/v1/object/public/user-uploads/1766234589585-ohqk0l.jpg')
INSERT [dbo].[Speaker] ([speaker_id], [full_name], [bio], [email], [phone], [avatar_url]) VALUES (1032, N'Trần Tấn Phát', N'Anh Trần Tấn Phát là chuyên gia trong lĩnh vực Công nghệ Thông tin và Chuyển đổi số, với nhiều năm kinh nghiệm làm việc và triển khai các giải pháp công nghệ tại doanh nghiệp và tổ chức giáo dục.', N'a@gmail.com', N'0933307646', N'https://oihlyoeuwpcfnoywboyg.supabase.co/storage/v1/object/public/user-uploads/1766234589585-ohqk0l.jpg')
INSERT [dbo].[Speaker] ([speaker_id], [full_name], [bio], [email], [phone], [avatar_url]) VALUES (1033, N'Dr. Nguyen Van A', N'Chuyên gia công nghệ với hơn 10 năm kinh nghiệm trong lĩnh vực AI và Machine Learningcdnclcsncjcndskjcdncdscdcnkdkcdsnknvskcnslcndscjdndsjkcds vdsjvdsncdcndcldcndlcjdcnjdlaclndcnldlndsndcjnldsvnds', N'a@gmail.com', N'0933307646', N'https://oihlyoeuwpcfnoywboyg.supabase.co/storage/v1/object/public/user-uploads/1766052449389-i71zlf.jfif')
INSERT [dbo].[Speaker] ([speaker_id], [full_name], [bio], [email], [phone], [avatar_url]) VALUES (1035, N'Trần Tấn Phát', N'Anh Trần Tấn Phát là chuyên gia trong lĩnh vực Công nghệ Thông tin và Chuyển đổi số, với nhiều năm kinh nghiệm làm việc và triển khai các giải pháp công nghệ tại doanh nghiệp và tổ chức giáo dục.
', N'phat@gmail.com', N'0933307646', N'https://oihlyoeuwpcfnoywboyg.supabase.co/storage/v1/object/public/user-uploads/1766719369380-g24uwn.jpg')
INSERT [dbo].[Speaker] ([speaker_id], [full_name], [bio], [email], [phone], [avatar_url]) VALUES (1036, N'Nguyễn Văn Minh', N'Nguyễn Văn Minh là giảng viên và lập trình viên Fullstack với hơn 6 năm kinh nghiệm trong lĩnh vực phát triển Web bằng Java.
Anh từng tham gia xây dựng nhiều hệ thống quản lý sự kiện, thương mại điện tử và đào tạo sinh viên CNTT về Java Web, Spring Boot và CSDL.', N'minh@gmail.com', N'0933307646', N'https://oihlyoeuwpcfnoywboyg.supabase.co/storage/v1/object/public/user-uploads/1766336509523-ffkr3k.jfif')
INSERT [dbo].[Speaker] ([speaker_id], [full_name], [bio], [email], [phone], [avatar_url]) VALUES (1037, N'Trần Tấn Phát', N'Anh Trần Tấn Phát là chuyên gia trong lĩnh vực Công nghệ Thông tin và Chuyển đổi số, với nhiều năm kinh nghiệm làm việc và triển khai các giải pháp công nghệ tại doanh nghiệp và tổ chức giáo dục.', N'phat@gmail.com', N'0933307646', N'https://oihlyoeuwpcfnoywboyg.supabase.co/storage/v1/object/public/user-uploads/1766370748351-l8i7a.jpg')
SET IDENTITY_INSERT [dbo].[Speaker] OFF
GO
SET IDENTITY_INSERT [dbo].[Ticket] ON 

INSERT [dbo].[Ticket] ([ticket_id], [event_id], [user_id], [category_ticket_id], [bill_id], [seat_id], [qr_code_value], [qr_issued_at], [status], [checkin_time], [check_out_time]) VALUES (32, 7, 7, 14, 34, 15, N'iVBORw0KGgoAAAANSUhEUgAAASwAAAEsAQAAAABRBrPYAAABI0lEQVR42u3aQRLCIAxA0bDqMXrU9qg9gktWYglBmFGrC0lH57PoUHmsGBJClfRJuwgMBoPBYD/FolibSy+k1X4IMD9W3tI6p6ss26S9bgDmxFZdosxk1glR1w52FpMJdjJTEWDnsBq49rbVCQfxDTaAtSQebLHe5HrY91lrsRs8OPfCBrB9cNlaEo+vtwxsHMsxS6b9LKsT0n3fzDBPlouJFrjKij0mcdhQpm/5keu68ki1wIA5MjvB1vOUFRgPFx2wcaxL4lZg7Ct2LSEM5sXagTZZDinrtAnMkfXFnVYUmk2WoxoQNoDZRce9l09Wr+9DYKOZbZSaTWD+TANXt3kCzJNZ4IqWQ+RZcQcby/oPo0srK2RKMDfG3yFgMBgM9jfsBql8Skq/0WXsAAAAAElFTkSuQmCC', CAST(N'2025-12-11T09:02:11.1310000' AS DateTime2), N'CHECKED_IN', CAST(N'2025-12-11T09:14:32.0530000' AS DateTime2), NULL)
INSERT [dbo].[Ticket] ([ticket_id], [event_id], [user_id], [category_ticket_id], [bill_id], [seat_id], [qr_code_value], [qr_issued_at], [status], [checkin_time], [check_out_time]) VALUES (33, 7, 7, 14, 34, 16, N'iVBORw0KGgoAAAANSUhEUgAAASwAAAEsAQAAAABRBrPYAAABGUlEQVR42u3aOw6DMAyA4TD1GBwVjsoROmaK28R5oYLaoTFq9WeIaPiYrNgm1Mkn4+5gMBgMBvsp5l0e8/NqET/JmhcmmB3TX7LOEjKb+xswI7bGwKyzb1OKHewiJttNYNeyeFNgF7GSuGR3BbNkrYiXxPWm1sO+z7oRdMu863th32cpWFo0ptpPHSQu2EgWx5a2hy+TVvLXmMLGsWd00rq7lTjFsQjMkGkDFcq6LyI+CjNjU81eQaf+PRtmw9rQelF30FkrBRvAWkOrrVTIrS3MlO0O/Ta3z2MwM5YPOiRV8v4QFmbPauKqXS3sAuZi5agvdwIzZTlxpRC1B87KB2wE6z+M6lFfitjB2wdsGOPvEDAYDAb7G/YA38/ueGvD59wAAAAASUVORK5CYII=', CAST(N'2025-12-11T09:02:11.1920000' AS DateTime2), N'CHECKED_IN', CAST(N'2025-12-11T09:14:32.0530000' AS DateTime2), NULL)
INSERT [dbo].[Ticket] ([ticket_id], [event_id], [user_id], [category_ticket_id], [bill_id], [seat_id], [qr_code_value], [qr_issued_at], [status], [checkin_time], [check_out_time]) VALUES (38, 8, 7, 15, 38, 26, N'iVBORw0KGgoAAAANSUhEUgAAASwAAAEsAQAAAABRBrPYAAABGElEQVR42u3aQQ6DIBCFYVh5DI6qR+UIXbpyWmQQNTV2UYa0+VkYW7+uJs4bSJ18sh4OBoPBYLCfYrPTFV53o8xeJv3Cw+xY/iRTkEVZ2D+AGbEpFWYKc72stYN1YhIHgfVl6aHAOrHSuORwB7NkNcRL47rJetj32W4t+ZW5m3th32drsXJo+G2eetO4YE2Z10t0uq3QJD8VC9aSpbxww7Jt7rRrjaf4gDVleYBKL4ps9iLEYW1Zie4xDsd9NsyG1ZWrsyQreasBs2J1oK3zVNnwwczY4dAvutrHBGbJ9KAjx/n+EBZmz2qcl6kW1oWVEK99DGbFtHHNesikP7iKD1gLdjj0W6N7rdj5lYG1ZPwdAgaDwWB/w57SV4oomMXV5gAAAABJRU5ErkJggg==', CAST(N'2025-12-11T09:27:07.8220000' AS DateTime2), N'CHECKED_IN', CAST(N'2025-12-11T09:27:40.8960000' AS DateTime2), NULL)
INSERT [dbo].[Ticket] ([ticket_id], [event_id], [user_id], [category_ticket_id], [bill_id], [seat_id], [qr_code_value], [qr_issued_at], [status], [checkin_time], [check_out_time]) VALUES (39, 8, 1, 16, 39, 35, N'iVBORw0KGgoAAAANSUhEUgAAASwAAAEsAQAAAABRBrPYAAABHElEQVR42u3aMZLDIAxAUVFxDB/VPipH2JLKCgYMzGzWSRHkyc6nwua50oAkxqLvjB+BwWAwGOyrWJQ6ljJzutUXDmbHypNui+6yBp9nwwLMiG05RAeTJX8Qc+xgdzHxsJtZFg52DzsPrjTC+cHF+QabwHoSdzVYL3I97POsjzgsXtS9sAksLa6hJ/H495aBTWTurGVznNq+WWCG7MgcpaXz2iImpbSFWbFYQ6TB14I2jf15iw2bxtLBpeMeORsMmCEbknhtMHLYVo0wO9YL2nbHUazADNnY3OWOIqVz+R0s2GRWLzraTPx+cR8Cm8tac/e8lIJZsKO3GDePg1myenCV2T5cPMHM2Hjpp6G3FV5hZozfIWAwGAz2b9gDJVFYlueDMjgAAAAASUVORK5CYII=', CAST(N'2025-12-11T10:08:17.1100000' AS DateTime2), N'BOOKED', NULL, NULL)
INSERT [dbo].[Ticket] ([ticket_id], [event_id], [user_id], [category_ticket_id], [bill_id], [seat_id], [qr_code_value], [qr_issued_at], [status], [checkin_time], [check_out_time]) VALUES (40, 8, 7, 16, 40, 38, N'iVBORw0KGgoAAAANSUhEUgAAASwAAAEsAQAAAABRBrPYAAABHElEQVR42u3aMXKEMAxAUVH5GBwVjuojpHSFApJZeycbkiIWs5nvggH8XGksIQ+ivxkfAoPBYDDYW7Eidcx+N+laX0ywOOZPus66yZKT3XUTsCC2WogOJrMtKBY72F1MEuxmZmKC3cPOxLWPfC64yG+wAawV8akG64daD/t71kbpJi++e2ED2D655FbEy/dbBjaOWem2EJV6WR+bBxbFjqecNs9Vi3rEXhdx2EjmgTn6Or/o2WDAApkHq2vuzhQGi2JPRdwKia1aFBbI2gftI2dZNckCC2R9c2cdxR4x+Ros2GBWDzraAXjaLs5DYKOZJy7bRi9qPSyAdUVc/R0skNXEVZ777AILZP2hX9dWSFJYGON3CBgMBoP9G/YJQr0wZHQmsuwAAAAASUVORK5CYII=', CAST(N'2025-12-11T12:41:44.8280000' AS DateTime2), N'CHECKED_IN', CAST(N'2026-01-01T18:06:44.8240000' AS DateTime2), NULL)
INSERT [dbo].[Ticket] ([ticket_id], [event_id], [user_id], [category_ticket_id], [bill_id], [seat_id], [qr_code_value], [qr_issued_at], [status], [checkin_time], [check_out_time]) VALUES (41, 8, 7, 16, 40, 39, N'iVBORw0KGgoAAAANSUhEUgAAASwAAAEsAQAAAABRBrPYAAABHElEQVR42u3aOxKDIBCAYaw8hkfVo3KElFRsBBbRPMYUcZlkfoqMwS/VDvtg4uSTdXMwGAwGg/0UC07XtD7NEgZZdGOA2bHyTZZJorJp/wJmxJYUmGUK7SPHDtaJiR8F1pellwLrxGriksMTzJK1Il4T10mth32f7VYsR+as74V9n+VglaIxbP3Ui8QFu5KlfT/qy9zQaiV/iCnsSpb3nQ4TpX6nNQvMkuWtWPdDFSliMDOWqvZ6ZEr2cmOdsx3MkLVVxoqcx6SMGjAr1hracm6itrYwU3a49PO7HwjMkulFh9TstV3CwuxZK+e1q4V1Yc6N23AnMFOmiSsFy29h8+/KB+wKdrj0y6U7T9zP0wfsOsbfIWAwGAz2N+wOoOSbJm8HR24AAAAASUVORK5CYII=', CAST(N'2025-12-11T12:41:44.9680000' AS DateTime2), N'CHECKED_IN', CAST(N'2026-01-01T18:06:44.8240000' AS DateTime2), NULL)
INSERT [dbo].[Ticket] ([ticket_id], [event_id], [user_id], [category_ticket_id], [bill_id], [seat_id], [qr_code_value], [qr_issued_at], [status], [checkin_time], [check_out_time]) VALUES (42, 8, 7, 16, 41, 32, N'iVBORw0KGgoAAAANSUhEUgAAASwAAAEsAQAAAABRBrPYAAABF0lEQVR42u3aSRKDIBCFYVxxDI8ajsoRsnQlCdgMJg5ZpLGS+lk5fK5e2Q2oCZ+Mu4HBYDAY7KfYZGSMy9EQnFwYYP3YchZcZDcf2djegHViziw352dCVh54Zge7iElYsOtYuj7BLmK5cEnNOqtvMAVWm7gkdtbrYd9ndaQH7Om8F6bAUpGK/XsssaWc/HumME2WWnfwNtqDxR1MkcVKZV/ax7y1uIMpshiWjXNZW1r3lLILsH5MipQrb4uTOjbAurGmiefqZexc2zmsB6sT2njmTeomJr9BsE6s3fTLOTXtHNaJ5e2mUNZ1ZrvXw/qw4wktTJ+ttpvcblgwHdZ8DDqc0ML02HrTbzcsmCbjdwgYDAaD/Q17AOifbzRwjW5yAAAAAElFTkSuQmCC', CAST(N'2025-12-11T12:50:44.1410000' AS DateTime2), N'CHECKED_IN', CAST(N'2026-01-01T18:06:22.6520000' AS DateTime2), NULL)
INSERT [dbo].[Ticket] ([ticket_id], [event_id], [user_id], [category_ticket_id], [bill_id], [seat_id], [qr_code_value], [qr_issued_at], [status], [checkin_time], [check_out_time]) VALUES (46, 14, 7, 27, 42, 316, N'iVBORw0KGgoAAAANSUhEUgAAASwAAAEsAQAAAABRBrPYAAABGUlEQVR42u3aOxKCMBCA4VBxjBwVjpojWFKxmmxCguJgYZbR+VM4IB/VTvYRdfLJujkYDAaDwX6KLS4v/7iaZBlkzl8MMDumdzJ7WTPz7QOYEZtjYGa/1I8UO9hFTMIosGtZfCiwi1hJXLK7glmyWsRL4jqp9bDvs2atumXO+l7Y91kKlhaNYeunDhIXrDObYpymkPZIreQvwYJ1ZW7LVFq/45relQ9YJ6bB0sSlt4dFHNaXpT2SqnYYy5wdkxnMitWlY8XavgUzYrWhLWdOzpeBD2bGdod+wZWIPTe0sM4sH3TEOGlrWw5hYfasGStyVwu7gKUxbxvuBGbKcuLavZBnPZgRa38YdbWrDaPAzBh/h4DBYDDY37A7zdA/CgESKmsAAAAASUVORK5CYII=', CAST(N'2025-12-11T23:07:47.2280000' AS DateTime2), N'CHECKED_IN', CAST(N'2025-12-18T08:04:24.6640000' AS DateTime2), NULL)
INSERT [dbo].[Ticket] ([ticket_id], [event_id], [user_id], [category_ticket_id], [bill_id], [seat_id], [qr_code_value], [qr_issued_at], [status], [checkin_time], [check_out_time]) VALUES (80, 14, 7, 27, 43, 328, N'iVBORw0KGgoAAAANSUhEUgAAASwAAAEsAQAAAABRBrPYAAABG0lEQVR42u3aMRLCIBCF4aXKMXLU5KgcwZJKjAsriWOihWxG56fC8FExsA9GyZ+0i8BgMBgM9lMsSW1j6YU81w8B5sfKrzyP+SpTHLS3GoA5sVmX6M5k1AlJ1w52FpMBdjJTEWDnMDu4lhZtwsH5BuvAWhEPdbHe1HrY91lraTV4kHthHdgyOMVWxNP+loH1YxagtDflx74ZYZ7MisY9RdVZL4o4rDfT7DRlC7SbBYT5sO1xZZdtmwDzYa2I1wtGjkN98oB5sRZoS/mwPBX3ci+sB1tf7vRGsSQrKeUc5sjqQ8cj2spwPXgPgfVldnDpvnkq4jAn1h7Ay+YJME9mqTZsklWCObLNo1+7VshelIJ1YPwdAgaDwWB/w259QojA7OwySAAAAABJRU5ErkJggg==', CAST(N'2025-12-12T08:25:45.7190000' AS DateTime2), N'EXPIRED', CAST(N'2025-12-18T08:03:39.4080000' AS DateTime2), CAST(N'2025-12-18T08:37:33.2587383' AS DateTime2))
INSERT [dbo].[Ticket] ([ticket_id], [event_id], [user_id], [category_ticket_id], [bill_id], [seat_id], [qr_code_value], [qr_issued_at], [status], [checkin_time], [check_out_time]) VALUES (81, 1014, 7, 1022, 44, 277, N'iVBORw0KGgoAAAANSUhEUgAAASwAAAEsAQAAAABRBrPYAAABD0lEQVR42u3aQQ6DIBCFYVh5DI9ajuoRunQlRWcA21Tqooxp87sgYr/dS2YGUhfPPHcHg8FgMNhPsdnpM6ZNGGcfg37wMDsmuyTytr7BDFlYg5GcNLE1O9glrIYFu5At7jY52EUsF64l/TrEj/UN1oGVJj77U70e1oHVp/bv5twL68CkSGk6WrPqZAUzYl6XKdWstKw9RBaYLSutexP7HgKzYTJAOU1H3soWZsckna1wuUZYsI6sNvEUUbnyCMejFOz7bDfQliNdPmrAzFg53L2ENcBMWXBP1xuhLDB7Fuss+3aghVkwOVtsTXxp35PDOrBcuPSmSQba4/YB68D2l36NsGA9GX+HgMFgMNjfsAdJXHw22IKnmgAAAABJRU5ErkJggg==', CAST(N'2025-12-12T10:09:37.1570000' AS DateTime2), N'BOOKED', NULL, NULL)
INSERT [dbo].[Ticket] ([ticket_id], [event_id], [user_id], [category_ticket_id], [bill_id], [seat_id], [qr_code_value], [qr_issued_at], [status], [checkin_time], [check_out_time]) VALUES (85, 17, 7, 21, 45, 26, N'iVBORw0KGgoAAAANSUhEUgAAASwAAAEsAQAAAABRBrPYAAABEklEQVR42u3aOxKDIBCAYaxyDI8KR+UIKa3YiDwzMTGFrJPMT+EgflaM+2A08s24GxgMBoPBfootJo95nVlZJnF5YYLpsXQnbpaQ2dw/gCkxFzfGzUu7bHsHu4iJvwnsWhYfCuwiVgKXPM1gmqwl8RK4DnI97HzWjZA+maO6F3Y+2zYrJY2p1lM7gQs2mFmpiaTL5C+bBRvIavrYZiWOWYEpsji86WtZ29ZgWiykM441eoV0se3jgWmxOlJbsbK9wAUbylpB2+1dbvhgaqxv7lx+IXzIMrAxLB90SCilbTmEhemztF5EjF6wa5i/1eZOYKqsayt8OYS1/l36gI1g/aFfaTByPQXTYvwOAYPBYLC/YQ+x/xCDaFC7KAAAAABJRU5ErkJggg==', CAST(N'2025-12-12T13:25:20.1540000' AS DateTime2), N'EXPIRED', NULL, NULL)
INSERT [dbo].[Ticket] ([ticket_id], [event_id], [user_id], [category_ticket_id], [bill_id], [seat_id], [qr_code_value], [qr_issued_at], [status], [checkin_time], [check_out_time]) VALUES (89, 17, 7, 21, 46, 29, N'iVBORw0KGgoAAAANSUhEUgAAASwAAAEsAQAAAABRBrPYAAABGUlEQVR42u3aSw6DIBCA4WHlMTwqHpUjdMlKqoBATbBdlDFtfhaNLZ+rCfMglfDJeggMBoPBYD/FvOQ1pycTlvyDgemx9C0sc1jFuik+NRswJbbEEO1M5viCj7GD3cVkgt3MojCwe9iRuLbljhcu8htsAKtF3ORgvan1sO+zunyzedH3wgawbdO6WsR9/8jAxrE9Z6UQlSNTPmBqbBsmSvayIUVMUmsL02I+n5Yk9oY2hGPAgGmx1EBJk7PqmAfTZKci7qZ85QHTYrWhPdle3wsbwdrhLk4U1sVC4mGqLF90lNZWpvXiPgQ2muXhrtNKwRRYvQCvowZMjeXE5V/nbA9TZO2lX3BlrJBeKwUbwPg7BAwGg8H+hj0BBR8+dMAekYUAAAAASUVORK5CYII=', CAST(N'2025-12-13T20:47:03.7940000' AS DateTime2), N'CHECKED_IN', CAST(N'2025-12-22T18:03:51.4600000' AS DateTime2), NULL)
INSERT [dbo].[Ticket] ([ticket_id], [event_id], [user_id], [category_ticket_id], [bill_id], [seat_id], [qr_code_value], [qr_issued_at], [status], [checkin_time], [check_out_time]) VALUES (102, 14, 7, 27, 47, 314, N'iVBORw0KGgoAAAANSUhEUgAAASwAAAEsAQAAAABRBrPYAAABDElEQVR42u3aMRKDIBCFYaw4hkfVo3KElFYSgVXWxMQUYZ1kfirFj+qN7Mro4ifj5mAwGAwG+yk2ORl9ueriKBMdzI6VuzgmNoTEev0AZsRGVx7OS0JeFizZwS5iEhbsOpbnJ9hFbN24ZM86299gDVgt4pLYWa2HfZ/VkRf4074X1oDlTSrV736LLecUnjOFtWPyjgxpwaCzg5myqBqoUj7mwyIOa8by1BpQ7acew4K1ZkPws5xxvAsL1pDpIi4LvAoQZsFqQ5vugstnTqqQwEzY7uPOvQwL1pjpQz+362ph9mw74zj6uIPZMNXQxjIHM2SHvWzwEWbH9KGfLDgKC9aS8TsEDAaDwf6G3QFCoGF+YkkzVAAAAABJRU5ErkJggg==', CAST(N'2025-12-15T10:11:32.0290000' AS DateTime2), N'EXPIRED', NULL, NULL)
INSERT [dbo].[Ticket] ([ticket_id], [event_id], [user_id], [category_ticket_id], [bill_id], [seat_id], [qr_code_value], [qr_issued_at], [status], [checkin_time], [check_out_time]) VALUES (105, 14, 7, 27, 48, 312, N'iVBORw0KGgoAAAANSUhEUgAAASwAAAEsAQAAAABRBrPYAAABC0lEQVR42u3aTQ6DIBCG4XHlMTyqHNUjdMlKKjKAqT91M5g2Lwsj9tl9ycxAKuHOegkMBoPBYD/FvOgalo0bfBecfuhg7VjaLSJv6xusIXMxmJSTJhazgz3CaliwB9ks4ySwh1guXPPyax++1jeYAStN3He3ej3MgNVV+/fl3AszYKlIaTpas+pkBWvD1qbRr51D8lt8BFhzltOJYttDYG2YF82pNBKNbddlYIYsdu2DsATWkO2beHpEC2vF9gNtOlFMsJasHO6uw4IZM1dm2TGUE9753SDMkqWLjjLfnoUFM2VrCevVylWmMANWC1eYykD7edEBM2XbJp4H2oOwYJaMv0PAYDAY7G/YGxnJW/wOC2PMAAAAAElFTkSuQmCC', CAST(N'2025-12-16T09:45:23.5300000' AS DateTime2), N'EXPIRED', CAST(N'2025-12-18T08:08:03.7790000' AS DateTime2), CAST(N'2025-12-18T08:17:41.9327663' AS DateTime2))
INSERT [dbo].[Ticket] ([ticket_id], [event_id], [user_id], [category_ticket_id], [bill_id], [seat_id], [qr_code_value], [qr_issued_at], [status], [checkin_time], [check_out_time]) VALUES (106, 17, 7, 21, 49, 25, N'iVBORw0KGgoAAAANSUhEUgAAASwAAAEsAQAAAABRBrPYAAABFElEQVR42u3aPQ7CMAyGYWfqMXrU5qg9AmOnhkT5cfgpMOBUoDdD1MCzfcJ2IyR8si4Cg8FgMNhPsU3KmuPBz5sLvnzgYONYPkVRj/oEG8h8CibnVBJL2cFOYRoW7ES2y7IK7CRWC9cev53C2/oGM2CtiW/uo14PM2C6tH+/nHthBiwXqZJOqVk6WcGGsWWd9Gmv28MvC2bHUtPI5aqKvofAxrAuonhaJR3z5mDjmCuJyaRbyEMubBTrmniMqF15eJkCbBjrBtr2Spe2FTaStZc7vW56FhbMmPk2yy6hveEd3w3CLFnYbwbao7BgpqwOVbmTv8wU9n2mhasbaO8vOmCm7KaJy2FYMEvG3yFgMBgM9jfsCnqVJlC4e1ulAAAAAElFTkSuQmCC', CAST(N'2025-12-16T09:49:56.5320000' AS DateTime2), N'EXPIRED', CAST(N'2025-12-22T18:07:11.2080000' AS DateTime2), CAST(N'2025-12-22T19:02:54.8266390' AS DateTime2))
INSERT [dbo].[Ticket] ([ticket_id], [event_id], [user_id], [category_ticket_id], [bill_id], [seat_id], [qr_code_value], [qr_issued_at], [status], [checkin_time], [check_out_time]) VALUES (116, 15, 7, 26, 50, 122, N'iVBORw0KGgoAAAANSUhEUgAAASwAAAEsAQAAAABRBrPYAAABE0lEQVR42u3aSxKDIAyA4bjyGBxVj8oRumRlankIdqrtosRp52fhUPlcZUgIU9FPxk1gMBgMBvspFiQPl2aDzvnFALNj6ZfOTheZ/BhnzQLMiM0xRA8mLn4QYuxgVzEZYRezKAbYNawkrnX48sFJfoN1YLWIDzlYb2o97PusjtAsnpx7YR3Yujj5WsTD8ZaB9WPlGJtmuu0bBzNk9X3pLWqbB7NiKVglTlLCBjNlcWc0QpsUBrNiuyIeC4nG2HmB2bF6oE3lY8tZAWbI9pd+IvkBM2b5omM72sq4nNyHwPqyPEvbyD01dzAbVu6c0uPFuRfWk+XEFXINkYPmDtaRtZd+6mtbMSrMjPF3CBgMBoP9DbsDfGxlAoI60cwAAAAASUVORK5CYII=', CAST(N'2025-12-17T08:23:12.1350000' AS DateTime2), N'EXPIRED', NULL, NULL)
INSERT [dbo].[Ticket] ([ticket_id], [event_id], [user_id], [category_ticket_id], [bill_id], [seat_id], [qr_code_value], [qr_issued_at], [status], [checkin_time], [check_out_time]) VALUES (118, 8, 7, 15, 51, 31, N'iVBORw0KGgoAAAANSUhEUgAAASwAAAEsAQAAAABRBrPYAAABF0lEQVR42u3aOw6DMAyA4TBxjBwVjsoROjLFJQ+HUFHRoTFq9WdAQD4mC9sJOPlkPBwMBoPBYD/FVleG384mWQeZy40BZsfylcxeQmG+nYAZsTkGZvbrfkixg93EZBkFdi+LkwK7iWniksMZzJLtRVwT10Wth32fNSPkV+aq74V9n6Vg5aIx1H7qJHHBerLayy6uLCu0ksOMmWavqeax7SmYHVv1Vu1lJzkv4rB+LAbLjalyhJjCdJ0dkxnMkEkbnZjCzhMXrB/bG1otJHtrCzNjh8Xdkh8Imr1gZqxsdOTE1W7CwuxZrt+h6WphN7A0WRd3AjNlh7WFhm1590kO1oO1H0bzVl+K2OsrA+vJ+B0CBoPBYH/DnvJqigqT2J9gAAAAAElFTkSuQmCC', CAST(N'2025-12-18T21:34:27.0190000' AS DateTime2), N'CHECKED_OUT', CAST(N'2026-01-01T18:07:17.4490000' AS DateTime2), CAST(N'2026-01-01T19:10:26.5460953' AS DateTime2))
INSERT [dbo].[Ticket] ([ticket_id], [event_id], [user_id], [category_ticket_id], [bill_id], [seat_id], [qr_code_value], [qr_issued_at], [status], [checkin_time], [check_out_time]) VALUES (121, 1014, 7, 1021, 52, 251, N'iVBORw0KGgoAAAANSUhEUgAAASwAAAEsAQAAAABRBrPYAAABEklEQVR42u3aOxLCIBCAYag4BkdNjsoRLKlA5CEkarSQzej8FJkYvlQ7yy5EFT8ZFwWDwWAw2E8xr+qw5U7HtT7QMDlWfsXVxqAWZ/LdMAETYmsO0Y0pm1/wOXaws5gysJNZFhp2DmsLVxquvXCwvsEmsF7EdQ3Wm1oP+z7rww+TB30vbAJLk4vrRdy/ThnYRNaeOxO2eQOTY61ytEuo2zz7kFmweSwvVybUvLk1tGmE51UGNpOVHDG7iMHk2FDE23LlWuxgUqw3tLt+ysME2bi5yzuKFKd0gQmzetBxb22VCQfnITARVkvKrpWCybB+AF6SR8MkWV24/Haf7WGCbPthtG8rTISJMf4OAYPBYLC/YVfraBNU40ggngAAAABJRU5ErkJggg==', CAST(N'2025-12-20T19:13:34.3810000' AS DateTime2), N'BOOKED', NULL, NULL)
INSERT [dbo].[Ticket] ([ticket_id], [event_id], [user_id], [category_ticket_id], [bill_id], [seat_id], [qr_code_value], [qr_issued_at], [status], [checkin_time], [check_out_time]) VALUES (132, 16, 7, 24, 53, 77, N'iVBORw0KGgoAAAANSUhEUgAAASwAAAEsAQAAAABRBrPYAAABEElEQVR42u3aTQ6DIBCGYVxxDI8qR/UIXbJiGn4ENVW7kDFtXhZGy+PqC8xgauSb8TIwGAwGg/0U86aMUYKZxA/iyg8DTI/lJ3FjvJttvFtPwJSYi8G4HFZ+IWYHe4S1sGDPsZhTeQGmz2S7UK72N1gHVou4L+vmotbDOrDNcMvked8Lu5v5EkyKaIqP02xDvMD0WB4hT5p9VwtTYksba2yx5YRnYYpM6mpZ6vdshk+ZwjqysKrf0sLaNbSwvqyO2kXVwzZMi20aWml71nzS98JuZ/Vwlyr5YViwzqx9bnKHrRRMj+XsYA+zUsTTuoGpsvbRL29XqaHdHStgfVkr4vF6GBasJ+PvEDAYDAb7G/YGehv8prqwlNAAAAAASUVORK5CYII=', CAST(N'2025-12-20T19:24:23.1150000' AS DateTime2), N'BOOKED', NULL, NULL)
INSERT [dbo].[Ticket] ([ticket_id], [event_id], [user_id], [category_ticket_id], [bill_id], [seat_id], [qr_code_value], [qr_issued_at], [status], [checkin_time], [check_out_time]) VALUES (138, 1014, 7, 1021, 54, 248, N'iVBORw0KGgoAAAANSUhEUgAAASwAAAEsAQAAAABRBrPYAAABE0lEQVR42u3aOw7DIAyA4TD1GBw1HLVH6MiEG940rZQOwVGrn6Ei5ctkgW2URb4ZjwUGg8FgsJ9ifinDbrNVvBFX/jAwPZafxFkJhdlxAabEXAyMs77/pNjBLmJyvwnsWhYXBXYRqweXvMxgmqwn8XpwHeR62PlsGCFvmaO6F3Y+S8HKScO0eurDwQWbyWKIItvydyloayaHqbI175bc3JVTa93vLNh0FkWrZbOIjzA1Ji1rJ9v6bG9gmqyM3FaEFjaYHusFbS6lwlDawtTY2Ny59sI+fcBms3LRUYuqfgkL02dDW2HekjhMi6U2rzV3AlNl5eBKVW19Ic1gamy89JO0mKra/ZaBzWR8DgGDwWCwv2FPO6N8VEDygC4AAAAASUVORK5CYII=', CAST(N'2025-12-20T20:12:59.3520000' AS DateTime2), N'CHECKED_IN', CAST(N'2026-01-01T13:15:50.8410000' AS DateTime2), NULL)
INSERT [dbo].[Ticket] ([ticket_id], [event_id], [user_id], [category_ticket_id], [bill_id], [seat_id], [qr_code_value], [qr_issued_at], [status], [checkin_time], [check_out_time]) VALUES (139, 1014, 7, 1022, 54, 258, N'iVBORw0KGgoAAAANSUhEUgAAASwAAAEsAQAAAABRBrPYAAABEklEQVR42u3aOw6DMAyA4TD1GBwVjsoROmbCJcQmvCQ6EKNWf4Yqha+TFT+gQb5Z7wCDwWAw2E+xGHS1066T2EivFxqYH8vfpG9lVNaub8CcWJ8C07exfMyxgz3EZHgJ7FmWbgrsIWaJSzY7mCcrRdwS10Wth93PVmvMR+aq74Xdz+Zg5aLRLP3USeKCVWVaPqx+2+44VsDqsfmg2DCR63da3f5kwaoyPTed2GnJIkUM5sXS9SFozppS2DJnH/IbrB47iVhJYTAnVhraXR6DebLNcDfkH4yH8gGrzfRBhxWN8hAW5s/iEiframGPsKlyLMOdwFyZJq7SVNkO5sY2L0aHPGxrPwXzYvwdAgaDwWB/wz7irdf4Mbvh0gAAAABJRU5ErkJggg==', CAST(N'2025-12-20T20:12:59.4340000' AS DateTime2), N'CHECKED_IN', CAST(N'2026-01-01T13:15:50.8410000' AS DateTime2), NULL)
INSERT [dbo].[Ticket] ([ticket_id], [event_id], [user_id], [category_ticket_id], [bill_id], [seat_id], [qr_code_value], [qr_issued_at], [status], [checkin_time], [check_out_time]) VALUES (140, 16, 7, 23, 55, 67, N'iVBORw0KGgoAAAANSUhEUgAAASwAAAEsAQAAAABRBrPYAAABHUlEQVR42u3aMRLCIBCFYVJ5DI6aHJUjWKbKGmCBxIxoITA6PwVj4me1A29JNPLJuBsYDAaDwX6KrUaH3S8Wu06y6I0J1o/FKxVxOn4B68QWXxit0y38wNcONoTlS9hAtup2BRvC0saVM6S+v8EasBziOT7qWQ9rwMpIZXvT98IasL1Ys/PRHfI7bFxxusF6s83M5ZNOsI4s5/e5YlZg/ZhsXmh1Sj8l7ik+YE2Z+Fupg/WrJZbNXlMG1pRJWTy+doenHbA+7NTQhoUS1s3sKn0v7OssH+7EJ3k63F1aKVhjVlL7cM6+PgCH9WCxbBof4mBDmOiJInRWlSe0sCasvAyKJXpxuIM1ZCXEw56VDxgC68f4OwQMBoPB/oY9AJsDUawqJmHJAAAAAElFTkSuQmCC', CAST(N'2025-12-21T21:07:11.4450000' AS DateTime2), N'BOOKED', NULL, NULL)
INSERT [dbo].[Ticket] ([ticket_id], [event_id], [user_id], [category_ticket_id], [bill_id], [seat_id], [qr_code_value], [qr_issued_at], [status], [checkin_time], [check_out_time]) VALUES (141, 16, 7, 23, 55, 66, N'iVBORw0KGgoAAAANSUhEUgAAASwAAAEsAQAAAABRBrPYAAABFUlEQVR42u3aOxKCMBCA4aTiGBwVjpojWKYiwuapKFiYZXT+FAySjyqTfQRN+GTcDAwGg8FgP8W8SWOMdzbM6YGF6bH4K8xjWMzkBrlrJmBKbJYl2pgZ5QUvawe7ipkBdjETYWHXsBy41uHyCwfxDdaB1SRu02Kd5HrY91kdvpk8qHthHdg6ObmaxP37LQPrykyMWcNa0IZm38BU2bSJnLWX3OYNAabKZHvIvkmTqcGAqbFSwdbmLjcYMC32IolLCHOnpRTse6wWtOWMI2YOD1NkT82dVFY5mMH0WDroaHLIcnAeAuvNUhlbilyYOsv7Jl72H4NgXVkKXLWeyh0eTI09fhgtbcW+uYP1Y/wdAgaDwWB/w+58XhREhctQpAAAAABJRU5ErkJggg==', CAST(N'2025-12-21T21:07:11.5740000' AS DateTime2), N'BOOKED', NULL, NULL)
INSERT [dbo].[Ticket] ([ticket_id], [event_id], [user_id], [category_ticket_id], [bill_id], [seat_id], [qr_code_value], [qr_issued_at], [status], [checkin_time], [check_out_time]) VALUES (142, 1014, 7, 1021, 56, 242, N'iVBORw0KGgoAAAANSUhEUgAAASwAAAEsAQAAAABRBrPYAAABI0lEQVR42u3aQQ6DIBCFYVx5DI+qR+UIXbpyKjAMNja0C8G0+V2QUD9Xk84bbJ18cz0cDAaDwWA/xVan17RvlmkdZNEPBlg/lnYq0nK8AevEllAYrdMYHwi1g93CbAu7ka3armC3sNy4LEPq/Q3WgFmIW3zUsx7WgJUrl+3D3AtrwPZizT5Ed8zv2LjSMsI6sr1E3umy39zCU2E5HytgLVkZaMVbxSYRWDcmkvIiVqfMU+JP8QFrx0LjkjRF6bfFpRPeOT5gzdghxNW6w9sOWB/2OtDa4W72tbkXdjWzw12sUz7cvRulYC1ZTu3NWpgmOaw/s8YV6+Rht7BDiG+1N7SwJqz8GKTHvHTCE1g/VkI8jLaiojJKwa5n/B0CBoPBYH/DnquFEPwDKJgzAAAAAElFTkSuQmCC', CAST(N'2026-01-01T13:19:30.7250000' AS DateTime2), N'CHECKED_OUT', CAST(N'2026-01-01T13:20:25.7850000' AS DateTime2), CAST(N'2026-01-01T15:37:57.3600000' AS DateTime2))
INSERT [dbo].[Ticket] ([ticket_id], [event_id], [user_id], [category_ticket_id], [bill_id], [seat_id], [qr_code_value], [qr_issued_at], [status], [checkin_time], [check_out_time]) VALUES (143, 1014, 7, 1021, 56, 243, N'iVBORw0KGgoAAAANSUhEUgAAASwAAAEsAQAAAABRBrPYAAABD0lEQVR42u3aPRKDIBCGYaw4hkeVo3KElFZuZnGF/GiSIqyTzEvhKD5W35B1MUE+GZcAg8FgMNhPsTnYGGUJk8yDJJsYYH5svZI06lmOenZ7A+bEkgaT1rDWBzQ72CmshQU7j2lO9gDMn8n9Qnn3+wbrwGoRn23dvKn1sA7sbqTt5uv3Xti32WzBlIgmvZxyXPQAc2SldC8mpFbynbYC1o9ZX2eJxdbhwRyZphO2hVKmcqiVHObDynxZI1Hq4tm6DJgjk72Np6NaD+vA9l5oo60bmBurzZ1GlA/DgnVmj9sbN/uvMHc2PO+Cw05grcEIMGfWPgatEeWw1RCYF2tFXI+HYcF6Mv4OAYPBYLC/YVfaPYuQjEXNlgAAAABJRU5ErkJggg==', CAST(N'2026-01-01T13:19:30.9480000' AS DateTime2), N'CHECKED_OUT', CAST(N'2026-01-01T13:20:25.7850000' AS DateTime2), CAST(N'2026-01-01T15:37:57.5200000' AS DateTime2))
INSERT [dbo].[Ticket] ([ticket_id], [event_id], [user_id], [category_ticket_id], [bill_id], [seat_id], [qr_code_value], [qr_issued_at], [status], [checkin_time], [check_out_time]) VALUES (144, 1014, 7, 1022, 56, 253, N'iVBORw0KGgoAAAANSUhEUgAAASwAAAEsAQAAAABRBrPYAAABFElEQVR42u3aMRKDIBCFYaw8hkeVo3qElFYSFlaFcRhTZHGS+akS/KzeAMsmLnwyXg4Gg8FgsJ9iq9Mx5U9D8DoxwPqx/C14YfMibCofwDox7/LDLSY06gsxO9hDTMOCPcfS/Ap7iO0bl+5Zd/sbzICdh7gmdnfWw77PzpFeGG/rXpgBS5uUnN/TEVvKablmCrNjskYkon2+ERbMkqUy9rjS6fGxXTcumCmTnMZYy4a1rKfiXIB1Y3KxDnsB5YuwYB1ZdYjPElsUW148sF7sLGjT4nGp56QBwrqx6nLnmmHBjFnVbqqqWlh/dvQ4WnUvzJ5V7SbfDAtmw4ofg0KzoIWZsrrp1wwLZsn4OwQMBoPB/oa9ASW3fK4H58f3AAAAAElFTkSuQmCC', CAST(N'2026-01-01T13:19:34.1440000' AS DateTime2), N'CHECKED_OUT', CAST(N'2026-01-01T13:20:25.7850000' AS DateTime2), CAST(N'2026-01-01T15:37:57.6833333' AS DateTime2))
INSERT [dbo].[Ticket] ([ticket_id], [event_id], [user_id], [category_ticket_id], [bill_id], [seat_id], [qr_code_value], [qr_issued_at], [status], [checkin_time], [check_out_time]) VALUES (145, 1014, 7, 1022, 56, 252, N'iVBORw0KGgoAAAANSUhEUgAAASwAAAEsAQAAAABRBrPYAAABGElEQVR42u3aTQ7CIBCGYbrqMXrU9qgcwSUrsPyN/UnQhQzRvCxI0KerSecD1IRPxsPAYDAYDPZTzJkyln2xLW4KW/lggumxvCoiT8cvYEpsi4UpdZrTA7F2sCFMlrCBzJV2BRvCauOSDGn3N1gHJiEu8dHOelgH9hq1bG/2vbAObC/WamN0p/xOjStPM0yP1Z615iCZfXxqn+41hXVk/iDMuWIwNZZSW6rjJDkcTJHVEi25hcny9srAOrJLiPu6qYIpsvOGVg53q23te2HfZtO1e6U63XZcsM6sXjelOK/n7PsFOEyDuWJTfAQLG8KClxD3rRtaWBd2+DEovSg2n/ACTI+dL/1CEe2tFOzLjL9DwGAwGOxv2BOMXHsK76tHvQAAAABJRU5ErkJggg==', CAST(N'2026-01-01T13:19:34.4660000' AS DateTime2), N'CHECKED_OUT', CAST(N'2026-01-01T13:20:25.7850000' AS DateTime2), CAST(N'2026-01-01T15:37:57.8233333' AS DateTime2))
INSERT [dbo].[Ticket] ([ticket_id], [event_id], [user_id], [category_ticket_id], [bill_id], [seat_id], [qr_code_value], [qr_issued_at], [status], [checkin_time], [check_out_time]) VALUES (154, 1028, 10, 1062, 61, 22, N'iVBORw0KGgoAAAANSUhEUgAAASwAAAEsAQAAAABRBrPYAAABCklEQVR42u3aMRKDIBCFYaw8BkeVo3qElFYSZFfBSRhThHWS+Skcgx/VG5dV4+In4+FgMBgMBvsptjgdXs6GGHRigNkx+RXDxqZ5Y76+ADNiwcnFNSU06oKUHewmpmHB7mN5foHdxPbCpTXrqr7BOrCyiWtiV3s97PusjLxgvOx7YR1YLlLb/u2P2HJO82umsL5MilTaxOvsYLYst7FSvWT7WMvNA7NjmlPpp+IMM2TyMKE5aVP1JixYX1ZXqrDFlrM7VsEsWGlo99jkEGGWrH64S+WqFRasM6tf+rlTVwu7g03tj0EwG1ZunhhlDmbI6pd+zb4X1pWdPoz6Zliwnoy/Q8BgMBjsb9gT/G48lILg1VoAAAAASUVORK5CYII=', CAST(N'2025-12-22T00:06:10.9300000' AS DateTime2), N'BOOKED', NULL, NULL)
INSERT [dbo].[Ticket] ([ticket_id], [event_id], [user_id], [category_ticket_id], [bill_id], [seat_id], [qr_code_value], [qr_issued_at], [status], [checkin_time], [check_out_time]) VALUES (155, 1028, 10, 1062, 62, 31, N'iVBORw0KGgoAAAANSUhEUgAAASwAAAEsAQAAAABRBrPYAAABDUlEQVR42u3aQRKDIAxAUVhxDI+qR/UIXbKS2gQFdbRdlDjtfBYMlucqQwhYlz5pDweDwWAw2E+x6HLrdOTTkH/wMDumT2no0uT6MciomoAZsUFC9GKukxeixA52F3MBdjMT4WH3sCVxzW1cXrjIb7AGrGziPgfrzV4P+z4rLVaTF3UvrAGbJ/uxbOLxfMnAGjK/7/K6CQlmysaw1rIaMaePMCv2mpR0JTaHqIxgJmwtaKuqFmbNqk3ca0ErYZMtBWbFSkG73nFoPRVhhmx3uJPKau5gxiznrJLCwnRxHwIzYbqMjhUXzIIt60a748cgWFOWE1fcnrMjzJBtLv3OjxWwloy/Q8BgMBjsb9gT7TZy9BpCZUIAAAAASUVORK5CYII=', CAST(N'2025-12-22T00:07:26.2490000' AS DateTime2), N'BOOKED', NULL, NULL)
INSERT [dbo].[Ticket] ([ticket_id], [event_id], [user_id], [category_ticket_id], [bill_id], [seat_id], [qr_code_value], [qr_issued_at], [status], [checkin_time], [check_out_time]) VALUES (156, 1028, 10, 1061, 62, 21, N'iVBORw0KGgoAAAANSUhEUgAAASwAAAEsAQAAAABRBrPYAAABF0lEQVR42u3aOw6DMAyAYZg4BkdNjsoROmbCbZwnhYoOJKjV7wFR+JgiOzZ0kG/iMcBgMBgM9lPMDTHm15kRN4qNF0ZYPxZ+iZ1ljWyub8A6MesXxs6uHHTtYDcxWSaB3cv8TYHdxFLhks0ZrCcrm3gqXCd7Pex6VsUaUuas74Vdz3SxwqYx5n7qoHDBWjIfi6aHS4ewk+/XFNaUxWxZw4SnYbyF9WJpvzBLmbOPChesJZNSs3zyTHnO3hUuWFMWI1xfQ7bAurLS0FbVa4R1ZvVwZ/MDZl/fYE1ZfNFRsiW9hIX1Z9VYEbta2A1Mx7w83AmsKyv9lI55+oBZPn2Sg7Vgmw+jelO72veUgbVk/B0CBoPBYH/Dnle/76QnJjcHAAAAAElFTkSuQmCC', CAST(N'2025-12-22T00:07:26.3410000' AS DateTime2), N'BOOKED', NULL, NULL)
INSERT [dbo].[Ticket] ([ticket_id], [event_id], [user_id], [category_ticket_id], [bill_id], [seat_id], [qr_code_value], [qr_issued_at], [status], [checkin_time], [check_out_time]) VALUES (157, 1028, 7, 1061, 63, 15, N'iVBORw0KGgoAAAANSUhEUgAAASwAAAEsAQAAAABRBrPYAAABFUlEQVR42u3aMQ6DMAyFYZg4BkeFo3KEjky8QkhiUKF0aIxa/RkQJV8mC9sJrfTJeFQwGAwGg/0UG6s42vmu01irjw9qmB9bf6lvNUXWbidgTqxfAtO3o11C7GA3MQ2NYPeyZVKwm1hKXNrdwTyZFfGUuC5qPez7bDOm9ZW56nth32chWGvRqHM/dZC4YIVZt5Ru2WSo5FUjmBuTNr2s5bG4FObD8nMl1r076ICVYl20S/1u8j77NXHBijEbuXwMqZrAvJg1tNZPHccUVpDtNnfDumCy7AVzYvGgQ7GBskNYmD8bc5xSVwu7hc2VI2/uBHNltreYE1decPZJDlaCbQ/9AlOI2MnmDlaE8XcIGAwGg/0NewLPgsms29pBlQAAAABJRU5ErkJggg==', CAST(N'2025-12-22T07:07:55.8170000' AS DateTime2), N'BOOKED', NULL, NULL)
INSERT [dbo].[Ticket] ([ticket_id], [event_id], [user_id], [category_ticket_id], [bill_id], [seat_id], [qr_code_value], [qr_issued_at], [status], [checkin_time], [check_out_time]) VALUES (158, 1028, 7, 1062, 63, 25, N'iVBORw0KGgoAAAANSUhEUgAAASwAAAEsAQAAAABRBrPYAAABEklEQVR42u3aOQ6DMBBAUVNxDI6Kj8oRUrpiovHGEggp4kGJvouI5bkazYIVJ5+sh4PBYDAY7KdYcHkNMrtRQic+P+hgdizdiR/0aur1av0CZsS8BsanYKUNGjvYLWwJFuw+pnHKG2D2TLaJclXfYA1YbeIh581Fr4c1YJvly8v3cy/s2yzkwMQQjXo7Tv2sPzA7JnN5XvKmdPIOZsZCnmWd0+jEDbWxw6xY6d/jUqummEG9wMxYLVxDrVlS2jnMii0r1qzl4Oms18MasKOBts95AzNj9eMu1ayzYMEas/3xxur8FWbOutdTcJg503RJTTzmDcyU7afaw4EW1pStm3j5uDsIFqwl4+8QMBgMBvsb9gSo7qFcTIxCwAAAAABJRU5ErkJggg==', CAST(N'2025-12-22T07:07:55.9700000' AS DateTime2), N'BOOKED', NULL, NULL)
INSERT [dbo].[Ticket] ([ticket_id], [event_id], [user_id], [category_ticket_id], [bill_id], [seat_id], [qr_code_value], [qr_issued_at], [status], [checkin_time], [check_out_time]) VALUES (159, 1028, 7, 1062, 64, 29, N'iVBORw0KGgoAAAANSUhEUgAAASwAAAEsAQAAAABRBrPYAAABH0lEQVR42u3aOw6DMAyA4TBxjByVHJUjdGTCJc4LKio6NEat/gyIwpfJiu2EOvlkPBwMBoPBYD/FFpeH3+4mWQYJ+cEAs2PplwQva2Z+/wJmxEIMTPBLu2jsYDcxmUeB3cviS4HdxEriksMdzJK1Il4S10Wth32f7caalsxV3wv7PtNgpaIx1H7qJHHBurJYurfH06xrpFbyk20FrBsTKZmqdlFOZ40CM2NaL8a4UMoKmk4TF6wni2NOwVrTJe+zlwFmymqcnJaPuVQTmBVrDW05c2qtLcyM7Td3IU9YW/aCGbF80NFWSzmEhdmz9LyIs1YKZsC0ja2bO4GZspy40javTnj3SQ7Wgx0O/XRjrRF7XTKwnoy/Q8BgMBjsb9gT05eu9GcwaLsAAAAASUVORK5CYII=', CAST(N'2025-12-22T07:13:07.9200000' AS DateTime2), N'BOOKED', NULL, NULL)
INSERT [dbo].[Ticket] ([ticket_id], [event_id], [user_id], [category_ticket_id], [bill_id], [seat_id], [qr_code_value], [qr_issued_at], [status], [checkin_time], [check_out_time]) VALUES (160, 1028, 7, 1062, 65, 54, N'iVBORw0KGgoAAAANSUhEUgAAASwAAAEsAQAAAABRBrPYAAABFklEQVR42u3aOw7DIAyAYTJxjBw1HJUjdMwUtzwDUat0CI5a/R4qWr5MFtiQGvkmHgYGg8FgsJ9iq8kxv0aLrJO4/MME02Ppm7hZtszmdgKmxFxIjJvX/SPmDnYTE28Fdi8LkwK7iZWNS7oRTJPtRbxsXCe1HnY9a2JLS+as74Vdz2KyUtGYaj/1ZuOCDWV1UqSr5IdkwUayILzpetkQy6F8wIaytGSirefsEN7AFNmUK0dMkbf1nL3C9Nge6VgR0laqCUyL7Q1tqiFb09rC1Fh76dc9IDBNli86IrPtJSxMn9WNS0pXC7uBhZGthzuBqbK8cYVe1pe0Lf7TKznYCNa9GI2Tsas9LhnYSMbfIWAwGAz2N+wJzAxQvNELuJ8AAAAASUVORK5CYII=', CAST(N'2025-12-22T07:18:41.7510000' AS DateTime2), N'BOOKED', NULL, NULL)
INSERT [dbo].[Ticket] ([ticket_id], [event_id], [user_id], [category_ticket_id], [bill_id], [seat_id], [qr_code_value], [qr_issued_at], [status], [checkin_time], [check_out_time]) VALUES (161, 1028, 7, 1061, 66, 17, N'iVBORw0KGgoAAAANSUhEUgAAASwAAAEsAQAAAABRBrPYAAABHUlEQVR42u3aPRLCIBCG4aXKMXLU5Kg5giVVMFl+dTRahM3ovBROlIeKgW8hSvim3QQGg8FgsJ9iXlIb45MLc/rBwexY/BbmMawyLYM+NR0wIzbrFO1MRh3gde5gVzEZYBczFQ52Dcsb19aWPOBgf4N1YDXEXZqsD1kPO5/V5pvOg7oX1oFtndNSQ9y/XzKwfiyWsdtHKEtmzJECs2Ia2LmW1VHyMsRhPVkuYzW/w364yxZmyNokn8phOw6FWbKHIAm6jy0HpRTsbFYL2rJnxeTwMEPWHu70RLHNk8RMhxmydNFRSlsZ1oP7EFhfVsrYWF4F2AWsrJu0eBzMkqWNy2sptTYXTzAz1r4Yneqx4qmghXVl/B0CBoPBYH/D7nljKZhxKZ5dAAAAAElFTkSuQmCC', CAST(N'2025-12-22T08:35:46.8870000' AS DateTime2), N'BOOKED', NULL, NULL)
INSERT [dbo].[Ticket] ([ticket_id], [event_id], [user_id], [category_ticket_id], [bill_id], [seat_id], [qr_code_value], [qr_issued_at], [status], [checkin_time], [check_out_time]) VALUES (162, 1029, 7, 1063, 67, 5, N'iVBORw0KGgoAAAANSUhEUgAAASwAAAEsAQAAAABRBrPYAAABF0lEQVR42u3aMRLCIBCFYaxyDI4ajpojWFIFwwKBKE4sZDM6fyolX6o32V1QEz657gYGg8FgsJ9i3uTLpk+34PLCDabH0rfgIpuXyGx7A6bEnEk31y2hKT+wZQe7iOWwYNcxWfewi1gpXLlmndU32ABWm3hO7KzXw77P6iUPTKdzL2wAkyIV+7fdY5OcltdMYcOYDFCy/pSTh+kxL2ItiaX2sXY3d7BxTMrVNsvG2OZQ5qluE4eNYjGdfaB1TVhTgGmyWqlcjE2yMzbA9FgdaFNscuZk4hsEU2Tt5i41km5YsMGsPfQzh6kWps/2M47e5g6mw+rLUxo7TJE1PwbVWXaZAkyPHQ/93oYFG8n4OwQMBoPB/oY9ANtoYKwMvjmvAAAAAElFTkSuQmCC', CAST(N'2025-12-22T09:37:35.2350000' AS DateTime2), N'BOOKED', NULL, NULL)
INSERT [dbo].[Ticket] ([ticket_id], [event_id], [user_id], [category_ticket_id], [bill_id], [seat_id], [qr_code_value], [qr_issued_at], [status], [checkin_time], [check_out_time]) VALUES (163, 1029, 7, 1063, 67, 15, N'iVBORw0KGgoAAAANSUhEUgAAASwAAAEsAQAAAABRBrPYAAABE0lEQVR42u3aOxKDIBCAYaw8hkeVo3KElFZu5K3GjCnCMsn8FA7CZ7XDLpAY+aQ9DAwGg8FgP8UWk9q09WZZBrFpYIDpsfgmdpI1sWk/AVNi1gfGTkt9hNjBOjFxo8D6Mj8psE4sJy459GCarBbxnLhuaj3s+2zX1rhk7va9sO+zEKxYNIayn7pIXLCWrGQql23svS4ZWEOWFootJ7zQ5lP5gDVldTy/xp4zMEXmq3ZJXGYs5+wFpsdqi+MbqykMpsTqhrbmsauYwpqy/aVf/mDNeQymxtJFR2Dj/hIWps9i/c7CZy9YBxYmy+FOYKosJS4fLFfC5t79JAdrwQ6XfuFgHSJ2XjKwloy/Q8BgMBjsb9gTEZuqCEZAwkgAAAAASUVORK5CYII=', CAST(N'2025-12-22T09:37:35.2990000' AS DateTime2), N'BOOKED', NULL, NULL)
INSERT [dbo].[Ticket] ([ticket_id], [event_id], [user_id], [category_ticket_id], [bill_id], [seat_id], [qr_code_value], [qr_issued_at], [status], [checkin_time], [check_out_time]) VALUES (164, 1029, 7, 1063, 67, 16, N'iVBORw0KGgoAAAANSUhEUgAAASwAAAEsAQAAAABRBrPYAAABGUlEQVR42u3aQRKDIAxAUVx5DI5ajsoRumRlqhCEduy0C4nTzs/Csfp2GRJCdfJN3B0MBoPBYD/FktPw691N0iRBH0wwO1Z+SfCyKPP9C5gRC1tigk/tknMHu4hJnAV2LdteCuwiVguXPN3BLFlr4rVwfej1sPNZF0tZMp/2vbDzWU5WaRrTvp86KFywoWzSS3Q6Vmgnf0kWbCSrCyXsE16OW3wpXLCRrPYLfZ7n7C1gluypUgU373N2ghmyPcrzlcXaTWBWrG1oWx07SBZsLOuHO+0heRkd9HrYQKYHHW211ENYmD0r/XvpdrWwS5jTJt7qGMyKaeFKeshU0hbf/SUHG8H6Q78yTMRZSxjMivE5BAwGg8H+hj0Am5mWlBMaT7gAAAAASUVORK5CYII=', CAST(N'2025-12-22T09:37:35.3630000' AS DateTime2), N'BOOKED', NULL, NULL)
INSERT [dbo].[Ticket] ([ticket_id], [event_id], [user_id], [category_ticket_id], [bill_id], [seat_id], [qr_code_value], [qr_issued_at], [status], [checkin_time], [check_out_time]) VALUES (165, 1029, 7, 1063, 67, 6, N'iVBORw0KGgoAAAANSUhEUgAAASwAAAEsAQAAAABRBrPYAAABE0lEQVR42u3aQRKDIAxAUVh5DI+qR+UIXbIyLRBAnXbsQuO081l0LDxWGUhAnXzTHg4Gg8FgsJ9i0WkbX0+TRC+zdniYHSv/ZB5lUTauB2BGbE6BmcfYf3LsYDcxCYPA7mVpUGA3sbpxyeYJZsl6Eq8b10Guh53PVm0pS+ao7oWdz3KwStLwrZ56s3HBrmS5P7WwzeRpKsyU1Yj1fWwKzsPMWOvXheJWsYOZsZa6U7DC0M7ZEWbHemvpI9RsArNivaAtpdSyKm1hZmxzuAt1wrQvaGEXM73oEC2g+iUszJ6V/irCILA7WCpjh3a4E5gp040r6iWTTvj0Sg52Bdu8GM2DOWL7JQO7kvE5BAwGg8H+hj0BgKOSXMb3jgkAAAAASUVORK5CYII=', CAST(N'2025-12-22T09:37:35.4400000' AS DateTime2), N'BOOKED', NULL, NULL)
INSERT [dbo].[Ticket] ([ticket_id], [event_id], [user_id], [category_ticket_id], [bill_id], [seat_id], [qr_code_value], [qr_issued_at], [status], [checkin_time], [check_out_time]) VALUES (166, 1029, 7, 1063, 68, 9, N'iVBORw0KGgoAAAANSUhEUgAAASwAAAEsAQAAAABRBrPYAAABEElEQVR42u3aPRLCIBCG4U2VY+SocFSOYJkqKH8BMkYtXDI6L4WTmIfqG9glKv6TcRMYDAaDwX6KrZLH4jcxfp28zV9MsHEs3Xm7hCs3h6v2AWwQsyEYm8JKE0J2sEtYDQt2HQs55Qmw8cz3C+Xd/gZTYHsRX/O6eVPrYQqsG7Y8fN33wr7N1hxMjMiEW+PmLXzAhrJHA1VOFG0ln2CDWT1W7Ce8Z2HBlFip3zExifXb7f0tbBCLEZUXHSJzt3hgg1gd3QRzWuthCqxpaKXds9xp3wtTYPvhLu1ZZ2HBlNnx9Ubz/hV2ATMedj0rRVxyUwUbx+qPQbY2tMfTB0yVdUXcnYYF02T8HQIGg8Fgf8Pu+yKyeBUvWRkAAAAASUVORK5CYII=', CAST(N'2025-12-22T09:38:38.8540000' AS DateTime2), N'BOOKED', NULL, NULL)
INSERT [dbo].[Ticket] ([ticket_id], [event_id], [user_id], [category_ticket_id], [bill_id], [seat_id], [qr_code_value], [qr_issued_at], [status], [checkin_time], [check_out_time]) VALUES (167, 1029, 7, 1063, 68, 10, N'iVBORw0KGgoAAAANSUhEUgAAASwAAAEsAQAAAABRBrPYAAABGElEQVR42u3aQRKDIAxAUVx5DI4qR/UIXbIylQCCHTt2UeO081l0rDxXGZKAOvlkPBwMBoPBYD/FoivDr1eTxEFCuTHA7Fj+J8HLUpjvJ2BGLKTABB/bj8YOdhOTeRTYvSxNCuwmVhOX7K5glqwV8Zq4Tmo97PusG0teMmd9L+z7TIOVi8aw9VMHiQt2Jat2krqtyJX8aMnALmNrdGa362XT0HswK6b1YkwLRROXRiwNmCVLk9rQ5hCN2z47wgxZn72clo+5VhOYFWsNrbR1M8CMWb+5C/0DArNk5aCjrZZ6CAuzZ1vi2rpa2C2sFnHXNtswI1YSVyyHTOWBd6/kYFew/sVoPurTiL0uGdiVjM8hYDAYDPY37Akq4T50spm1HQAAAABJRU5ErkJggg==', CAST(N'2025-12-22T09:38:38.9180000' AS DateTime2), N'BOOKED', NULL, NULL)
INSERT [dbo].[Ticket] ([ticket_id], [event_id], [user_id], [category_ticket_id], [bill_id], [seat_id], [qr_code_value], [qr_issued_at], [status], [checkin_time], [check_out_time]) VALUES (168, 1029, 7, 1063, 68, 20, N'iVBORw0KGgoAAAANSUhEUgAAASwAAAEsAQAAAABRBrPYAAABCklEQVR42u3aQQ6DIBCF4XHlMTyqHNUjdMlK2gFENKF2Uca0+WfRSPlcvQBTUgmf1ENgMBgMBvsp5iXXFFaZgx+Cy18MMDuWRsFN+rSM+lRPwIyY02BcCiu9oNnBbmF7WLD7mOaUX4DZs3BcKFf7G6wDK4e4z+vm4qyHdWCHctvk+74X9m3mczAxolmH8zKu+gEzZCrGslOdulqYDXu1saIshRVzCtsWBrNiaZQnUy0Cs2ayXW/ExJphwXqyveKetV88tc56WAdWNbR1bHHdwMxY+XEXD5JmWLDO7Hy90ey4YAbssu+F2bDc0MZ1AzNl9aVfaWhlhBmywyHeDgvWk/F3CBgMBoP9DXsCS2vXYmehUGQAAAAASUVORK5CYII=', CAST(N'2025-12-22T09:38:38.9670000' AS DateTime2), N'CHECKED_IN', CAST(N'2025-12-28T14:01:40.4910000' AS DateTime2), NULL)
INSERT [dbo].[Ticket] ([ticket_id], [event_id], [user_id], [category_ticket_id], [bill_id], [seat_id], [qr_code_value], [qr_issued_at], [status], [checkin_time], [check_out_time]) VALUES (169, 1029, 7, 1063, 68, 19, N'iVBORw0KGgoAAAANSUhEUgAAASwAAAEsAQAAAABRBrPYAAABFUlEQVR42u3aOw6DMAyA4TBxjBw1OWqO0JEJl7yDREUHMGr1e6go+TJFwXbAyDfxMjAYDAaD/RRbTAm7XTlZJvHlxgTTY/mfeCtrYXYcgCkxHxfG26X/pLWDPcQkzAJ7lsVBgT3E6oNLdlcwTdaTeH1wneR62PVsiDVvmbO6F3Y9S4uVk8bU6qmDBxfsThaXKG+PNpgyeZwK02J10LcOL4U72DKw21iMYEp3nWa5cm+CabKhgg1z67MXmCorkduKjYWaTWBarBe0KX+neupgsWD3st2hXxgmCEyTlYOOvlvqISxMnw1tRalqYc8wM7fmTmCqrNZT4yGsC59eycHuYOOL0dxsp6o2zAJTY3wOAYPBYLC/YW8ATHOK4nY8ewAAAABJRU5ErkJggg==', CAST(N'2025-12-22T09:38:39.5380000' AS DateTime2), N'CHECKED_OUT', CAST(N'2025-12-28T14:02:14.6990000' AS DateTime2), CAST(N'2025-12-28T15:56:04.4800000' AS DateTime2))
SET IDENTITY_INSERT [dbo].[Ticket] OFF
GO
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([user_id], [full_name], [email], [phone], [password_hash], [role], [status], [created_at], [Wallet]) VALUES (1, N'Nguyễn Văn An', N'an.nvse14001@fpt.edu.vn', N'0901000100', N'8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', N'STUDENT', N'ACTIVE', CAST(N'2025-12-01T09:16:32.7895734' AS DateTime2), CAST(0.00 AS Decimal(18, 2)))
INSERT [dbo].[Users] ([user_id], [full_name], [email], [phone], [password_hash], [role], [status], [created_at], [Wallet]) VALUES (2, N'Trần Thị Bình', N'binh.ttse14002@fpt.edu.vn', N'0902000200', N'8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', N'STUDENT', N'ACTIVE', CAST(N'2025-12-01T09:16:32.7895734' AS DateTime2), CAST(0.00 AS Decimal(18, 2)))
INSERT [dbo].[Users] ([user_id], [full_name], [email], [phone], [password_hash], [role], [status], [created_at], [Wallet]) VALUES (3, N'Lê Quang Huy', N'huy.lqclub@fpt.edu.vn', N'0903000300', N'8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', N'ORGANIZER', N'ACTIVE', CAST(N'2025-12-01T09:16:32.7895734' AS DateTime2), CAST(0.00 AS Decimal(18, 2)))
INSERT [dbo].[Users] ([user_id], [full_name], [email], [phone], [password_hash], [role], [status], [created_at], [Wallet]) VALUES (4, N'Phạm Minh Thu', N'thu.pmso@fpt.edu.vn', N'0904000400', N'8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', N'STAFF', N'ACTIVE', CAST(N'2025-12-01T09:16:32.7895734' AS DateTime2), CAST(0.00 AS Decimal(18, 2)))
INSERT [dbo].[Users] ([user_id], [full_name], [email], [phone], [password_hash], [role], [status], [created_at], [Wallet]) VALUES (5, N'Quản trị hệ thống', N'admin.event@fpt.edu.vn', N'0905000500', N'8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', N'ADMIN', N'ACTIVE', CAST(N'2025-12-01T09:16:32.7895734' AS DateTime2), CAST(0.00 AS Decimal(18, 2)))
INSERT [dbo].[Users] ([user_id], [full_name], [email], [phone], [password_hash], [role], [status], [created_at], [Wallet]) VALUES (7, N'Nguyen Vo Minh Chau', N'nguyenvominhchau165@gmail.com', N'0901000123', N'99e5fee36796021ffed4198e0ba9a98c1e5dd44fbb597bf1a9a1b93141e31697', N'STUDENT', N'ACTIVE', CAST(N'2025-12-01T12:26:17.7984701' AS DateTime2), CAST(200000.00 AS Decimal(18, 2)))
INSERT [dbo].[Users] ([user_id], [full_name], [email], [phone], [password_hash], [role], [status], [created_at], [Wallet]) VALUES (9, N'Nguyễn Võ Minh Châu', N'jaelynfox@muagicungre.com', N'0373253725', N'db45e60dbcd828b39ca720d7f2202a63399b4563d05030bc4295380eb5966385', N'STUDENT', N'ACTIVE', CAST(N'2025-12-21T20:51:56.7912859' AS DateTime2), CAST(0.00 AS Decimal(18, 2)))
INSERT [dbo].[Users] ([user_id], [full_name], [email], [phone], [password_hash], [role], [status], [created_at], [Wallet]) VALUES (10, N'Nguyễn Võ Kim Ngân', N'nguyenvkngan261001@gmail.com', N'0923828824', N'99e5fee36796021ffed4198e0ba9a98c1e5dd44fbb597bf1a9a1b93141e31697', N'STUDENT', N'ACTIVE', CAST(N'2025-12-22T00:05:02.1540829' AS DateTime2), CAST(0.00 AS Decimal(18, 2)))
INSERT [dbo].[Users] ([user_id], [full_name], [email], [phone], [password_hash], [role], [status], [created_at], [Wallet]) VALUES (11, N'Châu', N'jc104@gmail2.gq', N'0933307646', N'6ef133bdc8609e45457a2e152e81713214abef6141da0c29e1013e51fa022661', N'STUDENT', N'ACTIVE', CAST(N'2025-12-22T07:55:35.5895086' AS DateTime2), CAST(0.00 AS Decimal(18, 2)))
SET IDENTITY_INSERT [dbo].[Users] OFF
GO
SET IDENTITY_INSERT [dbo].[Venue] ON 

INSERT [dbo].[Venue] ([venue_id], [venue_name], [location], [status]) VALUES (1, N'Nhà văn hóa sinh viên Đại học Quốc gia Tp HCM', N'Khu đô thị Đại học Quốc gia TP.HCM.', N'AVAILABLE')
INSERT [dbo].[Venue] ([venue_id], [venue_name], [location], [status]) VALUES (2, N'FPT University HCM Campus', N'Khu Công nghệ cao, Phường Long Thạnh Mỹ, Thành Phố Thủ Đức, Tp.HCM', N'AVAILABLE')
SET IDENTITY_INSERT [dbo].[Venue] OFF
GO
SET IDENTITY_INSERT [dbo].[Venue_Area] ON 

INSERT [dbo].[Venue_Area] ([area_id], [venue_id], [area_name], [floor], [capacity], [status]) VALUES (1, 1, N'Lầu 2, Hội trường nhà văn hóa sinh viên', N'2', 60, N'AVAILABLE')
INSERT [dbo].[Venue_Area] ([area_id], [venue_id], [area_name], [floor], [capacity], [status]) VALUES (6, 2, N'Sảnh lầu 4, P.408', N'4', 50, N'AVAILABLE')
INSERT [dbo].[Venue_Area] ([area_id], [venue_id], [area_name], [floor], [capacity], [status]) VALUES (7, 2, N'Sảnh lầu 3, P.306', N'3', 100, N'AVAILABLE')
INSERT [dbo].[Venue_Area] ([area_id], [venue_id], [area_name], [floor], [capacity], [status]) VALUES (8, 1, N'Hội Trường Lớn', N'2', 100, N'AVAILABLE')
INSERT [dbo].[Venue_Area] ([area_id], [venue_id], [area_name], [floor], [capacity], [status]) VALUES (9, 2, N'Phòng Sự Kiện', N'1', 40, N'AVAILABLE')
SET IDENTITY_INSERT [dbo].[Venue_Area] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ_CategoryTicket_Event_Name]    Script Date: 22/12/2025 2:25:26 CH ******/
ALTER TABLE [dbo].[Category_Ticket] ADD  CONSTRAINT [UQ_CategoryTicket_Event_Name] UNIQUE NONCLUSTERED 
(
	[event_id] ASC,
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Report_Status_CreatedAt]    Script Date: 22/12/2025 2:25:26 CH ******/
CREATE NONCLUSTERED INDEX [IX_Report_Status_CreatedAt] ON [dbo].[Report]
(
	[status] ASC,
	[created_at] DESC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Report_TicketId]    Script Date: 22/12/2025 2:25:26 CH ******/
CREATE NONCLUSTERED INDEX [IX_Report_TicketId] ON [dbo].[Report]
(
	[ticket_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Report_UserId]    Script Date: 22/12/2025 2:25:26 CH ******/
CREATE NONCLUSTERED INDEX [IX_Report_UserId] ON [dbo].[Report]
(
	[user_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ_Seat_Area_SeatCode]    Script Date: 22/12/2025 2:25:26 CH ******/
ALTER TABLE [dbo].[Seat] ADD  CONSTRAINT [UQ_Seat_Area_SeatCode] UNIQUE NONCLUSTERED 
(
	[area_id] ASC,
	[seat_code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [UQ_Ticket_Event_Seat]    Script Date: 22/12/2025 2:25:26 CH ******/
ALTER TABLE [dbo].[Ticket] ADD  CONSTRAINT [UQ_Ticket_Event_Seat] UNIQUE NONCLUSTERED 
(
	[event_id] ASC,
	[seat_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Users__AB6E616407CE7F93]    Script Date: 22/12/2025 2:25:26 CH ******/
ALTER TABLE [dbo].[Users] ADD UNIQUE NONCLUSTERED 
(
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ_VenueArea_Venue_AreaName]    Script Date: 22/12/2025 2:25:26 CH ******/
ALTER TABLE [dbo].[Venue_Area] ADD  CONSTRAINT [UQ_VenueArea_Venue_AreaName] UNIQUE NONCLUSTERED 
(
	[venue_id] ASC,
	[area_name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Bill] ADD  CONSTRAINT [DF_Bill_Currency]  DEFAULT ('VND') FOR [currency]
GO
ALTER TABLE [dbo].[Bill] ADD  CONSTRAINT [DF_Bill_PaymentStatus]  DEFAULT ('PENDING') FOR [payment_status]
GO
ALTER TABLE [dbo].[Bill] ADD  CONSTRAINT [DF_Bill_CreatedAt]  DEFAULT (sysdatetime()) FOR [created_at]
GO
ALTER TABLE [dbo].[Category_Ticket] ADD  CONSTRAINT [DF_CategoryTicket_Price]  DEFAULT ((0)) FOR [price]
GO
ALTER TABLE [dbo].[Category_Ticket] ADD  CONSTRAINT [DF_CategoryTicket_Status]  DEFAULT ('ACTIVE') FOR [status]
GO
ALTER TABLE [dbo].[Event] ADD  CONSTRAINT [DF_Event_Status]  DEFAULT ('OPEN') FOR [status]
GO
ALTER TABLE [dbo].[Event] ADD  CONSTRAINT [DF_Event_CreatedAt]  DEFAULT (sysdatetime()) FOR [created_at]
GO
ALTER TABLE [dbo].[Event_Request] ADD  CONSTRAINT [DF_EventRequest_Status]  DEFAULT ('PENDING') FOR [status]
GO
ALTER TABLE [dbo].[Event_Request] ADD  CONSTRAINT [DF_EventRequest_CreatedAt]  DEFAULT (sysdatetime()) FOR [created_at]
GO
ALTER TABLE [dbo].[Event_Seat_Layout] ADD  CONSTRAINT [DF_EventSeatLayout_Status]  DEFAULT ('AVAILABLE') FOR [status]
GO
ALTER TABLE [dbo].[Report] ADD  DEFAULT (sysutcdatetime()) FOR [created_at]
GO
ALTER TABLE [dbo].[Report] ADD  DEFAULT (N'PENDING') FOR [status]
GO
ALTER TABLE [dbo].[Seat] ADD  CONSTRAINT [DF_Seat_Status]  DEFAULT ('ACTIVE') FOR [status]
GO
ALTER TABLE [dbo].[Ticket] ADD  CONSTRAINT [DF_Ticket_QRIssuedAt]  DEFAULT (sysdatetime()) FOR [qr_issued_at]
GO
ALTER TABLE [dbo].[Ticket] ADD  CONSTRAINT [DF_Ticket_Status]  DEFAULT ('BOOKED') FOR [status]
GO
ALTER TABLE [dbo].[Users] ADD  CONSTRAINT [DF_Users_Status]  DEFAULT ('ACTIVE') FOR [status]
GO
ALTER TABLE [dbo].[Users] ADD  CONSTRAINT [DF_Users_CreatedAt]  DEFAULT (sysdatetime()) FOR [created_at]
GO
ALTER TABLE [dbo].[Users] ADD  DEFAULT ((0)) FOR [Wallet]
GO
ALTER TABLE [dbo].[Venue] ADD  CONSTRAINT [DF_Venue_Status]  DEFAULT ('AVAILABLE') FOR [status]
GO
ALTER TABLE [dbo].[Venue_Area] ADD  CONSTRAINT [DF_VenueArea_Status]  DEFAULT ('AVAILABLE') FOR [status]
GO
ALTER TABLE [dbo].[Bill]  WITH CHECK ADD  CONSTRAINT [FK_Bill_User] FOREIGN KEY([user_id])
REFERENCES [dbo].[Users] ([user_id])
GO
ALTER TABLE [dbo].[Bill] CHECK CONSTRAINT [FK_Bill_User]
GO
ALTER TABLE [dbo].[Category_Ticket]  WITH CHECK ADD  CONSTRAINT [FK_CategoryTicket_Event] FOREIGN KEY([event_id])
REFERENCES [dbo].[Event] ([event_id])
GO
ALTER TABLE [dbo].[Category_Ticket] CHECK CONSTRAINT [FK_CategoryTicket_Event]
GO
ALTER TABLE [dbo].[Event]  WITH CHECK ADD  CONSTRAINT [FK_Event_Area] FOREIGN KEY([area_id])
REFERENCES [dbo].[Venue_Area] ([area_id])
GO
ALTER TABLE [dbo].[Event] CHECK CONSTRAINT [FK_Event_Area]
GO
ALTER TABLE [dbo].[Event]  WITH CHECK ADD  CONSTRAINT [FK_Event_CreatedBy] FOREIGN KEY([created_by])
REFERENCES [dbo].[Users] ([user_id])
GO
ALTER TABLE [dbo].[Event] CHECK CONSTRAINT [FK_Event_CreatedBy]
GO
ALTER TABLE [dbo].[Event]  WITH CHECK ADD  CONSTRAINT [FK_Event_Speaker] FOREIGN KEY([speaker_id])
REFERENCES [dbo].[Speaker] ([speaker_id])
GO
ALTER TABLE [dbo].[Event] CHECK CONSTRAINT [FK_Event_Speaker]
GO
ALTER TABLE [dbo].[Event_Request]  WITH CHECK ADD  CONSTRAINT [FK_EventRequest_Event] FOREIGN KEY([created_event_id])
REFERENCES [dbo].[Event] ([event_id])
GO
ALTER TABLE [dbo].[Event_Request] CHECK CONSTRAINT [FK_EventRequest_Event]
GO
ALTER TABLE [dbo].[Event_Request]  WITH CHECK ADD  CONSTRAINT [FK_EventRequest_ProcessedBy] FOREIGN KEY([processed_by])
REFERENCES [dbo].[Users] ([user_id])
GO
ALTER TABLE [dbo].[Event_Request] CHECK CONSTRAINT [FK_EventRequest_ProcessedBy]
GO
ALTER TABLE [dbo].[Event_Request]  WITH CHECK ADD  CONSTRAINT [FK_EventRequest_Requester] FOREIGN KEY([requester_id])
REFERENCES [dbo].[Users] ([user_id])
GO
ALTER TABLE [dbo].[Event_Request] CHECK CONSTRAINT [FK_EventRequest_Requester]
GO
ALTER TABLE [dbo].[Event_Seat_Layout]  WITH CHECK ADD  CONSTRAINT [FK_EventSeatLayout_Event] FOREIGN KEY([event_id])
REFERENCES [dbo].[Event] ([event_id])
GO
ALTER TABLE [dbo].[Event_Seat_Layout] CHECK CONSTRAINT [FK_EventSeatLayout_Event]
GO
ALTER TABLE [dbo].[Event_Seat_Layout]  WITH CHECK ADD  CONSTRAINT [FK_EventSeatLayout_Seat] FOREIGN KEY([seat_id])
REFERENCES [dbo].[Seat] ([seat_id])
GO
ALTER TABLE [dbo].[Event_Seat_Layout] CHECK CONSTRAINT [FK_EventSeatLayout_Seat]
GO
ALTER TABLE [dbo].[Report]  WITH CHECK ADD  CONSTRAINT [FK_Report_ProcessedBy] FOREIGN KEY([processed_by])
REFERENCES [dbo].[Users] ([user_id])
GO
ALTER TABLE [dbo].[Report] CHECK CONSTRAINT [FK_Report_ProcessedBy]
GO
ALTER TABLE [dbo].[Report]  WITH CHECK ADD  CONSTRAINT [FK_Report_Ticket] FOREIGN KEY([ticket_id])
REFERENCES [dbo].[Ticket] ([ticket_id])
GO
ALTER TABLE [dbo].[Report] CHECK CONSTRAINT [FK_Report_Ticket]
GO
ALTER TABLE [dbo].[Report]  WITH CHECK ADD  CONSTRAINT [FK_Report_User] FOREIGN KEY([user_id])
REFERENCES [dbo].[Users] ([user_id])
GO
ALTER TABLE [dbo].[Report] CHECK CONSTRAINT [FK_Report_User]
GO
ALTER TABLE [dbo].[Seat]  WITH CHECK ADD  CONSTRAINT [FK_Seat_Area] FOREIGN KEY([area_id])
REFERENCES [dbo].[Venue_Area] ([area_id])
GO
ALTER TABLE [dbo].[Seat] CHECK CONSTRAINT [FK_Seat_Area]
GO
ALTER TABLE [dbo].[Ticket]  WITH CHECK ADD  CONSTRAINT [FK_Ticket_Bill] FOREIGN KEY([bill_id])
REFERENCES [dbo].[Bill] ([bill_id])
GO
ALTER TABLE [dbo].[Ticket] CHECK CONSTRAINT [FK_Ticket_Bill]
GO
ALTER TABLE [dbo].[Ticket]  WITH CHECK ADD  CONSTRAINT [FK_Ticket_CategoryTicket] FOREIGN KEY([category_ticket_id])
REFERENCES [dbo].[Category_Ticket] ([category_ticket_id])
GO
ALTER TABLE [dbo].[Ticket] CHECK CONSTRAINT [FK_Ticket_CategoryTicket]
GO
ALTER TABLE [dbo].[Ticket]  WITH CHECK ADD  CONSTRAINT [FK_Ticket_Event] FOREIGN KEY([event_id])
REFERENCES [dbo].[Event] ([event_id])
GO
ALTER TABLE [dbo].[Ticket] CHECK CONSTRAINT [FK_Ticket_Event]
GO
ALTER TABLE [dbo].[Ticket]  WITH CHECK ADD  CONSTRAINT [FK_Ticket_Seat] FOREIGN KEY([seat_id])
REFERENCES [dbo].[Seat] ([seat_id])
GO
ALTER TABLE [dbo].[Ticket] CHECK CONSTRAINT [FK_Ticket_Seat]
GO
ALTER TABLE [dbo].[Ticket]  WITH CHECK ADD  CONSTRAINT [FK_Ticket_User] FOREIGN KEY([user_id])
REFERENCES [dbo].[Users] ([user_id])
GO
ALTER TABLE [dbo].[Ticket] CHECK CONSTRAINT [FK_Ticket_User]
GO
ALTER TABLE [dbo].[Venue_Area]  WITH CHECK ADD  CONSTRAINT [FK_VenueArea_Venue] FOREIGN KEY([venue_id])
REFERENCES [dbo].[Venue] ([venue_id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Venue_Area] CHECK CONSTRAINT [FK_VenueArea_Venue]
GO
ALTER TABLE [dbo].[Bill]  WITH CHECK ADD CHECK  (([payment_status]='REFUNDED' OR [payment_status]='FAILED' OR [payment_status]='PAID' OR [payment_status]='PENDING'))
GO
ALTER TABLE [dbo].[Category_Ticket]  WITH CHECK ADD CHECK  (([max_quantity]>(0)))
GO
ALTER TABLE [dbo].[Category_Ticket]  WITH CHECK ADD CHECK  (([status]='INACTIVE' OR [status]='ACTIVE'))
GO
ALTER TABLE [dbo].[Event]  WITH CHECK ADD CHECK  (([max_seats]>(0)))
GO
ALTER TABLE [dbo].[Event]  WITH CHECK ADD CHECK  (([status]='CANCELLED' OR [status]='CLOSED' OR [status]='OPEN' OR [status]='DRAFT'))
GO
ALTER TABLE [dbo].[Event]  WITH CHECK ADD  CONSTRAINT [CK_Event_Time] CHECK  (([end_time]>[start_time]))
GO
ALTER TABLE [dbo].[Event] CHECK CONSTRAINT [CK_Event_Time]
GO
ALTER TABLE [dbo].[Event_Request]  WITH CHECK ADD  CONSTRAINT [CK_EventRequest_Status] CHECK  (([status]='REJECTED' OR [status]='APPROVED' OR [status]='PENDING'))
GO
ALTER TABLE [dbo].[Event_Request] CHECK CONSTRAINT [CK_EventRequest_Status]
GO
ALTER TABLE [dbo].[Event_Seat_Layout]  WITH CHECK ADD  CONSTRAINT [CK_EventSeatLayout_SeatType] CHECK  (([seat_type]='STANDARD' OR [seat_type]='VIP'))
GO
ALTER TABLE [dbo].[Event_Seat_Layout] CHECK CONSTRAINT [CK_EventSeatLayout_SeatType]
GO
ALTER TABLE [dbo].[Event_Seat_Layout]  WITH CHECK ADD  CONSTRAINT [CK_EventSeatLayout_Status] CHECK  (([status]='INAVAILABLE' OR [status]='BOOKED' OR [status]='HOLD' OR [status]='AVAILABLE'))
GO
ALTER TABLE [dbo].[Event_Seat_Layout] CHECK CONSTRAINT [CK_EventSeatLayout_Status]
GO
ALTER TABLE [dbo].[Report]  WITH CHECK ADD CHECK  (([status]=N'CANCELLED' OR [status]=N'REJECTED' OR [status]=N'APPROVED' OR [status]=N'PENDING'))
GO
ALTER TABLE [dbo].[Seat]  WITH CHECK ADD CHECK  (([status]='INACTIVE' OR [status]='ACTIVE'))
GO
ALTER TABLE [dbo].[Ticket]  WITH CHECK ADD  CONSTRAINT [CK_Ticket_Status] CHECK  (([status]='REFUNDED' OR [status]='EXPIRED' OR [status]='CHECKED_OUT' OR [status]='CHECKED_IN' OR [status]='BOOKED'))
GO
ALTER TABLE [dbo].[Ticket] CHECK CONSTRAINT [CK_Ticket_Status]
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD CHECK  (([role]='ADMIN' OR [role]='STAFF' OR [role]='ORGANIZER' OR [role]='STUDENT'))
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD CHECK  (([status]='BLOCKED' OR [status]='INACTIVE' OR [status]='ACTIVE'))
GO
ALTER TABLE [dbo].[Venue]  WITH CHECK ADD CHECK  (([status]='UNAVAILABLE' OR [status]='AVAILABLE'))
GO
ALTER TABLE [dbo].[Venue_Area]  WITH CHECK ADD CHECK  (([capacity]>(0)))
GO
ALTER TABLE [dbo].[Venue_Area]  WITH CHECK ADD CHECK  (([status]='UNAVAILABLE' OR [status]='AVAILABLE'))
GO
/****** Object:  StoredProcedure [dbo].[usp_CloseExpiredEvents_CascadeAll]    Script Date: 22/12/2025 2:25:26 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[usp_CloseExpiredEvents_CascadeAll]
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    DECLARE @Now DATETIME2(7) = SYSDATETIME();

    DECLARE @ExpiredEvents TABLE (event_id INT PRIMARY KEY);

    -- Chọn các event cần đóng
    INSERT INTO @ExpiredEvents(event_id)
    SELECT e.event_id
    FROM dbo.[Event] e WITH (READPAST)
    WHERE e.[status] = 'OPEN'
      AND e.end_time <= @Now;

    IF NOT EXISTS (SELECT 1 FROM @ExpiredEvents)
        RETURN;

    BEGIN TRAN;

    /* 1) Event -> CLOSED */
    UPDATE e
    SET e.[status] = 'CLOSED'
    FROM dbo.[Event] e
    INNER JOIN @ExpiredEvents x ON x.event_id = e.event_id;

    /* 2) Category_Ticket -> INACTIVE */
    UPDATE ct
    SET ct.[status] = 'INACTIVE'
    FROM dbo.Category_Ticket ct
    INNER JOIN @ExpiredEvents x ON x.event_id = ct.event_id
    WHERE ct.[status] <> 'INACTIVE';

    /* 3) Ticket -> EXPIRED (trừ CHECKED_IN và CANCELLED) */
    UPDATE t
    SET t.[status] = 'EXPIRED'
    FROM dbo.Ticket t
    INNER JOIN @ExpiredEvents x ON x.event_id = t.event_id
    WHERE t.[status] NOT IN ('CHECKED_IN', 'CANCELLED', 'EXPIRED');

    /* 4) Seat -> INAVAILABLE (khóa toàn bộ ghế của event đã đóng) */
    UPDATE s
    SET s.[status] = 'INAVAILABLE'
    FROM dbo.Event_Seat_Layout s
    INNER JOIN @ExpiredEvents x ON x.event_id = s.event_id
    WHERE s.[status] <> 'INAVAILABLE';

    COMMIT TRAN;
END
GO
USE [master]
GO
ALTER DATABASE [FPTEventManagement] SET  READ_WRITE 
GO

--!- Create login and user for admin account

IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = '$(DB_USER)')
BEGIN
    CREATE LOGIN [$(DB_USER)] WITH PASSWORD = '$(DB_PASSWORD)', CHECK_POLICY = OFF, CHECK_EXPIRATION = OFF, DEFAULT_DATABASE = [FPTEventManagement];
END
GO

USE [FPTEventManagement]
GO
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = '$(DB_USER)')
BEGIN
    CREATE USER [$(DB_USER)] FOR LOGIN [$(DB_USER)];
    ALTER ROLE [db_datareader] ADD MEMBER [$(DB_USER)];
	ALTER ROLE [db_datawriter] ADD MEMBER [$(DB_USER)];
END
ELSE
BEGIN
	IF EXISTS (SELECT * FROM sys.database_principals WHERE name = '$(DB_USER)')
	BEGIN
		ALTER USER [$(DB_USER)] WITH LOGIN = [$(DB_USER)];
	END
END
GO
