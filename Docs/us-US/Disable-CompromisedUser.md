---
external help file: PSSYSAdm-help.xml
Module Name: PSSYSAdm
online version:
schema: 2.0.0
---

# Disable-CompromisedUser

## SYNOPSIS
Disable compromised user

## SYNTAX

### ByUser (Default)
```
Disable-CompromisedUser [-Identity <String[]>] [-Check] [<CommonParameters>]
```

### ByFileName
```
Disable-CompromisedUser [-FileName <String>] [-Check] [<CommonParameters>]
```

### ByOu
```
Disable-CompromisedUser [-OU <String[]>] [-Check] [<CommonParameters>]
```

## DESCRIPTION
In case of compromission from some users, you can rapidly disable this users.
You can pass to parameter :
    - a nominative list of user
    - a file with a nominative list of users (one user by line)
    - an OU to disable all users
Check example for more details (get-help Disable-CompromisedUser -Examples)
A log file is create in your temp directory ($env:temp)

## EXAMPLES

### EXAMPLE 1
```
Disable-CompromisedUser -Identity "User1"
```

Disable the user account : User1

### EXAMPLE 2
```
Disable-CompromisedUser -Identity "User1" -Check
```

Check if user account User1 is disable

### EXAMPLE 3
```
Disable-CompromisedUser -Identity "User1","User2","User3"
```

Disable users account : User1, User2 and User3

### EXAMPLE 4
```
Disable-CompromisedUser -Identity "User1","User2","User3" -Check
```

Check if users account User1, User2 and User3 are disable

### EXAMPLE 5
```
Disable-CompromisedUser -FileName "c:\temp\CompromisedUser.txt"
```

File template CompromisedUser.txt :
User1
User2
User3

Disable users account : User1, User2 and User3

### EXAMPLE 6
```
Disable-CompromisedUser -FileName "c:\temp\CompromisedUser.txt" -Check
```

File template CompromisedUser.txt :
User1
User2
User3

Check if users account User1, User2 and User3 are disable

### EXAMPLE 7
```
Disable-CompromisedUser -OU "OU=OU1,DC=contoso,DC=com"
```

Disable all users present in OU1

### EXAMPLE 8
```
Disable-CompromisedUser -OU "OU=OU1,DC=contoso,DC=com" -Check
```

Check if all users present in OU1 are disable

### EXAMPLE 9
```
Disable-CompromisedUser -OU "OU=OU1,DC=contoso,DC=com","OU=OU2,DC=contoso,DC=com"
```

Disable all users present in OU1 and OU2

### EXAMPLE 10
```
Disable-CompromisedUser -OU "OU=OU1,DC=contoso,DC=com","OU=OU2,DC=contoso,DC=com" -check
```

Check if all users present in OU1 and OU2 are disable

## PARAMETERS

### -Identity
One or more user(s) to disable

```yaml
Type: String[]
Parameter Sets: ByUser
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -FileName
File with a list of users to disable.
txt with one name by line

```yaml
Type: String
Parameter Sets: ByFileName
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -OU
One or more OU(s) in which we want to disable all users

```yaml
Type: String[]
Parameter Sets: ByOu
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Check
Only check if the users passed in parameter, whatever the way (Identity, Filename or OU), are disable

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
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
