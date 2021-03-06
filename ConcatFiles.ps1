﻿<#
    .SYNOPSIS
    
    .DESCRIPTION
    1. Copy the script file in the root of the sandbox folder. 
	2. Run the script and choose menu
        
    .EXAMPLE
    
	.NOTES
	Filename:     ConcatFiles.ps1
	
	Maintenance History
	Name	           Date		 	Version		C/R		Description        
	----------------------------------------------------------------------------------
	Aaron			13 May 2016							Created
#>

$releaseVersion = "1.0.0"
$basePath = (Get-Item $MyInvocation.MyCommand.Path).Directory

##-----------------------------------------------------------------------
## Function: Main
## Purpose: Main logic
##-----------------------------------------------------------------------
function Main
{
    Start-Transcript -Path "${basePath}\${releaseVersion}_Log_$([DateTime]::Now.ToString('yyyy.MM.dd.HH.mm.ss')).txt"
    
    Write-Host 'Please choose the path of sandbox location..'
    
    Add-Type -AssemblyName System.Windows.Forms
    $folderBrowser = New-Object System.Windows.Forms.FolderBrowserDialog
    [void]$folderBrowser.ShowDialog()

    $targetFolder = $folderBrowser.SelectedPath

    $filterTarget = Read-Host "Please input target file extension to filter and merge... E.g. dsql"

    $title = "Select options..."
    $message = "Choose what you need"

    #region MenuCreation

    $menu0 = New-Object System.Management.Automation.Host.ChoiceDescription "&0. Exit", `
        "Exit"

    $menu1 = New-Object System.Management.Automation.Host.ChoiceDescription "&1. List files", `
        "List files under sandbox location in targetFiles.csv and open from notepad"

    $menu2 = New-Object System.Management.Automation.Host.ChoiceDescription "&2. Concat files", `
        "Concat files in order you have chosen in previous step"
    	
    $options = [System.Management.Automation.Host.ChoiceDescription[]]($menu0, $menu1, $menu2)

    #endregion
	
    :OuterLoop 
    do 
    { 
        $result = $host.ui.PromptForChoice($title, $message, $options, 0) 

        switch ($result)
            {
                0 {break OuterLoop}
    			1 {
					List-Files
    			  }
    			2 {
					Concat-Files
    			  }
            }
    }
    while (1)
    	
    Stop-Transcript
}

function List-Files()
{
	# Write in .csv file
	$csvFile = "$basePath\targetFiles.csv"
	Get-ChildItem -Path $targetFolder -Recurse | Where-Object {$_.Extension -eq ".$filterTarget"} | Select-Object -Property FullName | ConvertTo-Csv -NoTypeInformation | Select-Object -Skip 1 | Set-Content -Path $csvFile
	# Open from notepad
	Notepad $csvFile 
}

function Concat-Files()
{
    # remove previously merged file
    Remove-Item -Path $basePath\merged.$filterTarget -ErrorAction SilentlyContinue

    $csvFile = "$basePath\targetFiles.csv"
    $content = Get-Content $csvFile | ForEach-Object { $_ -replace '"' }
    foreach ($line in $content)
    {
        Get-Content $line | Add-Content -Path $basePath\merged.$filterTarget
    }
    # remove .csv file
    Remove-Item -Path $csvFile -ErrorAction SilentlyContinue
}

Main
