USE [master]
GO
/****** Object:  Database [patikaDb]    Script Date: 1/29/2022 6:18:31 PM ******/
CREATE DATABASE [patikaDb]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'patikaDb', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER01\MSSQL\DATA\patikaDb.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'patikaDb_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER01\MSSQL\DATA\patikaDb_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [patikaDb] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [patikaDb].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [patikaDb] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [patikaDb] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [patikaDb] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [patikaDb] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [patikaDb] SET ARITHABORT OFF 
GO
ALTER DATABASE [patikaDb] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [patikaDb] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [patikaDb] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [patikaDb] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [patikaDb] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [patikaDb] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [patikaDb] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [patikaDb] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [patikaDb] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [patikaDb] SET  DISABLE_BROKER 
GO
ALTER DATABASE [patikaDb] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [patikaDb] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [patikaDb] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [patikaDb] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [patikaDb] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [patikaDb] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [patikaDb] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [patikaDb] SET RECOVERY FULL 
GO
ALTER DATABASE [patikaDb] SET  MULTI_USER 
GO
ALTER DATABASE [patikaDb] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [patikaDb] SET DB_CHAINING OFF 
GO
ALTER DATABASE [patikaDb] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [patikaDb] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [patikaDb] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [patikaDb] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'patikaDb', N'ON'
GO
ALTER DATABASE [patikaDb] SET QUERY_STORE = OFF
GO
USE [patikaDb]
GO
/****** Object:  UserDefinedFunction [dbo].[checkStudentStatus]    Script Date: 1/29/2022 6:18:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[checkStudentStatus]
(
	@studentID bigint,
	@lessonID bigint
)
returns int
as
begin
declare @sayi int
declare @startDate date
select @startDate=E.LessonStartDate from Educations E where E.id = @lessonID
select @sayi=count(U.id)  from Users U join student_education SE
						on U.id = SE.studentId
						join Educations ED
						on ED.id = SE.lessonId
						where U.id = @studentID
						and ED.LessonEndDate < @startDate
return @sayi
end




GO
/****** Object:  Table [dbo].[Roles]    Script Date: 1/29/2022 6:18:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Roles](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[roleName] [nvarchar](50) NULL,
 CONSTRAINT [PK_Roles] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 1/29/2022 6:18:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](50) NULL,
	[lastName] [nvarchar](50) NULL,
	[email] [nvarchar](max) NULL,
	[roleId] [int] NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[UsersView]    Script Date: 1/29/2022 6:18:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create View [dbo].[UsersView]
As 
Select name , lastName, email, roleName From Users U  join Roles R on U.roleId = R.id
GO
/****** Object:  Table [dbo].[teacher_lesson]    Script Date: 1/29/2022 6:18:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[teacher_lesson](
	[lessonId] [bigint] NOT NULL,
	[teacherId] [bigint] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Educations]    Script Date: 1/29/2022 6:18:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Educations](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[LessonName] [nvarchar](max) NULL,
	[LessonStartDate] [date] NULL,
	[LessonEndDate] [date] NULL,
 CONSTRAINT [PK_Educations] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[EducationAndTeacher]    Script Date: 1/29/2022 6:18:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create View [dbo].[EducationAndTeacher]
As
Select LessonName, LessonStartDate, LessonEndDate, name  from Educations E join teacher_lesson TL
																				on E.id = TL.lessonId
																				join Users U  
																				on TL.teacherId = U.id
GO
/****** Object:  Table [dbo].[asistant_education]    Script Date: 1/29/2022 6:18:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[asistant_education](
	[lessonId] [bigint] NOT NULL,
	[asistantId] [bigint] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[student_education]    Script Date: 1/29/2022 6:18:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[student_education](
	[lessonId] [bigint] NOT NULL,
	[studentId] [bigint] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[student_rollcall]    Script Date: 1/29/2022 6:18:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[student_rollcall](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[lessonId] [bigint] NULL,
	[studentId] [bigint] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[student_success]    Script Date: 1/29/2022 6:18:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[student_success](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[studentId] [bigint] NULL,
	[score] [decimal](18, 0) NULL
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Educations] ON 

INSERT [dbo].[Educations] ([id], [LessonName], [LessonStartDate], [LessonEndDate]) VALUES (1, N'.NEtCore', CAST(N'2022-01-01' AS Date), CAST(N'2022-03-01' AS Date))
INSERT [dbo].[Educations] ([id], [LessonName], [LessonStartDate], [LessonEndDate]) VALUES (2, N'python', CAST(N'2022-02-01' AS Date), CAST(N'2022-04-04' AS Date))
INSERT [dbo].[Educations] ([id], [LessonName], [LessonStartDate], [LessonEndDate]) VALUES (3, N'php', CAST(N'2021-01-01' AS Date), CAST(N'2023-05-01' AS Date))
SET IDENTITY_INSERT [dbo].[Educations] OFF
GO
SET IDENTITY_INSERT [dbo].[Roles] ON 

INSERT [dbo].[Roles] ([id], [roleName]) VALUES (1, N'Teacher')
INSERT [dbo].[Roles] ([id], [roleName]) VALUES (2, N'Student')
INSERT [dbo].[Roles] ([id], [roleName]) VALUES (3, N'Assistant')
SET IDENTITY_INSERT [dbo].[Roles] OFF
GO
SET IDENTITY_INSERT [dbo].[student_rollcall] ON 

INSERT [dbo].[student_rollcall] ([id], [lessonId], [studentId]) VALUES (1, 3, 2)
INSERT [dbo].[student_rollcall] ([id], [lessonId], [studentId]) VALUES (2, 3, 8)
INSERT [dbo].[student_rollcall] ([id], [lessonId], [studentId]) VALUES (3, 3, 8)
SET IDENTITY_INSERT [dbo].[student_rollcall] OFF
GO
SET IDENTITY_INSERT [dbo].[student_success] ON 

INSERT [dbo].[student_success] ([id], [studentId], [score]) VALUES (1, 8, CAST(20 AS Decimal(18, 0)))
SET IDENTITY_INSERT [dbo].[student_success] OFF
GO
INSERT [dbo].[teacher_lesson] ([lessonId], [teacherId]) VALUES (1, 2)
INSERT [dbo].[teacher_lesson] ([lessonId], [teacherId]) VALUES (3, 2)
INSERT [dbo].[teacher_lesson] ([lessonId], [teacherId]) VALUES (2, 4)
GO
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([id], [name], [lastName], [email], [roleId]) VALUES (1, N'Ertan', N'Aktaş', N'ertan@gmail.com', 2)
INSERT [dbo].[Users] ([id], [name], [lastName], [email], [roleId]) VALUES (2, N'Mehmet', N'MEhmet', N'metmet@gmail.com', 1)
INSERT [dbo].[Users] ([id], [name], [lastName], [email], [roleId]) VALUES (3, N'mesut', N'komiser', N'arkasokaklar@gmail.com', 3)
INSERT [dbo].[Users] ([id], [name], [lastName], [email], [roleId]) VALUES (4, N'John', N'Verdon', N'johnVerdon@gmail.com', 1)
INSERT [dbo].[Users] ([id], [name], [lastName], [email], [roleId]) VALUES (5, N'Jane', N'Verd', N'janeVerd@gmail.com', 2)
INSERT [dbo].[Users] ([id], [name], [lastName], [email], [roleId]) VALUES (6, N'Ertan', N'Jobs', N'jobsErtan@gmail.com', 2)
INSERT [dbo].[Users] ([id], [name], [lastName], [email], [roleId]) VALUES (7, N'Oguzhan', N'test', N'oguzhan@gmail.com', 3)
INSERT [dbo].[Users] ([id], [name], [lastName], [email], [roleId]) VALUES (8, N'test', N'lastname', N'tester@gmail.com', 2)
SET IDENTITY_INSERT [dbo].[Users] OFF
GO
ALTER TABLE [dbo].[asistant_education]  WITH CHECK ADD  CONSTRAINT [FK_asistant_education_Educations] FOREIGN KEY([lessonId])
REFERENCES [dbo].[Educations] ([id])
GO
ALTER TABLE [dbo].[asistant_education] CHECK CONSTRAINT [FK_asistant_education_Educations]
GO
ALTER TABLE [dbo].[asistant_education]  WITH CHECK ADD  CONSTRAINT [FK_asistant_education_Users] FOREIGN KEY([asistantId])
REFERENCES [dbo].[Users] ([id])
GO
ALTER TABLE [dbo].[asistant_education] CHECK CONSTRAINT [FK_asistant_education_Users]
GO
ALTER TABLE [dbo].[student_education]  WITH CHECK ADD  CONSTRAINT [FK_StudentEducation_Educations] FOREIGN KEY([lessonId])
REFERENCES [dbo].[Educations] ([id])
GO
ALTER TABLE [dbo].[student_education] CHECK CONSTRAINT [FK_StudentEducation_Educations]
GO
ALTER TABLE [dbo].[student_education]  WITH CHECK ADD  CONSTRAINT [FK_StudentEducation_Users] FOREIGN KEY([studentId])
REFERENCES [dbo].[Users] ([id])
GO
ALTER TABLE [dbo].[student_education] CHECK CONSTRAINT [FK_StudentEducation_Users]
GO
ALTER TABLE [dbo].[student_rollcall]  WITH CHECK ADD  CONSTRAINT [FK_student_rollcall_Educations] FOREIGN KEY([lessonId])
REFERENCES [dbo].[Educations] ([id])
GO
ALTER TABLE [dbo].[student_rollcall] CHECK CONSTRAINT [FK_student_rollcall_Educations]
GO
ALTER TABLE [dbo].[student_rollcall]  WITH CHECK ADD  CONSTRAINT [FK_student_rollcall_Users] FOREIGN KEY([studentId])
REFERENCES [dbo].[Users] ([id])
GO
ALTER TABLE [dbo].[student_rollcall] CHECK CONSTRAINT [FK_student_rollcall_Users]
GO
ALTER TABLE [dbo].[student_success]  WITH CHECK ADD  CONSTRAINT [FK_student_success_Users] FOREIGN KEY([studentId])
REFERENCES [dbo].[Users] ([id])
GO
ALTER TABLE [dbo].[student_success] CHECK CONSTRAINT [FK_student_success_Users]
GO
ALTER TABLE [dbo].[teacher_lesson]  WITH CHECK ADD  CONSTRAINT [FK_teacher_lesson_Educations] FOREIGN KEY([lessonId])
REFERENCES [dbo].[Educations] ([id])
GO
ALTER TABLE [dbo].[teacher_lesson] CHECK CONSTRAINT [FK_teacher_lesson_Educations]
GO
ALTER TABLE [dbo].[teacher_lesson]  WITH CHECK ADD  CONSTRAINT [FK_teacher_lesson_Users] FOREIGN KEY([teacherId])
REFERENCES [dbo].[Users] ([id])
GO
ALTER TABLE [dbo].[teacher_lesson] CHECK CONSTRAINT [FK_teacher_lesson_Users]
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD  CONSTRAINT [FK_Users_Roles] FOREIGN KEY([roleId])
REFERENCES [dbo].[Roles] ([id])
GO
ALTER TABLE [dbo].[Users] CHECK CONSTRAINT [FK_Users_Roles]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Add_Student_to_Lesson]    Script Date: 1/29/2022 6:18:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Sp_Add_Student_to_Lesson]
(
	@studentId bigint,
	@lessonId bigint
)
As
Begin
	if(dbo.checkStudentStatus(@studentId, @lessonId) = 0)
	begin
		Insert into student_education (lessonId, studentId)
		values (@lessonId, @studentId)
	end
	else
	begin
	print 'Kayıt Eklenemedi Öğrenci Zaten Bir Derse Kayıtlı'

	end

End
GO
/****** Object:  StoredProcedure [dbo].[Sp_Add_User]    Script Date: 1/29/2022 6:18:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Proc [dbo].[Sp_Add_User]
(
	@name nvarchar(50),
	@lastname nvarchar(50) ,
	@email nvarchar(max),
	@roleId int
	
)
As
Begin
	Insert Into Users (name, lastName,	email,roleId)
	Values (@name, @lastname,@email,@roleId)
End
GO
USE [master]
GO
ALTER DATABASE [patikaDb] SET  READ_WRITE 
GO
