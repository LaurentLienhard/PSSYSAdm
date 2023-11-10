function Update-LastPasswordDate {
    [CmdletBinding()]
    param (
        [Parameter(ValueFromPipelineByPropertyName = $true, ValueFromPipeline = $true)]
        [System.String[]]$Identity,
        # Specifies the user account credentials to use when performing this task.
        [Parameter()]
        [ValidateNotNull()]
        [System.Management.Automation.PSCredential]
        [System.Management.Automation.Credential()]
        $Credential = [System.Management.Automation.PSCredential]::Empty,
        [Parameter()]
        [Switch]$Log
    )

    begin {
        if ($log) {
            $paramSetPSFLoggingProvider = @{
                Name         = 'logfile'
                InstanceName = 'Update-LastPasswordDate'
                FilePath = "$($env:temp)\Update-LastPasswordDate-%Date% %hour%-%minute%.csv"
                Enabled      = $true
                Wait         = $true
            }
            Set-PSFLoggingProvider @paramSetPSFLoggingProvider
        }

        $Properties = "PwdLastSet","PasswordLastSet","SamAccountName"
        $Parameter =  @{}
        if ($PSBoundParameters.ContainsKey('Credential'))
        {
            $Parameter['Credential'] = $Credential
        }

    }

    process {
        foreach ($User in $Identity) {
            $Parameter['Identity'] = $User
            $InfoUser = Get-ADUser @Parameter -Properties $Properties
            if ($log) {Write-PSFMessage -Message "UserName $($InfoUser.SamAccountName) " -Level Verbose -Target MAIN}
            if ($log) {Write-PSFMessage -Message "Last password change date $($InfoUser.PasswordLastSet) " -Level Verbose -Target MAIN}
            $InfoUser.PwdLastSet = 0
            Set-ADUser -Instance $InfoUser

            $InfoUser.PwdLastSet = -1
            Set-ADUser -Instance $InfoUser
            $InfoUser = Get-ADUser @Parameter -Properties $Properties
            if ($log) {Write-PSFMessage -Message " New last password change date  $($InfoUser.PasswordLastSet) " -Level Verbose -Target MAIN}
        }
    }

    end {
        Wait-PSFMessage
    }
}
