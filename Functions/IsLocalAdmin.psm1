Function IsLocalAdmin {
  <#
  .DESCRIPTION
    Check if the Current User from this Powershell Session is a Local Administrator
  .EXAMPLE
    PS C:\> IsLocalAdmin
    Returns True or False if the Current User from this Powershell Session is a Local Administrator
  .INPUTS
    It takes CurrentUser as input into the function
  .OUTPUTS
    True
    False
  #>
  
  $CurrentUser = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
  Return [bool] $CurrentUser.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}
Export-ModuleMember -Function IsLocalAdmin