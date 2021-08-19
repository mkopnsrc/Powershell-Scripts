Function Get-NetAdapterNetbiosOptions {
<#
.DESCRIPTION
None
 
.EXAMPLE
Get-NetAdapterNetbiosOptions
Get-NetAdapterNetbiosOptions -Filter (Enabled,Disabled,All)
 
.INPUTS
None
 
.OUTPUTS
Interface Name                           Index TcpipNetbiosOptions
--------------                           ----- -------------------
Intel(R) Ethernet Connection I219         1     Disabled           
Hyper-V Virtual Ethernet Adapter          2     Default
 
.NOTES
None
#>

  [CmdletBinding()]
  Param (
    [Parameter(Mandatory=$false)]
    [ValidateSet("Enabled","Disabled","All")]
    [string] $Filter
  )
  
  $HT = @()

  # REPLACES ALL OCCURENCES OF 2 OR MORE SPACES IN A ROW WITH A SINGLE COMMA
  $Lines = @(wmic nicconfig get caption,index,TcpipNetbiosOptions).foreach({$(($_) -replace('\s{2,}',','))})
  $Lines = $Lines.Where({$_ -ne ''}) #Remove empty spaces

  $header = $($Lines[0].split(',').trim())  # EXTRACTS THE FIRST ROW FOR ITS HEADER LINE
  $header = $header.Where({$_ -ne ''})
  $header[0] ="Interface Name" # overide name; defualt-> Caption

  Write-Debug "Header: $header"

  for($i=1;$i -lt $($Lines.Count);$i++){ # NOTE $i=1 TO SKIP THE HEADER LINE

    $Res = "" | Select-Object $header # CREATES AN EMPTY PSCUSTOMOBJECT WITH PRE DEFINED FIELDS
    $Line = $($Lines[$i].split(',')).ForEach({ $_.trim().trim('>') }).Where({$_ -ne ''}) # SPLITS AND THEN TRIMS ANOMALIES THEN REMOVES EMPTY FIELDS
    Write-Debug "$Line"

    for($x=0;$x -lt $($Line.count);$x++){
          if($x -eq 0){ $Line[$x]=$Line[$x] -replace "\[\d{8}\] ",'' }
          if($x -eq 2){
              if ($Line[$x] -eq 0){ $Line[$x] = 'Default' }
              elseif ($Line[$x] -eq 1){ $Line[$x] = 'Enabled' }
              elseif ($Line[$x] -eq 2){ $Line[$x] = 'Disabled' }
          }
      $Res.$($header[$x]) = $Line[$x] # DYNAMICALLY ADDS DATA TO $Res
    }
    $HT += $Res # APPENDS THE LINE OF DATA AS PSCUSTOMOBJECT TO AN ARRAY

    Remove-Variable Res # DESTROYS THE LINE OF DATA BY REMOVING THE VARIABLE
  }

  Switch($Filter) {
    Enabled { $HT | Where-Object { ($_.TcpipNetbiosOptions -match 'Enabled|Default' ) } }
    Disabled { $HT | Where-Object { $_.TcpipNetbiosOptions -eq 'Disabled' } }
    All { $HT }
    Default { $HT | Where-Object { $_.TcpipNetbiosOptions -ne $null } }
  }
  Remove-Variable HT
}