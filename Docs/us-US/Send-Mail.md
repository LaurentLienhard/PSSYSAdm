---
external help file: PSSYSAdm-help.xml
Module Name: PSSYSAdm
online version:
schema: 2.0.0
---

# Send-Mail

## SYNOPSIS
Sends an email using the MimeKit library.

## SYNTAX

```
Send-Mail [-SmtpServer] <String> [[-Port] <String>] [-Sender] <String> [-Recipient] <String[]>
 [[-CC] <String[]>] [[-BCC] <String[]>] [[-Subject] <String>] [[-TextBody] <String>] [[-Htmlbody] <String>]
 [[-Attachement] <String>] [[-UseSecureConnectionIfAvailable] <Boolean>] [<CommonParameters>]
```

## DESCRIPTION
This function sends an email using the MimeKit library in PowerShell.
It allows you to specify various email parameters such as the SMTP server, sender, recipients, CC, BCC, subject, body, and attachments.

## EXAMPLES

### EXAMPLE 1
```
Send-Mail -SmtpServer "smtp.example.com" -Sender "sender@example.com" -Recipient "recipient@example.com" -Subject "Test Email" -TextBody "This is a test email."
```

## PARAMETERS

### -SmtpServer
The SMTP server to use for sending the email.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Port
The port number to use for the SMTP server.
Default value is 25.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: 25
Accept pipeline input: False
Accept wildcard characters: False
```

### -Sender
The email address of the sender.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Recipient
An array of email addresses of the recipients.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: True
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -CC
An array of email addresses to be added in the CC field.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -BCC
An array of email addresses to be added in the BCC field.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Subject
The subject of the email.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -TextBody
The plain text body of the email.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 8
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Htmlbody
The HTML body of the email.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 9
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Attachement
An array of file paths to attachments to be included in the email.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 10
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -UseSecureConnectionIfAvailable
Specifies whether to use a secure connection if available.
Default value is $true.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 11
Default value: True
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
File Name      : Send-Mail.ps1
Author         : LIENHARD Laurent
Prerequisite   : MimeKit library

## RELATED LINKS
