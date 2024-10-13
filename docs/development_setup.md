# Development Setup

Follow these steps to set up and run the project locally.

## Prerequisites

Before starting development on GuffGaff, ensure that your development environment meets the following requirements:

1. **Flutter Version:** 3.24.0 or higher [Install Flutter](https://flutter.dev/docs/get-started/install)
2. **Dart Version:** 3.5.0 or higher
3. **Minimum Android Sdk:** 23
4. **Minimum Java Version:** 17
5. **Firebase Account:** [Create a Firebase Account](https://firebase.google.com/)
6. **Firebase-cli:** [Install Firebase-cli](https://firebase.google.com/docs/cli#install-cli-mac-linux)

## Installation
### 1. Clone the repository

```bash
git clone https://github.com/grgprarup/guffgaff.git
```

### 2. Navigate to the Project Directory:

```bash
cd guffgaff
```

### 3. Install Flutter Dependencies:

```bash
flutter pub get
```

### 4. Run the Application:

```bash
flutter run
```

## Setup Firebase

### 1. Create a new Firebase project at [Firebase Console](https://console.firebase.google.com/).
### 2. Login to Firebase-cli
```bash
firebase login
```
### 3. Activate flutterfire cli
```bash
flutter pub global activate flutterfire_cli
```
### 4. Configure Firebase for Android and iOS
```bash
flutterfire configure
```
