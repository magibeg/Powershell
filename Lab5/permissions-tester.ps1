
[CmdletBinding()]
param (
    [Parameter(Mandatory=$true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage="The Path is Required")][String]$Path, 
    [Parameter(Mandatory=$false, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)][String]$ComputerName=$(Read-Host "What is the computer name")
)

#Get-Acl -Path $path | Format-Table @{n="Access"; e={$_.isreadonly}}
$readable = (Get-ChildItem -Path $Path).IsReadOnly
$writeable = (Get-ChildItem -Path $Path).Access

$Exists = Test-path -Path $Path

If ($Exists -eq $True) {
    Write-Verbose "The file exists!"
}
Else {Write-Verbose "The file does not exist."}

    #Where-Object { $_.length -ge $minimumsize } |
    #Select-Object FullName, LastAccessTime, Length |
    #Sort-Object -Descending Length |
    #Out-GridView