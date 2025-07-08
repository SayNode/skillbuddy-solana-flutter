import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

import '../util/constants.dart';
import 'user_state_service.dart';

class MessagingService extends GetxService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final UserStateService userStateService = Get.find<UserStateService>();
  FlutterLocalNotificationsPlugin notificationPlugin =
      FlutterLocalNotificationsPlugin();

  Future<MessagingService> init() async {
    SkillBuddyConstants.logger.log('MessagingService - initializing ...');
    await requestPermission();
    await _getToken();
    try {
      await notificationPlugin.initialize(
        const InitializationSettings(
          android: AndroidInitializationSettings('ic_not'),
          iOS: DarwinInitializationSettings(),
        ),
      );
    } catch (e) {
      SkillBuddyConstants.logger
          .log('MessagingService Error on init', error: e);
    }
    setupForegroundListener();
    return this;
  }

  Future<void> requestPermission() async {
    final NotificationSettings settings =
        await _firebaseMessaging.requestPermission();
    SkillBuddyConstants.logger
        .log('User granted permission: ${settings.authorizationStatus}');
  }

  Future<bool> _getToken() async {
    // Check for APNS on iOS
    if (GetPlatform.isIOS) {
      if (await _firebaseMessaging.getAPNSToken() == null) {
        SkillBuddyConstants.logger
            .log("Couldn't get APNS token, retrying after delay.");
        await Future<void>.delayed(3.seconds);
        if (await _firebaseMessaging.getAPNSToken() == null) {
          SkillBuddyConstants.logger.log(
            "Still can't get APNS token, after delay. Aborting Messaging Service initialization.",
          );
          return false;
        }
      }
    }

    final String? token = await _firebaseMessaging.getToken();
    if (token != null && token.isNotEmpty) {
      SkillBuddyConstants.logger.log(
        'MessagingService - Successfully got notification token: $token',
      );
      await userStateService.update(firebasePushNotificationToken: token);
      userStateService.user.refresh();
    } else {
      SkillBuddyConstants.logger
          .log('MessagingService - Notification token is null or empty');
      return false;
    }

    return true;
  }

  void setupForegroundListener() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      SkillBuddyConstants.logger
          .log('Received Message: ${message.notification?.title}');
      final RemoteNotification? notification = message.notification;
      if (notification != null) {
        notificationPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          const NotificationDetails(
            android: AndroidNotificationDetails(
              'high_importance_channel',
              'High Importance Notifications',
              importance: Importance.max,
              icon: 'ic_not',
            ),
            iOS: DarwinNotificationDetails(),
          ),
          payload: message.data['route'] as String?,
        );
      }
    });
  }
}
