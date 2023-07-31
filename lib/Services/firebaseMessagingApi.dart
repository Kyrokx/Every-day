import 'package:firebase_messaging/firebase_messaging.dart';


Future<void> handleBackgroundMessage(RemoteMessage message) async {
  print("Title ${message.notification!.title}");
  print("Body : ${message.notification!.body}");
  print("Payload: ${message.data}");
}

class FirebaseMessagingApi {

  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    final fCMToken = await _firebaseMessaging.getToken();
    print(fCMToken);
    //FirebaseMessaging.onBackgroundMessage((message) => handleBackgroundMessage(message));
  }

}