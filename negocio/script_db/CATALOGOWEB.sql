USE [master]
GO
/****** Object:  Database [CATALOGO_WEB_DB]    Script Date: 30/04/2024 01:06:12 p. m. ******/
CREATE DATABASE [CATALOGO_WEB_DB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'CATALOGO_WEB_DB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\CATALOGO_WEB_DB.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'CATALOGO_WEB_DB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\CATALOGO_WEB_DB_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [CATALOGO_WEB_DB] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [CATALOGO_WEB_DB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [CATALOGO_WEB_DB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [CATALOGO_WEB_DB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [CATALOGO_WEB_DB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [CATALOGO_WEB_DB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [CATALOGO_WEB_DB] SET ARITHABORT OFF 
GO
ALTER DATABASE [CATALOGO_WEB_DB] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [CATALOGO_WEB_DB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [CATALOGO_WEB_DB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [CATALOGO_WEB_DB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [CATALOGO_WEB_DB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [CATALOGO_WEB_DB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [CATALOGO_WEB_DB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [CATALOGO_WEB_DB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [CATALOGO_WEB_DB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [CATALOGO_WEB_DB] SET  ENABLE_BROKER 
GO
ALTER DATABASE [CATALOGO_WEB_DB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [CATALOGO_WEB_DB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [CATALOGO_WEB_DB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [CATALOGO_WEB_DB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [CATALOGO_WEB_DB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [CATALOGO_WEB_DB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [CATALOGO_WEB_DB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [CATALOGO_WEB_DB] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [CATALOGO_WEB_DB] SET  MULTI_USER 
GO
ALTER DATABASE [CATALOGO_WEB_DB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [CATALOGO_WEB_DB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [CATALOGO_WEB_DB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [CATALOGO_WEB_DB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [CATALOGO_WEB_DB] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [CATALOGO_WEB_DB] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [CATALOGO_WEB_DB] SET QUERY_STORE = ON
GO
ALTER DATABASE [CATALOGO_WEB_DB] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [CATALOGO_WEB_DB]
GO
/****** Object:  Table [dbo].[ARTICULOS]    Script Date: 30/04/2024 01:06:12 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARTICULOS](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Codigo] [varchar](50) NULL,
	[Nombre] [varchar](50) NULL,
	[Descripcion] [varchar](150) NULL,
	[IdMarca] [int] NULL,
	[IdCategoria] [int] NULL,
	[ImagenUrl] [varchar](1000) NULL,
	[Precio] [money] NULL,
 CONSTRAINT [PK_ARTICULOS] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CATEGORIAS]    Script Date: 30/04/2024 01:06:12 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CATEGORIAS](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Descripcion] [varchar](50) NULL,
 CONSTRAINT [PK_CATEGORIAS] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FAVORITOS]    Script Date: 30/04/2024 01:06:12 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FAVORITOS](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdUser] [int] NOT NULL,
	[IdArticulo] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MARCAS]    Script Date: 30/04/2024 01:06:12 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MARCAS](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Descripcion] [varchar](50) NULL,
 CONSTRAINT [PK_MARCAS] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[USERS]    Script Date: 30/04/2024 01:06:12 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[USERS](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[email] [varchar](100) NOT NULL,
	[pass] [varchar](20) NOT NULL,
	[nombre] [varchar](50) NULL,
	[apellido] [varchar](50) NULL,
	[urlImagenPerfil] [varchar](500) NULL,
	[admin] [bit] NOT NULL,
	[fechaNacimiento] [datetime] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[USERS] ADD  DEFAULT ((0)) FOR [admin]
GO
/****** Object:  StoredProcedure [dbo].[EliminarFavoritoPorArticulo]    Script Date: 30/04/2024 01:06:12 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EliminarFavoritoPorArticulo]
    @idArticulo INT
AS
BEGIN
    DELETE FROM FAVORITOS WHERE IdArticulo = @idArticulo
END
GO
/****** Object:  StoredProcedure [dbo].[EliminarFavoritoPorArticuloYUsuario]    Script Date: 30/04/2024 01:06:12 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EliminarFavoritoPorArticuloYUsuario]
    @idArticulo INT,
    @idUser INT
AS
BEGIN
    DELETE FROM FAVORITOS WHERE IdArticulo = @idArticulo AND IdUser = @idUser
END
GO
/****** Object:  StoredProcedure [dbo].[InsertarFavorito]    Script Date: 30/04/2024 01:06:12 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertarFavorito]
    @idUser INT,
    @idArticulo INT
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM FAVORITOS WHERE IdUser = @idUser AND IdArticulo = @idArticulo)
    BEGIN
        INSERT INTO FAVORITOS (IdUser, IdArticulo) VALUES (@idUser, @idArticulo)
    END
END
GO
/****** Object:  StoredProcedure [dbo].[insertarNuevo]    Script Date: 30/04/2024 01:06:12 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[insertarNuevo]
@email varchar(50),
@pass varchar(50)
as
insert into USERS (email, pass, admin) output inserted.id values (@email, @pass, 0)
GO
/****** Object:  StoredProcedure [dbo].[ListarFavoritos]    Script Date: 30/04/2024 01:06:12 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ListarFavoritos]
    @idUser INT
AS
BEGIN
    SELECT IdArticulo FROM FAVORITOS WHERE IdUser = @idUser
END
GO
/****** Object:  StoredProcedure [dbo].[storedAltaArticulos]    Script Date: 30/04/2024 01:06:12 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[storedAltaArticulos]
@codigo varchar(50),
@nombre varchar(50),
@descripcion varchar(150),
@idMarca int,
@idCategoria int,
@imagenUrl varchar(1000),
@precio money
as
insert into articulos values (@codigo, @nombre, @descripcion, @idMarca, @idCategoria, @imagenUrl, @precio)
GO
/****** Object:  StoredProcedure [dbo].[storedListar]    Script Date: 30/04/2024 01:06:12 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




create procedure [dbo].[storedListar] as
Select A.Codigo, A.Nombre, A.Descripcion, A.ImagenUrl, M.Descripcion as Marca, C. Descripcion
as Categoria, A. Precio, A.IdMarca, A.IdCategoria, A.Id From ARTICULOS A, MARCAS M, CATEGORIAS C 
where M.Id = A.IdMarca and C. Id = A. IdCategoria
GO
/****** Object:  StoredProcedure [dbo].[storedModificarArticulos]    Script Date: 30/04/2024 01:06:12 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






create procedure [dbo].[storedModificarArticulos]
@codigo varchar(50),
@nombre varchar(50),
@descripcion varchar(150),
@idMarca int,
@idCategoria int,
@imagenUrl varchar(1000),
@precio money,
@id int
as
update articulos set Codigo = @codigo, Nombre = @nombre, Descripcion = @descripcion,
IdMarca = @idMarca, IdCategoria = @idCategoria, ImagenUrl = @imagenUrl, Precio = @precio
where id = @id


GO
USE [master]
GO
ALTER DATABASE [CATALOGO_WEB_DB] SET  READ_WRITE 
GO
