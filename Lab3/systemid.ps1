# Lab 3 COMP2101 Powershell - systemid
#

$hostname = hostname
$ipinfo = Get-NetIPAddress -AddressFamily IPV4|
                      select ipaddress, @{n="hostname";e={try {[System.Net.Dns]::GetHostEntry($_.ipaddress).hostname} catch {}}}
$extipaddress = (curl icanhazip.com).content
$extname = try {[System.Net.Dns]::GetHostEntry($extipaddress).hostname} catch {}
$realHostName = nslookup $ipinfo
"
Hostname:          $hostname
$ipinfo
External IP:       $extipaddress
External Hostname: $extname
$realHostname
"
