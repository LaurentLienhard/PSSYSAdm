<#
.SYNOPSIS
Disable compromised user

.DESCRIPTION
Disable compromised users

.PARAMETER Identity
One or more user(s) to disable

.PARAMETER FileName
File with a list of users to disable. txt with one name by line

.PARAMETER OU
One or more OU(s) in which we want to disable all users

.PARAMETER Check
Only check if the users passed in parameter, whatever the way (Identity, Filename or OU), are disable

.EXAMPLE
Disable-CompromisedUser -Identity "User1"

Disable the user account : User1

.EXAMPLE
Disable-CompromisedUser -Identity "User1" -Check

Check if user account User1 is disable

.EXAMPLE
Disable-CompromisedUser -Identity "User1","User2","User3"

Disable users account : User1, User2 and User3

.EXAMPLE
Disable-CompromisedUser -Identity "User1","User2","User3" -Check

Check if users account User1, User2 and User3 are disable

.EXAMPLE
Disable-CompromisedUser -FileName "c:\temp\CompromisedUser.txt"

File template CompromisedUser.txt :
User1
User2
User3

Disable users account : User1, User2 and User3

.EXAMPLE
Disable-CompromisedUser -FileName "c:\temp\CompromisedUser.txt" -Check

File template CompromisedUser.txt :
User1
User2
User3

Check if users account User1, User2 and User3 are disable

.EXAMPLE
Disable-CompromisedUser -OU "OU=OU1,DC=contoso,DC=com"

Disable all users present in OU1

.EXAMPLE
Disable-CompromisedUser -OU "OU=OU1,DC=contoso,DC=com" -Check

Check if all users present in OU1 are disable

.EXAMPLE
Disable-CompromisedUser -OU "OU=OU1,DC=contoso,DC=com","OU=OU2,DC=contoso,DC=com"

Disable all users present in OU1 and OU2

.EXAMPLE
Disable-CompromisedUser -OU "OU=OU1,DC=contoso,DC=com","OU=OU2,DC=contoso,DC=com" -check

Check if all users present in OU1 and OU2 are disable

