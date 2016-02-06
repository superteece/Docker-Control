﻿######################################################################
#  ____             _              ____            _             _   #
# |  _ \  ___   ___| | _____ _ __ / ___|___  _ __ | |_ _ __ ___ | |  #
# | | | |/ _ \ / __| |/ / _ \ '__| |   / _ \| '_ \| __| '__/ _ \| |  #
# | |_| | (_) | (__|   <  __/ |  | |__| (_) | | | | |_| | | (_) | |  #
# |____/ \___/ \___|_|\_\___|_|   \____\___/|_| |_|\__|_|  \___/|_|  #
#                                                                    #
#Tool doing Docker stuff in PowerShell                               #
#TC Johnson                                                          #
#TC@geekministry.org                                                 #
#ASCII Art created at: patorjk.com/software/taag/                    #
#Special thanks to the folks at Freenode #Powershell                 #
######################################################################


function banner
{

Write-Host "  ____             _              ____            _             _ " -foreground Green
Write-Host " |  _ \  ___   ___| | _____ _ __ / ___|___  _ __ | |_ _ __ ___ | |" -foreground Green
Write-Host " | | | |/ _ \ / __| |/ / _ \ '__| |   / _ \| '_ \| __| '__/ _ \| |" -foreground Green
Write-Host " | |_| | (_) | (__|   <  __/ |  | |__| (_) | | | | |_| | | (_) | |" -foreground Green
Write-Host " |____/ \___/ \___|_|\_\___|_|   \____\___/|_| |_|\__|_|  \___/|_|" -foreground Green
""
}

#A function of the main menu used by other functions to return to main
function main
{
    Clear-Host
    banner
    Write-Host "What would you like to do?"
    Write-Host "1. Create Kali Docker Machine"
    Write-Host "2. Pull Official Kali Docker Image"
    Write-Host "3. Launch Kali Within Powershell"
    #Write-Host "4. Auto Validate signatures of all processes"
    Write-Host ""
    Write-Host "0. Exit"
    ""
    $menuSelect = Read-host "Selection"
    Switch ($menuSelect)
       {
        1 {makeMachine}
        2 {pullKali}
        3 {launchKali}
        #4 {autoCheck}
        0 {Clear-Host}
       Default {main}
     }
}

#Create a Docker Machine on which to run the Kali image
function makeMachine
{
    $machineName = Read-Host -Prompt 'Enter a name for your new machine'
    docker-machine create --driver virtualbox $machineName
    main
}

#Pull the official Kali Docker Image from Docker Hub
#Runs the pull command in a seperate instance of Powershell
function pullKali
{
    start-process powershell.exe -argument '-nologo -noprofile -executionpolicy bypass -command docker pull kalilinux/kali-linux-docker; read-host "press enter"'
    main
}

#Set env for kali and launch in a new instance of Powershell
function launchKali
{
    
}

#Automatically check the signature validity of each running process
function autoCheck
{
foreach ($item in Get-Process)
    {
    $procValidate = Get-Process $item.Name | select -Expand Path | select -Unique
    Get-AuthenticodeSignature "$procValidate"
    }
    end
}

#Runs at the end of each operation to give the option of returning to the main menu
function end
{
    ""
    ""
    Read-Host 'Press Enter to return to main menu...' | Out-Null
    main
}

function bye
{
    "Good Bye"
}


#This is the main menu which is first presented when the script is executed
clear-host
banner
    Clear-Host
    banner
    Write-Host "Select a tool"
    Write-Host "1. List Running Processes"
    Write-Host "2. List Running Processes by Company"
    Write-Host "3. Validate a process' signature"
    Write-Host "4. Auto Validate signatures of all processes"
    Write-Host ""
    Write-Host "0. Exit"
    ""
    $menuSelect = Read-host "Selection"
    Switch ($menuSelect)
       {
        1 {list}
        2 {listbycomp}
        3 {validate}
        4 {autoCheck}
        0 {Clear-Host}
        Default {main}
       }

    