@echo off
setlocal enabledelayedexpansion

:main
cls
echo -----------------------------------
echo   Develop by VOHALA. 
echo -----------------------------------
echo Listing all users in C:\Users...
set userIndex=1

for /d %%i in (C:\Users\*) do (
    set "user[!userIndex!]=%%~nxi"
    echo !userIndex!. %%~nxi
    set /a userIndex+=1
)

set /p "selected=Enter the number corresponding to the user (or type 'exit' to quit): "

if /i "%selected%"=="exit" (
    echo Exiting the script. Goodbye!
    pause
    exit /b
)

if "!user[%selected%]"=="" (
    echo Invalid selection. Please try again.
    pause
    goto main
)

set "selectedUser=!user[%selected%]!"
echo You selected: %selectedUser%

set "targetDir=C:\Users\%selectedUser%\AppData\Local\Temp"

if not exist "%targetDir%" (
    echo The directory "%targetDir%" does not exist for the selected user.
    pause
    goto main
)

echo Deleting all files and folders in %targetDir%...
for /d %%i in ("%targetDir%\*") do (
    rd /s /q "%%i" 2>nul
)
for %%i in ("%targetDir%\*") do (
    del /f /q "%%i" 2>nul
)

echo All deletable files and folders in %targetDir% have been deleted.
pause
goto main
