import-module .\PSClippy.FBP.GeneralAdvice.psd1

$X = Get-ChildItem -Path "$Env:Temp" | Where-Object {$_.Extension -like '*txt'}

$Variable -eq $null

$X = Get-Process | Format-Table | ForEach-Object { $_ }

$Snake_Case = 'should be Pascal Case'