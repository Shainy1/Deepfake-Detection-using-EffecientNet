#!/bin/bash

echo "========================================"
echo " Deepfake Detection System Setup"
echo "========================================"
echo

# Check if Python is installed
if ! command -v python3 &> /dev/null && ! command -v python &> /dev/null; then
    echo "ERROR: Python is not installed."
    echo "Please install Python 3.8 or higher."
    echo "On Ubuntu/Debian: sudo apt install python3 python3-pip python3-venv"
    echo "On macOS: brew install python3"
    exit 1
fi

# Determine Python command
if command -v python3 &> /dev/null; then
    PYTHON_CMD="python3"
else
    PYTHON_CMD="python"
fi

# Check Python version
PYTHON_VERSION=$($PYTHON_CMD --version 2>&1 | grep -oP '\d+\.\d+')
echo "Python version: $PYTHON_VERSION"

# Extract major and minor version
MAJOR=$(echo $PYTHON_VERSION | cut -d. -f1)
MINOR=$(echo $PYTHON_VERSION | cut -d. -f2)

if [ $MAJOR -lt 3 ] || ([ $MAJOR -eq 3 ] && [ $MINOR -lt 8 ]); then
    echo "ERROR: Python 3.8 or higher is required. Current version: $PYTHON_VERSION"
    exit 1
fi

echo "Python version check passed."
echo

# Create virtual environment if it doesn't exist
if [ ! -d "venv" ]; then
    echo "Creating virtual environment..."
    $PYTHON_CMD -m venv venv
    if [ $? -ne 0 ]; then
        echo "ERROR: Failed to create virtual environment."
        exit 1
    fi
    echo "Virtual environment created successfully."
else
    echo "Virtual environment already exists."
fi

echo
echo "Activating virtual environment..."
source venv/bin/activate
if [ $? -ne 0 ]; then
    echo "ERROR: Failed to activate virtual environment."
    exit 1
fi

echo "Virtual environment activated."
echo

# Upgrade pip
echo "Upgrading pip..."
pip install --upgrade pip
if [ $? -ne 0 ]; then
    echo "WARNING: Failed to upgrade pip, continuing..."
fi

echo
echo "Installing requirements..."
pip install -r requirements.txt
if [ $? -ne 0 ]; then
    echo "ERROR: Failed to install requirements."
    echo "Please check your internet connection and try again."
    exit 1
fi

echo "Requirements installed successfully."
echo

# Remove old database and cache files
echo "Cleaning up old data..."
if [ -f "db.sqlite3" ]; then
    echo "Removing old database file..."
    rm db.sqlite3
fi

# Remove Python cache
echo "Removing Python cache..."
find . -type d -name "__pycache__" -exec rm -rf {} + 2>/dev/null || true
find . -name "*.pyc" -delete 2>/dev/null || true

echo "Cleanup completed."
echo

# Run Django migrations
echo "Setting up database..."
python manage.py makemigrations
if [ $? -ne 0 ]; then
    echo "ERROR: Failed to create migrations."
    exit 1
fi

python manage.py migrate
if [ $? -ne 0 ]; then
    echo "ERROR: Failed to run migrations."
    exit 1
fi

echo "Database setup completed."
echo

# Collect static files
echo "Collecting static files..."
python manage.py collectstatic --noinput
if [ $? -ne 0 ]; then
    echo "WARNING: Failed to collect static files, continuing..."
fi

echo
echo "========================================"
echo " Setup Complete!"
echo "========================================"
echo
echo "The Deepfake Detection System is ready to run."
echo
echo "To start the server, run: python manage.py runserver"
echo "Then open your browser to: http://127.0.0.1:8000"
echo
echo "Press Enter to start the server now..."
read -r

# Start the Django server
echo "Starting Django development server..."
python manage.py runserver