#This is the permission tester program by Ian Dublack
#Student Number: 100036585
#April 8th, 2019

#Use CmdletBdinding to take advantage of -verbose and/or -debug when executing the script
[CmdletBinding()]

#param is used to gather parameters from the user at the start of the script. Path is a mandatory variable while ComputerName isn't.
param (
    [Parameter(Mandatory=$true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage="The Path is Required")][String]$Path, 
    [Parameter(Mandatory=$false, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)][String]$ComputerName=$(Read-Host "What is the computer name")
)

#Checks to see if the file exists or not and tell the user that information if they are running the script in verbose mode
$Exists = Test-path -Path $Path
If ($Exists -eq $True) {
    Write-Verbose "The file exists!"
}
Else {
    Write-Verbose "The file does not exist."
}

#Gives the user the value of $Path and $ComputerName if they are in debug mode
write-debug "The value of Path is $Path"
write-debug "The value of ComputerName is $ComputerName"

#Asks the user if they want to check if the file is readable or writable
$AskUser = read-host -prompt "To check if the file can be read type 'read', to check if the file can be written to type 'write'"

#If the user specified that they want to check if the file is readable
if ($AskUser -eq "read"){
    #This line grabs the acl (access control list) from $Path, but the value we need to find is under .Access and .filesystemrights
    #Probably a better way to do this but i just checked to see if it matched read
    if ((get-acl $Path).Access.filesystemrights -match "read"){
        write-host "You have read access"
    }
    else{
        write-host "You don't have read access"
    }

}

#If the user specified that they want to check if the file can be written to
if ($AskUser -eq "write"){
    #write doesn't exist as a permission in windows, instead it's modify
    if ((get-acl $Path).Access.filesystemrights -match "modify"){
        write-host "You have write access"
    }
    else{
        write-host "You don't have write access"
    }
}