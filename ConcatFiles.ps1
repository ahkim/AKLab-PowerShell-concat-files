<#
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
    
    $targetFolder = Read-Host 'Please input path of sandbox location...'

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
    			  }
            }
    }
    while (1)
    	
    Stop-Transcript
}

function List-Files()
{
	Get-ChildItem -Path $targetFolder -Recurse | Where-Object {$_.Extension -eq ".dsql"} | Select-Object -Property FullName | ConvertTo-Csv -NoTypeInformation | Select-Object -Skip 1 | Set-Content -Path "$basePath\targetFiles.csv"
}

Main