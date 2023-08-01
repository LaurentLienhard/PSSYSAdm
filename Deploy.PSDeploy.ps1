Deploy PowerShell {
    By FileSystem Scripts {
        FromSource "C:\01-DEV\PSSYSAdm\output\module\PSSYSAdm"
        To "C:\Users\llienhard\Documents\PowerShell\Modules\PSSYSAdm",
            "C:\Users\llienhard\Documents\WindowsPowerShell\Modules\PSSYSAdm"
        WithOptions @{
            Mirror = $true
        }
    }
}
