import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import '../firebase_options.dart';

class FCMService {
    // create new messaging instance
    final FirebaseMessaging messaging = FirebaseMessaging.instance;

    Future<void> initialize({required void Function(RemoteMessage) onData}) async {
        // must ask user's permission before data can be sent
        await messaging.requestPermission(alert: true, badge: true, sound: true);

        // listen to messages when app is opened in the foreground
        FirebaseMessaging.onMessage.listen((RemoteMessage message) {
            onData(message);
        });

        // used when app opened in the background
        FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
            onData(message);
        });

        // InitialMessage gets notification when app first opens
        final initialMessage = await messaging.getInitialMessage();
            if (initialMessage != null) {
                onData(initialMessage);
            }
    }

    Future<String?> getToken() {
        // need this key for service to work on web
        return messaging.getToken(
            vapidKey: "BIMSQZLs0a2-jtMVfCp_Q22IRuVTV-qAYvrnxKueqJH57PUfZlqjsrEESz3YxZ61jAz6_KZgPe9kxMJGzwC-VOQ" 
        );
    }
}
