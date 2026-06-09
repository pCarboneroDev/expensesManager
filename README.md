![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)

# Expenses Manager

Expenses Manager is a personal expense and income tracking application. Currently in active development.

## 🚧 Project Status

This app is being developed as a personal project and learning exercise.

### ✅ Currently Implemented
- Basic CRUD operations for transactions
- Offline-first architecture
- Basic auth with Firebase
- First charts and model to predict user total expenses at the end of the month
- Both backend and local working separately

## 🛠️ Tech Stack
- **Frontend**: [Flutter]
- **Backend**: [Python, FastApi, SQLAlchemy]
- **Database**: [Currently sqlite, planned to move to PostgreSQL]

## ▶️ Execution Guide
- Go to lib/data/datasources/remote_datasource.dart
```
final dio = Dio(
    BaseOptions(
      baseUrl: 'http://YOUR_IP:8000/', // Change YOUR_IP to your pc ip address
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 3),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ),
  );
```

### How to get your IP address

Run one of these commands depending on your operating system:

```bash
# Windows (Command Prompt)
ipconfig

# Windows (PowerShell)
Get-NetIPAddress -AddressFamily IPv4 | Select-Object IPAddress

# Linux / macOS
ifconfig
# or (newer Linux distributions)
ip addr show

# Alternative for Linux/macOS (shows only IPv4 addresses)
hostname -I   # Linux
ipconfig getifaddr en0  # macOS (for Wi-Fi)
```
## It should work in an external device in the same network as your PC or with an android emulator.