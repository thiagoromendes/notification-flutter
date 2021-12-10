import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:notification/models/push_notification.dart';

class PushNotificationService with ChangeNotifier {
  List<PushNotification> _notifications = [];

  Future<void> init() async {
    await _messageForeground();
    await _messageBackground();
  }

  List<PushNotification> get notifications {
    return [..._notifications];
  }

  int get notificationsCount {
    return _notifications.length;
  }

  void add(PushNotification notification) {
    _notifications.add(notification);
    notifyListeners();
  }

  void remove(int index) {
    _notifications.removeAt(index);
    notifyListeners();
  }

  Future<bool> get _authorization async {
    final messaging = FirebaseMessaging.instance;
    final permission = await messaging.requestPermission();
    return permission.authorizationStatus == AuthorizationStatus.authorized;
  }

  Future<void> _messageForeground() async {
    if (await _authorization) {
      FirebaseMessaging.onMessage.listen(_onData);
    }
  }

  Future<void> _messageBackground() async {
    if (await _authorization) {
      FirebaseMessaging.onMessageOpenedApp.listen(_onData);
    }
  }

  void _onData(RemoteMessage? msg) {
    if (msg == null || msg.notification == null) return;

    add(PushNotification(
      title: msg.notification!.title ?? 'Título não informado',
      body: msg.notification!.body ?? 'Conteúdo não informado',
    ));
  }
}
