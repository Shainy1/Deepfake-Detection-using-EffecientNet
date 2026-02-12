@echo off
echo Cleaning up old cache and database files...

REM Remove database
if exist "db.sqlite3" (
    echo Removing database file...
    del db.sqlite3
)

REM Remove cache directories
echo Removing Python cache files...
for /d /r . %%d in (__pycache__) do (
    if exist "%%d" (
        rd /s /q "%%d" 2>nul
    )
)

REM Remove .pyc files
del /s /q *.pyc 2>nul

echo Cleanup completed!
pause