function Remove-CompromisedUser
{
    [CmdletBinding(DefaultParameterSetName="ByUser")]
    param (
        [Parameter(ParameterSetName="ByUser")]
        [System.String[]]$Identity,
        [Parameter(ParameterSetName="ByFileName")]
        [System.IO.Directory]$FileName,
        [Parameter()]
        [Switch]$Check
    )

    begin {

    }

    process {

    }

    end {

    }
}
