REM 	This batch file automates the process of installing ESRI's ArcGIS Desktop 10.7.1
REM 	The file was created by Stacey D. Maples, Geospatial Manager at the Stanford Geospatial Center, Stanford University
REM		Question & Comments should be directed to stacemaples@stanford.edu
REM     edited on 08/7/2019 for Stanford Faculty, Student & Staff Non-Managed Workstation and Personal Installations


set __COMPAT_LAYER=RunAsInvoker

echo off

REM Installation of prerequisites

"\\sul-gislab\geowares\Esri\ArcGIS_Desktop_10.7.1\Desktop\SetupFiles\Support\VCREDIST\vc_redist.x86.exe" /install /passive /norestart

REM Determine if on 64-bit operating system
IF not EXIST "C:\Program Files (x86)" GOTO 32BIT

echo Installing the SQL Server Native Client on 64-bit Windows first...

"\\sul-gislab\geowares\Esri\ArcGIS_Desktop_10.7.1\DesktopBackgroundGP\SetupFiles\Support\VCREDIST\vc_redist.x64.exe" /install /passive /norestart

C:\WINDOWS\system32\msiexec.exe /I "\\sul-gislab\geowares\Esri\ArcGIS_Desktop_10.7.1\SQLServer2012SP3NativeClient_64\sqlncli.msi" IACCEPTSQLNCLILICENSETERMS=YES /norestart /passive /qb

REM echo Installing MSXML6 64-bit...
REM REM install MSXML6
REM C:\WINDOWS\system32\msiexec.exe /I "\\sul-gislab\geowares\Esri\ArcGIS_Desktop_10.7.1\Desktop\SetupFiles\Support\MSXML6\64-bit\msxml6_x64.msi" /norestart /passive /qb

GOTO SQLEND

:32BIT
echo Installing the SQL Server Native Client on 32-bit Windows first...
C:\WINDOWS\system32\msiexec.exe /I "\\sul-gislab\geowares\Esri\ArcGIS_Desktop_10.7.1\SQLServer2012SP3NativeClient_32\sqlncli.msi" IACCEPTSQLNCLILICENSETERMS=YES /norestart /passive /qb

REM echo Installing MSXML6...
REM REM install MSXML6
REM C:\WINDOWS\system32\msiexec.exe /I "\\sul-gislab\geowares\Esri\ArcGIS_Desktop_10.7.1\Desktop\SetupFiles\Support\MSXML6\32-bit\msxml6.msi" /norestart /passive /qb

:SQLEND

REM Installation of ArcGIS Software

echo Installing ArcGIS Desktop 10.7.1... this could take a while... you should go have dinner, or something...
REM Install ArcGIS Desktop 10.7.1  with options
C:\WINDOWS\system32\msiexec.exe /I "\\sul-gislab\geowares\Esri\ArcGIS_Desktop_10.7.1\Desktop\SetupFiles\setup.msi" DESKTOP_CONFIG=TRUE ADDLOCAL=ALL ESRI_LICENSE_HOST=27004@sul-gislm.stanford.edu INSTALLDIR1=C:\Python27 SOFTWARE_CLASS=Professional SEAT_PREFERENCE=Float /norestart /passive /qb

