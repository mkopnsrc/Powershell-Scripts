# PS Function Name List
  - Get-QueryUser #Requires Domain Admins User


### Get-QueryUser

Displays information about user sessions on Remote Desktop Host server. You can use this function and command 'Get-QueryUser' to find out if a specific user session or to get list of users session that are logged on to a specific Remote Desktop Session Host server or workstation. This scripts requires elevated admin access to be able to execute.

#### Examples
```powershell
 Get-QueryUser Computer_Name OR IP_Address
 Get-QueryUser -ComputerName Computer_Name OR IP_Address -Json
```
#### Output
```powershell
PS C:\Users\MK> Get-QueryUser

COMPUTERNAME : MK-PC
USERNAME     : MK
SESSIONNAME  : rdp-tcp#4
ID           : 2
STATE        : Active
IDLE TIME    : .
LOGON TIME   : 8/31/2020 09:00 AM

PS C:\Users\MK> Get-QueryUser -GetSessionID
2

PS C:\Users\MK> Get-QueryUser -Json
{
    "MK-PC":  [
                          {
                              "COMPUTERNAME":  "MK-PC",
                              "USERNAME":  "MK",
                              "SESSIONNAME":  "rdp-tcp#4",
                              "ID":  "2",
                              "STATE":  "Active",
                              "IDLE TIME":  ".",
                              "LOGON TIME":  "8/31/2020 09:00 AM"
                          }
                      ]
}

```