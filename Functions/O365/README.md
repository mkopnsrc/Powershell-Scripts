# PS Function Name List
  - Get-O365-TenantID


### Get-O365-TenantID.ps1
Retrieve your office 365 organization tenant ID by providing your organization domain name associated with office 365.
if your organization domain name is xyzcorp.com then most likely your associated name would be "xyzcorp"
Return result would be your tenant ID.
#### Examples
```powershell
PS C:\Users\MK> Get-O365-TenantID -DomainName xyzcorp

3e760e32-9e8f-402f-943c-896dca577fe2
```