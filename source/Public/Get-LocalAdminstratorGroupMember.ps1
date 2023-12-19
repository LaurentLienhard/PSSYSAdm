function Get-LocalAdministratorGroupMember
{
    <#
.SYNOPSIS
Retrieves members of the local Administrators group on a Windows machine.

.DESCRIPTION
This function retrieves members of the local Administrators group on a Windows machine.
It allows you to specify the object class (e.g., "User" or "Group") and the domain to search.

.PARAMETER ObjectClass
Specifies the object class of members to retrieve. Valid values are "User" (default) or "Group."

.PARAMETER Domain
Specifies the domain to search for members. By default, it uses the current NetBiosname.

.EXAMPLE
Get-LocalAdministratorGroupMember
Retrieves all user members of the local Administrators group in the current domain.

.EXAMPLE
Get-LocalAdministratorGroupMember -ObjectClass "Group" -Domain "example.com"
Retrieves all group members of the local Administrators group in the "example.com" domain.

.NOTES
Author: LIENHARD Laurent
Version: 1.0
Last Updated: 09/08/2023
#>

    [CmdletBinding()]
    param (
        [Parameter()]
        [System.String]$ComputerName = $env:ComputerName,
        # Specifies the user account credentials to use when performing this task.
        [Parameter()]
        [ValidateNotNull()]
        [System.Management.Automation.PSCredential]
        [System.Management.Automation.Credential()]
        $Credential = [System.Management.Automation.PSCredential]::Empty

    )

    begin
    {
        $result = @()
        $members = $null

    }

    process
    {
        try
        {
            if ($ComputerName -eq $env:ComputerName)
            {
                # Determine the local Administrators group name based on the locale
                if (((Get-UICulture).Name -eq "fr-FR"))
                {
                    $administratorsGroupName = "Administrateurs"
                }
                else
                {
                    $administratorsGroupName = "Administrators"
                }
                $members = (net localgroup $administratorsGroupName) -replace 'The command completed successfully.|\-+' | Select-Object -Skip 4
            }
            else
            {
                $members = Invoke-Command -ScriptBlock {
                    if (((Get-UICulture).Name -eq "fr-FR"))
                    {
                        $administratorsGroupName = "Administrateurs"
                    }
                    else
                    {
                        $administratorsGroupName = "Administrators"
                    }
                    ((net localgroup $administratorsGroupName) -replace 'The command completed successfully.|\-+' | Select-Object -Skip 6) } -Authentication Kerberos -Credential $Credential -ComputerName $ComputerName
            }
        }
        catch
        {
            Write-Error -Message "An error occurred. Unable to retrieve the list of local administrators of the machine $($ComputerName)"
        }
    }

    end
    {
        $members = $members | Where-Object { $_ -ne "" }
        foreach ($Member in $members)
        {
            $MyObject = [PSCustomObject]@{
                "Computer"                              = $ComputerName
                "Members of Local Administrators Group" = $Member
            }
            $result += $MyObject
        }
        $result
    }
}


Get-LocalAdministratorGroupMember -Credential (Get-Secret FMAdminAccount)
