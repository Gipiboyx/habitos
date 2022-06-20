import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

//SHA 1: E7:04:94:04:CF:38:57:03:12:3D:C5:BD:C4:87:40:E0:07:95:BB:DE
// P8 - KeyID: 535YWVCLQ6

class Alertas {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static String? token;
  static StreamController<Map<String, dynamic>> _messageStream =
      new StreamController.broadcast();

  static Stream<Map<String, dynamic>> get messageStream =>
      _messageStream.stream;

  static Future _backgroundHandler(RemoteMessage message) async {
    //print('background Handler ${message.messageId}');
    _messageStream.add(message.data);
  }

  static Future _onMessageHandler(RemoteMessage message) async {
    //print('onMessage Handler ${message.messageId}');
    _messageStream.add(message.data);
  }

  static Future _onMessageOpenApp(RemoteMessage message) async {
    //print('onMessageOpenApp Handler ${message.messageId}');
    _messageStream.add(message.data);
    print(_messageStream);
  }

  static Future initializeApp() async {
    await Firebase.initializeApp();
    token = await FirebaseMessaging.instance.getToken();
    print("El token es: $token");

    FirebaseMessaging.onBackgroundMessage(_backgroundHandler);
    FirebaseMessaging.onMessage.listen(_onMessageHandler);
    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenApp);
  }

  static closeStream() {
    _messageStream.close();
  }
}
