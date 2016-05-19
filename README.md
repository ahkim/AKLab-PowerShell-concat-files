# AKLab-PowerShell-concat-files

### Introduction

This utility is initially created to cater concat sql dw query files(.dsql) in database project for Azure SQL Data Warehouse. Even though database project in Visual Studio supports excellent feature called schema comparison, it [currently doesn't support](https://feedback.azure.com/forums/307516-sql-data-warehouse/suggestions/13313247-database-project-from-visual-studio-to-support-azu) Data Warehouse. I still, however, manage queries and all other ojbects in database project for tracking purpose. When it was about time to spin up multiple environments(DEV, UAT, TST, PRD), it was required to execute all the queries written to each newly created DW instances. This is create to help just that. Concat all the queries built and build one large query file. 

![](http://i.imgur.com/XV3c3wY.png)

### How to use

When you run the script, you are supposed to input following two. 

"Please input path of sandbox location..."

"Please input target file extension to filter and merge... E.g. dsql"

Sandbox location is where you want to search the file to merge. Target file extension is to specify what type of file you want to merge. The rest of steps will be selectable from the menu. 

### Menu

0. Exit
1. List Files
: List Files command will list all the files under sandbox folder in targetfiles.csv in the same current directory you are running the script and open it with notepad. From the notepad, you can edit the list as you like. Here you could either delete or add items or change order to concat. In case you already have a list in a filename called targetfiles.csv, you can just skip this step. 
3. Concat Files
: Concat Files command will read targetfiles.txt and concat files accordingly as ordered in the list, drop merged.{extension} file in current directory.  
