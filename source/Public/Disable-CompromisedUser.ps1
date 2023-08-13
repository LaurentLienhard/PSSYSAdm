function Disable-CompromisedUser
{
<#
    .SYNOPSIS
    Disable compromised user

    .DESCRIPTION
    In case of compromission from some users, you can rapidly disable this users.
    You can pass to parameter :
        - a nominative list of user
        - a file with a nominative list of users (one user by line)
        - an OU to disable all users
    Check example for more details (get-help Disable-CompromisedUser -Examples)
    A log file is create in your temp directory ($env:temp)

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
        $paramSetPSFLoggingProvider = @{
            Name         = 'logfile'
            InstanceName = 'Disable-CompromisedUser'
            FilePath = "$($env:temp)\Disable-CompromisedUser-%Date% %hour%%minute%.csv"
            Enabled      = $true
            Wait         = $true
        }
        Set-PSFLoggingProvider @paramSetPSFLoggingProvider

        Write-PSFMessage -Message "Retrieve AD User Account" -Level Verbose -Target MAIN
        $Users = @()

        switch ($PSCmdlet.ParameterSetName)
        {
            ByUser
            {
                Write-PSFMessage -Message "Retrieve AD User Account by user list"  -Level Verbose -Target BYUSER
                foreach ($User in $Identity)
                {
                    try
                    {
                        $Users += Get-ADUser -Identity $User -Properties SamAccountName,DisplayName,Enabled -ErrorAction Continue | Select-Object SamAccountName,DisplayName,Enabled
                        Write-PSFMessage -Message "User $($User) found"  -Level Verbose -Target BYUSER
                    }
                    catch [Microsoft.ActiveDirectory.Management.ADIdentityNotFoundException]
                    {
                        Write-PSFMessage -Message "User $($User) not found"  -Level Verbose -Target BYUSER
                    }
                }
            }
            ByFileName
            {
                Write-PSFMessage -Message "Retrieve AD User Account by filename"  -Level Verbose -Target BYFILENAME
                foreach ($User in (Get-Content -Path $FileName))
                {
                    try
                    {
                        $Users += Get-ADUser -Identity $User -Properties SamAccountName,DisplayName,Enabled -ErrorAction Continue | Select-Object SamAccountName,DisplayName,Enabled
                        Write-PSFMessage -Message "User $($User) found"  -Level Verbose -Target BYFILENAME
                    }
                    catch [Microsoft.ActiveDirectory.Management.ADIdentityNotFoundException]
                    {
                        Write-PSFMessage -Message "User $($User) not found"  -Level Verbose -Target BYFILENAME
                    }
                }
            }
            ByOu
            {
                Write-PSFMessage -Message "Retrieve AD User Account by OU list"  -Level Verbose -Target BYOU
                foreach ($Organ in $OU)
                {
                    Write-PSFMessage -Message "Retrieve all users from OU $($Organ)"  -Level Verbose -Target BYOU
                    $Users += Get-ADUser -Filter * -SearchBase $Organ -Properties SamAccountName,DisplayName,Enabled | Select-Object SamAccountName,DisplayName,Enabled

                }
            }
        }
        Write-PSFMessage -Message "$($Users.Count) AD user account found"  -Level Verbose -Target MAIN
    }

    process
    {

        foreach ($user in $Users)
        {
            if ($Check)
            {
                Write-PSFMessage -Message "Check state for user $( $User.SamAccountName)"  -Level Verbose -Target MAIN
                if ($user.Enabled -eq "True")
                {
                    Write-PSFMessage -Message "user $($User.SamAccountName) is enabled"  -Level Verbose -Target MAIN
                } else
                {
                    Write-PSFMessage -Message "user $($User.SamAccountName) is disabled"  -Level Verbose -Target MAIN
                }
            } else
            {

                Disable-ADAccount -Identity $user.SamAccountName -WhatIf -Confirm:$false
                Write-PSFMessage -Message "Disabling $($User.SamAccountName) AD account"  -Level Verbose -Target MAIN
            }
        }
    }

    end
    {
        Wait-PSFMessage
    }
}
