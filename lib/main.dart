import 'package:agendamentos_app/app.dart';
import 'package:agendamentos_app/firebase_options.dart';
import 'package:agendamentos_app/services/custom_firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseApi().initNotifications();
  runApp(const App());
}
