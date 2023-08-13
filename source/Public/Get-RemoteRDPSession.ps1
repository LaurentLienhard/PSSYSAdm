function Get-RemoteRDPSession
{
    <#
    .SYNOPSIS
    Retrieve RDP session

    .DESCRIPTION
    This function retrive all rdp session on a remote computer.
    Result il like :
    UserName    : UserName
    SessionName : SessionName
    ID          : SessionID
    State       : SessionState
    IdleTime    : SessionIdleTime
    LogonTime   : SessionLogonType

    .PARAMETER ComputerName
    The remote computer on which you want RDP sessions

    .PARAMETER Credential
    An account with the necessary privileges to connect to the remote computer

    .EXAMPLE
    Get-RemoteRDPSessions -ComputerName Server1 -Credential MyAdmAccount

    .NOTES
    General notes
#>
    param (
        [Parameter(ValueFromPipeline = $true)]
        [string]$ComputerName,
        # Specifies the user account credentials to use when performing this task.
        [Parameter()]
        [ValidateNotNull()]
        [System.Management.Automation.PSCredential]
        [System.Management.Automation.Credential()]
        $Credential = [System.Management.Automation.PSCredential]::Empty
    )

    begin
    {

    }

    process
    {
        if ([COMPUTER]::TestIfComputerExist($ComputerName) -and [COMPUTER]::TestIfComputerIsAlive($ComputerName))
        {
            $QueryArguments = @{
                ComputerName = $ComputerName
            }

            if ($PSBoundParameters.ContainsKey('Credential'))
            {
                $QueryArguments['Credential'] = $Credential
            }

            $query = Invoke-Command @QueryArguments -ScriptBlock { quser }
            if ($query -match 'No User exists for ')
            {
                Write-Output "No active RDP sessions found on $ComputerName."
                return
            }

            $sessions = $query | Select-Object -Skip 1 | ForEach-Object {
                $parts = $_.Trim() -split '\s+'
                [PSCustomObject]@{
                    ComputerName = $ComputerName
                    UserName     = $parts[0]
                    SessionName  = $parts[1]
                    ID           = $parts[2]
                    State        = $parts[3]
                    IdleTime     = if ($parts.Count -ge 6)
                    {
                        $parts[5]
                    }
                    else
                    {
                        'N/A'
                    }
                    LogonTime    = if ($parts.Count -ge 5)
                    {
                        "$($parts[4]) $([DateTime]::Now.ToShortDateString())"
                    }
                    else
                    {
                        'N/A'
                    }
                }
            }
        } else
        {
            Write-Error ('[{0:O}] Computer {1} not found or not alive ' -f (get-date), $ComputerName)
        }
    }

    end
    {
        return $sessions
    }
}
