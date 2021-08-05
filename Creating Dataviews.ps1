$DataViewName = Read-Host -Prompt 'Input Dataview Name'
$FieldList = Read-Host -Prompt 'Give me your select statement (must have columns): SELECT '
$SQLBody = Read-Host -Prompt 'Give me your FROM statement:'
$IDColumn = Read-Host -Prompt 'Give me the main ID column used to link it all together:'
$SQLWhere = Read-Host -Prompt 'Give me your WHERE statement:'
$FolderID = Read-Host -Prompt 'Give me the folder ID from your Automate:'
$ClientLink = Read-Host -Prompt 'Give me the Client Link (example computers.clientid):'
$ComputerLink = Read-Host -Prompt 'Give me the Client Link (example computers.computerid):'
$LocationLink = Read-Host -Prompt 'Give me the Client Link (example computers.locationid):'
$DesktopPath = [Environment]::GetFolderPath("Desktop")


New-Item -Path $DesktopPath\$DataViewName.sql
"insert into ``dataviews`` (``Name``,
``FieldList``,``ColumnList``,``HiddenList``,``SQLBody``,``IDColumn``,``SQLWhere``,``FolderID``,``ClientLink``,``ComputerLink``,``SortField``,``GroupField``,``SortOrder``,``FilterControl``,``FormatControl``,``LocationLink``,``IconControl``,``SystemPermission``,``UserClassName``,``SystemPermissionHigh``) values('$DataViewName','$FieldList','','$SQLBody','$IDColumn','$SQLWhere','$FolderID','$ClientLink','$ComputerLink','','','1','','','$LocationLink','','','',''));" > $DesktopPath\$DataViewName.sql
Get-Content -Path $DesktopPath\$DataViewName.sql