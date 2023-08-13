function Send-Mail
{
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory = $true)]
        [System.String]$SmtpServer,
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
        [System.String]$Attachement
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
            "SMTPServer"     = $SMTPServer
            "From"           = $From
            "RecipientList"  = $RecipientList
            "CCList"         = $CCList
            "BCCList"        = $BCCList
            "Subject"        = $Subject
            "TextBody"       = $TextBody
            "HTMLBody"       = $HTMLBody
            "AttachmentList" = $AttachmentList
        }

        Send-MailKitMessage @Parameters

    }

    end
    {

    }
}
