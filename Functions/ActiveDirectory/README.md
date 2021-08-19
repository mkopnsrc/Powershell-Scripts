# Active Directory Functions List
*All of the following functions requires Domain Admins user to be able to call the functions.*
  - [Get-EmptyGroup] (#Get-EmptyGroup)


## Get-EmptyGroup

This function queries the Active Directory domain the initiaing computer is in for all groups that have no members.
This is common when attempting to find groups that can be removed.
This does not include default AD groups like Domain Computers, Domain Users, etc.

### Examples
```powershell
 Get-EmptyGroup
```
### Output
```powershell
#Get-EmptyGroup will return all empty groups with no members from Active Directory

PS C:\Users\MK> Get-EmptyGroup

```