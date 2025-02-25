// lib/firebase_options.dart

import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    return FirebaseOptions(
      apiKey: "AIzaSyBjyP2yijuQnN5dttiM4AaQue5W6-7fT90",
      authDomain: "YOUR_PROJECT_ID.firebaseapp.com",
      projectId: "my-expense-app-ab6ef",
      storageBucket: "YOUR_PROJECT_ID.appspot.com",
      messagingSenderId: "YOUR_MESSAGING_SENDER_ID",
      appId: "1:11023881784:android:2474e1d0b414b43a4538cd",
      measurementId: "YOUR_MEASUREMENT_ID",
    );
  }
}
