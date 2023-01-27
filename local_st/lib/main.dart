import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:local_st/General/login.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(home: Login()));
}
