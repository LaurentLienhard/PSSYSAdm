---
external help file: PSSYSAdm-help.xml
Module Name: PSSYSAdm
online version:
schema: 2.0.0
---

# Get-UserLockoutReason

## SYNOPSIS
Search user lockout reason

## SYNTAX

### All (Default)
```
Get-UserLockoutReason [-Computer <String>] [-Credential <PSCredential>] [<CommonParameters>]
```

### ByUser
```
Get-UserLockoutReason [-Computer <String>] [-Identity <String>] [-Credential <PSCredential>]
 [<CommonParameters>]
```

## DESCRIPTION
You can search the reason of locked user on a specific computer
To find the source you can use : Find-UserLockoutsInformation -Identity User1 -DC MyDC1 -Credential (Get-Credential MyAdminAccount)

## EXAMPLES

### EXAMPLE 1
```
Get-UserLockoutReason -Computer ComputerSource -Identity User1 -Credential (Get-Credential MyAdminAccount)
```

## PARAMETERS

### -Computer
User lockout source computer

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Identity
Name of the user for whom we are looking for the source of the lock

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

### -Credential
Administrator credential to connect to the computer

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

### System.Object[]
## NOTES
General notes

## RELATED LINKS
