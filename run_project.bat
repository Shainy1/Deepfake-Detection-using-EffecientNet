@echo off
echo ========================================
echo  Deepfake Detection System Setup
echo ========================================
echo.

REM Check if Python is installed
python --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ERROR: Python is not installed or not in PATH.
    echo Please install Python 3.8 or higher from https://python.org
    echo Make sure to check "Add Python to PATH" during installation.
    pause
    exit /b 1
)

REM Check Python version
for /f "tokens=2" %%i in ('python --version 2^>^&1') do set PYTHON_VERSION=%%i
echo Python version: %PYTHON_VERSION%

REM Extract major and minor version
for /f "tokens=1,2 delims=." %%a in ("%PYTHON_VERSION%") do (
    set MAJOR=%%a
    set MINOR=%%b
)

if %MAJOR% lss 3 (
    echo ERROR: Python 3.8 or higher is required. Current version: %PYTHON_VERSION%
    pause
    exit /b 1
)

if %MAJOR%==3 if %MINOR% lss 8 (
    echo ERROR: Python 3.8 or higher is required. Current version: %PYTHON_VERSION%
    pause
    exit /b 1
)

echo Python version check passed.
echo.

REM Create virtual environment if it doesn't exist
if not exist "venv" (
    echo Creating virtual environment...
    python -m venv venv
    if %errorlevel% neq 0 (
        echo ERROR: Failed to create virtual environment.
        pause
        exit /b 1
    )
    echo Virtual environment created successfully.
) else (
    echo Virtual environment already exists.
)

echo.
echo Activating virtual environment...
call venv\Scripts\activate.bat
if %errorlevel% neq 0 (
    echo ERROR: Failed to activate virtual environment.
    pause
    exit /b 1
)

echo Virtual environment activated.
echo.

REM Upgrade pip
echo Upgrading pip...
python -m pip install --upgrade pip
if %errorlevel% neq 0 (
    echo WARNING: Failed to upgrade pip, continuing...
)

echo.
echo Installing requirements...
pip install -r requirements.txt
if %errorlevel% neq 0 (
    echo ERROR: Failed to install requirements.
    echo Please check your internet connection and try again.
    pause
    exit /b 1
)

echo Requirements installed successfully.
echo.

REM Remove old database and cache files
echo Cleaning up old data...
if exist "db.sqlite3" (
    echo Removing old database file...
    del db.sqlite3
)

REM Remove Django cache
if exist "__pycache__" (
    echo Removing Python cache...
    rmdir /s /q "__pycache__"
)

for /d /r . %%d in (__pycache__) do (
    if exist "%%d" rmdir /s /q "%%d"
)

echo Cleanup completed.
echo.

REM Run Django migrations
echo Setting up database...
python manage.py makemigrations
if %errorlevel% neq 0 (
    echo ERROR: Failed to create migrations.
    pause
    exit /b 1
)

python manage.py migrate
if %errorlevel% neq 0 (
    echo ERROR: Failed to run migrations.
    pause
    exit /b 1
)

echo Database setup completed.
echo.

REM Collect static files
echo Collecting static files...
python manage.py collectstatic --noinput
if %errorlevel% neq 0 (
    echo WARNING: Failed to collect static files, continuing...
)

echo.
echo ========================================
echo  Setup Complete!
echo ========================================
echo.
echo The Deepfake Detection System is ready to run.
echo.
echo To start the server, run: python manage.py runserver
echo Then open your browser to: http://127.0.0.1:8000
echo.
echo Press any key to start the server now...
pause >nul

REM Start the Django server
echo Starting Django development server...
python manage.py runserver

pause