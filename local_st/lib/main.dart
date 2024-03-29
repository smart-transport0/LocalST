import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:local_st/General/home.dart';
import 'package:local_st/General/login.dart';

// must have location permission before running app
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseAuth.instance.authStateChanges().listen((User? user) async {
    if (user == null) {
      runApp(const MaterialApp(home: Login()));
    } else {
      runApp(const MaterialApp(home: Home()));
    }
  });
}
