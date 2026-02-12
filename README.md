# Deepfake Detection System

A comprehensive Django-based web application for detecting deepfake videos and images using advanced machine learning models.

## Features

- **Video & Image Analysis**: Upload and analyze videos/photos for deepfake detection
- **Multiple ML Models**: MesoNet, MesoInception, and other detection algorithms
- **Real-time Processing**: Fast analysis with detailed results
- **User Management**: Registration, login, and profile management
- **Results History**: Track all your detection results
- **Responsive UI**: Modern dark theme with smooth animations

## Environment Configuration

Create a `.env` file in the project root (copy from `.env.example`):

```bash
cp .env.example .env
```

Edit the `.env` file with your configuration:
- Set `DEBUG=False` for production
- Configure `ALLOWED_HOSTS` for your domain
- Set a secure `SECRET_KEY`
- Configure database settings if using MySQL/PostgreSQL

## Quick Start (Windows)

1. **Download and Extract**: Extract the project files to your desired location

2. **Run Setup**: Double-click `run_project.bat` or run it from command prompt:
   ```
   run_project.bat
   ```

   This will:
   - Check Python installation and version
   - Create a virtual environment
   - Install all required packages
   - Set up the database
   - Clean old cache files
   - Start the Django server

3. **Access Application**: Open your browser and go to:
   ```
   http://127.0.0.1:8000
   ```

## Linux/Mac Setup

Run the setup script:
```bash
chmod +x run_project.sh
./run_project.sh
```

Or follow the manual setup steps below.

## Manual Setup (All Platforms)

### Prerequisites
- Python 3.8 or higher
- pip (Python package installer)

### Installation Steps

1. **Clone or Download** the project files

2. **Create Virtual Environment**:
   ```bash
   python -m venv venv
   ```

3. **Activate Virtual Environment**:
   - Windows: `venv\Scripts\activate`
   - Linux/Mac: `source venv/bin/activate`

4. **Install Dependencies**:
   ```bash
   pip install -r requirements.txt
   ```

5. **Setup Database**:
   ```bash
   python manage.py makemigrations
   python manage.py migrate
   ```

6. **Run Server**:
   ```bash
   python manage.py runserver
   ```

7. **Access Application**:
   Open browser to `http://127.0.0.1:8000`

## Project Structure

```
detection_of_deepfake_videos/
├── detection_of_deepfake_videos/    # Django project settings
├── Remote_User/                     # User-facing app
│   ├── models.py                    # Database models
│   ├── views.py                     # View functions
│   ├── templates/                   # HTML templates
│   └── classifiers/                 # ML models
├── Service_Provider/                # Admin/service app
├── Template/                        # Static templates
├── FaceForensics/                   # Face forensics datasets
├── MesoNet/                         # MesoNet implementation
├── manage.py                        # Django management script
├── requirements.txt                 # Python dependencies
├── run_project.bat                  # Windows setup script
└── README.md                        # This file
```

## Supported File Formats

- **Videos**: MP4, AVI, MOV, MKV
- **Images**: JPG, JPEG, PNG
- **Max Size**: 500 MB per file

## Models Used

- **Meso4**: Basic MesoNet architecture
- **MesoInception4**: Advanced MesoNet with inception modules
- **Ensemble Models**: Combined predictions for higher accuracy

## Database

- **Default**: SQLite (db.sqlite3)
- **Production**: Configurable to MySQL/PostgreSQL via environment variables

## Environment Variables (Optional)

```bash
# Database Configuration
DB_ENGINE=mysql
MYSQL_DATABASE=your_db_name
MYSQL_USER=your_username
MYSQL_PASSWORD=your_password
MYSQL_HOST=localhost
MYSQL_PORT=3306
```

## Maintenance

### Clean Database and Cache
To start fresh with a clean database and remove all cache files:
- **Windows**: Run `cleanup.bat`
- **Linux/Mac**: Run `cleanup.sh` (or manually delete `db.sqlite3` and `__pycache__` directories)

### Update Dependencies
```bash
# Activate virtual environment first
pip install -r requirements.txt --upgrade
```

## Troubleshooting

### Common Issues

1. **Python not found**: Ensure Python 3.8+ is installed and in PATH
2. **Virtual environment issues**: Delete `venv` folder and rerun setup
3. **Port already in use**: Change port with `python manage.py runserver 8001`
4. **Database errors**: Run `cleanup.bat` then `python manage.py migrate`
5. **Permission errors**: Run command prompt as administrator (Windows) or use `sudo` (Linux/Mac)
6. **Module not found**: Ensure virtual environment is activated before running commands

### Performance Tips

- Use GPU-enabled TensorFlow for faster processing
- Process smaller files for quicker results
- Close other applications to free up RAM
- Use production server (gunicorn/uwsgi) instead of development server for better performance

## License

This project is for educational and research purposes.

## Support

For issues or questions, please check the troubleshooting section or create an issue in the repository.