.NOTES
General notes
#>
function Disable-CompromisedUser
{
    [CmdletBinding(DefaultParameterSetName = "ByUser")]
    param (
        [Parameter(
            ParameterSetName = "ByUser",
            HelpMessage = 'One or more user(s) to disable'
        )]
        [System.String[]]$Identity,
        [Parameter(
            ParameterSetName = "ByFileName",
            HelpMessage = 'File with a list of users to disable. txt with one name by line'
        )]
        [System.String]$FileName,
        [Parameter(
            ParameterSetName = "ByOu",
            HelpMessage = 'One or more OU(s) in which we want to disable all users'
        )]
        [System.String[]]$OU,
        [Parameter(
            HelpMessage = 'Only check if the users passed in parameter, whatever the way (Identity, Filename or OU), are disable'
        )]
        [Switch]$Check
    )

    begin
    {

        $LogFile = "$env:temp\DisableCompromisedUser-$((get-date).ToString("yyyyMMddTHHmmss")).log"
        if (Test-Path -Path $LogFile)
        {
            Remove-Item -Path $LogFile -Force
        }
        Write-Verbose ('[{0:O}] Log File {1}' -f (get-date),$LogFile)
        Write-Verbose ('[{0:O}] Retrieve AD User Account ' -f (get-date))
        $Users = @()

        switch ($PSCmdlet.ParameterSetName)
        {
            ByUser
            {
                Add-content $Logfile -value ('[{0:O}] Retrieve AD User Account by user list ' -f (get-date))
                foreach ($User in $Identity)
                {
                    try
                    {
                        $Users += Get-ADUser -Identity $User -Properties SamAccountName,DisplayName,Enabled -ErrorAction Continue | Select-Object SamAccountName,DisplayName,Enabled
                        Write-Verbose ('[{0:O}] User {1} found ' -f (get-date),$User)
                        Add-content $Logfile -value ('[{0:O}] User {1} found ' -f (get-date),$User)
                    }
                    catch [Microsoft.ActiveDirectory.Management.ADIdentityNotFoundException]
                    {
                        Write-Verbose ('[{0:O}] user {1} not found' -f (get-date), $User)
                        Add-content $Logfile -value (('[{0:O}] user {1} not found' -f (get-date), $User))
                    }
                }
            }
            ByFileName
            {
                Add-content $Logfile -value ('[{0:O}] [INFO] Retrieve AD User Account by filename ' -f (get-date))
                foreach ($User in (Get-Content -Path $FileName))
                {
                    try
                    {
                        $Users += Get-ADUser -Identity $User -Properties SamAccountName,DisplayName,Enabled -ErrorAction Continue | Select-Object SamAccountName,DisplayName,Enabled
                        Write-Verbose ('[{0:O}] [INFO] [FOUND] user {1} ' -f (get-date),$User)
                        Add-content $Logfile -value ('[{0:O}] [INFO] [FOUND] user {1} ' -f (get-date),$User)
                    }
                    catch [Microsoft.ActiveDirectory.Management.ADIdentityNotFoundException]
                    {
                        Write-Verbose ('[{0:O}] [ERROR] [NOTFOUND] user {1} ' -f (get-date), $User)
                        Add-content $Logfile -value (('[{0:O}] [ERROR] [NOTFOUND] user {1}' -f (get-date), $User))
                    }
                }
            }
            ByOu
            {
                Add-content $Logfile -value ('[{0:O}] [INFO] Retrieve AD User Account by OU list ' -f (get-date))
                foreach ($Organ in $OU)
                {
                    Write-Verbose ('[{0:O}] [INFO] Retrieve all users from OU {1}' -f (get-date), $Organ)
                    Add-content $Logfile -value (('[{0:O}] [INFO] Retrieve all users from OU {1}' -f (get-date), $Organ))
                    $Users += Get-ADUser -Filter * -SearchBase $Organ -Properties SamAccountName,DisplayName,Enabled | Select-Object SamAccountName,DisplayName,Enabled
                }
            }
        }

        Write-Verbose ('[{0:O}] [INFO] {1} AD user account found ' -f (get-date), $Users.Count)
        Add-content $Logfile -value (('[{0:O}] [INFO] {1} AD user account found ' -f (get-date), $Users.Count))
    }

    process
    {

        foreach ($user in $Users)
        {
            if ($Check)
            {
                Write-Verbose (('[{0:O}] [INFO] Check state for user {1} ' -f (get-date), $User.SamAccountName))
                Add-content $Logfile -value (('[{0:O}] [INFO] Check state for user {1} [{2}]' -f (get-date), $User.SamAccountName,$user.DisplayName))
                if ($user.Enabled -eq "True")
                {
                    Write-Verbose (('[{0:O}] [INFO] [ENABLE] user {1}  ' -f (get-date), $User.SamAccountName))
                    Add-content $Logfile -value (('[{0:O}] [ENABLE] user {1} [{2}] ' -f (get-date), $User.SamAccountName,$user.DisplayName))
                } else
                {
                    Write-Verbose (('[{0:O}] [INFO] [DISABLE] user {1}' -f (get-date), $User.SamAccountName))
                    Add-content $Logfile -value (('[{0:O}] [DISABLE] user {1} [{2}] ' -f (get-date), $User.SamAccountName,$User.DisplayName))
                }
            } else
            {
                Write-Verbose ('[{0:O}] [INFO] Disable AD Account {1} ' -f (get-date), $User.SamAccountName)
                Disable-ADAccount -Identity $user.SamAccountName -WhatIf -Confirm:$false
                Add-content $Logfile -value (('[{0:O}] [INFO] {1} [{2}] AD account disabled ' -f (get-date), $User.SamAccountName,$User.DisplayName))
            }
        }
    }

    end
    {

    }
}