echo Installing the Data Interoperability Extension (you should read up on this, it's pretty cool)...
REM Install Data Interoperability Extension for ArcGIS 10.7.1
C:\WINDOWS\system32\msiexec.exe /I "\\sul-gislab\geowares\Esri\ArcGIS_Desktop_10.7.1\DataInteropDesktop\SetupFiles\setup.msi" /norestart /passive /qb

REM Determine if on 64-bit operating system
IF not EXIST "C:\Program Files (x86)" GOTO 64BITEND

echo Installing the 64-bit Background Geoprocessing Extension...
REM 64-bit Background Geoprocessing Extension
C:\WINDOWS\system32\msiexec.exe /I "\\sul-gislab\geowares\Esri\ArcGIS_Desktop_10.7.1\DesktopBackgroundGP\SetupFiles\setup.msi" /norestart /passive /qb

Rem echo Installing the 64-bit ArcHydro Extension...
REM Installing the 64-bit ArcHydro Extension...
Rem C:\WINDOWS\system32\msiexec.exe /I "\\sul-gislab\geowares\Esri\ArcGIS_Desktop_10.7.1\ArcHydro\ArcHydroTools_x64.msi" /norestart /passive /qb

REM Patch Installation

Rem echo Installing the 64-bit ArcHydro Extension...
REM Installing the 32-bit ArcHydro Extension...
Rem C:\WINDOWS\system32\msiexec.exe /I "\\sul-gislab\geowares\Esri\ArcGIS_Desktop_10.7.1\ArcHydro\ArcHydroTools_x64.msi" /norestart /passive /qb


rem ArcGIS (Desktop, Engine, Server) Microsoft ( R ) Windows ( R ) June 2019 Security Update Compatibility Patch
rem This patch resolves an issue with publishing services containing character marker symbology from ArcMap to ArcGIS Server, ArcGIS Enterprise or ArcGIS Online. This issue began with 
rem Microsoft's June 2019 security updates. The patch should be applied to ArcGIS Desktop, ArcGIS Engine and ArcGIS Server machines.
echo Installing 64-bit Patches

echo Installing ArcGIS (Desktop, Engine, Server) Microsoft ( R ) Windows ( R ) June 2019 Security Update Compatibility Patch
C:\WINDOWS\system32\msiexec.exe /p "\\sul-gislab\geowares\Esri\ArcGIS_Desktop_10.7.1\ArcGIS-1071-DT-MWJUN2019SUC-Patch.msp" /norestart /passive /gb

GOTO 32BITPatchesEnd

:64BITEND

echo Installing the 32-bit ArcHydro Extension...
REM Installing the 32-bit ArcHydro Extension...
C:\WINDOWS\system32\msiexec.exe /I "\\sul-gislab\geowares\Esri\ArcGIS_Desktop_10.7.1\ArcHydro\ArcHydroTools.msi" /norestart /passive /qb


rem ArcGIS (Desktop, Engine, Server) Microsoft ( R ) Windows ( R ) June 2019 Security Update Compatibility Patch
rem This patch resolves an issue with publishing services containing character marker symbology from ArcMap to ArcGIS Server, ArcGIS Enterprise or ArcGIS Online. This issue began with 
rem Microsoft's June 2019 security updates. The patch should be applied to ArcGIS Desktop, ArcGIS Engine and ArcGIS Server machines.
echo Installing ArcGIS (Desktop, Engine, Server) Microsoft ( R ) Windows ( R ) June 2019 Security Update Compatibility Patch
C:\WINDOWS\system32\msiexec.exe /p "\\sul-gislab\geowares\Esri\ArcGIS_Desktop_10.7.1\ArcGIS-1071-DT-MWJUN2019SUC-Patch.msp" /norestart /passive /gb

:32BITPatchesEnd 

REM install data & maps, ArcTutor and default settings registry entries

rem echo Installing ArcGIS 10.7 Tutorial Materials that go with the tutorials in the Help System...
rem Install ArcGIS 10.7 Tutorial Materials
rem xcopy "\\sul-gislab\geowares\Esri\ArcGIS_Desktop_10.7.1\ArcTutor_10.7.1\ArcTutor" "C:\ArcTutor_10.7.1" /s /e /i

rem echo Installing the Esri Data & Maps Dataset... this is about 4GB of data, so it might take a while...
rem Copy ESRI Data & Maps to C:\EsriDataMaps107 Drive of the target machine
rem xcopy "\\sul-gislab\geowares\Esri\Data_and_Maps_for_ArcGIS2018_166503" "C:\EsriDataMaps107" /s /e /i

REM Install Registry Entries for enabling all extensions and setting Relative Paths as the default
REGEDIT.exe -S "\\sul-gislab\geowares\Esri\ArcGIS_Desktop_10.7.1\ArcGIS_10.7.1_RegistryEntries.reg" /norestart
