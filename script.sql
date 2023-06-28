USE [master]
GO
/****** Object:  Database [AIRMAC]    Script Date: 28-Jun-23 8:50:47 PM ******/
CREATE DATABASE [AIRMAC]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'AIRMAC', FILENAME = N'C:\Users\Administrator\AIRMAC.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'AIRMAC_log', FILENAME = N'C:\Users\Administrator\AIRMAC_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [AIRMAC] SET COMPATIBILITY_LEVEL = 130
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [AIRMAC].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [AIRMAC] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [AIRMAC] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [AIRMAC] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [AIRMAC] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [AIRMAC] SET ARITHABORT OFF 
GO
ALTER DATABASE [AIRMAC] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [AIRMAC] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [AIRMAC] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [AIRMAC] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [AIRMAC] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [AIRMAC] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [AIRMAC] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [AIRMAC] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [AIRMAC] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [AIRMAC] SET  DISABLE_BROKER 
GO
ALTER DATABASE [AIRMAC] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [AIRMAC] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [AIRMAC] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [AIRMAC] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [AIRMAC] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [AIRMAC] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [AIRMAC] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [AIRMAC] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [AIRMAC] SET  MULTI_USER 
GO
ALTER DATABASE [AIRMAC] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [AIRMAC] SET DB_CHAINING OFF 
GO
ALTER DATABASE [AIRMAC] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [AIRMAC] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [AIRMAC] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [AIRMAC] SET QUERY_STORE = OFF
GO
USE [AIRMAC]
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
USE [AIRMAC]
GO
/****** Object:  UserDefinedFunction [dbo].[hours_add]    Script Date: 28-Jun-23 8:50:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[hours_add](@h1 decimal(18,2), @h2 decimal(18,2))  
RETURNS decimal(18,2) AS  
BEGIN 
DECLARE
@z1 AS int,
@z2 AS int

SELECT @z1 =  cast(@h1 * 100 / 100 as int) * 60 + cast(@h1 * 100 as int)  % 100
SELECT @z2 =  cast(@h2 * 100 / 100 as int) * 60 + cast(@h2 * 100 as int)  % 100
return cast((@z1 + @z2) / 60 as int) + cast((@z1 + @z2) % 60 as decimal(18,2)) /100 
END
GO
/****** Object:  UserDefinedFunction [dbo].[hours_sub]    Script Date: 28-Jun-23 8:50:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[hours_sub](@h1 decimal(18,2), @h2 decimal(18,2))  
RETURNS decimal(18,2) AS  
BEGIN 
DECLARE
@z1 AS int,
@z2 AS int

SELECT @z1 =  cast(@h1 * 100 / 100 as int) * 60 + cast(@h1 * 100 as int)  % 100
SELECT @z2 =  cast(@h2 * 100 / 100 as int) * 60 + cast(@h2 * 100 as int)  % 100
return cast((@z1 - @z2) / 60 as int) + cast((@z1 - @z2) % 60 as decimal(18,2)) /100 
END
GO
/****** Object:  Table [dbo].[Aircraft]    Script Date: 28-Jun-23 8:50:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Aircraft](
	[RegistrationNumber] [varchar](10) NOT NULL,
	[SerialNumber] [varchar](50) NOT NULL,
	[LastUpdate] [datetime] NOT NULL,
	[ID_Airport] [numeric](18, 0) NOT NULL,
	[LastACHours] [decimal](18, 2) NOT NULL,
	[LastACCycles] [decimal](18, 0) NOT NULL,
 CONSTRAINT [PK_Aircraft] PRIMARY KEY CLUSTERED 
(
	[RegistrationNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Airports]    Script Date: 28-Jun-23 8:50:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Airports](
	[ID_Airport] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[NameOfAirports] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Airports] PRIMARY KEY CLUSTERED 
(
	[ID_Airport] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LogBook]    Script Date: 28-Jun-23 8:50:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LogBook](
	[ID_LogBook] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[ID_Airport_FROM] [numeric](18, 0) NOT NULL,
	[ID_Airport_TO] [numeric](18, 0) NOT NULL,
	[FlightDate] [date] NOT NULL,
	[FlightNumber] [varchar](10) NOT NULL,
	[RegistrationNumber] [varchar](10) NOT NULL,
	[FlightTimeStart] [datetime] NOT NULL,
	[FlightTimeStop] [datetime] NOT NULL,
	[PreviousACHours] [numeric](18, 2) NOT NULL,
	[PreviousACCycles] [numeric](18, 0) NOT NULL,
	[NextACHours] [numeric](18, 2) NOT NULL,
	[NextACCycles] [numeric](18, 0) NOT NULL,
 CONSTRAINT [PK_LogBook] PRIMARY KEY CLUSTERED 
(
	[ID_LogBook] ASC,
	[ID_Airport_FROM] ASC,
	[ID_Airport_TO] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RotableParts]    Script Date: 28-Jun-23 8:50:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RotableParts](
	[ID_RotableParts] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[PartNumber] [varchar](20) NOT NULL,
	[SerialNumber] [varchar](20) NOT NULL,
	[Description] [varchar](max) NOT NULL,
 CONSTRAINT [PK_RotableParts] PRIMARY KEY CLUSTERED 
(
	[ID_RotableParts] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RotablePartsAircraft]    Script Date: 28-Jun-23 8:50:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RotablePartsAircraft](
	[ID_RotablePartsLog] [numeric](18, 0) NOT NULL,
	[ID_RotableParts] [numeric](18, 0) NOT NULL,
	[RegistrationNumber] [varchar](10) NOT NULL,
	[AircraftHours] [numeric](18, 2) NOT NULL,
	[AircraftCycles] [numeric](18, 0) NOT NULL,
	[InstalationDate] [date] NOT NULL,
	[HoursOperationalLimit] [numeric](18, 2) NOT NULL,
	[CyclesOperationalLimit] [numeric](18, 0) NOT NULL,
	[DaysOperationalLimit] [numeric](18, 0) NOT NULL,
	[StorageLimit] [numeric](18, 0) NOT NULL,
	[TimeSinceNew] [numeric](18, 2) NOT NULL,
	[CyclesSinceNew] [numeric](18, 0) NOT NULL,
	[DaysSinceNew] [numeric](18, 0) NOT NULL,
	[TimeSinceOverhaul] [numeric](18, 2) NOT NULL,
	[CyclesSinceOverhaul] [numeric](18, 0) NOT NULL,
	[DaysSinceOverhaul] [numeric](18, 0) NOT NULL,
	[ExpireOnHours] [numeric](18, 2) NOT NULL,
	[ExpireOnCycles] [numeric](18, 0) NOT NULL,
	[ExpireAtDate] [date] NOT NULL,
 CONSTRAINT [PK_RotablePartsAircraft] PRIMARY KEY CLUSTERED 
(
	[ID_RotablePartsLog] ASC,
	[ID_RotableParts] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RotablePartsLog]    Script Date: 28-Jun-23 8:50:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RotablePartsLog](
	[ID_RotablePartsLog] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[ID_RotableParts] [numeric](18, 0) NOT NULL,
	[ID_SubClass] [int] NOT NULL,
 CONSTRAINT [PK_RotablePartsLog] PRIMARY KEY CLUSTERED 
(
	[ID_RotablePartsLog] ASC,
	[ID_RotableParts] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RotablePartsService]    Script Date: 28-Jun-23 8:50:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RotablePartsService](
	[ID_RotablePartsLog] [numeric](18, 0) NOT NULL,
	[ID_RotableParts] [numeric](18, 0) NOT NULL,
	[WorkOrder] [varchar](50) NOT NULL,
	[WorkOrderDescription] [varchar](max) NOT NULL,
	[HoursOperationalLimit] [numeric](18, 2) NOT NULL,
	[CyclesOperationalLimit] [numeric](18, 0) NOT NULL,
	[DaysOperationalLimit] [numeric](18, 0) NOT NULL,
	[StorageLimit] [numeric](18, 0) NOT NULL,
	[TimeSinceNew] [numeric](18, 2) NOT NULL,
	[CyclesSinceNew] [numeric](18, 0) NOT NULL,
	[DaysCinceNew] [numeric](18, 0) NOT NULL,
	[TimeSinceOverhaul] [numeric](18, 2) NOT NULL,
	[CyclesSinceOverhaul] [numeric](18, 0) NOT NULL,
	[DaysCinceOverhaul] [numeric](18, 0) NOT NULL,
	[ID_ResultOfInspection] [numeric](18, 0) NULL,
	[NewHoursOperationalLimit] [numeric](18, 2) NULL,
	[NewCyclesOperationalLimit] [numeric](18, 0) NULL,
	[NewDaysOperationalLimit] [numeric](18, 0) NULL,
	[NewStorageLimit] [numeric](18, 0) NULL,
	[Description] [varchar](max) NULL,
 CONSTRAINT [PK_RotablePartsService] PRIMARY KEY CLUSTERED 
(
	[ID_RotablePartsLog] ASC,
	[ID_RotableParts] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RotablePartsStock]    Script Date: 28-Jun-23 8:50:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RotablePartsStock](
	[ID_RotablePartsLog] [numeric](18, 0) NOT NULL,
	[ID_RotableParts] [numeric](18, 0) NOT NULL,
	[RegistrationNumber] [varchar](10) NULL,
	[AircraftHours] [numeric](18, 2) NULL,
	[AircraftCycles] [numeric](18, 0) NULL,
	[DateOfEntry] [date] NOT NULL,
	[HoursOperationalLimit] [numeric](18, 2) NOT NULL,
	[CyclesOperationalLimit] [numeric](18, 0) NOT NULL,
	[DaysOperationalLimit] [numeric](18, 0) NOT NULL,
	[StorageLimit] [numeric](18, 0) NOT NULL,
	[TimeSinceNew] [numeric](18, 2) NOT NULL,
	[CyclesSinceNew] [numeric](18, 0) NOT NULL,
	[DaysSinceNew] [numeric](18, 0) NOT NULL,
	[TimeSinceOverhaul] [numeric](18, 2) NOT NULL,
	[CyclesSinceOverhaul] [numeric](18, 0) NOT NULL,
	[DaysSinceOverhaul] [numeric](18, 0) NOT NULL,
	[ExpireAtDate] [date] NOT NULL,
	[IsInitial] [bit] NOT NULL,
 CONSTRAINT [PK_RotablePartsStock] PRIMARY KEY CLUSTERED 
(
	[ID_RotablePartsLog] ASC,
	[ID_RotableParts] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[Aircraft] ([RegistrationNumber], [SerialNumber], [LastUpdate], [ID_Airport], [LastACHours], [LastACCycles]) VALUES (N'4O-AOA', N'SN 110-234', CAST(N'2023-02-20T10:05:00.000' AS DateTime), CAST(3 AS Numeric(18, 0)), CAST(20120.13 AS Decimal(18, 2)), CAST(12031 AS Decimal(18, 0)))
INSERT [dbo].[Aircraft] ([RegistrationNumber], [SerialNumber], [LastUpdate], [ID_Airport], [LastACHours], [LastACCycles]) VALUES (N'4O-AOB', N'SN 220-543', CAST(N'2023-02-13T23:00:00.000' AS DateTime), CAST(1 AS Numeric(18, 0)), CAST(18203.44 AS Decimal(18, 2)), CAST(10036 AS Decimal(18, 0)))
GO
SET IDENTITY_INSERT [dbo].[Airports] ON 

INSERT [dbo].[Airports] ([ID_Airport], [NameOfAirports]) VALUES (CAST(1 AS Numeric(18, 0)), N'Podgorica TGD')
INSERT [dbo].[Airports] ([ID_Airport], [NameOfAirports]) VALUES (CAST(2 AS Numeric(18, 0)), N'Beograd BEG')
INSERT [dbo].[Airports] ([ID_Airport], [NameOfAirports]) VALUES (CAST(3 AS Numeric(18, 0)), N'Frankfurt FRA')
INSERT [dbo].[Airports] ([ID_Airport], [NameOfAirports]) VALUES (CAST(4 AS Numeric(18, 0)), N'Rim FCO')
INSERT [dbo].[Airports] ([ID_Airport], [NameOfAirports]) VALUES (CAST(5 AS Numeric(18, 0)), N'London LHR')
SET IDENTITY_INSERT [dbo].[Airports] OFF
GO
SET IDENTITY_INSERT [dbo].[LogBook] ON 

INSERT [dbo].[LogBook] ([ID_LogBook], [ID_Airport_FROM], [ID_Airport_TO], [FlightDate], [FlightNumber], [RegistrationNumber], [FlightTimeStart], [FlightTimeStop], [PreviousACHours], [PreviousACCycles], [NextACHours], [NextACCycles]) VALUES (CAST(40106 AS Numeric(18, 0)), CAST(1 AS Numeric(18, 0)), CAST(2 AS Numeric(18, 0)), CAST(N'2023-02-10' AS Date), N'YM-100', N'4O-AOA', CAST(N'2023-02-10T12:52:00.000' AS DateTime), CAST(N'2023-02-10T13:50:00.000' AS DateTime), CAST(20102.34 AS Numeric(18, 2)), CAST(12023 AS Numeric(18, 0)), CAST(20103.32 AS Numeric(18, 2)), CAST(12024 AS Numeric(18, 0)))
INSERT [dbo].[LogBook] ([ID_LogBook], [ID_Airport_FROM], [ID_Airport_TO], [FlightDate], [FlightNumber], [RegistrationNumber], [FlightTimeStart], [FlightTimeStop], [PreviousACHours], [PreviousACCycles], [NextACHours], [NextACCycles]) VALUES (CAST(40107 AS Numeric(18, 0)), CAST(2 AS Numeric(18, 0)), CAST(1 AS Numeric(18, 0)), CAST(N'2023-02-10' AS Date), N'YM-101', N'4O-AOA', CAST(N'2023-02-10T15:10:00.000' AS DateTime), CAST(N'2023-02-10T17:02:00.000' AS DateTime), CAST(20103.32 AS Numeric(18, 2)), CAST(12024 AS Numeric(18, 0)), CAST(20105.24 AS Numeric(18, 2)), CAST(12025 AS Numeric(18, 0)))
INSERT [dbo].[LogBook] ([ID_LogBook], [ID_Airport_FROM], [ID_Airport_TO], [FlightDate], [FlightNumber], [RegistrationNumber], [FlightTimeStart], [FlightTimeStop], [PreviousACHours], [PreviousACCycles], [NextACHours], [NextACCycles]) VALUES (CAST(40108 AS Numeric(18, 0)), CAST(1 AS Numeric(18, 0)), CAST(4 AS Numeric(18, 0)), CAST(N'2023-02-11' AS Date), N'YM-200', N'4O-AOA', CAST(N'2023-02-11T07:00:00.000' AS DateTime), CAST(N'2023-02-11T09:23:00.000' AS DateTime), CAST(20105.24 AS Numeric(18, 2)), CAST(12025 AS Numeric(18, 0)), CAST(20107.47 AS Numeric(18, 2)), CAST(12026 AS Numeric(18, 0)))
INSERT [dbo].[LogBook] ([ID_LogBook], [ID_Airport_FROM], [ID_Airport_TO], [FlightDate], [FlightNumber], [RegistrationNumber], [FlightTimeStart], [FlightTimeStop], [PreviousACHours], [PreviousACCycles], [NextACHours], [NextACCycles]) VALUES (CAST(40109 AS Numeric(18, 0)), CAST(4 AS Numeric(18, 0)), CAST(1 AS Numeric(18, 0)), CAST(N'2023-02-11' AS Date), N'YM-201', N'4O-AOA', CAST(N'2023-02-11T13:15:00.000' AS DateTime), CAST(N'2023-02-11T17:13:00.000' AS DateTime), CAST(20107.47 AS Numeric(18, 2)), CAST(12026 AS Numeric(18, 0)), CAST(20111.45 AS Numeric(18, 2)), CAST(12027 AS Numeric(18, 0)))
INSERT [dbo].[LogBook] ([ID_LogBook], [ID_Airport_FROM], [ID_Airport_TO], [FlightDate], [FlightNumber], [RegistrationNumber], [FlightTimeStart], [FlightTimeStop], [PreviousACHours], [PreviousACCycles], [NextACHours], [NextACCycles]) VALUES (CAST(40110 AS Numeric(18, 0)), CAST(1 AS Numeric(18, 0)), CAST(5 AS Numeric(18, 0)), CAST(N'2023-02-12' AS Date), N'YM-300', N'4O-AOA', CAST(N'2023-02-12T09:15:00.000' AS DateTime), CAST(N'2023-02-12T12:30:00.000' AS DateTime), CAST(20111.45 AS Numeric(18, 2)), CAST(12027 AS Numeric(18, 0)), CAST(20115.00 AS Numeric(18, 2)), CAST(12028 AS Numeric(18, 0)))
INSERT [dbo].[LogBook] ([ID_LogBook], [ID_Airport_FROM], [ID_Airport_TO], [FlightDate], [FlightNumber], [RegistrationNumber], [FlightTimeStart], [FlightTimeStop], [PreviousACHours], [PreviousACCycles], [NextACHours], [NextACCycles]) VALUES (CAST(40111 AS Numeric(18, 0)), CAST(5 AS Numeric(18, 0)), CAST(1 AS Numeric(18, 0)), CAST(N'2023-02-12' AS Date), N'YM-301', N'4O-AOA', CAST(N'2023-02-12T16:10:00.000' AS DateTime), CAST(N'2023-02-12T19:35:00.000' AS DateTime), CAST(20115.00 AS Numeric(18, 2)), CAST(12028 AS Numeric(18, 0)), CAST(20118.25 AS Numeric(18, 2)), CAST(12029 AS Numeric(18, 0)))
INSERT [dbo].[LogBook] ([ID_LogBook], [ID_Airport_FROM], [ID_Airport_TO], [FlightDate], [FlightNumber], [RegistrationNumber], [FlightTimeStart], [FlightTimeStop], [PreviousACHours], [PreviousACCycles], [NextACHours], [NextACCycles]) VALUES (CAST(40114 AS Numeric(18, 0)), CAST(1 AS Numeric(18, 0)), CAST(2 AS Numeric(18, 0)), CAST(N'2023-02-13' AS Date), N'YM-100', N'4O-AOA', CAST(N'2023-02-13T12:17:00.000' AS DateTime), CAST(N'2023-02-13T13:05:00.000' AS DateTime), CAST(20118.25 AS Numeric(18, 2)), CAST(12029 AS Numeric(18, 0)), CAST(20119.13 AS Numeric(18, 2)), CAST(12030 AS Numeric(18, 0)))
INSERT [dbo].[LogBook] ([ID_LogBook], [ID_Airport_FROM], [ID_Airport_TO], [FlightDate], [FlightNumber], [RegistrationNumber], [FlightTimeStart], [FlightTimeStop], [PreviousACHours], [PreviousACCycles], [NextACHours], [NextACCycles]) VALUES (CAST(40115 AS Numeric(18, 0)), CAST(2 AS Numeric(18, 0)), CAST(3 AS Numeric(18, 0)), CAST(N'2023-02-20' AS Date), N'YM-101', N'4O-AOA', CAST(N'2023-02-20T09:05:00.000' AS DateTime), CAST(N'2023-02-20T10:05:00.000' AS DateTime), CAST(20119.13 AS Numeric(18, 2)), CAST(12030 AS Numeric(18, 0)), CAST(20120.13 AS Numeric(18, 2)), CAST(12031 AS Numeric(18, 0)))
SET IDENTITY_INSERT [dbo].[LogBook] OFF
GO
SET IDENTITY_INSERT [dbo].[RotableParts] ON 

INSERT [dbo].[RotableParts] ([ID_RotableParts], [PartNumber], [SerialNumber], [Description]) VALUES (CAST(20007 AS Numeric(18, 0)), N'P123-A201', N'6347322-45', N'ENGINE HIGH PRESSURE TURBINE ROTOR ASSEMBLY')
INSERT [dbo].[RotableParts] ([ID_RotableParts], [PartNumber], [SerialNumber], [Description]) VALUES (CAST(20008 AS Numeric(18, 0)), N'P123-A202', N'7868920-08', N'ENGINE LOW PRESSURE TURBINE ROTOR ASSEMBLY')
INSERT [dbo].[RotableParts] ([ID_RotableParts], [PartNumber], [SerialNumber], [Description]) VALUES (CAST(20009 AS Numeric(18, 0)), N'N234-K892', N'8978970-73', N'RADAR ALTIMETER')
INSERT [dbo].[RotableParts] ([ID_RotableParts], [PartNumber], [SerialNumber], [Description]) VALUES (CAST(20010 AS Numeric(18, 0)), N'H723-L833', N'7867899-33', N'BRAKE CONTROL MODULE')
INSERT [dbo].[RotableParts] ([ID_RotableParts], [PartNumber], [SerialNumber], [Description]) VALUES (CAST(20011 AS Numeric(18, 0)), N'F733-L730', N'0909098-46', N'AIR DRIVEN GENERATOR')
INSERT [dbo].[RotableParts] ([ID_RotableParts], [PartNumber], [SerialNumber], [Description]) VALUES (CAST(20012 AS Numeric(18, 0)), N'P638-U738', N'9009090-32', N'STARTER AIR TURBINE')
INSERT [dbo].[RotableParts] ([ID_RotableParts], [PartNumber], [SerialNumber], [Description]) VALUES (CAST(20013 AS Numeric(18, 0)), N'W638-K839', N'2139123-14', N'ALTERNATOR')
INSERT [dbo].[RotableParts] ([ID_RotableParts], [PartNumber], [SerialNumber], [Description]) VALUES (CAST(20014 AS Numeric(18, 0)), N'H738-J838', N'7201011-15', N'HYDRAULIC PUMP')
INSERT [dbo].[RotableParts] ([ID_RotableParts], [PartNumber], [SerialNumber], [Description]) VALUES (CAST(20015 AS Numeric(18, 0)), N'C832-K672', N'7788390-74', N'FLAP SKEW SENSOR')
INSERT [dbo].[RotableParts] ([ID_RotableParts], [PartNumber], [SerialNumber], [Description]) VALUES (CAST(20016 AS Numeric(18, 0)), N'G738-X782', N'5592222-97', N'POWER SUPPLY MODULE')
INSERT [dbo].[RotableParts] ([ID_RotableParts], [PartNumber], [SerialNumber], [Description]) VALUES (CAST(20017 AS Numeric(18, 0)), N'X763-J839', N'8973821-34', N'RADAR RECEIVER')
INSERT [dbo].[RotableParts] ([ID_RotableParts], [PartNumber], [SerialNumber], [Description]) VALUES (CAST(20018 AS Numeric(18, 0)), N'Y733-G733', N'0983333-26', N'CONTROL DISPLAY UNIT')
INSERT [dbo].[RotableParts] ([ID_RotableParts], [PartNumber], [SerialNumber], [Description]) VALUES (CAST(20019 AS Numeric(18, 0)), N'E839-R833', N'6380913-21', N'TEMPERATURE SENSOR')
INSERT [dbo].[RotableParts] ([ID_RotableParts], [PartNumber], [SerialNumber], [Description]) VALUES (CAST(20020 AS Numeric(18, 0)), N'U839-O839', N'0892309-46', N'DIGITAL VOICE DATA RECORDER')
INSERT [dbo].[RotableParts] ([ID_RotableParts], [PartNumber], [SerialNumber], [Description]) VALUES (CAST(20021 AS Numeric(18, 0)), N'D739-D833', N'8312323-09', N'TEMPERATURE CONTROLLER')
SET IDENTITY_INSERT [dbo].[RotableParts] OFF
GO
INSERT [dbo].[RotablePartsAircraft] ([ID_RotablePartsLog], [ID_RotableParts], [RegistrationNumber], [AircraftHours], [AircraftCycles], [InstalationDate], [HoursOperationalLimit], [CyclesOperationalLimit], [DaysOperationalLimit], [StorageLimit], [TimeSinceNew], [CyclesSinceNew], [DaysSinceNew], [TimeSinceOverhaul], [CyclesSinceOverhaul], [DaysSinceOverhaul], [ExpireOnHours], [ExpireOnCycles], [ExpireAtDate]) VALUES (CAST(20070 AS Numeric(18, 0)), CAST(20007 AS Numeric(18, 0)), N'4O-AOA', CAST(20117.20 AS Numeric(18, 2)), CAST(12029 AS Numeric(18, 0)), CAST(N'2023-02-12' AS Date), CAST(1000.00 AS Numeric(18, 2)), CAST(500 AS Numeric(18, 0)), CAST(365 AS Numeric(18, 0)), CAST(60 AS Numeric(18, 0)), CAST(0.00 AS Numeric(18, 2)), CAST(0 AS Numeric(18, 0)), CAST(0 AS Numeric(18, 0)), CAST(0.00 AS Numeric(18, 2)), CAST(0 AS Numeric(18, 0)), CAST(0 AS Numeric(18, 0)), CAST(21117.20 AS Numeric(18, 2)), CAST(12529 AS Numeric(18, 0)), CAST(N'2024-02-12' AS Date))
INSERT [dbo].[RotablePartsAircraft] ([ID_RotablePartsLog], [ID_RotableParts], [RegistrationNumber], [AircraftHours], [AircraftCycles], [InstalationDate], [HoursOperationalLimit], [CyclesOperationalLimit], [DaysOperationalLimit], [StorageLimit], [TimeSinceNew], [CyclesSinceNew], [DaysSinceNew], [TimeSinceOverhaul], [CyclesSinceOverhaul], [DaysSinceOverhaul], [ExpireOnHours], [ExpireOnCycles], [ExpireAtDate]) VALUES (CAST(20071 AS Numeric(18, 0)), CAST(20008 AS Numeric(18, 0)), N'4O-AOA', CAST(20117.20 AS Numeric(18, 2)), CAST(12029 AS Numeric(18, 0)), CAST(N'2023-02-12' AS Date), CAST(1000.00 AS Numeric(18, 2)), CAST(500 AS Numeric(18, 0)), CAST(365 AS Numeric(18, 0)), CAST(60 AS Numeric(18, 0)), CAST(100.00 AS Numeric(18, 2)), CAST(55 AS Numeric(18, 0)), CAST(180 AS Numeric(18, 0)), CAST(100.00 AS Numeric(18, 2)), CAST(55 AS Numeric(18, 0)), CAST(180 AS Numeric(18, 0)), CAST(21017.20 AS Numeric(18, 2)), CAST(12474 AS Numeric(18, 0)), CAST(N'2023-08-16' AS Date))
INSERT [dbo].[RotablePartsAircraft] ([ID_RotablePartsLog], [ID_RotableParts], [RegistrationNumber], [AircraftHours], [AircraftCycles], [InstalationDate], [HoursOperationalLimit], [CyclesOperationalLimit], [DaysOperationalLimit], [StorageLimit], [TimeSinceNew], [CyclesSinceNew], [DaysSinceNew], [TimeSinceOverhaul], [CyclesSinceOverhaul], [DaysSinceOverhaul], [ExpireOnHours], [ExpireOnCycles], [ExpireAtDate]) VALUES (CAST(20072 AS Numeric(18, 0)), CAST(20009 AS Numeric(18, 0)), N'4O-AOA', CAST(20117.20 AS Numeric(18, 2)), CAST(12029 AS Numeric(18, 0)), CAST(N'2023-02-12' AS Date), CAST(1500.00 AS Numeric(18, 2)), CAST(1000 AS Numeric(18, 0)), CAST(365 AS Numeric(18, 0)), CAST(60 AS Numeric(18, 0)), CAST(0.00 AS Numeric(18, 2)), CAST(0 AS Numeric(18, 0)), CAST(0 AS Numeric(18, 0)), CAST(0.00 AS Numeric(18, 2)), CAST(0 AS Numeric(18, 0)), CAST(0 AS Numeric(18, 0)), CAST(21617.20 AS Numeric(18, 2)), CAST(13029 AS Numeric(18, 0)), CAST(N'2024-02-12' AS Date))
INSERT [dbo].[RotablePartsAircraft] ([ID_RotablePartsLog], [ID_RotableParts], [RegistrationNumber], [AircraftHours], [AircraftCycles], [InstalationDate], [HoursOperationalLimit], [CyclesOperationalLimit], [DaysOperationalLimit], [StorageLimit], [TimeSinceNew], [CyclesSinceNew], [DaysSinceNew], [TimeSinceOverhaul], [CyclesSinceOverhaul], [DaysSinceOverhaul], [ExpireOnHours], [ExpireOnCycles], [ExpireAtDate]) VALUES (CAST(20073 AS Numeric(18, 0)), CAST(20010 AS Numeric(18, 0)), N'4O-AOA', CAST(20117.20 AS Numeric(18, 2)), CAST(12029 AS Numeric(18, 0)), CAST(N'2023-02-12' AS Date), CAST(850.00 AS Numeric(18, 2)), CAST(600 AS Numeric(18, 0)), CAST(200 AS Numeric(18, 0)), CAST(40 AS Numeric(18, 0)), CAST(850.00 AS Numeric(18, 2)), CAST(600 AS Numeric(18, 0)), CAST(200 AS Numeric(18, 0)), CAST(0.00 AS Numeric(18, 2)), CAST(0 AS Numeric(18, 0)), CAST(0 AS Numeric(18, 0)), CAST(20967.20 AS Numeric(18, 2)), CAST(12629 AS Numeric(18, 0)), CAST(N'2023-08-31' AS Date))
INSERT [dbo].[RotablePartsAircraft] ([ID_RotablePartsLog], [ID_RotableParts], [RegistrationNumber], [AircraftHours], [AircraftCycles], [InstalationDate], [HoursOperationalLimit], [CyclesOperationalLimit], [DaysOperationalLimit], [StorageLimit], [TimeSinceNew], [CyclesSinceNew], [DaysSinceNew], [TimeSinceOverhaul], [CyclesSinceOverhaul], [DaysSinceOverhaul], [ExpireOnHours], [ExpireOnCycles], [ExpireAtDate]) VALUES (CAST(20074 AS Numeric(18, 0)), CAST(20011 AS Numeric(18, 0)), N'4O-AOA', CAST(20117.20 AS Numeric(18, 2)), CAST(12029 AS Numeric(18, 0)), CAST(N'2023-02-12' AS Date), CAST(2000.00 AS Numeric(18, 2)), CAST(1200 AS Numeric(18, 0)), CAST(720 AS Numeric(18, 0)), CAST(100 AS Numeric(18, 0)), CAST(2300.00 AS Numeric(18, 2)), CAST(1310 AS Numeric(18, 0)), CAST(750 AS Numeric(18, 0)), CAST(300.00 AS Numeric(18, 2)), CAST(110 AS Numeric(18, 0)), CAST(30 AS Numeric(18, 0)), CAST(21817.20 AS Numeric(18, 2)), CAST(13119 AS Numeric(18, 0)), CAST(N'2025-01-02' AS Date))
INSERT [dbo].[RotablePartsAircraft] ([ID_RotablePartsLog], [ID_RotableParts], [RegistrationNumber], [AircraftHours], [AircraftCycles], [InstalationDate], [HoursOperationalLimit], [CyclesOperationalLimit], [DaysOperationalLimit], [StorageLimit], [TimeSinceNew], [CyclesSinceNew], [DaysSinceNew], [TimeSinceOverhaul], [CyclesSinceOverhaul], [DaysSinceOverhaul], [ExpireOnHours], [ExpireOnCycles], [ExpireAtDate]) VALUES (CAST(20085 AS Numeric(18, 0)), CAST(20012 AS Numeric(18, 0)), N'4O-AOA', CAST(20117.20 AS Numeric(18, 2)), CAST(12029 AS Numeric(18, 0)), CAST(N'2023-02-12' AS Date), CAST(500.00 AS Numeric(18, 2)), CAST(300 AS Numeric(18, 0)), CAST(356 AS Numeric(18, 0)), CAST(100 AS Numeric(18, 0)), CAST(0.00 AS Numeric(18, 2)), CAST(0 AS Numeric(18, 0)), CAST(0 AS Numeric(18, 0)), CAST(0.00 AS Numeric(18, 2)), CAST(0 AS Numeric(18, 0)), CAST(0 AS Numeric(18, 0)), CAST(20617.20 AS Numeric(18, 2)), CAST(12329 AS Numeric(18, 0)), CAST(N'2024-02-03' AS Date))
INSERT [dbo].[RotablePartsAircraft] ([ID_RotablePartsLog], [ID_RotableParts], [RegistrationNumber], [AircraftHours], [AircraftCycles], [InstalationDate], [HoursOperationalLimit], [CyclesOperationalLimit], [DaysOperationalLimit], [StorageLimit], [TimeSinceNew], [CyclesSinceNew], [DaysSinceNew], [TimeSinceOverhaul], [CyclesSinceOverhaul], [DaysSinceOverhaul], [ExpireOnHours], [ExpireOnCycles], [ExpireAtDate]) VALUES (CAST(20086 AS Numeric(18, 0)), CAST(20013 AS Numeric(18, 0)), N'4O-AOA', CAST(20117.20 AS Numeric(18, 2)), CAST(12029 AS Numeric(18, 0)), CAST(N'2023-02-12' AS Date), CAST(600.00 AS Numeric(18, 2)), CAST(400 AS Numeric(18, 0)), CAST(365 AS Numeric(18, 0)), CAST(60 AS Numeric(18, 0)), CAST(100.00 AS Numeric(18, 2)), CAST(70 AS Numeric(18, 0)), CAST(52 AS Numeric(18, 0)), CAST(100.00 AS Numeric(18, 2)), CAST(70 AS Numeric(18, 0)), CAST(52 AS Numeric(18, 0)), CAST(20617.20 AS Numeric(18, 2)), CAST(12359 AS Numeric(18, 0)), CAST(N'2023-12-22' AS Date))
INSERT [dbo].[RotablePartsAircraft] ([ID_RotablePartsLog], [ID_RotableParts], [RegistrationNumber], [AircraftHours], [AircraftCycles], [InstalationDate], [HoursOperationalLimit], [CyclesOperationalLimit], [DaysOperationalLimit], [StorageLimit], [TimeSinceNew], [CyclesSinceNew], [DaysSinceNew], [TimeSinceOverhaul], [CyclesSinceOverhaul], [DaysSinceOverhaul], [ExpireOnHours], [ExpireOnCycles], [ExpireAtDate]) VALUES (CAST(20106 AS Numeric(18, 0)), CAST(20021 AS Numeric(18, 0)), N'4O-AOA', CAST(20120.13 AS Numeric(18, 2)), CAST(12031 AS Numeric(18, 0)), CAST(N'2023-02-20' AS Date), CAST(950.00 AS Numeric(18, 2)), CAST(850 AS Numeric(18, 0)), CAST(720 AS Numeric(18, 0)), CAST(180 AS Numeric(18, 0)), CAST(0.00 AS Numeric(18, 2)), CAST(0 AS Numeric(18, 0)), CAST(0 AS Numeric(18, 0)), CAST(0.00 AS Numeric(18, 2)), CAST(0 AS Numeric(18, 0)), CAST(0 AS Numeric(18, 0)), CAST(21070.13 AS Numeric(18, 2)), CAST(12881 AS Numeric(18, 0)), CAST(N'2025-02-09' AS Date))
GO
SET IDENTITY_INSERT [dbo].[RotablePartsLog] ON 

INSERT [dbo].[RotablePartsLog] ([ID_RotablePartsLog], [ID_RotableParts], [ID_SubClass]) VALUES (CAST(20065 AS Numeric(18, 0)), CAST(20007 AS Numeric(18, 0)), 2)
INSERT [dbo].[RotablePartsLog] ([ID_RotablePartsLog], [ID_RotableParts], [ID_SubClass]) VALUES (CAST(20066 AS Numeric(18, 0)), CAST(20008 AS Numeric(18, 0)), 2)
INSERT [dbo].[RotablePartsLog] ([ID_RotablePartsLog], [ID_RotableParts], [ID_SubClass]) VALUES (CAST(20067 AS Numeric(18, 0)), CAST(20009 AS Numeric(18, 0)), 2)
INSERT [dbo].[RotablePartsLog] ([ID_RotablePartsLog], [ID_RotableParts], [ID_SubClass]) VALUES (CAST(20068 AS Numeric(18, 0)), CAST(20010 AS Numeric(18, 0)), 2)
INSERT [dbo].[RotablePartsLog] ([ID_RotablePartsLog], [ID_RotableParts], [ID_SubClass]) VALUES (CAST(20069 AS Numeric(18, 0)), CAST(20011 AS Numeric(18, 0)), 2)
INSERT [dbo].[RotablePartsLog] ([ID_RotablePartsLog], [ID_RotableParts], [ID_SubClass]) VALUES (CAST(20070 AS Numeric(18, 0)), CAST(20007 AS Numeric(18, 0)), 1)
INSERT [dbo].[RotablePartsLog] ([ID_RotablePartsLog], [ID_RotableParts], [ID_SubClass]) VALUES (CAST(20071 AS Numeric(18, 0)), CAST(20008 AS Numeric(18, 0)), 1)
INSERT [dbo].[RotablePartsLog] ([ID_RotablePartsLog], [ID_RotableParts], [ID_SubClass]) VALUES (CAST(20072 AS Numeric(18, 0)), CAST(20009 AS Numeric(18, 0)), 1)
INSERT [dbo].[RotablePartsLog] ([ID_RotablePartsLog], [ID_RotableParts], [ID_SubClass]) VALUES (CAST(20073 AS Numeric(18, 0)), CAST(20010 AS Numeric(18, 0)), 1)
INSERT [dbo].[RotablePartsLog] ([ID_RotablePartsLog], [ID_RotableParts], [ID_SubClass]) VALUES (CAST(20074 AS Numeric(18, 0)), CAST(20011 AS Numeric(18, 0)), 1)
INSERT [dbo].[RotablePartsLog] ([ID_RotablePartsLog], [ID_RotableParts], [ID_SubClass]) VALUES (CAST(20075 AS Numeric(18, 0)), CAST(20012 AS Numeric(18, 0)), 2)
INSERT [dbo].[RotablePartsLog] ([ID_RotablePartsLog], [ID_RotableParts], [ID_SubClass]) VALUES (CAST(20076 AS Numeric(18, 0)), CAST(20013 AS Numeric(18, 0)), 2)
INSERT [dbo].[RotablePartsLog] ([ID_RotablePartsLog], [ID_RotableParts], [ID_SubClass]) VALUES (CAST(20077 AS Numeric(18, 0)), CAST(20014 AS Numeric(18, 0)), 2)
INSERT [dbo].[RotablePartsLog] ([ID_RotablePartsLog], [ID_RotableParts], [ID_SubClass]) VALUES (CAST(20078 AS Numeric(18, 0)), CAST(20015 AS Numeric(18, 0)), 2)
INSERT [dbo].[RotablePartsLog] ([ID_RotablePartsLog], [ID_RotableParts], [ID_SubClass]) VALUES (CAST(20079 AS Numeric(18, 0)), CAST(20016 AS Numeric(18, 0)), 2)
INSERT [dbo].[RotablePartsLog] ([ID_RotablePartsLog], [ID_RotableParts], [ID_SubClass]) VALUES (CAST(20080 AS Numeric(18, 0)), CAST(20017 AS Numeric(18, 0)), 2)
INSERT [dbo].[RotablePartsLog] ([ID_RotablePartsLog], [ID_RotableParts], [ID_SubClass]) VALUES (CAST(20081 AS Numeric(18, 0)), CAST(20018 AS Numeric(18, 0)), 2)
INSERT [dbo].[RotablePartsLog] ([ID_RotablePartsLog], [ID_RotableParts], [ID_SubClass]) VALUES (CAST(20082 AS Numeric(18, 0)), CAST(20019 AS Numeric(18, 0)), 2)
INSERT [dbo].[RotablePartsLog] ([ID_RotablePartsLog], [ID_RotableParts], [ID_SubClass]) VALUES (CAST(20083 AS Numeric(18, 0)), CAST(20020 AS Numeric(18, 0)), 2)
INSERT [dbo].[RotablePartsLog] ([ID_RotablePartsLog], [ID_RotableParts], [ID_SubClass]) VALUES (CAST(20084 AS Numeric(18, 0)), CAST(20021 AS Numeric(18, 0)), 2)
INSERT [dbo].[RotablePartsLog] ([ID_RotablePartsLog], [ID_RotableParts], [ID_SubClass]) VALUES (CAST(20085 AS Numeric(18, 0)), CAST(20012 AS Numeric(18, 0)), 1)
INSERT [dbo].[RotablePartsLog] ([ID_RotablePartsLog], [ID_RotableParts], [ID_SubClass]) VALUES (CAST(20086 AS Numeric(18, 0)), CAST(20013 AS Numeric(18, 0)), 1)
INSERT [dbo].[RotablePartsLog] ([ID_RotablePartsLog], [ID_RotableParts], [ID_SubClass]) VALUES (CAST(20106 AS Numeric(18, 0)), CAST(20021 AS Numeric(18, 0)), 1)
SET IDENTITY_INSERT [dbo].[RotablePartsLog] OFF
GO
INSERT [dbo].[RotablePartsStock] ([ID_RotablePartsLog], [ID_RotableParts], [RegistrationNumber], [AircraftHours], [AircraftCycles], [DateOfEntry], [HoursOperationalLimit], [CyclesOperationalLimit], [DaysOperationalLimit], [StorageLimit], [TimeSinceNew], [CyclesSinceNew], [DaysSinceNew], [TimeSinceOverhaul], [CyclesSinceOverhaul], [DaysSinceOverhaul], [ExpireAtDate], [IsInitial]) VALUES (CAST(20065 AS Numeric(18, 0)), CAST(20007 AS Numeric(18, 0)), NULL, NULL, NULL, CAST(N'2023-02-11' AS Date), CAST(1000.00 AS Numeric(18, 2)), CAST(500 AS Numeric(18, 0)), CAST(365 AS Numeric(18, 0)), CAST(60 AS Numeric(18, 0)), CAST(0.00 AS Numeric(18, 2)), CAST(0 AS Numeric(18, 0)), CAST(0 AS Numeric(18, 0)), CAST(0.00 AS Numeric(18, 2)), CAST(0 AS Numeric(18, 0)), CAST(0 AS Numeric(18, 0)), CAST(N'2023-04-12' AS Date), 1)
INSERT [dbo].[RotablePartsStock] ([ID_RotablePartsLog], [ID_RotableParts], [RegistrationNumber], [AircraftHours], [AircraftCycles], [DateOfEntry], [HoursOperationalLimit], [CyclesOperationalLimit], [DaysOperationalLimit], [StorageLimit], [TimeSinceNew], [CyclesSinceNew], [DaysSinceNew], [TimeSinceOverhaul], [CyclesSinceOverhaul], [DaysSinceOverhaul], [ExpireAtDate], [IsInitial]) VALUES (CAST(20066 AS Numeric(18, 0)), CAST(20008 AS Numeric(18, 0)), NULL, NULL, NULL, CAST(N'2023-02-11' AS Date), CAST(1000.00 AS Numeric(18, 2)), CAST(500 AS Numeric(18, 0)), CAST(365 AS Numeric(18, 0)), CAST(60 AS Numeric(18, 0)), CAST(100.00 AS Numeric(18, 2)), CAST(55 AS Numeric(18, 0)), CAST(180 AS Numeric(18, 0)), CAST(100.00 AS Numeric(18, 2)), CAST(55 AS Numeric(18, 0)), CAST(180 AS Numeric(18, 0)), CAST(N'2023-04-12' AS Date), 1)
INSERT [dbo].[RotablePartsStock] ([ID_RotablePartsLog], [ID_RotableParts], [RegistrationNumber], [AircraftHours], [AircraftCycles], [DateOfEntry], [HoursOperationalLimit], [CyclesOperationalLimit], [DaysOperationalLimit], [StorageLimit], [TimeSinceNew], [CyclesSinceNew], [DaysSinceNew], [TimeSinceOverhaul], [CyclesSinceOverhaul], [DaysSinceOverhaul], [ExpireAtDate], [IsInitial]) VALUES (CAST(20067 AS Numeric(18, 0)), CAST(20009 AS Numeric(18, 0)), NULL, NULL, NULL, CAST(N'2023-02-11' AS Date), CAST(1500.00 AS Numeric(18, 2)), CAST(1000 AS Numeric(18, 0)), CAST(365 AS Numeric(18, 0)), CAST(60 AS Numeric(18, 0)), CAST(0.00 AS Numeric(18, 2)), CAST(0 AS Numeric(18, 0)), CAST(0 AS Numeric(18, 0)), CAST(0.00 AS Numeric(18, 2)), CAST(0 AS Numeric(18, 0)), CAST(0 AS Numeric(18, 0)), CAST(N'2023-04-12' AS Date), 1)
INSERT [dbo].[RotablePartsStock] ([ID_RotablePartsLog], [ID_RotableParts], [RegistrationNumber], [AircraftHours], [AircraftCycles], [DateOfEntry], [HoursOperationalLimit], [CyclesOperationalLimit], [DaysOperationalLimit], [StorageLimit], [TimeSinceNew], [CyclesSinceNew], [DaysSinceNew], [TimeSinceOverhaul], [CyclesSinceOverhaul], [DaysSinceOverhaul], [ExpireAtDate], [IsInitial]) VALUES (CAST(20068 AS Numeric(18, 0)), CAST(20010 AS Numeric(18, 0)), NULL, NULL, NULL, CAST(N'2023-02-11' AS Date), CAST(850.00 AS Numeric(18, 2)), CAST(600 AS Numeric(18, 0)), CAST(200 AS Numeric(18, 0)), CAST(40 AS Numeric(18, 0)), CAST(850.00 AS Numeric(18, 2)), CAST(600 AS Numeric(18, 0)), CAST(200 AS Numeric(18, 0)), CAST(0.00 AS Numeric(18, 2)), CAST(0 AS Numeric(18, 0)), CAST(0 AS Numeric(18, 0)), CAST(N'2023-03-23' AS Date), 1)
INSERT [dbo].[RotablePartsStock] ([ID_RotablePartsLog], [ID_RotableParts], [RegistrationNumber], [AircraftHours], [AircraftCycles], [DateOfEntry], [HoursOperationalLimit], [CyclesOperationalLimit], [DaysOperationalLimit], [StorageLimit], [TimeSinceNew], [CyclesSinceNew], [DaysSinceNew], [TimeSinceOverhaul], [CyclesSinceOverhaul], [DaysSinceOverhaul], [ExpireAtDate], [IsInitial]) VALUES (CAST(20069 AS Numeric(18, 0)), CAST(20011 AS Numeric(18, 0)), NULL, NULL, NULL, CAST(N'2023-02-11' AS Date), CAST(2000.00 AS Numeric(18, 2)), CAST(1200 AS Numeric(18, 0)), CAST(720 AS Numeric(18, 0)), CAST(100 AS Numeric(18, 0)), CAST(2300.00 AS Numeric(18, 2)), CAST(1310 AS Numeric(18, 0)), CAST(750 AS Numeric(18, 0)), CAST(300.00 AS Numeric(18, 2)), CAST(110 AS Numeric(18, 0)), CAST(30 AS Numeric(18, 0)), CAST(N'2023-05-22' AS Date), 1)
INSERT [dbo].[RotablePartsStock] ([ID_RotablePartsLog], [ID_RotableParts], [RegistrationNumber], [AircraftHours], [AircraftCycles], [DateOfEntry], [HoursOperationalLimit], [CyclesOperationalLimit], [DaysOperationalLimit], [StorageLimit], [TimeSinceNew], [CyclesSinceNew], [DaysSinceNew], [TimeSinceOverhaul], [CyclesSinceOverhaul], [DaysSinceOverhaul], [ExpireAtDate], [IsInitial]) VALUES (CAST(20075 AS Numeric(18, 0)), CAST(20012 AS Numeric(18, 0)), NULL, NULL, NULL, CAST(N'2023-02-11' AS Date), CAST(500.00 AS Numeric(18, 2)), CAST(300 AS Numeric(18, 0)), CAST(356 AS Numeric(18, 0)), CAST(100 AS Numeric(18, 0)), CAST(0.00 AS Numeric(18, 2)), CAST(0 AS Numeric(18, 0)), CAST(0 AS Numeric(18, 0)), CAST(0.00 AS Numeric(18, 2)), CAST(0 AS Numeric(18, 0)), CAST(0 AS Numeric(18, 0)), CAST(N'2023-05-22' AS Date), 1)
INSERT [dbo].[RotablePartsStock] ([ID_RotablePartsLog], [ID_RotableParts], [RegistrationNumber], [AircraftHours], [AircraftCycles], [DateOfEntry], [HoursOperationalLimit], [CyclesOperationalLimit], [DaysOperationalLimit], [StorageLimit], [TimeSinceNew], [CyclesSinceNew], [DaysSinceNew], [TimeSinceOverhaul], [CyclesSinceOverhaul], [DaysSinceOverhaul], [ExpireAtDate], [IsInitial]) VALUES (CAST(20076 AS Numeric(18, 0)), CAST(20013 AS Numeric(18, 0)), NULL, NULL, NULL, CAST(N'2023-02-11' AS Date), CAST(600.00 AS Numeric(18, 2)), CAST(400 AS Numeric(18, 0)), CAST(365 AS Numeric(18, 0)), CAST(60 AS Numeric(18, 0)), CAST(100.00 AS Numeric(18, 2)), CAST(70 AS Numeric(18, 0)), CAST(52 AS Numeric(18, 0)), CAST(100.00 AS Numeric(18, 2)), CAST(70 AS Numeric(18, 0)), CAST(52 AS Numeric(18, 0)), CAST(N'2023-04-12' AS Date), 1)
INSERT [dbo].[RotablePartsStock] ([ID_RotablePartsLog], [ID_RotableParts], [RegistrationNumber], [AircraftHours], [AircraftCycles], [DateOfEntry], [HoursOperationalLimit], [CyclesOperationalLimit], [DaysOperationalLimit], [StorageLimit], [TimeSinceNew], [CyclesSinceNew], [DaysSinceNew], [TimeSinceOverhaul], [CyclesSinceOverhaul], [DaysSinceOverhaul], [ExpireAtDate], [IsInitial]) VALUES (CAST(20077 AS Numeric(18, 0)), CAST(20014 AS Numeric(18, 0)), NULL, NULL, NULL, CAST(N'2023-02-11' AS Date), CAST(1000.00 AS Numeric(18, 2)), CAST(800 AS Numeric(18, 0)), CAST(365 AS Numeric(18, 0)), CAST(30 AS Numeric(18, 0)), CAST(0.00 AS Numeric(18, 2)), CAST(0 AS Numeric(18, 0)), CAST(0 AS Numeric(18, 0)), CAST(0.00 AS Numeric(18, 2)), CAST(0 AS Numeric(18, 0)), CAST(0 AS Numeric(18, 0)), CAST(N'2023-03-13' AS Date), 1)
INSERT [dbo].[RotablePartsStock] ([ID_RotablePartsLog], [ID_RotableParts], [RegistrationNumber], [AircraftHours], [AircraftCycles], [DateOfEntry], [HoursOperationalLimit], [CyclesOperationalLimit], [DaysOperationalLimit], [StorageLimit], [TimeSinceNew], [CyclesSinceNew], [DaysSinceNew], [TimeSinceOverhaul], [CyclesSinceOverhaul], [DaysSinceOverhaul], [ExpireAtDate], [IsInitial]) VALUES (CAST(20078 AS Numeric(18, 0)), CAST(20015 AS Numeric(18, 0)), NULL, NULL, NULL, CAST(N'2023-02-11' AS Date), CAST(500.00 AS Numeric(18, 2)), CAST(350 AS Numeric(18, 0)), CAST(365 AS Numeric(18, 0)), CAST(100 AS Numeric(18, 0)), CAST(50.00 AS Numeric(18, 2)), CAST(30 AS Numeric(18, 0)), CAST(15 AS Numeric(18, 0)), CAST(50.00 AS Numeric(18, 2)), CAST(30 AS Numeric(18, 0)), CAST(15 AS Numeric(18, 0)), CAST(N'2023-05-22' AS Date), 1)
INSERT [dbo].[RotablePartsStock] ([ID_RotablePartsLog], [ID_RotableParts], [RegistrationNumber], [AircraftHours], [AircraftCycles], [DateOfEntry], [HoursOperationalLimit], [CyclesOperationalLimit], [DaysOperationalLimit], [StorageLimit], [TimeSinceNew], [CyclesSinceNew], [DaysSinceNew], [TimeSinceOverhaul], [CyclesSinceOverhaul], [DaysSinceOverhaul], [ExpireAtDate], [IsInitial]) VALUES (CAST(20079 AS Numeric(18, 0)), CAST(20016 AS Numeric(18, 0)), NULL, NULL, NULL, CAST(N'2023-02-11' AS Date), CAST(750.00 AS Numeric(18, 2)), CAST(500 AS Numeric(18, 0)), CAST(180 AS Numeric(18, 0)), CAST(90 AS Numeric(18, 0)), CAST(0.00 AS Numeric(18, 2)), CAST(0 AS Numeric(18, 0)), CAST(0 AS Numeric(18, 0)), CAST(0.00 AS Numeric(18, 2)), CAST(0 AS Numeric(18, 0)), CAST(0 AS Numeric(18, 0)), CAST(N'2023-05-12' AS Date), 1)
INSERT [dbo].[RotablePartsStock] ([ID_RotablePartsLog], [ID_RotableParts], [RegistrationNumber], [AircraftHours], [AircraftCycles], [DateOfEntry], [HoursOperationalLimit], [CyclesOperationalLimit], [DaysOperationalLimit], [StorageLimit], [TimeSinceNew], [CyclesSinceNew], [DaysSinceNew], [TimeSinceOverhaul], [CyclesSinceOverhaul], [DaysSinceOverhaul], [ExpireAtDate], [IsInitial]) VALUES (CAST(20080 AS Numeric(18, 0)), CAST(20017 AS Numeric(18, 0)), NULL, NULL, NULL, CAST(N'2023-02-11' AS Date), CAST(1400.00 AS Numeric(18, 2)), CAST(1000 AS Numeric(18, 0)), CAST(365 AS Numeric(18, 0)), CAST(180 AS Numeric(18, 0)), CAST(100.00 AS Numeric(18, 2)), CAST(70 AS Numeric(18, 0)), CAST(30 AS Numeric(18, 0)), CAST(100.00 AS Numeric(18, 2)), CAST(70 AS Numeric(18, 0)), CAST(30 AS Numeric(18, 0)), CAST(N'2023-08-10' AS Date), 1)
INSERT [dbo].[RotablePartsStock] ([ID_RotablePartsLog], [ID_RotableParts], [RegistrationNumber], [AircraftHours], [AircraftCycles], [DateOfEntry], [HoursOperationalLimit], [CyclesOperationalLimit], [DaysOperationalLimit], [StorageLimit], [TimeSinceNew], [CyclesSinceNew], [DaysSinceNew], [TimeSinceOverhaul], [CyclesSinceOverhaul], [DaysSinceOverhaul], [ExpireAtDate], [IsInitial]) VALUES (CAST(20081 AS Numeric(18, 0)), CAST(20018 AS Numeric(18, 0)), NULL, NULL, NULL, CAST(N'2023-02-11' AS Date), CAST(1000.00 AS Numeric(18, 2)), CAST(750 AS Numeric(18, 0)), CAST(365 AS Numeric(18, 0)), CAST(180 AS Numeric(18, 0)), CAST(0.00 AS Numeric(18, 2)), CAST(0 AS Numeric(18, 0)), CAST(0 AS Numeric(18, 0)), CAST(0.00 AS Numeric(18, 2)), CAST(0 AS Numeric(18, 0)), CAST(0 AS Numeric(18, 0)), CAST(N'2023-08-10' AS Date), 1)
INSERT [dbo].[RotablePartsStock] ([ID_RotablePartsLog], [ID_RotableParts], [RegistrationNumber], [AircraftHours], [AircraftCycles], [DateOfEntry], [HoursOperationalLimit], [CyclesOperationalLimit], [DaysOperationalLimit], [StorageLimit], [TimeSinceNew], [CyclesSinceNew], [DaysSinceNew], [TimeSinceOverhaul], [CyclesSinceOverhaul], [DaysSinceOverhaul], [ExpireAtDate], [IsInitial]) VALUES (CAST(20082 AS Numeric(18, 0)), CAST(20019 AS Numeric(18, 0)), NULL, NULL, NULL, CAST(N'2023-02-11' AS Date), CAST(500.00 AS Numeric(18, 2)), CAST(350 AS Numeric(18, 0)), CAST(365 AS Numeric(18, 0)), CAST(90 AS Numeric(18, 0)), CAST(0.00 AS Numeric(18, 2)), CAST(0 AS Numeric(18, 0)), CAST(0 AS Numeric(18, 0)), CAST(0.00 AS Numeric(18, 2)), CAST(0 AS Numeric(18, 0)), CAST(0 AS Numeric(18, 0)), CAST(N'2023-05-12' AS Date), 1)
INSERT [dbo].[RotablePartsStock] ([ID_RotablePartsLog], [ID_RotableParts], [RegistrationNumber], [AircraftHours], [AircraftCycles], [DateOfEntry], [HoursOperationalLimit], [CyclesOperationalLimit], [DaysOperationalLimit], [StorageLimit], [TimeSinceNew], [CyclesSinceNew], [DaysSinceNew], [TimeSinceOverhaul], [CyclesSinceOverhaul], [DaysSinceOverhaul], [ExpireAtDate], [IsInitial]) VALUES (CAST(20083 AS Numeric(18, 0)), CAST(20020 AS Numeric(18, 0)), NULL, NULL, NULL, CAST(N'2023-02-11' AS Date), CAST(1000.00 AS Numeric(18, 2)), CAST(1000 AS Numeric(18, 0)), CAST(720 AS Numeric(18, 0)), CAST(180 AS Numeric(18, 0)), CAST(0.00 AS Numeric(18, 2)), CAST(0 AS Numeric(18, 0)), CAST(20 AS Numeric(18, 0)), CAST(0.00 AS Numeric(18, 2)), CAST(0 AS Numeric(18, 0)), CAST(20 AS Numeric(18, 0)), CAST(N'2023-08-10' AS Date), 1)
INSERT [dbo].[RotablePartsStock] ([ID_RotablePartsLog], [ID_RotableParts], [RegistrationNumber], [AircraftHours], [AircraftCycles], [DateOfEntry], [HoursOperationalLimit], [CyclesOperationalLimit], [DaysOperationalLimit], [StorageLimit], [TimeSinceNew], [CyclesSinceNew], [DaysSinceNew], [TimeSinceOverhaul], [CyclesSinceOverhaul], [DaysSinceOverhaul], [ExpireAtDate], [IsInitial]) VALUES (CAST(20084 AS Numeric(18, 0)), CAST(20021 AS Numeric(18, 0)), NULL, NULL, NULL, CAST(N'2023-02-11' AS Date), CAST(950.00 AS Numeric(18, 2)), CAST(850 AS Numeric(18, 0)), CAST(720 AS Numeric(18, 0)), CAST(180 AS Numeric(18, 0)), CAST(0.00 AS Numeric(18, 2)), CAST(0 AS Numeric(18, 0)), CAST(0 AS Numeric(18, 0)), CAST(0.00 AS Numeric(18, 2)), CAST(0 AS Numeric(18, 0)), CAST(0 AS Numeric(18, 0)), CAST(N'2023-08-10' AS Date), 1)
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_LogBook]    Script Date: 28-Jun-23 8:50:47 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_LogBook] ON [dbo].[LogBook]
(
	[FlightDate] ASC,
	[FlightNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_RotableParts]    Script Date: 28-Jun-23 8:50:47 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_RotableParts] ON [dbo].[RotableParts]
(
	[PartNumber] ASC,
	[SerialNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Aircraft]  WITH CHECK ADD  CONSTRAINT [FK_Aircraft_Airports] FOREIGN KEY([ID_Airport])
REFERENCES [dbo].[Airports] ([ID_Airport])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[Aircraft] CHECK CONSTRAINT [FK_Aircraft_Airports]
GO
ALTER TABLE [dbo].[LogBook]  WITH CHECK ADD  CONSTRAINT [FK_LogBook_Aircraft] FOREIGN KEY([RegistrationNumber])
REFERENCES [dbo].[Aircraft] ([RegistrationNumber])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[LogBook] CHECK CONSTRAINT [FK_LogBook_Aircraft]
GO
ALTER TABLE [dbo].[LogBook]  WITH CHECK ADD  CONSTRAINT [FK_LogBook_Airports_FROM] FOREIGN KEY([ID_Airport_FROM])
REFERENCES [dbo].[Airports] ([ID_Airport])
GO
ALTER TABLE [dbo].[LogBook] CHECK CONSTRAINT [FK_LogBook_Airports_FROM]
GO
ALTER TABLE [dbo].[LogBook]  WITH CHECK ADD  CONSTRAINT [FK_LogBook_Airports_TO] FOREIGN KEY([ID_Airport_TO])
REFERENCES [dbo].[Airports] ([ID_Airport])
GO
ALTER TABLE [dbo].[LogBook] CHECK CONSTRAINT [FK_LogBook_Airports_TO]
GO
ALTER TABLE [dbo].[RotablePartsAircraft]  WITH CHECK ADD  CONSTRAINT [FK_RotablePartsAircraft_Aircraft] FOREIGN KEY([RegistrationNumber])
REFERENCES [dbo].[Aircraft] ([RegistrationNumber])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[RotablePartsAircraft] CHECK CONSTRAINT [FK_RotablePartsAircraft_Aircraft]
GO
ALTER TABLE [dbo].[RotablePartsAircraft]  WITH CHECK ADD  CONSTRAINT [FK_RotablePartsAircraft_RotablePartsLog] FOREIGN KEY([ID_RotablePartsLog], [ID_RotableParts])
REFERENCES [dbo].[RotablePartsLog] ([ID_RotablePartsLog], [ID_RotableParts])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[RotablePartsAircraft] CHECK CONSTRAINT [FK_RotablePartsAircraft_RotablePartsLog]
GO
ALTER TABLE [dbo].[RotablePartsLog]  WITH CHECK ADD  CONSTRAINT [FK_RotablePartsLog_RotableParts] FOREIGN KEY([ID_RotableParts])
REFERENCES [dbo].[RotableParts] ([ID_RotableParts])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[RotablePartsLog] CHECK CONSTRAINT [FK_RotablePartsLog_RotableParts]
GO
ALTER TABLE [dbo].[RotablePartsService]  WITH CHECK ADD  CONSTRAINT [FK_RotablePartsService_RotablePartsLog] FOREIGN KEY([ID_RotablePartsLog], [ID_RotableParts])
REFERENCES [dbo].[RotablePartsLog] ([ID_RotablePartsLog], [ID_RotableParts])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[RotablePartsService] CHECK CONSTRAINT [FK_RotablePartsService_RotablePartsLog]
GO
ALTER TABLE [dbo].[RotablePartsStock]  WITH CHECK ADD  CONSTRAINT [FK_RotablePartsStock_Aircraft] FOREIGN KEY([RegistrationNumber])
REFERENCES [dbo].[Aircraft] ([RegistrationNumber])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[RotablePartsStock] CHECK CONSTRAINT [FK_RotablePartsStock_Aircraft]
GO
ALTER TABLE [dbo].[RotablePartsStock]  WITH CHECK ADD  CONSTRAINT [FK_RotablePartsStock_RotablePartsLog] FOREIGN KEY([ID_RotablePartsLog], [ID_RotableParts])
REFERENCES [dbo].[RotablePartsLog] ([ID_RotablePartsLog], [ID_RotableParts])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[RotablePartsStock] CHECK CONSTRAINT [FK_RotablePartsStock_RotablePartsLog]
GO
USE [master]
GO
ALTER DATABASE [AIRMAC] SET  READ_WRITE 
GO
