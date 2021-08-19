Function Get-O365-TenantID {
  [CmdletBinding()]
  Param (
    [Parameter(Mandatory=$true, HelpMessage="Your Office365 Domain Name only (No FQDN)")] [string] $DomainName
  )
  Return (Invoke-WebRequest https://login.windows.net/$DomainName.onmicrosoft.com/.well-known/openid-configuration|ConvertFrom-Json).token_endpoint.Split('/')[3]
}