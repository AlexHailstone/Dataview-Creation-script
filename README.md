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
