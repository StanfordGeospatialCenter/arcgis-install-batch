rem 		This batch file automates the process of installing ESRI's ArcGIS Desktop 10.2.2
rem 		The file was created by Stacey D. Maples, Geospatial Manager at the Stanford Geospatial Center, Stanford University
rem			Question & Comments should be directed to stacemaples@stanford.edu
rem         edited on 03/16/2015 for Stanford Faculty, Student & Staff Non-Managed Workstation and Personal Installations


set __COMPAT_LAYER=RunAsInvoker

echo off

REM Determine if on 64-bit operating system
IF not EXIST "C:\Program Files (x86)" GOTO 32BIT

echo Installing the SQL Server Native Client on 64-bit Windows first...
C:\WINDOWS\system32\msiexec.exe /I "\\INSERT_YOUR_SERVER_ADDRESS_HERE\ArcGIS_Desktop_10.2.2\SQLServer2012SP1NativeClient_64\sqlncli.msi" IACCEPTSQLNCLILICENSETERMS=YES /norestart /passive /qb

echo Installing MSXML6...
rem install MSXML6
C:\WINDOWS\system32\msiexec.exe /I "\\INSERT_YOUR_SERVER_ADDRESS_HERE\ArcGIS_Desktop_10.2.2\Desktop\SetupFiles\Support\MSXML6\64-bit\msxml6_x64.msi" /norestart /passive /qb

GOTO SQLEND

:32BIT
echo Installing the SQL Server Native Client on 32-bit Windows first...
C:\WINDOWS\system32\msiexec.exe /I "\\INSERT_YOUR_SERVER_ADDRESS_HERE\ArcGIS_Desktop_10.2.2\SQLServer2012SP1NativeClient_32\sqlncli.msi" IACCEPTSQLNCLILICENSETERMS=YES /norestart /passive /qb

echo Installing MSXML6...
rem install MSXML6
C:\WINDOWS\system32\msiexec.exe /I "\\INSERT_YOUR_SERVER_ADDRESS_HERE\ArcGIS_Desktop_10.2.2\Desktop\SetupFiles\Support\MSXML6\32-bit\msxml6.msi" /norestart /passive /qb

:SQLEND

echo Installing ArcGIS Desktop 10.2.2... this could take a while... you should go have dinner, or something...
rem Install ArcGIS Desktop 10.2.2  with options
C:\WINDOWS\system32\msiexec.exe /I "\\INSERT_YOUR_SERVER_ADDRESS_HERE\ArcGIS_Desktop_10.2.2\Desktop\SetupFiles\setup.msi" ADDLOCAL=ALL ESRI_LICENSE_HOST=27004@sul-gislm.stanford.edu INSTALLDIR1=C:\Python27 SOFTWARE_CLASS=Professional SEAT_PREFERENCE=Float /norestart /passive /qb

echo Installing VBA support for ArcGIS 10.2
rem Install VBA Support for ArcGIS 10.2
C:\WINDOWS\system32\msiexec.exe /I "\\INSERT_YOUR_SERVER_ADDRESS_HERE\ArcGIS_Desktop_10.2.2\VBACompatibility\VBA\VBAOF11.msi" /norestart /passive /qb

C:\WINDOWS\system32\msiexec.exe /I "\\INSERT_YOUR_SERVER_ADDRESS_HERE\ArcGIS_Desktop_10.2.2\VBACompatibility\VBA\1033\VBAOF11I.msi" /norestart /passive /qb

