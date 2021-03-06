use master
go

-- Get the SQL Server default data path
DECLARE @data_path nvarchar(256);
SET @data_path = (SELECT SUBSTRING(physical_name, 1, CHARINDEX(N'master.mdf', LOWER(physical_name)) - 1)
                  FROM master.sys.master_files
                  WHERE database_id = 1 AND file_id = 1);

 -- Execute the CREATE DATABASE statement to create a new database with filegroups
 -- Files in the new filegroups will be created in the default data path
 EXECUTE ('
CREATE DATABASE [TaxiNYC]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = ''TaxiNYC'', FILENAME = ''' + @data_path + 'TaxiNYC.mdf'', SIZE = 4096KB , FILEGROWTH = 1024KB ), 
 FILEGROUP [nyctaxi_1] 
( NAME = ''TaxiNYC_1'', FILENAME = ''' + @data_path + 'TaxiNYC_1.ndf'' , SIZE = 102400KB , FILEGROWTH = 10240KB ), 
 FILEGROUP [nyctaxi_10] 
( NAME = ''TaxiNYC_10'', FILENAME = ''' + @data_path + 'TaxiNYC_10.ndf'' , SIZE = 102400KB , FILEGROWTH = 10240KB ), 
 FILEGROUP [nyctaxi_11] 
( NAME = ''TaxiNYC_11'', FILENAME = ''' + @data_path + 'TaxiNYC_11.ndf'' , SIZE = 102400KB , FILEGROWTH = 10240KB ), 
 FILEGROUP [nyctaxi_12] 
( NAME = ''TaxiNYC_12'', FILENAME = ''' + @data_path + 'TaxiNYC_12.ndf'' , SIZE = 102400KB , FILEGROWTH = 10240KB ), 
 FILEGROUP [nyctaxi_2] 
( NAME = ''TaxiNYC_2'', FILENAME = ''' + @data_path + 'TaxiNYC_2.ndf'' , SIZE = 102400KB , FILEGROWTH = 10240KB ), 
 FILEGROUP [nyctaxi_3] 
( NAME = ''TaxiNYC_3'', FILENAME = ''' + @data_path + 'TaxiNYC_3.ndf'' , SIZE = 102400KB , FILEGROWTH = 10240KB ), 
 FILEGROUP [nyctaxi_4] 
( NAME = ''TaxiNYC_4'', FILENAME = ''' + @data_path + 'TaxiNYC_4.ndf'' , SIZE = 102400KB , FILEGROWTH = 10240KB ), 
 FILEGROUP [nyctaxi_5] 
( NAME = ''TaxiNYC_5'', FILENAME = ''' + @data_path + 'TaxiNYC_5.ndf'' , SIZE = 102400KB , FILEGROWTH = 10240KB ), 
 FILEGROUP [nyctaxi_6] 
( NAME = ''TaxiNYC_6'', FILENAME = ''' + @data_path + 'TaxiNYC_6.ndf'' , SIZE = 102400KB , FILEGROWTH = 10240KB ), 
 FILEGROUP [nyctaxi_7] 
( NAME = ''TaxiNYC_7'', FILENAME = ''' + @data_path + 'TaxiNYC_7.ndf'' , SIZE = 102400KB , FILEGROWTH = 10240KB ), 
 FILEGROUP [nyctaxi_8] 
( NAME = ''TaxiNYC_8'', FILENAME = ''' + @data_path + 'TaxiNYC_8.ndf'' , SIZE = 102400KB , FILEGROWTH = 10240KB ), 
 FILEGROUP [nyctaxi_9] 
( NAME = ''TaxiNYC_9'', FILENAME = ''' + @data_path + 'TaxiNYC_9.ndf'' , SIZE = 102400KB , FILEGROWTH = 10240KB )
 LOG ON 
( NAME = ''TaxiNYC_log'', FILENAME = ''' + @data_path + 'TaxiNYC_log.ldf'' , SIZE = 1024KB , FILEGROWTH = 10%)
')
GO

-- MOdify/set database configuration
-- RECOVERY BULK_LOGGED mode minimizes logging during bulk imports
ALTER DATABASE [TaxiNYC] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [TaxiNYC] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [TaxiNYC] SET AUTO_UPDATE_STATISTICS_ASYNC ON 
GO
ALTER DATABASE [TaxiNYC] SET  READ_WRITE 
GO
ALTER DATABASE [TaxiNYC] SET RECOVERY BULK_LOGGED 
GO
ALTER DATABASE [TaxiNYC] SET  MULTI_USER 
GO
ALTER DATABASE [TaxiNYC] SET PAGE_VERIFY CHECKSUM  
GO

USE [TaxiNYC]
GO
IF NOT EXISTS (SELECT name FROM sys.filegroups WHERE is_default=1 AND name = N'PRIMARY') ALTER DATABASE [TaxiNYC] MODIFY FILEGROUP [PRIMARY] DEFAULT
GO
