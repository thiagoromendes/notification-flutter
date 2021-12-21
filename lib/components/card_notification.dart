import 'package:flutter/material.dart';
import 'package:notification/models/push_notification.dart';
import 'package:notification/services/push_notification_service.dart';
import 'package:provider/provider.dart';

class CardNotification extends StatefulWidget {
  const CardNotification({Key? key}) : super(key: key);

  @override
  _CardNotificationState createState() => _CardNotificationState();
}

class _CardNotificationState extends State<CardNotification> {
  void _addNotification(BuildContext context) {
    Provider.of<PushNotificationService>(
      context,
      listen: false,
    ).add(PushNotification(
      title: 'Notificação de Teste',
      body: 'Notificação gerada manualmente no APP',
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              shadowColor: Colors.black87,
              color: Colors.blue.shade400,
              child: Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text(
                      'Card Notification',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.red.shade300,
                      maxRadius: 25,
                      child: Text(
                        '${Provider.of<PushNotificationService>(context).notificationsCount}',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addNotification(context),
        child: Icon(Icons.add),
      ),
    );
  }
}
