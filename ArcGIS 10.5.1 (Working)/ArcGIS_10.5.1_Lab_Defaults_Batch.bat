@echo off
 
REM Set up ArcMap and ArcCatalog GDB and home folder settings
reg add "HKEY_CURRENT_USER\Software\ESRI\Desktop10.5/\ArcMap\Recent Geodatabase List" /f /v "Geodatabase1" /d "E:\users\%USERNAME%\ArcGIS\Default.gdb"
 
reg add "HKEY_CURRENT_USER\Software\ESRI\ArcGIS File Handler\Settings" /v "PackageLocation" /f /d "E:\users\%USERNAME%\ArcGIS\\"
reg add "HKEY_CURRENT_USER\Software\ESRI\ArcGIS File Handler\Settings" /t REG_DWORD /v "PackageLocationOption" /f /d "1"
 
reg add "HKEY_CURRENT_USER\Software\ESRI\Desktop10.5\ArcCatalog\DefaultHomeFolder" /f /v "Location" /d "E:\users\%USERNAME%\ArcGIS"
 
 