rem 		This batch file automates the process of installing ESRI's ArcGIS Desktop 10.2.2
rem 		The file was created by Stacey D. Maples, GIS Specialist at the Yale University Map Collection
rem			Question & Comments should be directed to stacey.maples@yale.edu / 203-432-8269
rem         edited on 05/29/2014 for Yale Faculty, Student & Staff Installations


set __COMPAT_LAYER=RunAsInvoker

echo off

REM Determine if on 64-bit operating system
IF not EXIST "C:\Program Files (x86)" GOTO 32BIT

echo Installing the SQL Server Native Client on 64-bit Windows first...
C:\WINDOWS\system32\msiexec.exe /I "\\130.132.156.234\ArcGIS_10_Faculty_Staff\ArcGIS_Desktop102\DBMS_Support_Files\64-bit\sqlncli.msi" IACCEPTSQLNCLILICENSETERMS=YES /norestart /passive /qb

echo Installing MSXML6...
rem install MSXML6
C:\WINDOWS\system32\msiexec.exe /I "\\130.132.156.234\ArcGIS_10_Faculty_Staff\ArcGIS_Desktop102\Desktop\Support\MSXML6\64-bit\msxml6_x64.msi" /norestart /passive /qb

GOTO SQLEND

:32BIT
echo Installing the SQL Server Native Client on 32-bit Windows first...
C:\WINDOWS\system32\msiexec.exe /I "\\130.132.156.234\ArcGIS_10_Faculty_Staff\ArcGIS_Desktop102\DBMS_Support_Files\32-bit\sqlncli.msi" IACCEPTSQLNCLILICENSETERMS=YES /norestart /passive /qb

echo Installing MSXML6...
rem install MSXML6
C:\WINDOWS\system32\msiexec.exe /I "\\130.132.156.234\ArcGIS_10_Faculty_Staff\ArcGIS_Desktop102\Desktop\Support\MSXML6\32-bit\msxml6.msi" /norestart /passive /qb

:SQLEND

echo Installing ArcGIS Desktop 10.2.2... this could take a while... you should go have dinner, or something...
rem Install ArcGIS Desktop 10.2.2  with options
C:\WINDOWS\system32\msiexec.exe /I "\\130.132.156.234\ArcGIS_10_Faculty_Staff\ArcGIS_Desktop_10.2.2\Desktop\SetupFiles\setup.msi" ADDLOCAL=ALL ESRI_LICENSE_HOST=arcgis.library.yale.edu INSTALLDIR1=C:\Python27 SOFTWARE_CLASS=Professional SEAT_PREFERENCE=Float /norestart /passive /qb

echo Installing VBA support for ArcGIS 10.2
rem Install VBA Support for ArcGIS 10.2
C:\WINDOWS\system32\msiexec.exe /I "\\130.132.156.234\ArcGIS_10_Faculty_Staff\ArcGIS_Desktop_10.2.2\VBACompatibility\VBA\VBAOF11.msi" /norestart /passive /qb

C:\WINDOWS\system32\msiexec.exe /I "\\130.132.156.234\ArcGIS_10_Faculty_Staff\ArcGIS_Desktop_10.2.2\VBACompatibility\VBA\1033\VBAOF11I.msi" /norestart /passive /qb

echo Installing the Data Interoperability Extension (you should read up on this, it's pretty cool)...
rem Install Data Interoperability Extension for ArcGIS 10.2.2
C:\WINDOWS\system32\msiexec.exe /I "\\130.132.156.234\ArcGIS_10_Faculty_Staff\ArcGIS_Desktop_10.2.2\DataInterop\SetupFiles\setup.msi" /norestart /passive /qb

REM Determine if on 64-bit operating system
IF not EXIST "C:\Program Files (x86)" GOTO 64BITEND

echo Installing the 64-bit Background Geoprocessing Extension...
rem 64-bit Background Geoprocessing Extension
C:\WINDOWS\system32\msiexec.exe /I "\\130.132.156.234\ArcGIS_10_Faculty_Staff\ArcGIS_Desktop_10.2.2\BackgroundGP\SetupFiles\setup.msi" /norestart /passive /qb

:64BITEND

echo Installing ArcGIS Explorer 2500... Think of this as GeoPowerPoint...
Rem Install ArcGIS Explorer 2500 
C:\WINDOWS\system32\msiexec.exe /I "\\130.132.156.234\ArcGIS_10_Faculty_Staff\ArcGISExplorer\2500\Setup\AllUsers.msi" /qb /norestart

Rem Install Registry Entries for enabling all extensions and setting Relative Paths as the default
REGEDIT.exe -S "\\130.132.156.234\ArcGIS_10_Faculty_Staff\ArcGIS_10.2.2_RegistryEntries.reg" /norestart


