# Remote Desktop Functions List
*All of the following functions requires Domain Admins user to be able to call the functions.*
  - [Connect-RDPSession](#Connect-RDPSession)


## Connect-RDPSession
The RDP administrator can use the Shadow session mode to view and remotely manage active RDP session of any user. You can connect using this function command to remotely control user's session.

### Configuration Requirement for Remote Computers
  - Enable - Allow Remote Assistance connections to this computer in Windows System Properties / Remote Tab
  - Enable - Allow this computer to be controlled remotely in Advanced Option in Windows System Properties / Remote Tab
  - Configure following Group Policy through AD or Locally
  ![Remote Assistance GPO](images/gpo-remote-assistance.png)

### Examples
```powershell
Connect-RDPSession Computer_Name OR IP_Address
Connect-RDPSession -ComputerName Computer_Name OR IP_Address
Connect-RDPSession -ComputerName Computer_Name OR IP_Address -UserName Logged_on_Username
```
### Output
```powershell
# By running the Connect-RDPSession -ComputerName Computer_Name command, it will invoke Remote Desktop Connection Client which will try to connect to your remote computer that you provided.
```