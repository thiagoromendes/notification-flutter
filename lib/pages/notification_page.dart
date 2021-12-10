import 'package:flutter/material.dart';
import 'package:notification/services/push_notification_service.dart';
import 'package:provider/provider.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final service = Provider.of<PushNotificationService>(context);
    final count = service.notificationsCount;
    final notifications = service.notifications;

    return Scaffold(
        appBar: AppBar(
          title: Text('Notificações'),
          centerTitle: true,
        ),
        body: Container(
          padding: EdgeInsets.all(10),
          width: MediaQuery.of(context).size.width,
          child: ListView.builder(
              itemCount: count,
              itemBuilder: (ctx, index) => Card(
                    shadowColor: Colors.black87,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  notifications[index].title,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(notifications[index].body),
                              ],
                            ),
                          ),
                          IconButton(
                            onPressed: () => service.remove(index),
                            icon: Icon(Icons.delete),
                            color: Colors.red.shade300,
                          )
                        ],
                      ),
                    ),
                  )),
        ));
  }
}
