import 'package:flutter/material.dart';

class Utilities {
  String remove91(String with91) {
    String without91 = with91.substring(4);
    return without91;
  }

  String add91(String without91) {
    return "+91 ${without91}";
  }

  void AlertMessage(context, String title, String content) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => AlertDialog(
              title: Text(title),
              content: Text(content),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'OK'),
                  child: const Text('OK'),
                ),
              ],
            )));
  }
}
