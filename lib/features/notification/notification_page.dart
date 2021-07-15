import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:movie/features/bottom_bar/bottom_bar.dart';
import 'package:movie/features/home/home_page.dart';
import 'package:movie/util/constant.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationPage extends StatefulWidget {
  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    flutterLocalNotificationsPlugin.initialize(
      InitializationSettings(
        AndroidInitializationSettings("@mipmap/ic_launcher"),
        IOSInitializationSettings(),
      ),
      onSelectNotification: (payload) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: orange_color,
        title: Text("Notification"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                _showNotification();
              },
              child: Text("showNotification"),
            ),
            ElevatedButton(
              onPressed: () {

              },
              child: Text("showFullScreenNotification"),
            ),
            ElevatedButton(
              onPressed: () {
                _showNotificationWithNoBody();
              },
              child: Text("showNotificationWithNoBody"),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _showNotification() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        importance: Importance.Max,
        priority: Priority.High,
        ticker: 'ticker');
    const NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        0, 'plain title', 'plain body', platformChannelSpecifics,
        payload: 'item x');
  }

  // Future<void> _showFullScreenNotification() async {
  //   await showDialog(
  //     context: context,
  //     builder: (_) => AlertDialog(
  //       title: const Text('Turn off your screen'),
  //       content: const Text(
  //           'to see the full-screen intent in 5 seconds, press OK and TURN '
  //               'OFF your screen'),
  //       actions: <Widget>[
  //         TextButton(
  //           onPressed: () {
  //             Navigator.pop(context);
  //           },
  //           child: const Text('Cancel'),
  //         ),
  //         TextButton(
  //           onPressed: () async {
  //             await flutterLocalNotificationsPlugin.zonedSchedule(
  //                 0,
  //                 'scheduled title',
  //                 'scheduled body',
  //                 tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
  //                 const NotificationDetails(
  //                     android: AndroidNotificationDetails(
  //                         'full screen channel id',
  //                         'full screen channel name',
  //                         'full screen channel description',
  //                         priority: Priority.high,
  //                         importance: Importance.high,
  //                         fullScreenIntent: true)),
  //                 androidAllowWhileIdle: true,
  //                 uiLocalNotificationDateInterpretation:
  //                 UILocalNotificationDateInterpretation.absoluteTime);
  //
  //             Navigator.pop(context);
  //           },
  //           child: const Text('OK'),
  //         )
  //       ],
  //     ),
  //   );
  // }

  Future<void> _showNotificationWithNoBody() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        importance: Importance.Max,
        priority: Priority.High,
        ticker: 'ticker');
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );
    await flutterLocalNotificationsPlugin.show(
        0, 'plain title', null, platformChannelSpecifics,
        payload: 'item x');
  }

}
