$SPath = split-path -parent $MyInvocation.MyCommand.Definition
$PSRepoFolder ="$SPath\Functions"

Import-Module $SPath\IsAdmin.ps1
Foreach ($module in Get-Childitem $PSRepoFolder -Name -Filter "*.ps1" -Recurse -Force -WarningAction SilentlyContinue )
{
  Import-Module $PSRepoFolder\$module
}