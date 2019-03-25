# Lab 3 COMP2101 Powershell - systemid
#

$hostname = hostname
$ipinfo = Get-NetIPAddress -AddressFamily IPV4| select ipaddress, @{n="hostname";e={try {[System.Net.Dns]::GetHostEntry($_.ipaddress).hostname} catch {}}}
$ipinfo2 = Get-NetIPAddress -AddressFamily IPV4| where-object ipaddress -ne 127.0.0.1
$extipaddress = (curl icanhazip.com).content
$extname = try {[System.Net.Dns]::GetHostEntry($extipaddress).hostname} catch {}
$realHostName = nslookup $extipaddress | select-string name
"
Hostname:          $hostname
$ipinfo
$ipinfo2
External IP:       $extipaddress
External Hostname: $extname
$realHostname
"
