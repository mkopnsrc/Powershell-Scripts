Function IsMemberOf {
  <#
  .DESCRIPTION
    Check if the Current User from this Powershell Session is a member of a specified Group
  .EXAMPLE
    PS C:\> IsMember
    Returns True or False if the Current User from this Powershell Session is a member of specified Group
  .INPUTS
    GroupName
    Domain
  .OUTPUTS
    True
    False
  #>

  #Parameters
  [CmdletBinding()]
  Param (
    [Parameter(Mandatory=$True, HelpMessage="Group Name")] [String] $GroupName,
    [String] $Domain=$Env:USERDOMAIN
  )

  $CurrentUser = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
  If($Domain -like $env:COMPUTERNAME) {
    $GroupPrincipal = New-Object System.Security.Principal.NTAccount($GroupName)
  } Else {
    $GroupPrincipal = New-Object System.Security.Principal.NTAccount($Domain, $GroupName)
  }
  Return [bool] $CurrentUser.IsInRole($GroupPrincipal)
}
Export-ModuleMember -Function IsMemberOf
