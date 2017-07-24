# The Rough Guide to Using Stace Maples’ ArcGIS Silent Installation Batch Files
____  
 
**I suggest that you consult with your IT Staff to properly protect your University Licensing and Software resources from outside access, test extensively before distributing these files with your own network information and remember that you, of course, use these files at your own risk.**  
____
  
I found myself spending entirely too much time “circulating” installation disks and troubleshooting installation problems (like forgetting to install the extensions, etc…) when I first got here, so I created a set of standard installation batch files for the process.  

The batch files use parameters provided in the MS Installer for directing network installations and point to an IP restricted shared drive that has the ArcGIS Desktop Installation Media unzipped on it.  Here are the advantages of using this type of installation procedure:

1. Users simply double-click the batch file for the configuration they need, then go away for an hour or so while ArcGIS installs.  
2. When new Service Packs are released, all I have to do is drop them into the Service_Packs folder on the shared drive and add a line to the batch files and they are automatically deployed with all subsequent installations. 
3. You are able to include a registry file in the installation to write default values like "Make relative paths the default for all new Map Documents" and enabling all extension licenses by default.
3. We are able to IP restrict access to the folders where the installations are kept, so that only Stanford Fac/Staff/Students with valid SUNETID/Password can use them.  
4. I can also email the batch files to people and they work just fine (as long as the URIs I use in them are fully qualified).  Obviously, if users are off site, they must VPN into the University network, but once in, they work as expected.
5. Because we use the same installation batch files for individuals, labs, clusters and faculty/staff workstations, any user can sit down at any machine on campus and be assured that the configuration is the same as the one they are used to.

## How to deploy Esri installation media for use with batch files.
You are going to need a little bit of infrastructure. At a minimum, you will need:

* An IP restricted ArcGIS License Manager for licensing concurrent use versions of ArcGIS for Desktop. If you are managing an Esri EDU Site License, you probably have one. If you don't, you should.
* A folder on a Windows Server, preferably one that is IP restricted, or uses your enterprise authentication to allow authorized users to access it.

You'll also need the Esri Installation Media, which you can download from your [my.esri.com](my.esri.com) account.

 1. Obtain the ArcGIS Desktop Installation media for the version you want to deploy.
 2. Unzip the installers to your shared folder.
     * You can see from the batch file code, below, that I use a foldering system to manage and maintain several versions of the installers through time. I find that many users need to maintain or accasionally install older versions in order to run plugins or models that were created for earlier verions of ArcGIS Desktop. I have my [_base server address_] and I then keep a foldering system, like so:```\\[base server address]\Esri\ArcGIS_Desktop_[version_number]\```
     * I use [7-ZIP](http://www.7-zip.org/) to extract the Esri *.exe files directly to the folders I want to run them from. I find that if I create the foldering structure described above, then right-click and drag the installers (for ArcGIS Desktop, as well as the extensions I want to deploy), I can select **Extract Here** from the context menu I get from 7-ZIP and everything gets placed into appropriate subfolders, like so:

     * Note that I use the **xcopy** command in the batch files to move the ArcTutor datasets to the destination machine. I've had some trouble getting the ArcTutor installers to execute properly. However, since the installer just creates a folder and places the data into it, you can just run it once, copy the data to your shared folder and deploy using the **xcopy** command in the script. For the record, you can also use this method to copy the Esri Data & Maps Datasets to target machine, though I put both of these copy functions into separate batch files from the ArcGIS Dekstop installers so users can opt out of the hour or so it takes to copy all of that data, if they want to.
 3. Once you have placed the installation media on your shared drive, you are ready to customize the batchfiles I've created

### The Batch File Code
Below I'm going to go through the code for the batch file. The code below might not represent the most recent versions of the batch files, but my most recent versions should be available in the corresponding folders, above. 

```bat 
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
```