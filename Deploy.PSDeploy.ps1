$ps7 = [environment]::getfolderpath("mydocuments") + "\PowerShell\Modules\PSSYSAdm"
$ps5 = [environment]::getfolderpath("mydocuments") + "\WindowsPowerShell\Modules\PSSYSAdm"
#$dsdpwinadm = "\\dsdpwinadm\c$\Users\admllien\Documents\WindowsPowerShell\Modules\PSSYSAdm"
#$Credential = Get-Secret FMAdminAccount

Deploy PowerShell {
    By FileSystem Scripts {
        FromSource "C:\01-DEV\PSSYSAdm\output\module\PSSYSAdm"
        To $ps7 , $ps5
        WithOptions @{
            Mirror = $true
        }
    }
<#     By Remote Scripts {
        FromSource "C:\01-DEV\PSSYSAdm\output\module\PSSYSAdm"
        To $dsdpwinadm
        WithOptions @{
            Mirror = $true
            Credential = $Credential
        }
    } #>
}
