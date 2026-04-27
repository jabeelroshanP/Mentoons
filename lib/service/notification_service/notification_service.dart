import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mentoons/firebase_options.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  @pragma('vm:entry-point')
  static Future<void> firebaseMessagingBackgroundHandler(
    RemoteMessage message,
  ) async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    await _initializeLocalNotification();
    await _showFlutterNotification(message);
  }

  static Future<void> initializeNotification() async {
    await firebaseMessaging.requestPermission();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      await _showFlutterNotification(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("App opened from background notification: ${message.data}");
    });

    await _getFcmToken();

    await _initializeLocalNotification();

    await _getInitialNotification();
  }

  static Future<void> _getFcmToken() async {
    String? token = await firebaseMessaging.getToken();

    print('FCM Token: $token');
  }

  static Future<void> _showFlutterNotification(RemoteMessage message) async {
    RemoteNotification? notification = message.notification;
    Map<String, dynamic>? data = message.data;

    String title = notification?.title ?? data['title'] ?? "No Title";
    String body = notification?.body ?? data['body'] ?? 'No Body';

    /// Android notification
    AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'CHANNEL_ID',
      'CHANNEL_NAME',
      channelDescription: 'Notification channel for basic tests',
      priority: Priority.high,
      importance: Importance.high,
    );

    /// ios notification
    DarwinNotificationDetails iosDetails = const DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    NotificationDetails notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await flutterLocalNotificationsPlugin.show(
      id: DateTime.now().millisecondsSinceEpoch ~/ 1000,
      title: title,
      body: body,
      notificationDetails: notificationDetails,
    );
  }

  static Future<void> _initializeLocalNotification() async {
    const AndroidInitializationSettings androidInit =
        AndroidInitializationSettings('@drawable/ic_launcher');

    const DarwinInitializationSettings iOSInit = DarwinInitializationSettings();

    final InitializationSettings initSettings = InitializationSettings(
      android: androidInit,
      iOS: iOSInit,
    );

    await flutterLocalNotificationsPlugin.initialize(
      settings: initSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        print("User tapped notification: ${response.payload}");
      },
    );
  }

  static Future<void> _getInitialNotification() async {
    RemoteMessage? message = await FirebaseMessaging.instance
        .getInitialMessage();

    if (message != null) {
      print(
        "App Launched from terminated state via notification: ${message.data}",
      );
    }
  }
}
