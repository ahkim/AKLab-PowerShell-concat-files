# AKLab-PowerShell-concat-files

### Introduction

This utility is initially created to cater concat sql dw query files(.dsql) in database project for Azure SQL Data Warehouse. Even though database project in Visual Studio supports excellent feature called schema comparison, it [currently doesn't support](https://feedback.azure.com/forums/307516-sql-data-warehouse/suggestions/13313247-database-project-from-visual-studio-to-support-azu) Data Warehouse. I still, however, manage queries and all other ojbects in database project for tracking purpose. When it was about time to spin up multiple environments(DEV, UAT, TST, PRD), it was required to execute all the queries written to each newly created DW instances. This is create to help just that. Concat all the queries built and build one large query file. 

![](http://i.imgur.com/XV3c3wY.png)

### Menu

0. Exit
1. List Files
2. Concat Files

List Files command will list all the files under sandbox folder in targetfiles.txt in current directory and open notepad. From the notepad, you can edit the list as you like. Here you could either delete or add items or change order to concat. 

Concat Files command will read from targetfiles.txt and concat files accordingly. 
