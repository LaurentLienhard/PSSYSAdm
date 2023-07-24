#
# Module manifest for module 'PSSYSAdm'
#
# Generated by: LIENHARD Laurent
#
# Generated on: 7/16/2023
#

@{

    # Script module or binary module file associated with this manifest.
    RootModule           = 'PSSYSAdm.psm1'

    # Version number of this module.
    ModuleVersion        = '0.0.1'

    # Supported PSEditions
    # CompatiblePSEditions = @()

    # ID used to uniquely identify this module
    GUID                 = 'a026773f-db62-427e-ba8a-4a4a76901504'

    # Author of this module
    Author               = 'LIENHARD Laurent'

    # Company or vendor of this module
    CompanyName          = 'LIENHARD Laurent'

    # Copyright statement for this module
    Copyright            = '(c) 2023 LIENHARD Laurent. All rights reserved.'

    # Description of the functionality provided by this module
    Description          = 'Lot Of Stuff for admin day job'

    # Minimum version of the Windows PowerShell engine required by this module
    PowerShellVersion    = '5.0'

    # Name of the Windows PowerShell host required by this module
    # PowerShellHostName = ''

    # Minimum version of the Windows PowerShell host required by this module
    # PowerShellHostVersion = ''

    # Minimum version of Microsoft .NET Framework required by this module. This prerequisite is valid for the PowerShell Desktop edition only.
    # DotNetFrameworkVersion = ''

    # Minimum version of the common language runtime (CLR) required by this module. This prerequisite is valid for the PowerShell Desktop edition only.
    # CLRVersion = ''

    # Processor architecture (None, X86, Amd64) required by this module
    # ProcessorArchitecture = ''

    # Modules that must be imported into the global environment prior to importing this module
    RequiredModules      = @()

    # Assemblies that must be loaded prior to importing this module
    # RequiredAssemblies = @()

    # Script files (.ps1) that are run in the caller's environment prior to importing this module.
    # ScriptsToProcess = @()

    # Type files (.ps1xml) to be loaded when importing this module
    # TypesToProcess = @()

    # Format files (.ps1xml) to be loaded when importing this module
    # FormatsToProcess = @()

    # Modules to import as nested modules of the module specified in RootModule/ModuleToProcess
    # NestedModules = @()

    # Functions to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no functions to export.
    FunctionsToExport    = @()

    # Cmdlets to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no cmdlets to export.
    CmdletsToExport      = @()

    # Variables to export from this module
    VariablesToExport    = @()

    # Aliases to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no aliases to export.
    AliasesToExport      = @()

    # DSC resources to export from this module
    DscResourcesToExport = @()

    # List of all modules packaged with this module
    # ModuleList = @()

    # List of all files packaged with this module
    # FileList = @()

    # Private data to pass to the module specified in RootModule/ModuleToProcess. This may also contain a PSData hashtable with additional module metadata used by PowerShell.
    PrivateData          = @{

        PSData      = @{

            Prerelease   = ''
            # Tags applied to this module. These help with module discovery in online galleries.
            # Tags = @()

            # A URL to the license for this module.
            # LicenseUri = ''

            # A URL to the main website for this project.
            # ProjectUri = ''

            # A URL to an icon representing this module.
            # IconUri = ''

            # ReleaseNotes of this module
            ReleaseNotes = ''

        } # End of PSData hashtable

        FailureReason = @{
            '%%2305' = 'The specified user account has expired'
            '%%2309' = "The specified account's password has expired"
            '%%2310' = 'Account currently disabled'
            '%%2311' = 'Account logon time restriction violation'
            '%%2312' = 'User not allowed to logon at this computer'
            '%%2313' = 'Unknown user name or bad password'
        }
        FailureType = @{
            '0XC000005E' = 'There are currently no logon servers available to service the logon request'
            '0xC0000064' = 'User logon with misspelled or bad user account'
            '0xC000006A' = 'User logon with misspelled or bad password'
            '0XC000006D' = 'This is either due to a bad username or authentication information'
            '0XC000006E' = 'Unknown user name or bad password'
            '0xC000006F' = 'User logon outside authorized hours'
            '0xC0000070' = 'User logon from unauthorized workstation'
            '0xC0000071' = 'User logon with expired password'
            '0xC0000072' = 'User logon to account disabled by administrator'
            '0XC00000DC' = 'indicates the Sam Server was in the wrong state to perform the desired operation'
            '0XC0000133' = 'Clocks between DC and other computer too far out of sync'
            '0XC000015B' = 'The user has not been granted the requested logon type (aka logon right) at this machine'
            '0XC000018C' = 'The logon request failed because the trust relationship between the primary domain and the trusted domain failed'
            '0XC0000192' = 'An attempt was made to logon, but the Netlogon service was not started'
            '0xC0000193' = 'User logon with expired account'
            '0XC0000224' = 'User is required to change password at next logon'
            '0XC0000225' = 'Evidently a bug in Windows and not a risk'
            '0xC0000234' = 'User logon with account locked'
            '0XC00002EE' = 'Failure Reason: An Error occurred during Logon'
            '0XC0000413' = 'Logon Failure: The machine you are logging onto is protected by an authentication firewall. The specified account is not allowed to authenticate to the machine'
        }

        LogonType = @{
            '2' = 'INTERACTIVE (happens when a user logs on to the computer)'
            '3' = 'NETWORK (user or computer logs on to the computer from the network)'
            '4' = 'BATCH (Scheduled tasks are executed on behalf of a user)'
            '5' = 'SERVICE (services and service accounts that logon to run a service)'
            '7' = 'UNLOCK (when a user unlocks their machine)'
            '8' = 'NETWORKCLEARTEXT (password was passed in plaintext)'
            '9' = 'NEWCREDENTIALS (user uses the RunAs command)'
            '10' = 'REMOTEINTERACTIVE (user remotely accesses the computer through RDP applications)'
            '11'= 'CACHEDINTERACTIVE (user logons to the computer without having to contact the domain controller)'
        }

    } # End of PrivateData hashtable

    # HelpInfo URI of this module
    # HelpInfoURI = ''

    # Default prefix for commands exported from this module. Override the default prefix using Import-Module -Prefix.
    # DefaultCommandPrefix = ''

}
