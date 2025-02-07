
# Chat App

A modern, feature-rich chat application built using Flutter and Firebase. This app provides a seamless real-time messaging experience with a focus on user-friendliness and performance.

## Features

- **User Authentication**
  - Sign up and sign in with Firebase Authentication.
  - Persistent login to remember users.
  
- **Real-time Messaging**
  - Send and receive text messages instantly.
  - Send images in chats.
  - Delete and update messages.

- **User Profile Management**
  - View and update profile details.
  - Manage online/offline status.

- **Chat Functionality**
  - Responsive design with separate layouts for sender and receiver.
  - Timestamps for every message.
  - Image preview for shared photos.

- **Additional Features**
  - Dark theme for chat screens.
  - Secure and scalable backend with Firebase Firestore.
  - Smooth navigation using the GetX package.

## Screenshots

*(Add screenshots of your app here, such as splash screen, chat screen, login screen, etc.)*

## Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/kashishpatil1218/chat_app.git
   cd chat_app
   ```

2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Configure Firebase:
   - Set up a Firebase project.
   - Download the `google-services.json` (for Android) or `GoogleService-Info.plist` (for iOS).
   - Place them in the appropriate directories:
     - `android/app/google-services.json`
     - `ios/Runner/GoogleService-Info.plist`

4. Run the app:
   ```bash
   flutter run
   ```

## Dependencies

The app uses the following major packages:
- **Firebase** for authentication, Firestore, and storage:
  - `firebase_core`
  - `firebase_auth`
  - `cloud_firestore`
  - `firebase_storage`
- **GetX** for state management and navigation:
  - `get`
- **Material Design** for UI components:
  - `flutter/material.dart`

## Folder Structure

```
lib/
├── model/                     # Data models (e.g., ChatModel)
├── services/                  # Firebase services (e.g., AuthService, FirestoreService)
├── view/
│   ├── auth/                  # Sign In and Sign Up pages
│   ├── home/                  # Home, Chat, and other main pages
│   ├── profile_page/          # Profile management
│   ├── setting_page/          # Settings page
│   ├── splash_screen/         # Splash screen
├── main.dart                  # App entry point
```

## Future Enhancements

- **Push Notifications**: Enable real-time notifications for new messages.
- **Group Chats**: Allow users to create and participate in group conversations.
- **Media Sharing**: Add support for sharing videos, files, and more.
- **Typing Indicators**: Show when other users are typing.
- **Read Receipts**: Indicate when a message has been read.
```
````
# Images:

<div>
  <img src="https://github.com/user-attachments/assets/eb048992-eabb-4d57-96c6-2fb9731a08be"height=500px>
  <img src="https://github.com/user-attachments/assets/394493f7-057d-4ad1-8be1-2b4647527ec5"height=500px>
  <img src="https://github.com/user-attachments/assets/2eac1cdd-ad26-4c7a-83c9-0055e71409ae"height=500px>
  <img src="https://github.com/user-attachments/assets/13313d9d-8177-4a19-9205-fee86030f190"height=500px>
  <img src="https://github.com/user-attachments/assets/468b84d0-c1cc-4897-bdc6-37fe3ea71572"height=500px>
  <img src="https://github.com/user-attachments/assets/753e942e-4deb-41a2-afff-c1a74e73d662"height=500px>
  <img src="https://github.com/user-attachments/assets/991b2055-bd3e-4b8d-9c63-c24683f335fa"height=500px>
  <img src="https://github.com/user-attachments/assets/11553200-d01b-4018-bb8b-d9ec1ac348e6"height=500px>
  <img src="https://github.com/user-attachments/assets/8fb832a3-b335-4327-ac43-f1ccac7b94ad"height=500px>
 
</div>

# Authentication:
https://github.com/user-attachments/assets/131e0b7a-53a5-43a1-9838-f52eeb27f0d0
# Features:
https://github.com/user-attachments/assets/47e1ca06-8627-4ff1-a0a4-409f8659b7bc




