import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:local_st/Chat/chat.dart';
import 'package:local_st/Chat/group_chat.dart';
import 'package:local_st/Data-Services/realtimeDatabaseOperations.dart';
import 'package:local_st/Data-Services/utilities.dart';
import 'package:local_st/Reusable/bottom_navigation_bar.dart';
import 'package:local_st/Reusable/colors.dart';
import 'package:local_st/Reusable/loading.dart';
import 'package:local_st/Reusable/navigation_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ListedJourneyDetails extends StatefulWidget {
  final String journeyID;
  const ListedJourneyDetails({Key? key, required this.journeyID})
      : super(key: key);
  @override
  State<ListedJourneyDetails> createState() => _ListedJourneyDetailsState();
}

class _ListedJourneyDetailsState extends State<ListedJourneyDetails> {
  @override
  void initState() {
    super.initState();
    initial();
  }

  late SharedPreferences sharedPreferences;
  bool pendingVisibility = false;
  bool acceptedVisibility = false;
  List journeyDetails = [];
  List pendingRequests = [];
  List acceptedRequests = [];
  String journeyDate = "";
  String journeyDay = "";
  String journeyLeaveTime = "";
  String chatName = "";
  bool isAllowedToStart = false;
  bool isAllowedToComplete = false;
  late Utilities utilities;
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
            title: Text('$journeyDate $journeyLeaveTime'),
            centerTitle: true,
            backgroundColor: Colors.black,
            elevation: 0),
        drawer: const NavBar(),
        bottomNavigationBar: BottomNavBar(2),
        body: FutureBuilder(
            future: fetchJourneyDetails(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (journeyDetails.isNotEmpty) {
                  return SingleChildScrollView(
                      child: Column(children: <Widget>[
                    Container(
                        padding: EdgeInsets.fromLTRB(
                            w * 0.03, h * 0.04, 0, h * 0.04),
                        color: MyColorScheme.bgColor,
                        child: Row(children: <Widget>[
                          Expanded(
                              flex: 4,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                        padding: EdgeInsets.fromLTRB(
                                            0.0, 0.0, 0.0, h * 0.005),
                                        child: Text('SCHEDULED ON',
                                            style: TextStyle(
                                                color: Colors.grey[700],
                                                fontSize: h * 0.02,
                                                fontWeight: FontWeight.bold))),
                                    Padding(
                                        padding: EdgeInsets.fromLTRB(
                                            0.0, 0.0, 0.0, h * 0.02),
                                        child: Text(
                                            '${journeyDetails[0]} $journeyDay',
                                            style: TextStyle(
                                                fontSize: h * 0.034))),
                                    Padding(
                                        padding: EdgeInsets.fromLTRB(
                                            0.0, 0.0, 0.0, h * 0.005),
                                        child: Text('LEAVE TIME',
                                            style: TextStyle(
                                                color: Colors.grey[700],
                                                fontSize: h * 0.02,
                                                fontWeight: FontWeight.bold))),
                                    Padding(
                                        padding: EdgeInsets.fromLTRB(
                                            0.0, 0.0, 0.0, h * 0.02),
                                        child: Text('${journeyDetails[1]}',
                                            style: TextStyle(
                                                fontSize: h * 0.034))),
                                    Padding(
                                        padding: EdgeInsets.fromLTRB(
                                            0.0, 0.0, 0.0, h * 0.005),
                                        child: Text('SOURCE',
                                            style: TextStyle(
                                                color: Colors.grey[700],
                                                fontSize: h * 0.02,
                                                fontWeight: FontWeight.bold))),
                                    Padding(
                                        padding: EdgeInsets.fromLTRB(
                                            0.0, 0.0, 0.0, h * 0.02),
                                        child: Text('${journeyDetails[2]}',
                                            style: TextStyle(
                                                fontSize: h * 0.034))),
                                    Padding(
                                        padding: EdgeInsets.fromLTRB(
                                            0.0, 0.0, 0.0, h * 0.005),
                                        child: Text('DESTINATION',
                                            style: TextStyle(
                                                color: Colors.grey[700],
                                                fontSize: h * 0.02,
                                                fontWeight: FontWeight.bold))),
                                    Padding(
                                        padding: EdgeInsets.fromLTRB(
                                            0.0, 0.0, 0.0, h * 0.02),
                                        child: Text('${journeyDetails[3]}',
                                            style: TextStyle(
                                                fontSize: h * 0.034))),
                                    Padding(
                                        padding: EdgeInsets.fromLTRB(
                                            0.0, 0.0, 0.0, h * 0.005),
                                        child: Text('NUMBER PLATE',
                                            style: TextStyle(
                                                color: Colors.grey[700],
                                                fontSize: h * 0.02,
                                                fontWeight: FontWeight.bold))),
                                    Padding(
                                        padding: EdgeInsets.fromLTRB(
                                            0.0, 0.0, 0.0, h * 0.02),
                                        child: Text('${journeyDetails[9]}',
                                            style: TextStyle(
                                                fontSize: h * 0.034))),
                                    Padding(
                                        padding: EdgeInsets.fromLTRB(
                                            0.0, 0.0, 0.0, h * 0.005),
                                        child: Text('VEHICLE TYPE',
                                            style: TextStyle(
                                                color: Colors.grey[700],
                                                fontSize: h * 0.02,
                                                fontWeight: FontWeight.bold))),
                                    Padding(
                                        padding: EdgeInsets.fromLTRB(
                                            0.0, 0.0, 0.0, h * 0.02),
                                        child: Text('${journeyDetails[4]}',
                                            style: TextStyle(
                                                fontSize: h * 0.034))),
                                    Padding(
                                        padding: EdgeInsets.fromLTRB(
                                            0.0, 0.0, 0.0, h * 0.005),
                                        child: Text('AVAILABLE SEATS',
                                            style: TextStyle(
                                                color: Colors.grey[700],
                                                fontSize: h * 0.02,
                                                fontWeight: FontWeight.bold))),
                                    Padding(
                                        padding: EdgeInsets.fromLTRB(
                                            0.0, 0.0, 0.0, h * 0.02),
                                        child: Text('${journeyDetails[5]}',
                                            style: TextStyle(
                                                fontSize: h * 0.034))),
                                    Padding(
                                        padding: EdgeInsets.fromLTRB(
                                            0.0, 0.0, 0.0, h * 0.005),
                                        child: Text('ROUTE',
                                            style: TextStyle(
                                                color: Colors.grey[700],
                                                fontSize: h * 0.02,
                                                fontWeight: FontWeight.bold))),
                                    Padding(
                                        padding: EdgeInsets.fromLTRB(
                                            0.0, 0.0, 0.0, h * 0.02),
                                        child: Text('${journeyDetails[6]}',
                                            style: TextStyle(
                                                fontSize: h * 0.034))),
                                    Padding(
                                        padding: EdgeInsets.fromLTRB(
                                            0.0, 0.0, 0.0, h * 0.005),
                                        child: Text('PAID/UNPAID',
                                            style: TextStyle(
                                                color: Colors.grey[700],
                                                fontSize: h * 0.02,
                                                fontWeight: FontWeight.bold))),
                                    Padding(
                                        padding: EdgeInsets.fromLTRB(
                                            0.0, 0.0, 0.0, h * 0.02),
                                        child: Text('${journeyDetails[7]}',
                                            style: TextStyle(
                                                fontSize: h * 0.034))),
                                    Visibility(
                                      visible: journeyDetails[8] != "",
                                      child: Column(children: [
                                        Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                0.0, 0.0, 0.0, h * 0.005),
                                            child: Text('DESCRIPTION',
                                                style: TextStyle(
                                                    color: Colors.grey[700],
                                                    fontSize: h * 0.02,
                                                    fontWeight:
                                                        FontWeight.bold))),
                                        Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                0.0, 0.0, 0.0, h * 0.02),
                                            child: Text('${journeyDetails[8]}',
                                                style: TextStyle(
                                                    fontSize: h * 0.025)))
                                      ]),
                                    )
                                  ])),
                          Expanded(
                              flex: 1,
                              child: Column(children: <Widget>[
                                IconButton(
                                    onPressed: () {},
                                    icon: const FaIcon(Icons.edit)),
                                IconButton(
                                    onPressed: () {},
                                    icon: const FaIcon(Icons.delete)),
                                IconButton(
                                    onPressed: () {},
                                    icon:
                                        const FaIcon(Icons.notifications_off)),
                                IconButton(
                                    onPressed: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) => ChatUI(
                                                  widget.journeyID, chatName)));
                                    },
                                    icon: const FaIcon(Icons.chat)),
                                Visibility(
                                  visible: isAllowedToStart,
                                  child: IconButton(
                                      onPressed: () async {
                                        // notify users about the journey has started
                                        await FirebaseFirestore.instance
                                            .collection("TransporterList")
                                            .doc(widget.journeyID)
                                            .update({
                                          "StartTime":
                                              utilities.getFormattedDateTime(
                                                  DateTime.now())
                                        });
                                      },
                                      icon: const FaIcon(
                                          Icons.play_circle_filled)),
                                ),
                                Visibility(
                                  visible: isAllowedToComplete,
                                  child: IconButton(
                                      onPressed: () {},
                                      icon: const FaIcon(Icons.check_box)),
                                )
                              ]))
                        ])),
                    Visibility(
                      visible: pendingVisibility,
                      child: Column(children: <Widget>[
                        Text('Pending Requests',
                            style: TextStyle(fontSize: h * 0.035)),
                        SizedBox(
                            width: w,
                            child: ListView.builder(
                                primary: false,
                                shrinkWrap: true,
                                itemCount: pendingRequests.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Card(
                                      child: Padding(
                                          padding: EdgeInsets.fromLTRB(w * 0.05,
                                              h * 0.02, w * 0.05, h * 0.02),
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                        '${pendingRequests[index][1]}',
                                                        style: TextStyle(
                                                            fontSize:
                                                                h * 0.03)),
                                                    Text(
                                                        '${pendingRequests[index][0]}',
                                                        style: TextStyle(
                                                            fontSize:
                                                                h * 0.026)),
                                                  ],
                                                ),
                                                Row(children: <Widget>[
                                                  Padding(
                                                      padding:
                                                          EdgeInsets.fromLTRB(0,
                                                              0, w * 0.03, 0),
                                                      child: IconButton(
                                                        onPressed: () => {
                                                          acceptRequest(
                                                              pendingRequests[
                                                                  index][2],
                                                              pendingRequests[
                                                                  index][1])
                                                        },
                                                        icon: Icon(Icons.check,
                                                            size: h * 0.03),
                                                      )),
                                                  IconButton(
                                                      onPressed: () => {
                                                            rejectRequest(
                                                                pendingRequests[
                                                                    index][2],
                                                                pendingRequests[
                                                                    index][1])
                                                          },
                                                      icon: Icon(Icons.close,
                                                          size: h * 0.03))
                                                ])
                                              ])));
                                }))
                      ]),
                    ),
                    Visibility(
                      visible: acceptedVisibility,
                      child: Column(children: <Widget>[
                        Text('Accepted Requests',
                            style: TextStyle(fontSize: h * 0.035)),
                        SizedBox(
                            width: w,
                            child: ListView.builder(
                                primary: false,
                                shrinkWrap: true,
                                itemCount: acceptedRequests.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Card(
                                      child: Padding(
                                          padding: EdgeInsets.fromLTRB(w * 0.05,
                                              h * 0.02, w * 0.05, h * 0.02),
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                          '${acceptedRequests[index][1]}',
                                                          style: TextStyle(
                                                              fontSize:
                                                                  h * 0.03)),
                                                      Text(
                                                          '${acceptedRequests[index][0]}',
                                                          style: TextStyle(
                                                              fontSize:
                                                                  h * 0.026)),
                                                    ])
                                              ])));
                                }))
                      ]),
                    )
                  ]));
                } else {
                  return const Loading();
                }
              } else {
                return const Loading();
              }
            }));
  }

  Future<void> acceptRequest(String userID, String fullName) async {
    var requestInfo = await FirebaseFirestore.instance
        .collection('TransporterList')
        .doc(widget.journeyID)
        .collection('ActiveRequests')
        .doc(userID)
        .get();
    await FirebaseFirestore.instance
        .collection('TransporterList')
        .doc(widget.journeyID)
        .collection('AcceptedRequests')
        .doc(userID)
        .set({
      "FullName": fullName,
      "PhoneNumber": userID,
      "TimeStamp": requestInfo["TimeStamp"]
    });
    var data = await FirebaseFirestore.instance
        .collection('TransporterList')
        .doc(widget.journeyID)
        .get();
    if (data['IsJourneyAvailable']) {
      await FirebaseFirestore.instance
          .collection('TransporterList')
          .doc(widget.journeyID)
          .update({
        'PendingRequestsCount': data['PendingRequestsCount'] - 1,
        'AcceptedRequestsCount': data['AcceptedRequestsCount'] + 1,
        'IsJourneyAvailable':
            data['AcceptedRequestsCount'] + 1 < data['AvailableSeats']
      });
      await FirebaseFirestore.instance
          .collection('TransporterList')
          .doc(widget.journeyID)
          .collection('ActiveRequests')
          .doc(userID)
          .delete();
      RealTimeDatabase rdb = RealTimeDatabase();
      await rdb.updateDataIntoRTDB(
          "Chat/" + widget.journeyID + "/Members/" + userID,
          {"UserName": fullName, 'Unread': 0});
      setState(() {
        initial();
      });
    }
  }

  Future<void> rejectRequest(String userID, String fullName) async {
    await FirebaseFirestore.instance
        .collection('TransporterList')
        .doc(widget.journeyID)
        .collection('ActiveRequests')
        .doc(userID)
        .delete();
    var data = await FirebaseFirestore.instance
        .collection('TransporterList')
        .doc(widget.journeyID)
        .get();
    await FirebaseFirestore.instance
        .collection('TransporterList')
        .doc(widget.journeyID)
        .update({'PendingRequestsCount': data['PendingRequestsCount'] - 1});
    setState(() {
      initial();
    });
  }

  String dayofweek(int d, int m, int y) {
    List<int> t = [0, 3, 2, 5, 0, 3, 5, 1, 4, 6, 2, 4];
    if (m < 3) y = y - 1;
    int ans = (y +
            (y / 4).floor() -
            (y / 100).floor() +
            (y / 400).floor() +
            t[m - 1] +
            d) %
        7;
    if (ans == 0) {
      return "Sunday";
    } else if (ans == 1) {
      return "Monday";
    } else if (ans == 2) {
      return "Tuesday";
    } else if (ans == 3) {
      return "Wednesday";
    } else if (ans == 4) {
      return "Thursday";
    } else if (ans == 5) {
      return "Friday";
    } else {
      return "Saturday";
    }
  }

  Future<List> fetchJourneyDetails() async {
    return journeyDetails;
  }

  Future<void> initial() async {
    utilities = Utilities();
    sharedPreferences = await SharedPreferences.getInstance();
    var journeyData = await FirebaseFirestore.instance
        .collection('TransporterList')
        .doc(widget.journeyID)
        .get();
    journeyDetails = [];
    journeyDetails.add(journeyData['JourneyDate']);
    journeyDetails.add(journeyData['LeaveTime']);
    journeyDetails.add(journeyData['SourcePlace']);
    journeyDetails.add(journeyData['DestinationPlace']);
    journeyDetails.add(journeyData['VehicleType']);
    journeyDetails.add(journeyData['AvailableSeats']);
    journeyDetails.add(journeyData['Route']);
    journeyDetails.add(journeyData['PaidUnpaid']);
    journeyDetails.add(journeyData['Description']);
    journeyDetails.add(journeyData['NumberPlate']);
    chatName = journeyData['SourcePlace'] +
        " to " +
        journeyData['DestinationPlace'] +
        " " +
        journeyData['LeaveTime'];
    var activeRequests = await FirebaseFirestore.instance
        .collection('TransporterList')
        .doc(widget.journeyID)
        .collection('ActiveRequests')
        .get();
    pendingRequests = [];
    for (var request in activeRequests.docs) {
      var email = await FirebaseFirestore.instance
          .collection('Mapping')
          .doc('Permanent')
          .collection('PhonetoMail')
          .doc(request['PhoneNumber'])
          .get();
      pendingRequests
          .add([email['Email'], request['FullName'], request['PhoneNumber']]);
    }
    var accRequests = await FirebaseFirestore.instance
        .collection('TransporterList')
        .doc(widget.journeyID)
        .collection('AcceptedRequests')
        .get();
    acceptedRequests = [];
    for (var request in accRequests.docs) {
      var email = await FirebaseFirestore.instance
          .collection('Mapping')
          .doc('Permanent')
          .collection('PhonetoMail')
          .doc(request['PhoneNumber'])
          .get();
      acceptedRequests
          .add([email['Email'], request['FullName'], request['PhoneNumber']]);
    }
    int date = int.parse(journeyDetails[0].substring(0, 2)),
        month = int.parse(journeyDetails[0].substring(3, 5)),
        year = int.parse(journeyDetails[0].substring(6));
    if (mounted) {
      int hour, minute;
      hour = utilities.getHourFromTime(journeyData['LeaveTime']);
      minute = utilities.getMinuteFromTime(journeyData['LeaveTime']);
      setState(() {
        if (pendingRequests.isNotEmpty) {
          pendingVisibility = true;
        } else {
          pendingVisibility = false;
        }
        if (acceptedRequests.isNotEmpty) {
          acceptedVisibility = true;
        } else {
          acceptedVisibility = false;
        }
        journeyDate =
            date.toString() + "/" + month.toString() + "/" + year.toString();
        journeyDay = dayofweek(date, month, year);
        journeyLeaveTime = journeyDetails[1];
        if (journeyData.data()!.containsKey('StartTime') == false) {
          // Allow to start journey from 15 before the leave time to 30 minutes after the leavetime
          int allowToStartJourneyMinutesBeforeTheLeaveTime = sharedPreferences
                  .getInt('allowToStartJourneyMinutesBeforeTheLeaveTime')
                  ?.toInt() ??
              0;
          int allowToStartJourneyMinutesAfterTheLeaveTime = sharedPreferences
                  .getInt('allowToStartJourneyMinutesAfterTheLeaveTime')
                  ?.toInt() ??
              0;
          if (DateTime(year, month, date, hour, minute)
                      .difference(DateTime.now()) <=
                  Duration(
                      minutes: allowToStartJourneyMinutesBeforeTheLeaveTime) &&
              DateTime.now()
                      .difference(DateTime(year, month, date, hour, minute)) <=
                  Duration(
                      minutes: allowToStartJourneyMinutesAfterTheLeaveTime)) {
            isAllowedToStart = true;
          } else {
            isAllowedToStart = false;
          }
        } else {
          String startTime = journeyData['StartTime'];
          DateTime startDateTime =
              utilities.getDateTimeFromFormattedString(startTime);
          if (DateTime.now()
                  .difference(startDateTime.add(const Duration(hours: 2))) >=
              const Duration()) isAllowedToComplete = true;
        }
      });
    }
  }
}
