rem 		This batch file automates the process of installing ESRI's ArcGIS Desktop 10.3.1
rem 		The file was created by Stacey D. Maples, Geospatial Manager at the Stanford Geospatial Center, Stanford University
rem			Question & Comments should be directed to stacemaples@stanford.edu
rem         edited on 05/29/2015 for Stanford Faculty, Student & Staff Non-Managed Workstation and Personal Installations


set __COMPAT_LAYER=RunAsInvoker

echo off

REM Determine if on 64-bit operating system
IF not EXIST "C:\Program Files (x86)" GOTO 32BIT

echo Installing the SQL Server Native Client on 64-bit Windows first...
C:\WINDOWS\system32\msiexec.exe /I "\\INSERT_YOUR_SERVER_ADDRESS_HERE\Esri\ArcGIS_Desktop_10.3.1\SQLServer2012SP1NativeClient_64\sqlncli.msi" IACCEPTSQLNCLILICENSETERMS=YES /norestart /passive /qb

echo Installing MSXML6...
rem install MSXML6
C:\WINDOWS\system32\msiexec.exe /I "\\INSERT_YOUR_SERVER_ADDRESS_HERE\Esri\ArcGIS_Desktop_10.3.1\Desktop\SetupFiles\Support\MSXML6\64-bit\msxml6_x64.msi" /norestart /passive /qb

GOTO SQLEND

:32BIT
echo Installing the SQL Server Native Client on 32-bit Windows first...
C:\WINDOWS\system32\msiexec.exe /I "\\INSERT_YOUR_SERVER_ADDRESS_HERE\Esri\ArcGIS_Desktop_10.3.1\SQLServer2012SP1NativeClient_32\sqlncli.msi" IACCEPTSQLNCLILICENSETERMS=YES /norestart /passive /qb

echo Installing MSXML6...
rem install MSXML6
C:\WINDOWS\system32\msiexec.exe /I "\\INSERT_YOUR_SERVER_ADDRESS_HERE\Esri\ArcGIS_Desktop_10.3.1\Desktop\SetupFiles\Support\MSXML6\32-bit\msxml6.msi" /norestart /passive /qb

:SQLEND

echo Installing ArcGIS Desktop 10.3.1... this could take a while... you should go have dinner, or something...
rem Install ArcGIS Desktop 10.3.1  with options
C:\WINDOWS\system32\msiexec.exe /I "\\INSERT_YOUR_SERVER_ADDRESS_HERE\Esri\ArcGIS_Desktop_10.3.1\Desktop\SetupFiles\setup.msi" ADDLOCAL=ALL ESRI_LICENSE_HOST=yourlicensemanager@whatever.edu INSTALLDIR1=C:\Python27 SOFTWARE_CLASS=Professional SEAT_PREFERENCE=Float /norestart /passive /qb

echo Installing VBA support for ArcGIS 10.3.1
rem Install VBA Support for ArcGIS 10.3.1
C:\WINDOWS\system32\msiexec.exe /I "\\INSERT_YOUR_SERVER_ADDRESS_HERE\Esri\ArcGIS_Desktop_10.3.1\VBACompatibility\VBA\VBAOF11.msi" /norestart /passive /qb

C:\WINDOWS\system32\msiexec.exe /I "\\INSERT_YOUR_SERVER_ADDRESS_HERE\Esri\ArcGIS_Desktop_10.3.1\VBACompatibility\VBA\1033\VBAOF11I.msi" /norestart /passive /qb

echo Installing the Data Interoperability Extension (you should read up on this, it's pretty cool)...
rem Install Data Interoperability Extension for ArcGIS 10.3.1
C:\WINDOWS\system32\msiexec.exe /I "\\INSERT_YOUR_SERVER_ADDRESS_HERE\Esri\ArcGIS_Desktop_10.3.1\DataInteropDesktop\SetupFiles\setup.msi" /norestart /passive /qb



REM Determine if on 64-bit operating system
IF not EXIST "C:\Program Files (x86)" GOTO 64BITEND

echo Installing the 64-bit Background Geoprocessing Extension...
rem 64-bit Background Geoprocessing Extension
C:\WINDOWS\system32\msiexec.exe /I "\\INSERT_YOUR_SERVER_ADDRESS_HERE\Esri\ArcGIS_Desktop_10.3.1\DesktopBackgroundGP\SetupFiles\setup.msi" /norestart /passive /qb

Rem Install Registry Entries for enabling all extensions and setting Relative Paths as the default
REGEDIT.exe -S "\\INSERT_YOUR_SERVER_ADDRESS_HERE\ArcGIS_Desktop_10.3.1\ArcGIS_10.3.1_RegistryEntries.reg" /norestart

:64BITEND
