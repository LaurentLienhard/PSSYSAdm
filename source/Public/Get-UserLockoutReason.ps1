function Get-UserLockoutReason
{
<#
    .SYNOPSIS
    Search user lockout reason

    .DESCRIPTION
    You can search the reason of locked user on a specific computer
    To find the source you can use : Find-UserLockoutsInformation -Identity User1 -DC MyDC1 -Credential (Get-Credential MyAdminAccount)

    .PARAMETER Computer
    User lockout source computer

    .PARAMETER Identity
    Name of the user for whom we are looking for the source of the lock

    .PARAMETER Credential
    Administrator credential to connect to the computer

    .EXAMPLE
    Get-UserLockoutReason -Computer ComputerSource -Identity User1 -Credential (Get-Credential MyAdminAccount)

    .NOTES
    General notes
#>
    [CmdletBinding(
        DefaultParameterSetName = 'All'
    )]
    param (
        [System.String]$Computer,
        [Parameter(
            ValueFromPipeline = $true,
            ParameterSetName = 'ByUser'
        )]
        [System.String]$Identity,
        # Specifies the user account credentials to use when performing this task.
        [Parameter()]
        [ValidateNotNull()]
        [System.Management.Automation.PSCredential]
        [System.Management.Automation.Credential()]
        $Credential = [System.Management.Automation.PSCredential]::Empty
    )

    begin
    {
        $LogonInfo = Import-PSFPowerShellDataFile -Path $PSScriptRoot/PSSYSAdm.psd1
        Write-Verbose ('[{0:O}] Searching EventID : 4625 on Computer : {1}   ' -f (get-date), $Computer)

        $WinEventArguments = @{
            ComputerName    = $Computer
            FilterHashtable = @{LogName = 'Security'; Id = 4625 }
        }

        if ($PSBoundParameters.ContainsKey('Credential'))
        {
            $WinEventArguments['Credential'] = $Credential
        }

        $lockoutEvents = $null
        Write-Verbose ('[{0:O}] Test if computer : {1} is alive ' -f (get-date), $Computer)
        if (Test-Connection -ComputerName $Computer -Quiet -Count 2)
        {
            try
            {
                $lockoutEvents = Get-WinEvent @WinEventArguments -ErrorAction Stop
            }
            catch
            {
                if ($_.Exception.Message -match "No events were found that match the specified selection criteria")
                {
                    Write-Verbose ('[{0:O}] No logs found' -f (get-date))
                }
                if ($Error[-1].Exception.Message -like "*elevated user rights*")
                {
                    throw ('[{0:O}] You need an admin account. Please provide with the -Credential parameter' -f (get-date))
                }
            }
        }
        else
        {
            throw ('[{0:O}] computer {1} is not alive' -f (get-date), $Computer)
        }

        if ($lockoutEvents)
        {
            Write-Verbose ('[{0:O}] {1} event found' -f (get-date), $lockoutEvents.Count)
        }
        else
        {
            throw ('[{0:O}] No event found' -f (get-date))
        }
    }

    process
    {

        $ResultEvents = @()
        switch ($PSCmdlet.ParameterSetName)
        {
            All
            {
                Write-Verbose ('[{0:O}] Searching information for all user(s) ' -f (get-date))
                Foreach ($Event in $lockoutEvents)
                {
                    $eventXML = [xml]$event.ToXml()
                    # Building output based on advanced properties
                    $ResultEvents += @{
                        LockedUserName   = $eventXML.Event.EventData.Data[5].'#text'
                        LogonType        = $LogonInfo.PrivateData.LogonType."$($eventXML.Event.EventData.Data[10].'#text')"
                        LogonProcessName = $eventXML.Event.EventData.Data[11].'#text'
                        ProcessName      = $eventXML.Event.EventData.Data[18].'#text'
                        FailureReason    = $LogonInfo.PrivateData.FailureReason."$($eventXML.Event.EventData.Data[8].'#text')"
                        FailureStatus    = $LogonInfo.PrivateData.FailureType."$($eventXML.Event.EventData.Data[7].'#text')"
                        FailureSubStatus = $LogonInfo.PrivateData.FailureType."$($eventXML.Event.EventData.Data[9].'#text')"
                    }
                }
            }
            ByUser
            {
                Write-Verbose ('[{0:O}] Searching information for user : {1}' -f (get-date), $Identity)
                Foreach ($Event in $lockoutEvents)
                {
                    $eventXML = [xml]$event.ToXml()
                    If ($Event | Where-Object { $eventXML.Event.EventData.Data[5].'#text' -match $Identity })
                    {

                        # Building output based on advanced properties
                        $ResultEvents += @{
                            LockedUserName   = $eventXML.Event.EventData.Data[5].'#text'
                            LogonType        = $LogonInfo.PrivateData.LogonType.($eventXML.Event.EventData.Data[10].'#text')
                            LogonProcessName = $eventXML.Event.EventData.Data[11].'#text'
                            ProcessName      = $eventXML.Event.EventData.Data[18].'#text'
                            FailureReason    = $LogonInfo.PrivateData.FailureReason."$($eventXML.Event.EventData.Data[8].'#text')"
                            FailureStatus    = $LogonInfo.PrivateData.FailureType."$($eventXML.Event.EventData.Data[7].'#text')"
                            FailureSubStatus = $LogonInfo.PrivateData.FailureType."$($eventXML.Event.EventData.Data[9].'#text')"
                        }
                    }

                }

            }
        }


    }

    end
    {
        return $ResultEvents
    }
}
