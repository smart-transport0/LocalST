import 'package:flutter/material.dart';

// A set of utility functions
class Utilities {
  // Remove +91 from a mobile number
  String remove91(String with91) {
    String without91 = with91.substring(4);
    return without91;
  }

  // Add +91 to a mobile number
  String add91(String without91) {
    return "+91 $without91";
  }

  // Pada string s on left with string p to make its length equal to length
  String padCharacters(String s, String p, int length) {
    String pre = "";
    while (pre.length + s.length < length) {
      pre += p;
    }
    return pre + s;
  }

  // Convetr datetime object to a string of format dd-mm-yyyy
  String changeDateFormat(String dateTime) {
    String formattedDate = dateTime.substring(8, 10) +
        '-' +
        dateTime.substring(5, 7) +
        '-' +
        dateTime.substring(0, 4);
    return formattedDate;
  }

  int getHourFromTime(String time) {
    int hour = int.parse(time.split(":")[0]);
    if (time[time.length - 2] == 'P') hour += 12;
    return hour;
  }

  int getMinuteFromTime(String time) {
    String minute = (time.split(":")[1]).split(" ")[0];
    return int.parse(minute);
  }

  String getFormattedDateTime(DateTime datetime) {
    return datetime.toString().substring(0, 19);
  }

  DateTime getDateTimeFromFormattedString(String datetimeString) {
    int year = int.parse(datetimeString.substring(0, 4));
    int month = int.parse(datetimeString.substring(5, 7));
    int day = int.parse(datetimeString.substring(8, 10));
    int hour = int.parse(datetimeString.substring(11, 13));
    int minute = int.parse(datetimeString.substring(14, 16));
    int second = int.parse(datetimeString.substring(17));
    return DateTime(year, month, day, hour, minute, second);
  }

  // returns an alert dialog with given title and content
  void alertMessage(context, String title, String content) {
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

  // returns and alert dialog with given content and title and on clicking OK redirects to given widget
  void alertMessageWithWidget(
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
