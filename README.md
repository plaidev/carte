# CARTE
CARTE is an "KARTE for App PLAY" application.<br>
You can use this app to validate the features of "KARTE for App".

## Requirements
* iOS 12.0+
* Xcode 10.2+
* Swift 5+
* Node.js 10.10+

## Installation (Firebase)
This application uses Firebase for the backend.<br>
Therefore, you need to set up Firebase in advance.

### Features of the required Firebase.
- [x] Authentication
- [x] Cloud Firestore
- [x] Cloud Messaging
- [x] Cloud Storage
- [x] Hosting

#### Authentication
Enable the following login providers:
- [x] Email and password based authentication
- [x] Anonymous auth

#### Cloud Firestore
Set the following security rules:
```
service cloud.firestore {
  match /databases/{database}/documents {
    match /{document=**} {
      allow read, write: if request.auth.uid != null;
    }
  }
}
```

#### Cloud Messaging
Register the pre-created APNs Auth Key with Firebase.

#### Hosting
NOP

### Set the initial data.
To set the initial data (item data), run the following command:
```bash
cd native-karte-play/firebase/fixture
node index.js
```
You must have Node.js v10.10 or higher to run the command.


## Installation (Application)
To install the application on the device, you must install tools such as CocoaPods and Fastlane.<br>
CocoaPods and Fastlane are installed using Bundler.
```bash
cd native-karte-play/CARTE
bundle install --path vendor/bundler
```

The application relies on several libraries.<br>
To install them, run the following command:
```bash
bundle exec pod install
```

After you start Xcode, press ⌘ + R to run the application.

If you are running on a device, you must install the certificate.<br>
It is possible to install this by running the following command:
```
bundle exec fastlane certificate
```

## Deploy
To distribute the application, you must run the following command:
```
bundle exec fastlane release
```
