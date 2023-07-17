// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';

// class NotificationRepository {
//   final _firebaseMessaging = FirebaseMessaging.instance;
//   var _onNotificationOpenedController;

//   Future<void> _initialize(Stream<RemoteMessage> onNotificationOpened) async {
//     final response = await _firebaseMessaging.requestPermission();
//     final status = response.authorizationStatus;
//     if (status == AuthorizationStatus.authorized) {
//       final message = await _firebaseMessaging.getInitialMessage();
//       final token = await _firebaseMessaging.getToken(vapidKey: _vapidKey);
//       await _sendTokenToServer(token!);
//       if (message != null) {
//         _onMessageOpened(message);
//       }
//       onNotificationOpened.listen(_onMessageOpened);
//     }
//   }

//   /// see [FirebaseMessaging.getInitialMessage].
//   Stream<Notification> get onNotificationOpened {
//     return _onNotificationOpenedController.stream;
//   }

//   Stream<Notification> get onForegroundNotification {
//     return _onForegroundNotification.mapNotNull((message) {
//       final notification = message.notification;
//       if (notification == null) {
//         return null;
//       }
//       return Notification(
//         title: notification.title ?? '',
//         body: notification.body ?? '',
//       );
//     });
//   }
// }
