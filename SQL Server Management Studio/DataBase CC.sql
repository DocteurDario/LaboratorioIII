USE [master]
GO
/****** Object:  Database [CallCenter]    Script Date: 4/11/2022 02:15:05 ******/
CREATE DATABASE [CallCenter]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'CallCenter', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\CallCenter.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'CallCenter_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\CallCenter_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [CallCenter] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [CallCenter].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [CallCenter] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [CallCenter] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [CallCenter] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [CallCenter] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [CallCenter] SET ARITHABORT OFF 
GO
ALTER DATABASE [CallCenter] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [CallCenter] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [CallCenter] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [CallCenter] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [CallCenter] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [CallCenter] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [CallCenter] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [CallCenter] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [CallCenter] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [CallCenter] SET  ENABLE_BROKER 
GO
ALTER DATABASE [CallCenter] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [CallCenter] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [CallCenter] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [CallCenter] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [CallCenter] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [CallCenter] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [CallCenter] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [CallCenter] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [CallCenter] SET  MULTI_USER 
GO
ALTER DATABASE [CallCenter] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [CallCenter] SET DB_CHAINING OFF 
GO
ALTER DATABASE [CallCenter] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [CallCenter] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [CallCenter] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [CallCenter] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [CallCenter] SET QUERY_STORE = OFF
GO
USE [CallCenter]
GO
/****** Object:  Table [dbo].[Clientes]    Script Date: 4/11/2022 02:15:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Clientes](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[NomClien] [varchar](50) NOT NULL,
	[ApellClien] [varchar](100) NOT NULL,
	[DNIClien] [int] NOT NULL,
	[Tel] [varchar](25) NOT NULL,
	[Email] [varchar](100) NOT NULL,
	[Domicilio] [varchar](200) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Estados]    Script Date: 4/11/2022 02:15:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Estados](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Estados] [varchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Incidencia]    Script Date: 4/11/2022 02:15:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Incidencia](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[IDcliente] [int] NOT NULL,
	[IDestado] [int] NOT NULL,
	[IDusuario] [int] NOT NULL,
	[Problematica] [varchar](1000) NOT NULL,
	[Comentarios] [varchar](1000) NULL,
	[IDprioridad] [int] NOT NULL,
	[IDTipoIncidencia] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Perfiles]    Script Date: 4/11/2022 02:15:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Perfiles](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Perfil] [varchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[prioridad]    Script Date: 4/11/2022 02:15:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[prioridad](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Prioridad] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TipoIncidencia]    Script Date: 4/11/2022 02:15:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TipoIncidencia](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[TipoInc] [varchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Usuarios]    Script Date: 4/11/2022 02:15:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Usuarios](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](50) NOT NULL,
	[Apellido] [varchar](100) NOT NULL,
	[DNI] [int] NOT NULL,
	[IDPerf] [int] NOT NULL,
	[Pass] [varchar](50) NOT NULL,
	[Email] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Clientes] ON 
GO
INSERT [dbo].[Clientes] ([ID], [NomClien], [ApellClien], [DNIClien], [Tel], [Email], [Domicilio]) VALUES (1, N'Juan', N'Velazquez', 30987555, N'1122425677', N'juann234@gmail.com', N'Acevedo 4562')
GO
INSERT [dbo].[Clientes] ([ID], [NomClien], [ApellClien], [DNIClien], [Tel], [Email], [Domicilio]) VALUES (2, N'Santiago', N'Crisol', 34672190, N'1123435621', N'Santia.crisol@hotmail.com', N'Pacheco 321')
GO
INSERT [dbo].[Clientes] ([ID], [NomClien], [ApellClien], [DNIClien], [Tel], [Email], [Domicilio]) VALUES (3, N'Laura', N'vazquez', 20453288, N'1157634521', N'laura555@yahoo.com', N'Alberdi 888')
GO
SET IDENTITY_INSERT [dbo].[Clientes] OFF
GO
SET IDENTITY_INSERT [dbo].[Estados] ON 
GO
INSERT [dbo].[Estados] ([ID], [Estados]) VALUES (1, N'Abierto')
GO
INSERT [dbo].[Estados] ([ID], [Estados]) VALUES (2, N'En Analisis')
GO
INSERT [dbo].[Estados] ([ID], [Estados]) VALUES (3, N'Cerrado')
GO
INSERT [dbo].[Estados] ([ID], [Estados]) VALUES (4, N'Reabierto')
GO
INSERT [dbo].[Estados] ([ID], [Estados]) VALUES (5, N'Asignado')
GO
INSERT [dbo].[Estados] ([ID], [Estados]) VALUES (6, N'Resuelto')
GO
SET IDENTITY_INSERT [dbo].[Estados] OFF
GO
SET IDENTITY_INSERT [dbo].[Perfiles] ON 
GO
INSERT [dbo].[Perfiles] ([ID], [Perfil]) VALUES (1, N'Administrador')
GO
INSERT [dbo].[Perfiles] ([ID], [Perfil]) VALUES (2, N'Telefonista')
GO
INSERT [dbo].[Perfiles] ([ID], [Perfil]) VALUES (3, N'Supervisor')
GO
SET IDENTITY_INSERT [dbo].[Perfiles] OFF
GO
SET IDENTITY_INSERT [dbo].[prioridad] ON 
GO
INSERT [dbo].[prioridad] ([ID], [Prioridad]) VALUES (1, N'Baja')
GO
INSERT [dbo].[prioridad] ([ID], [Prioridad]) VALUES (2, N'Media')
GO
INSERT [dbo].[prioridad] ([ID], [Prioridad]) VALUES (3, N'Alta')
GO
INSERT [dbo].[prioridad] ([ID], [Prioridad]) VALUES (4, N'Urgente')
GO
SET IDENTITY_INSERT [dbo].[prioridad] OFF
GO
SET IDENTITY_INSERT [dbo].[TipoIncidencia] ON 
GO
INSERT [dbo].[TipoIncidencia] ([ID], [TipoInc]) VALUES (1, N'Administrativa')
GO
INSERT [dbo].[TipoIncidencia] ([ID], [TipoInc]) VALUES (2, N'Tecnica')
GO
SET IDENTITY_INSERT [dbo].[TipoIncidencia] OFF
GO
SET IDENTITY_INSERT [dbo].[Usuarios] ON 
GO
INSERT [dbo].[Usuarios] ([ID], [Nombre], [Apellido], [DNI], [IDPerf], [Pass], [Email]) VALUES (1, N'Carla', N'Ortiz', 18245654, 2, N'test', N'test@test.com')
GO
INSERT [dbo].[Usuarios] ([ID], [Nombre], [Apellido], [DNI], [IDPerf], [Pass], [Email]) VALUES (2, N'Maria', N'Giardina', 40561234, 1, N'Ricardito22', N'maria.giardina@callcenter.com')
GO
SET IDENTITY_INSERT [dbo].[Usuarios] OFF
GO
/****** Object:  Index [UQ__Clientes__312D663EC3A3989C]    Script Date: 4/11/2022 02:15:06 ******/
ALTER TABLE [dbo].[Clientes] ADD UNIQUE NONCLUSTERED 
(
	[DNIClien] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [UQ__Usuarios__C035B8DDE15D84FF]    Script Date: 4/11/2022 02:15:06 ******/
ALTER TABLE [dbo].[Usuarios] ADD UNIQUE NONCLUSTERED 
(
	[DNI] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Incidencia]  WITH CHECK ADD FOREIGN KEY([IDcliente])
REFERENCES [dbo].[Clientes] ([ID])
GO
ALTER TABLE [dbo].[Incidencia]  WITH CHECK ADD FOREIGN KEY([IDestado])
REFERENCES [dbo].[Estados] ([ID])
GO
ALTER TABLE [dbo].[Incidencia]  WITH CHECK ADD FOREIGN KEY([IDprioridad])
REFERENCES [dbo].[prioridad] ([ID])
GO
ALTER TABLE [dbo].[Incidencia]  WITH CHECK ADD FOREIGN KEY([IDTipoIncidencia])
REFERENCES [dbo].[TipoIncidencia] ([ID])
GO
ALTER TABLE [dbo].[Incidencia]  WITH CHECK ADD FOREIGN KEY([IDusuario])
REFERENCES [dbo].[Usuarios] ([ID])
GO
ALTER TABLE [dbo].[Usuarios]  WITH CHECK ADD FOREIGN KEY([IDPerf])
REFERENCES [dbo].[Perfiles] ([ID])
GO
USE [master]
GO
ALTER DATABASE [CallCenter] SET  READ_WRITE 
GO
