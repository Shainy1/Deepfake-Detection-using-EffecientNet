#!/bin/bash

echo "Cleaning up old cache and database files..."

# Remove database
if [ -f "db.sqlite3" ]; then
    echo "Removing database file..."
    rm db.sqlite3
fi

# Remove cache directories
echo "Removing Python cache files..."
find . -type d -name "__pycache__" -exec rm -rf {} + 2>/dev/null || true
find . -name "*.pyc" -delete 2>/dev/null || true

echo "Cleanup completed!"