import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:local_st/General/home.dart';
import 'package:local_st/General/login.dart';
import 'package:local_st/test.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseAuth.instance.authStateChanges().listen((User? user) {
    if (user == null) {
      runApp(MaterialApp(home: const Login()));
    } else {
      runApp(MaterialApp(home: const Home()));
    }
  });
}
