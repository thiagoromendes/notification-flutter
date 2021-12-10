import 'package:flutter/material.dart';
import 'package:notification/components/card_notification.dart';
import 'package:notification/pages/loading_page.dart';
import 'package:notification/pages/notification_page.dart';
import 'package:notification/services/push_notification_service.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  Future<void> init(BuildContext context) async {
    await Firebase.initializeApp();
    await Provider.of<PushNotificationService>(
      context,
      listen: false,
    ).init();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: init(context),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return LoadingPage();
          } else {
            return Scaffold(
                appBar: AppBar(
                  centerTitle: true,
                  title: Text('Push Notification'),
                  actions: [
                    Stack(
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (ctx) {
                                return NotificationPage();
                              }));
                            },
                            icon: Icon(
                              Icons.notifications,
                            )),
                        Positioned(
                            top: 8,
                            right: 8,
                            child: CircleAvatar(
                              backgroundColor: Colors.red.shade300,
                              child: Text(
                                '${Provider.of<PushNotificationService>(context).notificationsCount}',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              maxRadius: 8,
                            )),
                      ],
                    )
                  ],
                ),
                body: Center(
                  child: CardNotification(),
                ));
          }
        });
  }
}
