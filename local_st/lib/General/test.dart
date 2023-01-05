import 'package:flutter/material.dart';
import 'package:local_st/Admin/manageUsers.dart';
import 'package:local_st/Data-Services/utilities.dart';

class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    print(ManageUsers.encrypt('Manavh@1'));
    return Text('Test');
  }
}