echo Installing the Data Interoperability Extension (you should read up on this, it's pretty cool)...
rem Install Data Interoperability Extension for ArcGIS 10.2.2
C:\WINDOWS\system32\msiexec.exe /I "\\INSERT_YOUR_SERVER_ADDRESS_HERE\ArcGIS_Desktop_10.2.2\DataInteropDesktop\SetupFiles\setup.msi" /norestart /passive /qb



rem installing patches below
echo Installing ArcGIS 10.2 - 10.2.2 for Desktop Print Dialog Hang Patch...
rem Install ArcGIS 10.2 - 10.2.2 for Desktop Print Dialog Hang Patch
C:\WINDOWS\system32\msiexec.exe /P "\\INSERT_YOUR_SERVER_ADDRESS_HERE\ArcGIS_Desktop_10.2.2\Patches\ArcGIS-1022-DT-PDH-Patch.msp" /norestart /passive /qb

echo Installing ArcGIS 10.2.2 for (Desktop/Engine/Server) Oracle Geodatabase Object Schema Update and Editing Patch...
rem Install ArcGIS 10.2.2 for (Desktop/Engine/Server) Oracle Geodatabase Object Schema Update and Editing Patch
C:\WINDOWS\system32\msiexec.exe /P "\\INSERT_YOUR_SERVER_ADDRESS_HERE\ArcGIS_Desktop_10.2.2\Patches\ArcGIS-1022-DT-OGOSUE-Patch.msp" /norestart /passive /qb

echo Installing ArcGIS 10.2.2 for Desktop Non-textured Multipatch Transparency Patch...
rem Install ArcGIS 10.2.2 for Desktop Non-textured Multipatch Transparency Patch
C:\WINDOWS\system32\msiexec.exe /P "\\INSERT_YOUR_SERVER_ADDRESS_HERE\ArcGIS_Desktop_10.2.2\Patches\ArcGIS-1022-DT-NMT-Patch.msp" /norestart /passive /qb

echo Installing ArcGIS 10.2.2 for (Desktop, Engine, Server) Update GeoPackage Support for the OGC Standard Version 1...
rem Install ArcGIS 10.2.2 for (Desktop, Engine, Server) Update GeoPackage Support for the OGC Standard Version 1
C:\WINDOWS\system32\msiexec.exe /P "\\INSERT_YOUR_SERVER_ADDRESS_HERE\ArcGIS_Desktop_10.2.2\Patches\ArcGIS-1022-DT-UGSO-Patch.msp" /norestart /passive /qb

echo Installing ArcGIS 10.2.2 for (Desktop, Engine, Server) Spatial Reference Consistency Patch...
rem Install ArcGIS 10.2.2 for (Desktop, Engine, Server) Spatial Reference Consistency Patch
C:\WINDOWS\system32\msiexec.exe /P "\\INSERT_YOUR_SERVER_ADDRESS_HERE\ArcGIS_Desktop_10.2.2\Patches\ArcGIS-1022-DT-SRC-Patch.msp" /norestart /passive /qb

echo Installing ArcGIS 10.1 SP1 - 10.2.2 for (Desktop, Engine, Server) OpenSSL Update Patch...
rem Install ArcGIS 10.1 SP1 - 10.2.2 for (Desktop, Engine, Server) OpenSSL Update Patch
C:\WINDOWS\system32\msiexec.exe /P "\\INSERT_YOUR_SERVER_ADDRESS_HERE\ArcGIS_Desktop_10.2.2\Patches\ArcGIS-1022-DT-OSSLU-Patch.msp" /norestart /passive /qb

echo Installing ArcGIS 10.1 SP1 QIP – 10.2.2 (Desktop, Engine, Server) Tracking Layers Numeric NULL Values Patch...
rem Install ArcGIS 10.1 SP1 QIP – 10.2.2 (Desktop, Engine, Server) Tracking Layers Numeric NULL Values Patch
C:\WINDOWS\system32\msiexec.exe /P "\\INSERT_YOUR_SERVER_ADDRESS_HERE\ArcGIS_Desktop_10.2.2\Patches\ArcGIS-1022-DT-TLNNV-Patch.msp" /norestart /passive /qb


echo Installing ArcGIS 10.2 – 10.2.2 for Desktop Digital Globe GeoEye Metadata/Product Layout Patch...
rem Install ArcGIS 10.2 – 10.2.2 for Desktop Digital Globe GeoEye Metadata/Product Layout Patch
C:\WINDOWS\system32\msiexec.exe /P "\\INSERT_YOUR_SERVER_ADDRESS_HERE\ArcGIS_Desktop_10.2.2\Patches\ArcGIS-1022-DT-DGGM-Patch.msp" /norestart /passive /qb


echo Installing ArcGIS 10.2.2 for (Desktop, Engine, Server) Set Shapefile Default Code Page Patch...
rem Install ArcGIS 10.2.2 for (Desktop, Engine, Server) Set Shapefile Default Code Page Patch
C:\WINDOWS\system32\msiexec.exe /P "\\INSERT_YOUR_SERVER_ADDRESS_HERE\ArcGIS_Desktop_10.2.2\Patches\ArcGIS-1022-DT-SSDCP-Patch.msp" /norestart /passive /qb

echo Installing ArcGIS 10 SP5 – 10.2.2 for (Desktop, Engine, Server) PDF Web Mercator Auxiliary Sphere Patch...
rem Install ArcGIS 10 SP5 – 10.2.2 for (Desktop, Engine, Server) PDF Web Mercator Auxiliary Sphere Patch
C:\WINDOWS\system32\msiexec.exe /P "\\INSERT_YOUR_SERVER_ADDRESS_HERE\ArcGIS_Desktop_10.2.2\Patches\ArcGIS-1022-DT-PWMAS-Patch.msp" /norestart /passive /qb


echo Installing ArcGIS 10.2.1 & 10.2.2 for Desktop Hydrology Tools Ready-to-use-Services Patch...
rem Install ArcGIS 10.2.1 & 10.2.2 for Desktop Hydrology Tools Ready-to-use-Services Patch
C:\WINDOWS\system32\msiexec.exe /P "\\INSERT_YOUR_SERVER_ADDRESS_HERE\ArcGIS_Desktop_10.2.2\Patches\ArcGIS-1022-DT-HTRS-Patch.msp" /norestart /passive /qb


echo Installing ArcGIS 10.2.2 for (Desktop, Engine, Server) Geodatabase and Feature Service Sync Optimization Patch...
rem Install ArcGIS 10.2.2 for (Desktop, Engine, Server) Geodatabase and Feature Service Sync Optimization Patch
C:\WINDOWS\system32\msiexec.exe /P "\\INSERT_YOUR_SERVER_ADDRESS_HERE\ArcGIS_Desktop_10.2.2\Patches\ArcGIS-1022-DT-GFSSO-Patch.msp" /norestart /passive /qb


echo Installing ArcGIS 10.2.2 for Desktop Parcel Fabric General Maintenance Patch...
rem Install ArcGIS 10.2.2 for Desktop Parcel Fabric General Maintenance Patch
C:\WINDOWS\system32\msiexec.exe /P "\\INSERT_YOUR_SERVER_ADDRESS_HERE\ArcGIS_Desktop_10.2.2\Patches\ArcGIS-1022-DT-PFGM-PatchB.msp" /norestart /passive /qb


echo Installing ArcGIS 10.2.2 (Desktop, Engine, Server) Geographic or Datum Transformation Patch...
rem Install ArcGIS 10.2.2 (Desktop, Engine, Server) Geographic or Datum Transformation Patch
C:\WINDOWS\system32\msiexec.exe /P "\\INSERT_YOUR_SERVER_ADDRESS_HERE\ArcGIS_Desktop_10.2.2\Patches\ArcGIS-1022-DT-GDT-Patch.msp" /norestart /passive /qb


echo Installing ArcGIS 'Oracle Critical Patch Update - October 2014' Connection Issue Patch...
rem Install ArcGIS 'Oracle Critical Patch Update - October 2014' Connection Issue Patch
C:\WINDOWS\system32\msiexec.exe /P "\\INSERT_YOUR_SERVER_ADDRESS_HERE\ArcGIS_Desktop_10.2.2\Patches\ArcGIS-1022-DT-OCPU-Patch.msp" /norestart /passive /qb


echo Installing ArcGIS 10.2.2 for Desktop WMTS Service Layer Display Patch...
rem Install ArcGIS 10.2.2 for Desktop WMTS Service Layer Display Patch
C:\WINDOWS\system32\msiexec.exe /P "\\INSERT_YOUR_SERVER_ADDRESS_HERE\ArcGIS_Desktop_10.2.2\Patches\ArcGIS-1022-DT-WSLD-Patch.msp" /norestart /passive /qb



REM Determine if on 64-bit operating system
IF not EXIST "C:\Program Files (x86)" GOTO 64BITEND

echo Installing the 64-bit Background Geoprocessing Extension...
rem 64-bit Background Geoprocessing Extension
C:\WINDOWS\system32\msiexec.exe /I "\\INSERT_YOUR_SERVER_ADDRESS_HERE\ArcGIS_Desktop_10.2.2\DesktopBackgroundGP\SetupFiles\setup.msi" /norestart /passive /qb


rem Installing 64-bit patches below
echo Installing ArcGIS 10.2.2 for (Desktop/Engine/Server) Oracle Geodatabase Object Schema Update and Editing Patch...
rem Install ArcGIS 10.2.2 for (Desktop/Engine/Server) Oracle Geodatabase Object Schema Update and Editing Patch
C:\WINDOWS\system32\msiexec.exe /P "\\INSERT_YOUR_SERVER_ADDRESS_HERE\ArcGIS_Desktop_10.2.2\Patches\ArcGIS-1022-BGDT-OGOSUE-Patch.msp" /norestart /passive /qb

echo Installing ArcGIS 10.2.2 for (Desktop, Engine, Server) Spatial Reference Consistency Patch...
rem Install ArcGIS 10.2.2 for (Desktop, Engine, Server) Spatial Reference Consistency Patch
C:\WINDOWS\system32\msiexec.exe /P "\\INSERT_YOUR_SERVER_ADDRESS_HERE\ArcGIS_Desktop_10.2.2\Patches\ArcGIS-1022-BGDT-SRC-Patch.msp" /norestart /passive /qb

echo Installing ArcGIS 10.1 SP1 - 10.2.2 for (Desktop, Engine, Server) OpenSSL Update Patch...
rem Install ArcGIS 10.1 SP1 - 10.2.2 for (Desktop, Engine, Server) OpenSSL Update Patch
C:\WINDOWS\system32\msiexec.exe /P "\\INSERT_YOUR_SERVER_ADDRESS_HERE\ArcGIS_Desktop_10.2.2\Patches\ArcGIS-1022-BGDT-OSSLU-Patch.msp" /norestart /passive /qb

echo Installing ArcGIS 10.1 SP1 QIP – 10.2.2 (Desktop, Engine, Server) Tracking Layers Numeric NULL Values Patch...
rem Install ArcGIS 10.1 SP1 QIP – 10.2.2 (Desktop, Engine, Server) Tracking Layers Numeric NULL Values Patch
C:\WINDOWS\system32\msiexec.exe /P "\\INSERT_YOUR_SERVER_ADDRESS_HERE\ArcGIS_Desktop_10.2.2\Patches\ArcGIS-1022-BGDT-TLNNV-Patch.msp" /norestart /passive /qb

echo Installing ArcGIS 10.2.2 for (Desktop, Engine, Server) Set Shapefile Default Code Page Patch...
rem Install ArcGIS 10.2.2 for (Desktop, Engine, Server) Set Shapefile Default Code Page Patch
C:\WINDOWS\system32\msiexec.exe /P "\\INSERT_YOUR_SERVER_ADDRESS_HERE\ArcGIS_Desktop_10.2.2\Patches\ArcGIS-1022-BGDT-SSDCP-Patch.msp" /norestart /passive /qb

echo Installing ArcGIS 10 SP5 – 10.2.2 for (Desktop, Engine, Server) PDF Web Mercator Auxiliary Sphere Patch...
rem Install ArcGIS 10 SP5 – 10.2.2 for (Desktop, Engine, Server) PDF Web Mercator Auxiliary Sphere Patch
C:\WINDOWS\system32\msiexec.exe /P "\\INSERT_YOUR_SERVER_ADDRESS_HERE\ArcGIS_Desktop_10.2.2\Patches\ArcGIS-1022-BGDT-PWMAS-Patch.msp" /norestart /passive /qb

echo Installing ArcGIS 10.2.2 for (Desktop, Engine, Server) Geodatabase and Feature Service Sync Optimization Patch...
rem Install ArcGIS 10.2.2 for (Desktop, Engine, Server) Geodatabase and Feature Service Sync Optimization Patch
C:\WINDOWS\system32\msiexec.exe /P "\\INSERT_YOUR_SERVER_ADDRESS_HERE\ArcGIS_Desktop_10.2.2\Patches\ArcGIS-1022-BGDT-GFSSO-Patch.msp" /norestart /passive /qb

echo Installing ArcGIS 10.2.2 (Desktop, Engine, Server) Geographic or Datum Transformation Patch...
rem Install ArcGIS 10.2.2 (Desktop, Engine, Server) Geographic or Datum Transformation Patch
C:\WINDOWS\system32\msiexec.exe /P "\\INSERT_YOUR_SERVER_ADDRESS_HERE\ArcGIS_Desktop_10.2.2\Patches\ArcGIS-1022-BGDT-GDT-Patch.msp" /norestart /passive /qb

echo Installing ArcGIS 'Oracle Critical Patch Update - October 2014' Connection Issue Patch...
rem Install ArcGIS 'Oracle Critical Patch Update - October 2014' Connection Issue Patch
C:\WINDOWS\system32\msiexec.exe /P "\\INSERT_YOUR_SERVER_ADDRESS_HERE\ArcGIS_Desktop_10.2.2\Patches\ArcGIS-1022-BGDT-OCPU-Patch.msp" /norestart /passive /qb


:64BITEND

Rem Install Registry Entries for enabling all extensions and setting Relative Paths as the default
REGEDIT.exe -S "\\INSERT_YOUR_SERVER_ADDRESS_HERE\ArcGIS_Desktop_10.2.2\ArcGIS_10.2.2_RegistryEntries.reg" /norestart

echo Installing ArcGIS 10.2 Tutorial Materials that go with the tutorials in the Help System...
rem Install ArcGIS 10.2 Tutorial Materials
xcopy "\\INSERT_YOUR_SERVER_ADDRESS_HERE\ArcGIS_Desktop_10.2.2\ArcTutor" "C:\ArcTutor" /s /e /i

echo Installing the Esri Data & Maps Dataset... this is about 8GB of data, so it might take a while...
rem Copy ESRI Data & Maps to the C: Drive of the target machine
xcopy "\\INSERT_YOUR_SERVER_ADDRESS_HERE\ArcGIS_Desktop_10.2.2\DATAMAPS102" "C:\DATAMAPS102" /s /e /i 