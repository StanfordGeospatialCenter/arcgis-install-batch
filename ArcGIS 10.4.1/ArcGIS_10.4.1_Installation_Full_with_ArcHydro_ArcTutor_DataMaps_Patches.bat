REM 	This batch file automates the process of installing ESRI's ArcGIS Desktop 10.4.1
REM 	The file was created by Stacey D. Maples, Geospatial Manager at the Stanford Geospatial Center, Stanford University
REM		Question & Comments should be directed to stacemaples@stanford.edu
REM     edited on 08/05/2016 for Stanford Faculty, Student & Staff Non-Managed Workstation and Personal Installations


set __COMPAT_LAYER=RunAsInvoker

echo off

REM Installation of prerequisites

REM Determine if on 64-bit operating system
IF not EXIST "C:\Program Files (x86)" GOTO 32BIT

echo Installing the SQL Server Native Client on 64-bit Windows first...
C:\WINDOWS\system32\msiexec.exe /I "\\sul-gislab\geowares\Esri\ArcGIS_Desktop_10.4.1\SQLServer2012SP3NativeClient_64\sqlncli.msi" IACCEPTSQLNCLILICENSETERMS=YES /norestart /passive /qb

echo Installing MSXML6 64-bit...
REM install MSXML6
C:\WINDOWS\system32\msiexec.exe /I "\\sul-gislab\geowares\Esri\ArcGIS_Desktop_10.4.1\Desktop\SetupFiles\Support\MSXML6\64-bit\msxml6_x64.msi" /norestart /passive /qb

GOTO SQLEND

:32BIT
echo Installing the SQL Server Native Client on 32-bit Windows first...
C:\WINDOWS\system32\msiexec.exe /I "\\sul-gislab\geowares\Esri\ArcGIS_Desktop_10.4.1\SQLServer2012SP3NativeClient_32\sqlncli.msi" IACCEPTSQLNCLILICENSETERMS=YES /norestart /passive /qb

echo Installing MSXML6...
REM install MSXML6
C:\WINDOWS\system32\msiexec.exe /I "\\sul-gislab\geowares\Esri\ArcGIS_Desktop_10.4.1\Desktop\SetupFiles\Support\MSXML6\32-bit\msxml6.msi" /norestart /passive /qb

:SQLEND

REM Installation of ArcGIS Software

echo Installing ArcGIS Desktop 10.4.1... this could take a while... you should go have dinner, or something...
REM Install ArcGIS Desktop 10.4.1  with options
C:\WINDOWS\system32\msiexec.exe /I "\\sul-gislab\geowares\Esri\ArcGIS_Desktop_10.4.1\Desktop\SetupFiles\setup.msi" ADDLOCAL=ALL ESRI_LICENSE_HOST=27004@sul-gislm.stanford.edu INSTALLDIR1=C:\Python27 SOFTWARE_CLASS=Professional SEAT_PREFERENCE=Float /norestart /passive /qb

echo Installing VBA support for ArcGIS 10.4.1
REM Install VBA Support for ArcGIS 10.4.1
C:\WINDOWS\system32\msiexec.exe /I "\\sul-gislab\geowares\Esri\ArcGIS_Desktop_10.4.1\VBACompatibility\VBA\VBAOF11.msi" /norestart /passive /qb

C:\WINDOWS\system32\msiexec.exe /I "\\sul-gislab\geowares\Esri\ArcGIS_Desktop_10.4.1\VBACompatibility\VBA\1033\VBAOF11I.msi" /norestart /passive /qb

echo Installing the Data Interoperability Extension (you should read up on this, it's pretty cool)...
REM Install Data Interoperability Extension for ArcGIS 10.4.1
C:\WINDOWS\system32\msiexec.exe /I "\\sul-gislab\geowares\Esri\ArcGIS_Desktop_10.4.1\DataInteropDesktop\SetupFiles\setup.msi" /norestart /passive /qb



REM Determine if on 64-bit operating system
IF not EXIST "C:\Program Files (x86)" GOTO 64BITEND

echo Installing the 64-bit Background Geoprocessing Extension...
REM 64-bit Background Geoprocessing Extension
C:\WINDOWS\system32\msiexec.exe /I "\\sul-gislab\geowares\Esri\ArcGIS_Desktop_10.4.1\DesktopBackgroundGP\SetupFiles\setup.msi" /norestart /passive /qb

echo Installing the 64-bit ArcHydro Extension...
REM Installing the 64-bit ArcHydro Extension...
C:\WINDOWS\system32\msiexec.exe /I "\\sul-gislab\geowares\Esri\ArcGIS_Desktop_10.4.1\ArcHydro\ArcHydroTools_x64.msi" /norestart /passive /qb

:64BITEND

REM Patch Installation
echo Installing Patches

REM Determine if on 64-bit operating system
IF not EXIST "C:\Program Files (x86)" GOTO 64BITPatchesEnd

REM ArcGIS 10.4.1 for (Desktop, Engine, Server) Geocoding General Maintenance Patch 
echo Installing ArcGIS 10.4.1 for (Desktop, Engine, Server) Geocoding General Maintenance Patch 64-bit
C:\WINDOWS\system32\msiexec.exe /p "\\sul-gislab\geowares\Esri\ArcGIS_Desktop_10.4.1\Patches\ArcGIS-1041-BGDT-GGM-Patch.msp" /norestart /passive /gb

GOTO 32BITPatchesEnd

:64BITPatchesEnd

REM ArcGIS 10.4.1 for (Desktop, Engine, Server) Geocoding General Maintenance Patch 
echo Installing ArcGIS 10.4.1 for (Desktop, Engine, Server) Geocoding General Maintenance Patch 
C:\WINDOWS\system32\msiexec.exe /p "\\sul-gislab\geowares\Esri\ArcGIS_Desktop_10.4.1\Patches\ArcGIS-1041-DT-GGM-Patch.msp" /norestart /passive /gb

echo Installing the 32-bit ArcHydro Extension...
REM Installing the 32-bit ArcHydro Extension...
C:\WINDOWS\system32\msiexec.exe /I "\\sul-gislab\geowares\Esri\ArcGIS_Desktop_10.4.1\ArcHydro\ArcHydroTools.msi" /norestart /passive /qb

:32BITPatchesEnd 

REM install data & maps, ArcTutor and default settings registry entries

echo Installing ArcGIS 10.4 Tutorial Materials that go with the tutorials in the Help System...

rem Install ArcGIS 10.4 Tutorial Materials
xcopy "\\sul-gislab\geowares\Esri\ArcGIS_Desktop_10.4.1\ArcTutor" "C:\ArcTutor" /s /e /i

echo Installing the Esri Data & Maps Dataset... this is about 4GB of data, so it might take a while...
rem Copy ESRI Data & Maps to the C:\EsriDataMaps104 Drive of the target machine
xcopy "\\sul-gislab\geowares\Esri\Data_and_Maps_for_ArcGIS_10.4.1" "C:\EsriDataMaps104" /s /e /i 

REM Install Registry Entries for enabling all extensions and setting Relative Paths as the default
REGEDIT.exe -S "\\sul-gislab\geowares\Esri\ArcGIS_Desktop_10.4.1\ArcGIS_10.4.1_RegistryEntries.reg" /norestart



