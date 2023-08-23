# Dataview-Creation-script
Version 1.0
Author: Alex Ramsbey
Application: Connectwise Automate (formerly Labtech)

To use this script you need to be familiar with MySQL and how the tables are wrtten inside of Automate. 
If you want to look through tables and figure it out, look into the Internal (from scratch) setup and view the 'Tables to check' and 'Fields to Check'
Once you have a solid understandanding and you've built the select statement you want to show, then run this script


The script will ask you several questions to build an INSERT statement that will pop out on your desktop. Make sure you double check the statement just as a preventative measure.


The questions this script will ask you:

1. Dataview Name
2. SELECT statement (do NOT include the word 'select' but include all the columns you're choosing)
3. FROM tables (you DO need to include the FROM statement here)
4. ID Column (This is your linking identifier for all tables that you used)
5. Folder ID (you can get this by turning on Object IDs in your Automate User's preferences and looking at the Dataview Folders)
5. Client Link (use if you want to be able to reference back to clients)
6. Location Link (use if you want to be able to reference back to locations)
7. Computer Link (use if you want to be able to reference back to computers)

## Stipulations for formatting the Insert Statement
- Replaced commas within functions with double semicolons.

- Ensured that the "AS" keyword is in lowercase.

- Wrapped the column names with backticks.

Example: 

### This writes a Patch Policy Report into Dataviews
> This also has several SQL functions that are replacing commands with ;; along with making sure the 'as' is all lowercase. Refer to the fomatting here for column inserts to get working.


```sql
INSERT INTO `dataviews` (
    `Name`,
    `FieldList`,
    `ColumnList`,
    `HiddenList`,
    `SQLBody`,
    `IDColumn`,
    `SQLWhere`,
    `FolderID`,
    `ClientLink`,
    `ComputerLink`,
    `SortField`,
    `GroupField`,
    `SortOrder`,
    `FilterControl`,
    `FormatControl`,
    `LocationLink`,
    `IconControl`,
    `SystemPermission`,
    `UserClassName`,
    `SystemPermissionHigh`
) VALUES (
    'Patch Report',
    'clients.name as `Client`, computers.Name as `Hostname`, (SELECT `xADM Patch Actions` FROM v_extradatacomputers WHERE v_extradatacomputers.ComputerID = computers.ComputerID) as `Patch Action Items`, CASE WHEN LOWER(computers.os) LIKE \'%windows 10%\' THEN \'10\' WHEN LOWER(computers.os) LIKE \'%windows 11%\' THEN \'11\' WHEN LOWER(computers.os) LIKE \'%windows 8%\' THEN \'8\' WHEN LOWER(computers.os) LIKE \'%windows server 2016%\' THEN \'2016\' WHEN LOWER(computers.os) LIKE \'%windows server 2019%\' THEN \'2019\' WHEN LOWER(computers.os) LIKE \'%windows server 2012%\' THEN \'2012\' WHEN LOWER(computers.os) LIKE \'%windows server 2022%\' THEN \'2022\' WHEN LOWER(computers.os) LIKE \'%windows 7%\' THEN \'7\' WHEN LOWER(computers.os) LIKE \'%windows%2008%\' THEN \'2008\' WHEN LOWER(computers.os) LIKE \'%windows%2003%\' THEN \'2003\' WHEN LOWER(computers.os) LIKE \'%windows xp%\' THEN \'XP\' WHEN LOWER(computers.os) LIKE \'%mac%\' THEN \'Mac\' ELSE \'Unknown\' END as `OS`, SUBSTRING_INDEX(SUBSTRING_INDEX(computers.version;; \'.\';; -1);; \' \';; 1) as `OSBuild`, hotfix.FAILED as `Failed Patches`, GREATEST(0;; SUM(hotfix.Approved = 4) - SUM(hotfix.Installed = 1)) as `Missing Patches`, CASE WHEN hotfixcompliancedata.compliance IS NULL OR hotfixcompliancedata.compliance = 0 THEN \'No\' ELSE \'Yes\' END as `PatchData`, DATE_FORMAT(computers.DateAdded;; \'%Y/%m/%d\') as `FirstCheckin`, DATE_FORMAT(computers.LastContact;; \'%Y/%m/%d\') as `LastCheckin`, DATE_FORMAT(DATE(NOW() - INTERVAL UPTIME MINUTE);; \'%Y/%m/%d\') as `LastReboot`, FORMAT(computers.uptime / 1440;; 1) as `Uptime Days`, (SELECT installsoftwarepolicies.Name FROM patchgrouppolicies JOIN installsoftwarepolicies ON patchgrouppolicies.InstallPolicy = installsoftwarepolicies.ID WHERE patchgrouppolicies.GroupID IN (SELECT SubGroupwchildren.groupid FROM SubGroupwchildren WHERE SubGroupwchildren.ComputerID = computers.ComputerID) LIMIT 1) as `Install Policy`, computers.computerid as `ID`',
    'Client - Location,ComputerName,Patch Actions,Action,OS,OSBuild,Failed Patches,Missing Patches,PatchData,FirstCheckin,LastCheckin,LastReboot,Uptime,Install Policy,ID',
    '',
    'FROM (((computers LEFT JOIN hotfix ON Computers.ComputerID=hotfix.ComputerID) LEFT JOIN hotfixcompliancedata ON computers.computerid=hotfixcompliancedata.computerid) LEFT JOIN Locations ON Locations.LocationID=Computers.Locationid LEFT JOIN Clients ON Clients.ClientID=Computers.clientid) GROUP BY computers.computerid',
    'computers.computerid',
    '',
    '3',
    'clients.clientid',
    'computers.computerid',
    '',
    '',
    '1',
    '',
    '',
    '',
    '',
    '',
    '',
    ''
);
```







