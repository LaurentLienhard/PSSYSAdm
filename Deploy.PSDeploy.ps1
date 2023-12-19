$ps7 = [environment]::getfolderpath("mydocuments") + "\PowerShell\Modules\PSSYSAdm"
$ps5 = [environment]::getfolderpath("mydocuments") + "\WindowsPowerShell\Modules\PSSYSAdm"

Deploy PowerShell {
    By FileSystem Scripts {
        FromSource "C:\01-DEV\PSSYSAdm\output\module\PSSYSAdm"
        To $ps7 , $ps5
        WithOptions @{
            Mirror = $true
        }
    }
}
