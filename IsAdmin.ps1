Function IsAdmin {
  $currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
  Return $currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}
