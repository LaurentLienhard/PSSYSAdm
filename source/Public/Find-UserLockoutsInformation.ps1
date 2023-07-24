Function Find-UserLockoutsInformation
{
    [CmdletBinding(
        DefaultParameterSetName = 'All'
    )]
    param (
        [Parameter(
            ValueFromPipeline = $true,
            ParameterSetName = 'ByUser'
        )]
        [System.String]$Identity,
        [System.String]$DC = (Get-ADDomain).PDCEmulator,
        # Specifies the user account credentials to use when performing this task.
        [Parameter()]
        [ValidateNotNull()]
        [System.Management.Automation.PSCredential]
        [System.Management.Automation.Credential()]
        $Credential = [System.Management.Automation.PSCredential]::Empty
    )
    Begin
    {
        Write-Verbose ('[{0:O}] Searching EventID : 4740 on Server : {1}   ' -f (get-date), $DC)
        $WinEventArguments = @{
            ComputerName    = $DC
            FilterHashtable = @{LogName = 'Security'; Id = 4740 }
        }

        if ($PSBoundParameters.ContainsKey('Credential'))
        {
            $WinEventArguments['Credential'] = $Credential
        }
        try {
            $LockedOutEvents = Get-WinEvent @WinEventArguments -ErrorAction Stop | Sort-Object -Property TimeCreated -Descending
        }
        catch {
            if ($Error[-1].Exception.Message -like "*elevated user rights*") {
                throw ('[{0:O}] You need an admin account. Please provide with the -Credential parameter' -f (get-date))
            }
        }

        if ($LockedOutEvents) {
            Write-Verbose ('[{0:O}] {1} event found' -f (get-date), $LockedOutEvents.Count)
        } else {
            throw ('[{0:O}] No event found' -f (get-date))
        }
    }

    Process
    {
        switch ($PSCmdlet.ParameterSetName)
        {
            ByUser
            {
                Write-Verbose ('[{0:O}] Searching information for user : {1}' -f (get-date), $Identity)
                $UserInfo = Get-ADUser -Identity $Identity
                Foreach ($Event in $LockedOutEvents)
                {
                    If ($Event | Where-Object { $_.Properties[2].value -match $UserInfo.SID.Value })
                    {

                        $Event | Select-Object -Property @(
                            @{Label = 'User'; Expression = { $_.Properties[0].Value } }
                            @{Label = 'DomainController'; Expression = { $_.MachineName } }
                            @{Label = 'EventId'; Expression = { $_.Id } }
                            @{Label = 'LockoutTimeStamp'; Expression = { $_.TimeCreated } }
                            @{Label = 'Message'; Expression = { $_.Message -split "`r" | Select-Object -First 1 } }
                            @{Label = 'LockoutSource'; Expression = { $_.Properties[1].Value } }
                        )
                    }
                }
            }
            All
            {
                Write-Verbose ('[{0:O}] Searching information for all user(s) ' -f (get-date))
                Foreach ($Event in $LockedOutEvents)
                {

                    $Event | Select-Object -Property @(
                        @{Label = 'User'; Expression = { $_.Properties[0].Value } }
                        @{Label = 'DomainController'; Expression = { $_.MachineName } }
                        @{Label = 'EventId'; Expression = { $_.Id } }
                        @{Label = 'LockoutTimeStamp'; Expression = { $_.TimeCreated } }
                        @{Label = 'Message'; Expression = { $_.Message -split "`r" | Select-Object -First 1 } }
                        @{Label = 'LockoutSource'; Expression = { $_.Properties[1].Value } }
                    )
                }
            }
        }
    }
    End
    {
    }

}
