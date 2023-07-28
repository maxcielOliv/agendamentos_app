import 'package:agendamentos_app/screens/view/auth_page.dart';
import 'package:agendamentos_app/services/custom_local_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'services/custom_firebase_messaging.dart';

class App extends StatelessWidget {
  const App({super.key});

  void initState() {
    checkNotifications;
    checkFirebaseNotifications();
  }

  checkNotifications() async {
    await NotificationService().checkForNotifications();
  }

  checkFirebaseNotifications() async {
    FirebaseMessagingService(checkNotifications());
  }

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Agendamentos App',
      debugShowCheckedModeBanner: false,
      // theme: lightTheme,
      // darkTheme: darkTheme,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [Locale('pt', 'BR')],
      home: AuthPage(),
    );
  }
}
