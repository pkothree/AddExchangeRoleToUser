###
# Danny Davis
# twitter: twitter.com/pko3
# github: github.com/pkothree
# Created: 01/27/21
# Modified: 01/27/21
# Description: add Users to a Exchange Online Role
###

Write-Host "-------------------------------------------------" -ForeGroundColor Yellow
Write-Host "Loading config settings xml..." -ForeGroundColor Yellow
# Path to config File
$configFile = "config\config.xml"

# Test if config file  does exist
if((Test-Path $configFile) -eq $false) 
{ 
   Write-host "Config XML not found" 
   #exit 
} 

# Load config file
[XML]$config = Get-Content $configFile

# Load XML values
$EXORole = $config.Config.EXORole
$delimiter = $config.Config.delimiter
$log = $config.Config.log
$csvinputfile = $config.Config.csvinput
$eMailField = $config.Config.eMailField
$givennameField = $config.Config.givenname
$surnameField = $config.Config.surname

# Connect to Exchange Online
$Credentials = Get-Credential
Connect-ExchangeOnline -Credential $Credentials

#Connect to AzureAD
Connect-AzureAD

# Create logfile
$date = Get-Date -Format FileDateTime
$logFile = $log + "roles_added_" + $date + ".txt"
Start-Transcript -Path $logFile

Read-Host "Press Enter to continue..."

# import csv
$csvimport = Import-Csv -Path $csvinputfile -Delimiter $delimiter

# csv header
Write-Host "Action;E-Mail;Nachname;Vorname"

foreach($user in $csvimport)
{
    $mail = $user.$eMailField
    $surname = $user.$surnameField
    $givenname = $user.$givennameField

    try{
        $user = Get-AzureADUser -ObjectID $mail
        Add-RoleGroupMember $EXORole -Member $mail
        Write-Host "User added;"$mail";"$surname";"$givenname
    }catch{Write-Host "User not added;"$mail";"$surname";"$givenname -ForeGroundColor Red }
}

Stop-Transcript

Disconnect-ExchangeOnline
Disconnect-AzureAD