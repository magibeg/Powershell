#This program will display various pieces of system information

"###########################################################"
"##########   Computer System Summary Report    ############"
"###########################################################"
"###########################################################"
""
"##### Operating System Summary #####"
$OSInfo = get-wmiobject -class win32_operatingsystem
""
"OS Name: " + $OSInfo.Caption
"OS Version: " + $OSInfo.Version
""
"###########################################################"
""
"##### System Summary #####"
""
$SysInfo = get-wmiobject -class win32_computersystem
"System Name: " + $SysInfo.Name
"System Vendor: " + $SysInfo.Manufacturer
"System Model: " + $SysInfo.Model
""
"###########################################################"
""
"##### Bios Summary #####"
""
$BiosInfo = get-wmiobject -class win32_bios
"Bios Vendor: " + $BiosInfo.Manufacturer
"Bios Description: " + $BiosInfo.Description
"Bios Version: " + $BiosInfo.Version
""
"###########################################################"
""
"##### CPU Summary #####"
""
$HardwareInfo = get-wmiobject -class win32_processor
"CPU Description: " + $HardwareInfo.Name
"CPU Max Speed(GHz): " + $HardwareInfo.MaxClockSpeed
"CPU Core Count: " + $HardwareInfo.NumberOfCores
"CPU Thread Count: " + $HardwareInfo.ThreadCount
""
"###########################################################"
""
"##### Memory Summary #####"
""
$MemInfo = get-wmiobject -class win32_physicalmemory |
ForEach-Object {
    new-object -TypeName psobject -Property @{
        Manufacturer = $_.manufacturer;
        Size = [math]::Round($_.capacity/1MB,2);
        Bank = $_.banklabel;
        Slot = $_.DeviceLocator;
    };
}
$MemInfo
""
"###########################################################"
""
"##### Disk Summary #####"
get-wmiobject -class win32_diskdrive |
ForEach-Object {
    new-object -TypeName psobject -Property @{
        Manufacturer = $_.Description
        Model = $_.Model
        Size = [math]::Round($_.Size/1GB,2);
    }
} | Format-Table -AutoSize Manufacturer, Model, Size


get-wmiobject -class win32_logicaldisk |
ForEach-Object {
    new-object -TypeName psobject -Property @{
        Drive = $_.Caption
        "File System Type" = $_.FileSystem
        "Size (GB)" = [math]::Round($_.Size/1GB,2);
        "Free Space (GB)" = [math]::Round($_.FreeSpace/1GB,2);
    }
} | Format-Table -AutoSize Drive, "File System Type", "Size (GB)", "Free Space (GB)"

"###########################################################"
""
"##### Video Card Summary #####"
""
$VideoInfo = get-wmiobject -class win32_videocontroller
"Vendor Name: " + $VideoInfo.AdapterCompatibility
"GPU Description: " + $VideoInfo.Caption
"Display Mode: " + $VideoInfo.VideoModeDescription
""
"###########################################################"
"######################  END   #############################"
"###########################################################"
""