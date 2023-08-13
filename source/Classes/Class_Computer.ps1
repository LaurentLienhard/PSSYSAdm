class COMPUTER

{
    computer ()
    {
    }

    static [Boolean] TestIfComputerExist([System.String]$ComputerName)
    {
        try
        {
            Get-ADComputer -Identity $ComputerName -ErrorAction Stop -Verbose:$false
            return $true
        }
        catch
        {
            return $false
        }
    }

    static [Boolean] TestIfComputerIsAlive ([System.String]$ComputerName)
    {
        if (Test-Connection -BufferSize 32 -Count 1 -ComputerName $ComputerName -Quiet)
        {
            return $true
        }
        else
        {
            return $false
        }
    }
}
