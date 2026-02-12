#!/usr/bin/env python
"""
Import SQL dump data into Django models
"""
import os
import sys
import django

os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'detection_of_deepfake_videos.settings')
django.setup()

from Remote_User.models import ClientRegister_Model, deepfake_video_detection, detection_accuracy, detection_ratio

# Sample data from the SQL dump
users = [
    {
        'username': 'Govind',
        'email': 'Govind123@gmail.com',
        'password': 'Govind',
        'phoneno': '9535866270',
        'country': 'India',
        'state': 'Karnataka',
        'city': 'Bangalore',
        'address': '#8928,4th Cross,Rajajinagar',
        'gender': 'Male'
    },
    {
        'username': 'Manjunath',
        'email': 'tmksmanju19@gmail.com',
        'password': 'Manjunath',
        'phoneno': '9535866270',
        'country': 'India',
        'state': 'karnataka',
        'city': 'bangalore',
        'address': '#8928,4th Cross,Rajajinagar',
        'gender': 'Male'
    }
]

detections = [
    {
        'Fid': '10.42.0.151-88.212.196.77-37520-443-6',
        'video_id': '5E4ZBSInqUU',
        'title': 'Marshmello - Blocks (Official Music Video)',
        'channel_title': 'marshmello',
        'publish_time': '2022-11-13T17:00:00.000Z',
        'tags': 'marshmello|"blocks"|"marshmello blocks"',
        'views': '687582',
        'likes': '114188',
        'dislikes': '1333',
        'thumbnail_link': 'https://i.ytimg.com/vi/5E4ZBSInqUU/default.jpg',
        'description': 'Official music video for Marshmello - Blocks',
        'Prediction': 'Deepfake Video'
    },
    {
        'Fid': '172.217.10.110-10.42.0.151-443-58958-6',
        'video_id': 'kgaO45SyaO4',
        'title': 'The New SpotMini',
        'channel_title': 'BostonDynamics',
        'publish_time': '2022-11-13T20:09:58.000Z',
        'tags': 'Robots|"Boston Dynamics"|"SpotMini"',
        'views': '75752',
        'likes': '9419',
        'dislikes': '52',
        'thumbnail_link': 'https://i.ytimg.com/vi/kgaO45SyaO4/default.jpg',
        'description': 'Boston Dynamics SpotMini robot demonstration',
        'Prediction': 'Deepfake Video'
    },
    {
        'Fid': '10.42.0.211-74.6.105.13-36755-443-6',
        'video_id': 'vU14JY3x81A',
        'title': 'How Can You Control Your Dreams?',
        'channel_title': 'Life Noggin',
        'publish_time': '2022-11-13T14:00:03.000Z',
        'tags': 'life noggin|education|lucid dream',
        'views': '115791',
        'likes': '9586',
        'dislikes': '75',
        'thumbnail_link': 'https://i.ytimg.com/vi/vU14JY3x81A/default.jpg',
        'description': 'Educational video about lucid dreaming',
        'Prediction': 'No Deepfake Video'
    },
    {
        'Fid': '10.42.0.42-52.94.232.32-34922-443-6',
        'video_id': 'qEEtzzi1EII',
        'title': 'Birthdays - Simon\'s Cat | GUIDE TO',
        'channel_title': 'Simon\'s Cat',
        'publish_time': '2022-11-09T13:34:58.000Z',
        'tags': 'cartoon|simons cat|funny cats',
        'views': '426078',
        'likes': '19323',
        'dislikes': '245',
        'thumbnail_link': 'https://i.ytimg.com/vi/qEEtzzi1EII/default.jpg',
        'description': 'Simon\'s Cat birthday special',
        'Prediction': 'No Deepfake Video'
    }
]

accuracy_data = [
    {'names': 'Recurrent Neural Network-RNN', 'ratio': '53.92156862745098'},
    {'names': 'SVM', 'ratio': '52.94117647058824'},
    {'names': 'Gradient Boosting Classifier', 'ratio': '56.209150326797385'}
]

ratio_data = [
    {'names': 'No Deepfake Video', 'ratio': '50.0'},
    {'names': 'Deepfake Video', 'ratio': '50.0'}
]

def import_data():
    print("🔄 Starting data import...")
    
    # Import users
    print("\n👤 Importing users...")
    for user_data in users:
        user, created = ClientRegister_Model.objects.get_or_create(
            username=user_data['username'],
            defaults=user_data
        )
        status = "✅ Created" if created else "ℹ️  Exists"
        print(f"  {status}: {user.username}")
    
    # Import detections
    print("\n🎬 Importing video detection records...")
    for detection_data in detections:
        detection, created = deepfake_video_detection.objects.get_or_create(
            video_id=detection_data['video_id'],
            defaults=detection_data
        )
        status = "✅ Created" if created else "ℹ️  Exists"
        print(f"  {status}: {detection.title}")
    
    # Import accuracy data
    print("\n📊 Importing detection accuracy metrics...")
    for acc_data in accuracy_data:
        acc, created = detection_accuracy.objects.get_or_create(
            names=acc_data['names'],
            defaults=acc_data
        )
        status = "✅ Created" if created else "ℹ️  Exists"
        print(f"  {status}: {acc.names}")
    
    # Import ratio data
    print("\n📈 Importing detection ratios...")
    for ratio in ratio_data:
        ratio_obj, created = detection_ratio.objects.get_or_create(
            names=ratio['names'],
            defaults=ratio
        )
        status = "✅ Created" if created else "ℹ️  Exists"
        print(f"  {status}: {ratio_obj.names}")
    
    print("\n✅ Data import completed successfully!")
    print(f"  Users: {ClientRegister_Model.objects.count()}")
    print(f"  Detections: {deepfake_video_detection.objects.count()}")
    print(f"  Accuracy: {detection_accuracy.objects.count()}")
    print(f"  Ratios: {detection_ratio.objects.count()}")

if __name__ == '__main__':
    try:
        import_data()
    except Exception as e:
        print(f"❌ Error: {e}")
        sys.exit(1)
