import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';
class NotificationApi{
  
  static final _notifications = FlutterLocalNotificationsPlugin();
  static final onNotifications = BehaviorSubject<String?>();
  

  static Future _notificationDetails() async{
    final sound='notification1.mp3';
    return NotificationDetails (     
       android: AndroidNotificationDetails(
        'channel id',
        'channel name',
        channelDescription: 'description',
        importance: Importance.max,
        sound: RawResourceAndroidNotificationSound(sound.split('.').first),
        playSound: false,
        enableVibration: true,
        priority: Priority.high,
        ),
        iOS: IOSNotificationDetails(),
    );
  }

  static Future init({bool initScheduled = false})async{
    final android =AndroidInitializationSettings('@mipmap/ic_launcher');
    final settings =InitializationSettings(android: android);
    await _notifications.initialize(settings,
    onSelectNotification: (payload) async{
      onNotifications.add(payload);
    },);
  
    
  }

  static Future showNotification({
    int id = 1,
    String? title,
    String? body,
    String? payload,
  }) async =>
  _notifications.show(
    id, 
    title, 
    body,
    await _notificationDetails(),
    payload: payload,
    );
}