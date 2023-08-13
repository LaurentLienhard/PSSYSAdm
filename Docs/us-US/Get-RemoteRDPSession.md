---
external help file: PSSYSAdm-help.xml
Module Name: PSSYSAdm
online version:
schema: 2.0.0
---

# Get-RemoteRDPSession

## SYNOPSIS
Retrieve RDP session

## SYNTAX

```
Get-RemoteRDPSession [[-ComputerName] <String>] [[-Credential] <PSCredential>] [<CommonParameters>]
```

## DESCRIPTION
This function retrive all rdp session on a remote computer.
Result il like :
UserName    : UserName
SessionName : SessionName
ID          : SessionID
State       : SessionState
IdleTime    : SessionIdleTime
LogonTime   : SessionLogonType

## EXAMPLES

### EXAMPLE 1
```
Get-RemoteRDPSessions -ComputerName Server1 -Credential MyAdmAccount
```

## PARAMETERS

### -ComputerName
The remote computer on which you want RDP sessions

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Credential
An account with the necessary privileges to connect to the remote computer

```yaml
Type: PSCredential
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: [System.Management.Automation.PSCredential]::Empty
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
General notes

## RELATED LINKS
