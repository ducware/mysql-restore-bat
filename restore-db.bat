@echo off

for /f "tokens=1,2 delims==" %%i in (config.txt) do (
    if "%%i"=="mysqlPath" set "mysqlPath=%%j"
)

if "%~1"=="" (
    echo Please drag and drop a .sql file onto this script to execute it.
    pause
    exit /b
)

set "sqlFile=%~1"
set "sqlFile=%sqlFile:\=/%"

set "currentDir=%~dp0"
set "myCnfFile=%currentDir%my.cnf"

echo Executing SQL script: %sqlFile%
echo.
echo Please wait... Running SQL script...
"%mysqlPath%" --defaults-file="%myCnfFile%" -e "source %sqlFile%;"

if %errorlevel% equ 0 (
    echo SQL script executed successfully!
) else (
    echo Error occurred while executing SQL script.
)

pause
