
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:halka_arz_temettu/Providers/BedelliProvider.dart';
import 'package:halka_arz_temettu/Providers/BedelsizProvider.dart';
import 'package:halka_arz_temettu/Providers/HalkaArzProvider.dart';
import 'package:halka_arz_temettu/Providers/TemettuProvider.dart';
import 'package:halka_arz_temettu/Providers/UserProvider.dart';
import 'package:halka_arz_temettu/Screens/LoginPage.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
}

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,);
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  print('User granted permission: ${settings.authorizationStatus}');
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');

    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
    }
  });

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context)=>TemettuProvider()),
    ChangeNotifierProvider(create: (context)=>HalkaArzProvider()),
    ChangeNotifierProvider(create: (context)=>BedelsizProvider()),
    ChangeNotifierProvider(create: (context)=>BedelliProvider()),
  ],
  child: MyApp()));
}
class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization=Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(

          primarySwatch: Colors.blue,
        ),
        home: FutureBuilder(
          future: _initialization,
          builder: (context,snapshot){
            if(snapshot.hasError){
              return Text('Bir hata var');
            }
            else if(snapshot.hasData){
              return LoginPage();
            }
            else{
              return Text("Bir şeyler ters gidiyor");
            }
          },
        )
    );
  }
}
