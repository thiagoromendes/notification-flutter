import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:notification/models/push_notification.dart';

class PushNotificationService with ChangeNotifier {
  List<PushNotification> _notifications = [];
  List<String?> _ids = [];
  String? token;

  Future<void> init() async {
    //await Future.delayed(const Duration(seconds: 4));
    await _getToken();
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

  Future<String?> _getToken() async {
    final instance = FirebaseMessaging.instance;
    token = await instance.getToken();
    print('token: $token');
    return token;
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
    if (_validMsg(msg))
      add(PushNotification(
        title: msg!.notification!.title ?? 'Título não informado',
        body: msg.notification!.body ?? 'Conteúdo não informado',
      ));
  }

  bool _validMsg(RemoteMessage? msg) {
    if (msg == null || msg.notification == null) return false;
    if (_ids.contains(msg.data['id'])) return false;
    if (msg.data.containsKey('id')) {
      _ids.add(msg.data['id']);
      return true;
    } else {
      return false;
    }
  }
}
