REM 	This batch file automates the process of installing ESRI's ArcGIS Desktop 10.3.1
REM 	The file was created by Stacey D. Maples, Geospatial Manager at the Stanford Geospatial Center, Stanford University
REM		Question & Comments should be directed to stacemaples@stanford.edu
REM     edited on 08/12/2015 for Stanford Faculty, Student & Staff Non-Managed Workstation and Personal Installations


set __COMPAT_LAYER=RunAsInvoker

echo off

REM Installation of prerequisites

REM Determine if on 64-bit operating system
IF not EXIST "C:\Program Files (x86)" GOTO 32BIT

echo Installing the SQL Server Native Client on 64-bit Windows first...
C:\WINDOWS\system32\msiexec.exe /I "\\INSERT_YOUR_SERVER_ADDRESS_HERE\ArcGIS_Desktop_10.3.1\SQLServer2012SP1NativeClient_64\sqlncli.msi" IACCEPTSQLNCLILICENSETERMS=YES /norestart /passive /qb

echo Installing MSXML6 64-bit...
REM install MSXML6
C:\WINDOWS\system32\msiexec.exe /I "\\INSERT_YOUR_SERVER_ADDRESS_HERE\ArcGIS_Desktop_10.3.1\Desktop\SetupFiles\Support\MSXML6\64-bit\msxml6_x64.msi" /norestart /passive /qb

GOTO SQLEND

:32BIT
echo Installing the SQL Server Native Client on 32-bit Windows first...
C:\WINDOWS\system32\msiexec.exe /I "\\INSERT_YOUR_SERVER_ADDRESS_HERE\ArcGIS_Desktop_10.3.1\SQLServer2012SP1NativeClient_32\sqlncli.msi" IACCEPTSQLNCLILICENSETERMS=YES /norestart /passive /qb

echo Installing MSXML6...
REM install MSXML6
C:\WINDOWS\system32\msiexec.exe /I "\\INSERT_YOUR_SERVER_ADDRESS_HERE\ArcGIS_Desktop_10.3.1\Desktop\SetupFiles\Support\MSXML6\32-bit\msxml6.msi" /norestart /passive /qb

:SQLEND

REM Installation of ArcGIS Software

echo Installing ArcGIS Desktop 10.3.1... this could take a while... you should go have dinner, or something...
REM Install ArcGIS Desktop 10.3.1  with options
C:\WINDOWS\system32\msiexec.exe /I "\\INSERT_YOUR_SERVER_ADDRESS_HERE\ArcGIS_Desktop_10.3.1\Desktop\SetupFiles\setup.msi" ADDLOCAL=ALL ESRI_LICENSE_HOST=yourlicensemanager@whatever.edu INSTALLDIR1=C:\Python27 SOFTWARE_CLASS=Professional SEAT_PREFERENCE=Float /norestart /passive /qb

echo Installing VBA support for ArcGIS 10.3.1
REM Install VBA Support for ArcGIS 10.3.1
C:\WINDOWS\system32\msiexec.exe /I "\\INSERT_YOUR_SERVER_ADDRESS_HERE\ArcGIS_Desktop_10.3.1\VBACompatibility\VBA\VBAOF11.msi" /norestart /passive /qb

C:\WINDOWS\system32\msiexec.exe /I "\\INSERT_YOUR_SERVER_ADDRESS_HERE\ArcGIS_Desktop_10.3.1\VBACompatibility\VBA\1033\VBAOF11I.msi" /norestart /passive /qb

echo Installing the Data Interoperability Extension (you should read up on this, it's pretty cool)...
REM Install Data Interoperability Extension for ArcGIS 10.3.1
C:\WINDOWS\system32\msiexec.exe /I "\\INSERT_YOUR_SERVER_ADDRESS_HERE\ArcGIS_Desktop_10.3.1\DataInteropDesktop\SetupFiles\setup.msi" /norestart /passive /qb

REM Determine if on 64-bit operating system
IF not EXIST "C:\Program Files (x86)" GOTO 64BITEND

echo Installing the 64-bit Background Geoprocessing Extension...
REM 64-bit Background Geoprocessing Extension
C:\WINDOWS\system32\msiexec.exe /I "\\INSERT_YOUR_SERVER_ADDRESS_HERE\ArcGIS_Desktop_10.3.1\DesktopBackgroundGP\SetupFiles\setup.msi" /norestart /passive /qb

echo Installing the 64-bit ArcHydro Extension...
REM Installing the 64-bit ArcHydro Extension...
C:\WINDOWS\system32\msiexec.exe /I "\\INSERT_YOUR_SERVER_ADDRESS_HERE\ArcGIS_Desktop_10.3.1\ArcHydro\ArcHydroTools_x64.msi" /norestart /passive /qb

REM ArcGIS Desktop Background Geometric Geoprocessing (64-bit) patch
echo Installing ArcGIS Desktop Background Geoprocessing (64-bit) patch  
C:\WINDOWS\system32\msiexec.exe /p "\\INSERT_YOUR_SERVER_ADDRESS_HERE\ArcGIS_Desktop_10.3.1\Patches\ArcGIS-1031-BGDT-GNGU-Patch.msp" /norestart /passive /gb

:64BITEND

REM Patch Installation
echo Installing Patches

REM ArcGIS for Desktop Geometric Geoprocessing
echo Installing ArcGIS for Desktop Geometric Geoprocessing
C:\WINDOWS\system32\msiexec.exe /p "\\INSERT_YOUR_SERVER_ADDRESS_HERE\ArcGIS_Desktop_10.3.1\Patches\ArcGIS-1031-DT-GNGU-Patch.msp" /norestart /passive /gb

REM Desktop Package Map for ArcGIS Runtime Patch
echo Installing ArcGIS 10.3.1 for Desktop Package Map for ArcGIS Runtime Patch
C:\WINDOWS\system32\msiexec.exe /p "\\INSERT_YOUR_SERVER_ADDRESS_HERE\ArcGIS_Desktop_10.3.1\Patches\ArcGIS-1031-DT-PMFAR-Patch.msp" /norestart /passive /gb

REM Desktop Georeferencing CAD data Patch
echo Installing ArcGIS for 10.3.1 for Desktop Georeferencing CAD data Patch
C:\WINDOWS\system32\msiexec.exe /p "\\INSERT_YOUR_SERVER_ADDRESS_HERE\ArcGIS_Desktop_10.3.1\Patches\ArcGIS-1031-DT-GCD-Patch.msp" /norestart /passive /gb

REM install data & maps, ArcTutor and default settings registry entries

echo Installing ArcGIS 10.3 Tutorial Materials that go with the tutorials in the Help System...
rem Install ArcGIS 10.3 Tutorial Materials

xcopy "\\INSERT_YOUR_SERVER_ADDRESS_HERE\ArcGIS_Desktop_10.3.1\ArcTutor" "C:\ArcTutor" /s /e /i

echo Installing the Esri Data & Maps Dataset... this is about 3GB of data, so it might take a while...
rem Copy ESRI Data & Maps to the C: Drive of the target machine
xcopy "\\INSERT_YOUR_SERVER_ADDRESS_HERE\Data_and_Maps_for_ArcGIS_10.3.1" "C:\DATAMAPS103" /s /e /i 

REM Install Registry Entries for enabling all extensions and setting Relative Paths as the default
REGEDIT.exe -S "\\INSERT_YOUR_SERVER_ADDRESS_HERE\ArcGIS_Desktop_10.3.1\ArcGIS_10.3.1_RegistryEntries.reg" /norestart



