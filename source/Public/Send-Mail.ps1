function Send-Mail
{
    <#
.SYNOPSIS
    Sends an email using the MimeKit library.

.DESCRIPTION
    This function sends an email using the MimeKit library in PowerShell. It allows you to specify various email parameters such as the SMTP server, sender, recipients, CC, BCC, subject, body, and attachments.

.PARAMETER SmtpServer
    The SMTP server to use for sending the email.

.PARAMETER Port
    The port number to use for the SMTP server. Default value is 25.

.PARAMETER Sender
    The email address of the sender.

.PARAMETER Recipient
    An array of email addresses of the recipients.

.PARAMETER CC
    An array of email addresses to be added in the CC field.

.PARAMETER BCC
    An array of email addresses to be added in the BCC field.

.PARAMETER Subject
    The subject of the email.

.PARAMETER TextBody
    The plain text body of the email.

.PARAMETER HtmlBody
    The HTML body of the email.

.PARAMETER Attachement
    An array of file paths to attachments to be included in the email.

.PARAMETER UseSecureConnectionIfAvailable
    Specifies whether to use a secure connection if available. Default value is $true.

.EXAMPLE
    Send-Mail -SmtpServer "smtp.example.com" -Sender "sender@example.com" -Recipient "recipient@example.com" -Subject "Test Email" -TextBody "This is a test email."

.NOTES
    File Name      : Send-Mail.ps1
    Author         : LIENHARD Laurent
    Prerequisite   : MimeKit library
#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory = $true)]
        [System.String]$SmtpServer,
        [Parameter()]
        [System.String]$Port = "25",
        [Parameter(Mandatory = $true)]
        [System.String]$Sender,
        [Parameter(Mandatory = $true)]
        [System.String[]]$Recipient,
        [Parameter()]
        [System.String[]]$CC,
        [Parameter()]
        [System.String[]]$BCC,
        [Parameter()]
        [System.String]$Subject,
        [Parameter()]
        [System.String]$TextBody,
        [Parameter()]
        [System.String]$Htmlbody,
        [Parameter()]
        [System.String]$Attachement,
        [Parameter()]
        [Boolean]$UseSecureConnectionIfAvailable = $true
    )

    begin
    {

    }

    process
    {
        $From = [MimeKit.MailboxAddress]$Sender;

        if ($Recipient)
        {
            $RecipientList = [MimeKit.InternetAddressList]::new();
            foreach ($R in $Recipient)
            {
                $RecipientList.Add([MimeKit.InternetAddress]$R);
            }

        }

        if ($CC)
        {
            $CCList = [MimeKit.InternetAddressList]::new();
            foreach ($C in $CC)
            {
                $CCList.Add([MimeKit.InternetAddress]$C);
            }

        }

        if ($BCC)
        {
            $BCCList = [MimeKit.InternetAddressList]::new();
            foreach ($B in $BCC)
            {
                $BCCList.Add([MimeKit.InternetAddress]$B);
            }

        }

        if ($Attachement)
        {
            $AttachementList = [MimeKit.InternetAddressList]::new();
            foreach ($A in $Attachement)
            {
                $AttachementList.Add([MimeKit.InternetAddress]$A);
            }

        }

        $Parameters = @{
            "UseSecureConnectionIfAvailable" = $UseSecureConnectionIfAvailable
            "SMTPServer"                     = $SMTPServer
            "Port"                           = $Port
            "From"                           = $From
            "RecipientList"                  = $RecipientList
            "CCList"                         = $CCList
            "BCCList"                        = $BCCList
            "Subject"                        = $Subject
            "TextBody"                       = $TextBody
            "HTMLBody"                       = $HTMLBody
            "AttachmentList"                 = $AttachmentList
        }

        Send-MailKitMessage @Parameters

    }

    end
    {

    }
}
