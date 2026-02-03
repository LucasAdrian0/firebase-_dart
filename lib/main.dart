import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:modulo8/main_app.dart';
import 'package:modulo8/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MainApp());
}

