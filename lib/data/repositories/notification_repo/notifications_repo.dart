import 'dart:developer';
import 'dart:io';
import 'dart:math' as dm;

import 'package:doctormobileapplication/data/controller/ConsultingQueue_Controller.dart';
import 'package:doctormobileapplication/data/localDB/local_db.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

import '../../../screens/Consulting_Queue/ConsultingQueue.dart';

class NotificationsRepo {
  final _fcm = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

// final _messageStreamController = BehaviorSubject<RemoteMessage>();

  Future<void> initNotifications() async {
    _fcm.requestPermission();
    final fcm = await _fcm.getToken().then((value) {
      // _fcm.subscribeToTopic('all');
      log('saved token is $value');
      LocalDb().saveDeviceToken(value);
    });
  }

  Future<void> showNotifications(RemoteMessage message) async {
    AndroidNotificationChannel channel = AndroidNotificationChannel(
        dm.Random.secure().nextInt(100000).toString(),
        'High Importance Notification');
    AndroidNotificationDetails details = AndroidNotificationDetails(
      channel.id.toString(),
      channel.name.toString(),
      channelDescription: 'Channel Description',
      importance: Importance.high,
      priority: Priority.high,
      ticker: 'Ticker',
    );

    DarwinNotificationDetails darwin = const DarwinNotificationDetails(
        presentAlert: true, presentBadge: true, presentSound: true);

    NotificationDetails notifs =
        NotificationDetails(android: details, iOS: darwin);

    Future.delayed(Duration.zero, () {
      _plugin.show(
        0,
        message.notification?.title.toString(),
        message.notification?.body.toString(),
        notifs,
      );
      log('notifiction custom string is : ${message.data}');
    });
  }

  firebaseInit() {
    FirebaseMessaging.onMessage.listen((message) async {
      // log(message.notification!.body.toString());

      // log(message.data.toString());
      log(message.notification!.title.toString());
      if (Platform.isAndroid) {
        initLocalNotifications(message);
      }
      await showNotifications(message);
      if(message.notification!.title.toString().toLowerCase().replaceAll(' ', '')=='Accepted Consulatation'.toLowerCase().replaceAll(' ', ''))
      {
        ConsultingQueueController.i.updatecallresponse(true);
      }
    });
    // // Check if the app was terminated and opened by tapping the notification
    // FirebaseMessaging.instance.getInitialMessage().then((initialMessage) {
    //   if (initialMessage != null) {
    //     handleInitialMessage(initialMessage);
    //   }
    // });
  }

  // void handleInitialMessage(RemoteMessage initialMessage) {
  //   if (initialMessage.data['NotificationType'].toString() == "8") {
  //     Get.to(() => ConsultingQueue());
  //   }
  // }

  setupInteractMessage() async {
    // When app is terminated
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      if (initialMessage.data['NotificationType'].toString() == "8") {
        Get.to(() => const ConsultingQueue());
      }
    }
    // when app is in background
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      if (event.data['NotificationType'].toString() == "8") {
        Get.to(() => const ConsultingQueue());
      }
    });
  }

  initLocalNotifications(RemoteMessage message) async {
    var androidInitializationSettings =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    var iosInitializationSettings = const DarwinInitializationSettings();

    var init = InitializationSettings(
        android: androidInitializationSettings, iOS: iosInitializationSettings);

    await _plugin.initialize(
      init,
      onDidReceiveNotificationResponse: (payload) {
        print('Notification Type Is  ${message.data['NotificationType']}');
        if (message.data['NotificationType'].toString() == "8") {
          Get.to(() => const ConsultingQueue());
        }
      },
    );
  }

  Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    print('Handling a background message ${message.messageId}');
  }

  // background() {
  //   FirebaseMessaging.onBackgroundMessage(terminatedSatae);
  // }
  //
  // @pragma('vm:entry-point')
  // Future<void> terminatedSatae(RemoteMessage message) async {}
}
