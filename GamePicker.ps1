#requires -version 5
<#
.SYNOPSIS
  Import all csv files in sript location. Then have user choose to have a random game picked from the csv's or have it filtered by the options.
.DESCRIPTION
  Save me from having to pick the games!
.PARAMETER <Parameter_Name>
    <Brief description of parameter input required. Repeat this attribute if required>
.INPUTS
  Simple user inputs of numbers
  CSV spead sheets in same folder as script
.OUTPUTS
  Game selection based on choice made and 
.NOTES
  Version:        1.0
  Author:         RuhaiHu
  Creation Date:  2018.12.20
  Purpose/Change: Initial script development
  
.EXAMPLE
  <Example goes here. Repeat this attribute for more than one example>
#>

#---------------------------------------------------------[Initialisations]--------------------------------------------------------

#Set Error Action to Silently Continue
$ErrorActionPreference = "SilentlyContinue"


#----------------------------------------------------------[Declarations]----------------------------------------------------------
# Import CSV Files from Current Folder into Variable for PICKING!
$GameListAll = Import-Csv -Path (Get-ChildItem -Path . -Filter '*.csv') | Sort-Object -Property Title

# Game List Filtered by Not Played
$GameListNotPlayed = $GameListAll | Sort-Object -Property Title | Where-Object -Property Played -NotMatch 'Yes'

#-----------------------------------------------------------[Functions]------------------------------------------------------------
do {

  Write-Output "Game List to choose from:
    0) Exit
    1) All Games
    2) Not Played Games"

  # User input variable choice
  $UserChoiceGameList = Read-Host -Prompt "Choose Game List "

  # User input number of games to pick
  $UserChoiceNumberGames = Read-Host -Prompt "Choose Number of Games to pick "

  if($UserChoiceGameList -eq 1 -AND $UserChoiceNumberGames -eq 1){
    Write-Output "You chose all Games, and 1 game!"
    Write-Output "Your game is: " + $GameListAll | Get-Random | Select-Object -Property Played,Title | Format-Table
  }elseif ($UserChoiceGameList -eq 1 -AND $UserChoiceNumberGames -gt 1){
    Write-Output "You chose all Games, and $UserChoiceNumberGames games!"
    Write-Output "Your games are: " + $GameListAll | Get-Random -Count $UserChoiceNumberGames | Select-Object -Property Played,Title | Format-Table
  }

  if($UserChoiceGameList -eq 2 -AND $UserChoiceNumberGames -eq 1){
    Write-Output "You chose Not Played Games, and 1 game!"
    Write-Output "Your game is: " + $GameListNotPlayed | Get-Random | Select-Object -Property Played,Title | Format-Table
  }elseif ($UserChoiceGameList -eq 2 -AND $UserChoiceNumberGames -gt 1){
    Write-Output "You chose Not Played Games, and $UserChoiceNumberGames games!"
    Write-Output "Your games are: " + $GameListNotPlayed | Get-Random -Count $UserChoiceNumberGames | Select-Object -Property Played,Title | Format-Table
  }

  Write-Output "You the Dice have been cast! Will you proceed?"
  Write-output ""
  Write-output ""
  Write-output "0 exit, 1 to continue"
  $UserChoiceGameList = Read-Host "Choose Again? "


  Write-output ""
  Write-output ""
} while ($UserChoiceGameList -ne 0)



#-----------------------------------------------------------[Execution]------------------------------------------------------------

#Script Execution goes here
