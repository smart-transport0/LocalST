import 'package:flutter/material.dart';

class Utilities {
  String remove91(String with91) {
    String without91 = with91.substring(4);
    return without91;
  }

  String add91(String without91) {
    return "+91 ${without91}";
  }

  String padCharacters(String s, String p, int length) {
    String pre = "";
    while (pre.length + s.length < length) pre += p;
    return pre + s;
  }

  String changeDateFormat(String dateTime) {
    String formattedDate = dateTime.substring(8, 10) +
        '-' +
        dateTime.substring(5, 7) +
        '-' +
        dateTime.substring(0, 4);
    return formattedDate;
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

  void AlertMessageWithWidget(
      context, String title, String content, Widget widget) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => AlertDialog(
              title: Text(title),
              content: Text(content),
              actions: <Widget>[
                TextButton(
                  onPressed: () => {
                    Navigator.pop(context, 'OK'),
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: ((context) => widget)))
                  },
                  child: const Text('OK'),
                ),
              ],
            )));
  }
}
