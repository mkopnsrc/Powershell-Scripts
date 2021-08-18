$SPath = Split-Path -Parent $MyInvocation.MyCommand.Definition
$PSRepoFolder = "$SPath\Functions"

Import-Module "$PSRepoFolder\IsLocalAdmin.psm1"
Import-Module "$PSRepoFolder\IsMemberOf.psm1"

Foreach ($PSCustomModule in Get-Childitem $PSRepoFolder -Name -Filter "*.ps1" -Recurse -Force -WarningAction SilentlyContinue -ErrorAction SilentlyContinue) {
  Import-Module "$PSRepoFolder\$PSCustomModule"
}