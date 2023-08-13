---
external help file: PSSYSAdm-help.xml
Module Name: PSSYSAdm
online version:
schema: 2.0.0
---

# Find-UserLockoutsInformation

## SYNOPSIS
Find information about locked user account

## SYNTAX

### All (Default)
```
Find-UserLockoutsInformation [-DC <String>] [-Credential <PSCredential>] [<CommonParameters>]
```

### ByUser
```
Find-UserLockoutsInformation [-Identity <String>] [-DC <String>] [-Credential <PSCredential>]
 [<CommonParameters>]
```

## DESCRIPTION
This fonction search for locked user on PDC Emulator and return the lock source
return :
User             : User1
DomainController : PDCEmulator
EventId          : 4740
LockoutTimeStamp : 8/3/2023 6:18:12 AM
Message          : A user account was locked out.
LockoutSource    : SourceComputer
To find the reason use : Get-UserLockoutReason -Computer SourceComputer -Identity User1

## EXAMPLES

### EXAMPLE 1
```
Find-UserLockoutsInformation -Credential (Get-Credential MyAdminAccount)
```

Search information for all locked users in PDC Emulator

### EXAMPLE 2
```
Find-UserLockoutsInformation -Identity User1 -Credential (Get-Credential MyAdminAccount)
```

Search information for user User1 in PDC Emulator

### EXAMPLE 3
```
Find-UserLockoutsInformation -Identity User1 -DC MyDC1 -Credential (Get-Credential MyAdminAccount)
```

Search information for user User1 in specific domain controler MyDC1

## PARAMETERS

### -Identity
User to check (by default all)

```yaml
Type: String
Parameter Sets: ByUser
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -DC
Domain controller on which you want to look up information (by default PDC Emulator)

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: (Get-ADDomain).PDCEmulator
Accept pipeline input: False
Accept wildcard characters: False
```

### -Credential
Administrator credential to connect to the DC

```yaml
Type: PSCredential
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
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
