import 'package:flutter/material.dart';
import 'package:pushapp/src/pages/home_page.dart';
import 'package:pushapp/src/pages/mensaje_page.dart';
import 'package:pushapp/src/providers/push_notifications_provider.dart';
 
void main() => runApp(MyApp());
 /*
 para las pushnotificaciones es necesario instalar 
 https://pub.dev/packages/firebase_messaging
 
 
  */
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

  @override
  void initState(){
    super.initState();

    final pushProvider = new PushNotificationsProvider();
    pushProvider.initNotifications();

    pushProvider.mensajesStream.listen( (data) {
      print('argument desde main: $data');

      //Navigator.pushNamed(context, 'mensaje');
      navigatorKey.currentState.pushNamed('mensaje', arguments: data);
    });
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      title: 'Material App',
      initialRoute: 'home',
      routes: {
        'home'    : ( BuildContext c ) => HomePage(),
        'mensaje' : ( BuildContext c ) => MensajePage()
      },
    );
  }
}