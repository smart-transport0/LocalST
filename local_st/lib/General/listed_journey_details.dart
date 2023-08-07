import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:local_st/Chat/chat.dart';
import 'package:local_st/Data-Services/realtimeDatabaseOperations.dart';
import 'package:local_st/Data-Services/utilities.dart';
import 'package:local_st/Data-Services/validators.dart';
import 'package:local_st/Reusable/bottom_navigation_bar.dart';
import 'package:local_st/Reusable/colors.dart';
import 'package:local_st/Reusable/loading.dart';
import 'package:local_st/Reusable/navigation_bar.dart';
import 'package:local_st/Reusable/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math';

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
  List toStart = [];
  List toComplete = [];
  String journeyDate = "";
  String journeyDay = "";
  String journeyLeaveTime = "";
  String chatName = "";
  String userID = "";
  bool isAvailable = true;
  bool isAllowedToStart = false;
  bool isAllowedToDelete = false;
  bool hasStarted = false;
  bool isAllowedToComplete = false;
  bool isAllowedToEdit = false;
  late Utilities utilities;
  @override
  Widget build(BuildContext context) {
    SizeConfig sizeConfig = SizeConfig(context);
    double height = sizeConfig.screenHeight;
    double width = sizeConfig.screenWidth;
    double h = max(height, width);
    double w = min(height, width);

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
                                                fontSize: h * 0.025))),
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
                                                fontSize: h * 0.025))),
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
                                                fontSize: h * 0.025))),
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
                                                fontSize: h * 0.025))),
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
                                                fontSize: h * 0.025))),
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
                                                fontSize: h * 0.025))),
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
                                                fontSize: h * 0.025))),
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
                                                fontSize: h * 0.025))),
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
                                                fontSize: h * 0.025))),
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
                                Visibility(
                                  visible: isAllowedToEdit,
                                  child: IconButton(
                                      onPressed: () {
                                        editPopUp();
                                      },
                                      icon: const FaIcon(Icons.edit)),
                                ),
                                Visibility(
                                  visible: isAllowedToDelete,
                                  child: IconButton(
                                      onPressed: () async {
                                        // notify users
                                        // add this somewhere as log?
                                        deleteJourney();
                                        Navigator.of(context).pop();
                                      },
                                      icon: const FaIcon(Icons.delete)),
                                ),
                                IconButton(
                                    onPressed: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) => ChatUI(
                                                  widget.journeyID, chatName)));
                                    },
                                    icon: const FaIcon(Icons.chat)),
                                Visibility(
                                  // Can add time constraint
                                  visible: !hasStarted,
                                  child: IconButton(
                                    onPressed: () {
                                      switchVisibility();
                                    },
                                    icon: FaIcon(isAvailable
                                        ? Icons.visibility
                                        : Icons.visibility_off),
                                  ),
                                )
                              ]))
                        ])),
                    Visibility(
                      visible: true,
                      child: ElevatedButton(
                          child: Text('START',
                              style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: w * 0.06,
                                  color: MyColorScheme.baseColor)),
                          style: ButtonStyle(
                              elevation: MaterialStateProperty.all(15),
                              backgroundColor: MaterialStateProperty.all(
                                  MyColorScheme.darkColor),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: BorderSide(
                                          color: MyColorScheme.darkColor)))),
                          onPressed: (() async {
                            // notify users about the journey has started
                            await FirebaseFirestore.instance
                                .collection("TransporterList")
                                .doc(widget.journeyID)
                                .update({
                              "StartTime":
                                  utilities.getFormattedDateTime(DateTime.now())
                            });
                            for (var request in acceptedRequests) {
                              await FirebaseFirestore.instance
                                  .collection("UserInformation")
                                  .doc(request[2])
                                  .update({"OngoingJourney": widget.journeyID});
                            }
                            setState(() {
                              isAllowedToStart = false;
                              hasStarted = true;
                              deleteAllPendingRequests();
                            });
                          })),
                    ),
                    Visibility(
                      visible:
                          !isAllowedToStart && hasStarted && toStart.isNotEmpty,
                      child: Column(
                        children: [
                          // Add a confirmation for start
                          const Text('Start journey for passengers',
                              style: TextStyle(fontSize: 23)),
                          SizedBox(
                              width: w,
                              child: ListView.builder(
                                  primary: false,
                                  shrinkWrap: true,
                                  itemCount: toStart.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Card(
                                        child: Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                w * 0.05,
                                                h * 0.02,
                                                w * 0.05,
                                                h * 0.02),
                                            child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  Text('${toStart[index][0]}',
                                                      style: TextStyle(
                                                          fontSize: h * 0.03)),
                                                  Padding(
                                                      padding:
                                                          EdgeInsets.fromLTRB(0,
                                                              0, w * 0.03, 0),
                                                      child: IconButton(
                                                        onPressed: () => {
                                                          startJourneyForPassenger(
                                                              toStart[index][1])
                                                        },
                                                        icon: Icon(
                                                            Icons.play_arrow,
                                                            size: h * 0.03),
                                                      )),
                                                ])));
                                  })),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: !isAllowedToStart &&
                          hasStarted &&
                          toComplete.isNotEmpty,
                      child: Column(
                        children: [
                          // Add a confirmation for start
                          const Text('Complete journey for passengers',
                              style: TextStyle(fontSize: 23)),
                          SizedBox(
                              width: w,
                              child: ListView.builder(
                                  primary: false,
                                  shrinkWrap: true,
                                  itemCount: toComplete.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Card(
                                        child: Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                w * 0.05,
                                                h * 0.02,
                                                w * 0.05,
                                                h * 0.02),
                                            child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  Text(
                                                      '${toComplete[index][0]}',
                                                      style: TextStyle(
                                                          fontSize: h * 0.03)),
                                                  Padding(
                                                      padding:
                                                          EdgeInsets.fromLTRB(0,
                                                              0, w * 0.03, 0),
                                                      child: IconButton(
                                                        onPressed: () => {
                                                          completeJourneyForPassenger(
                                                              toComplete[index]
                                                                  [1])
                                                        },
                                                        icon: Icon(Icons.check,
                                                            size: h * 0.03),
                                                      )),
                                                ])));
                                  })),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: pendingVisibility,
                      child: Column(children: <Widget>[
                        Text('Pending Requests',
                            style: TextStyle(fontSize: w * 0.045)),
                        SizedBox(
                            width: width * 0.9,
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
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                          '${pendingRequests[index][1]}',
                                                          style: TextStyle(
                                                              fontSize:
                                                                  w * 0.04)),
                                                      Text(
                                                          '${pendingRequests[index][0]}',
                                                          style: TextStyle(
                                                              fontSize:
                                                                  w * 0.036)),
                                                      Text(
                                                          '${pendingRequests[index][3]} to ${pendingRequests[index][4]}',
                                                          style: TextStyle(
                                                              fontSize:
                                                                  w * 0.036))
                                                    ]),
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
                            style: TextStyle(fontSize: w * 0.045)),
                        SizedBox(
                            width: width * 0.9,
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
                                                                  w * 0.04)),
                                                      Text(
                                                          '${acceptedRequests[index][0]}',
                                                          style: TextStyle(
                                                              fontSize:
                                                                  w * 0.036)),
                                                      Text(
                                                          '${acceptedRequests[index][3]} to ${acceptedRequests[index][4]}',
                                                          style: TextStyle(
                                                              fontSize:
                                                                  w * 0.036))
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
          .collection('Requests')
          .doc(userID)
          .update({'Status': 'Accepted'});
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
        .collection('Requests')
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
    userID = sharedPreferences.getString('phoneNumber').toString();
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
    var requests = await FirebaseFirestore.instance
        .collection('TransporterList')
        .doc(widget.journeyID)
        .collection('Requests')
        .get();
    pendingRequests = [];
    acceptedRequests = [];
    if (!hasStarted) {
      for (var request in requests.docs) {
        var email = await FirebaseFirestore.instance
            .collection('Mapping')
            .doc('Permanent')
            .collection('PhonetoMail')
            .doc(request['PhoneNumber'])
            .get();
        if (request['Status'] == 'Pending') {
          pendingRequests.add([
            email['Email'],
            request['FullName'],
            request['PhoneNumber'],
            request['StartLocation'],
            request['DestinationLocation']
          ]);
        } else {
          acceptedRequests.add([
            email['Email'],
            request['FullName'],
            request['PhoneNumber'],
            request['StartLocation'],
            request['DestinationLocation']
          ]);
        }
      }
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
          isAvailable = journeyData['IsJourneyAvailable'];
          // Allow to start journey from 15 before the leave time to 30 minutes after the leavetime
          int allowToStartJourneyMinutesBeforeTheLeaveTime = sharedPreferences
                  .getInt('allowToStartJourneyMinutesBeforeTheLeaveTime')
                  ?.toInt() ??
              0;
          int allowToStartJourneyMinutesAfterTheLeaveTime = sharedPreferences
                  .getInt('allowToStartJourneyMinutesAfterTheLeaveTime')
                  ?.toInt() ??
              0;
          int allowToDeleteJourneyMinutesBeforeTheLeaveTime = sharedPreferences
                  .getInt('allowToDeleteJourneyMinutesBeforeTheLeaveTime')
                  ?.toInt() ??
              0;
          int allowToEditJourneyMinutesBeforeTheLeaveTime = sharedPreferences
                  .getInt('allowToEditJourneyMinutesBeforeTheLeaveTime')
                  ?.toInt() ??
              0;
          Duration timeLeftBeforeJourney =
              DateTime(year, month, date, hour, minute)
                  .difference(DateTime.now());
          isAllowedToStart = (timeLeftBeforeJourney <=
                  Duration(
                      minutes: allowToStartJourneyMinutesBeforeTheLeaveTime) &&
              DateTime.now()
                      .difference(DateTime(year, month, date, hour, minute)) <=
                  Duration(
                      minutes: allowToStartJourneyMinutesAfterTheLeaveTime));
          isAllowedToDelete = (timeLeftBeforeJourney >
              Duration(minutes: allowToDeleteJourneyMinutesBeforeTheLeaveTime));
          isAllowedToEdit = (timeLeftBeforeJourney >
              Duration(minutes: allowToEditJourneyMinutesBeforeTheLeaveTime));
        } else {
          String startTime = journeyData['StartTime'];
          DateTime startDateTime =
              utilities.getDateTimeFromFormattedString(startTime);
          if (DateTime.now()
                  .difference(startDateTime.add(const Duration(hours: 2))) >=
              const Duration()) {
            isAllowedToComplete = true;
          }
          hasStarted = true;
          toComplete = [];
          toStart = [];
          for (var request in requests.docs) {
            if (!request.data().containsKey('CompleteTime')) {
              if (request.data().containsKey('StartTime')) {
                toComplete.add([
                  request['FullName'],
                  request['PhoneNumber'],
                  request['StartLocation'],
                  request['DestinationLocation']
                ]);
              } else {
                toStart.add([
                  request['FullName'],
                  request['PhoneNumber'],
                  request['StartLocation'],
                  request['DestinationLocation']
                ]);
              }
            }
          }
          pendingVisibility = false;
          acceptedVisibility = false;
        }
      });
    }
  }

  void deleteAllPendingRequests() async {
    var requests = await FirebaseFirestore.instance
        .collection('TransporterList')
        .doc(widget.journeyID)
        .collection('Requests')
        .get();
    for (var request in requests.docs) {
      if (request['Status'] == 'Pending') {
        await FirebaseFirestore.instance
            .collection('TransporterList')
            .doc(widget.journeyID)
            .collection('Requests')
            .doc(request.id)
            .delete();
      }
    }
  }

  void startJourneyForPassenger(String passengerID) async {
    // Can be optimised
    await FirebaseFirestore.instance
        .collection('TransporterList')
        .doc(widget.journeyID)
        .collection('Requests')
        .doc(passengerID)
        .update({'StartTime': utilities.getFormattedDateTime(DateTime.now())});
    toComplete = [];
    toStart = [];
    var requests = await FirebaseFirestore.instance
        .collection('TransporterList')
        .doc(widget.journeyID)
        .collection('Requests')
        .get();
    for (var request in requests.docs) {
      if (!request.data().containsKey('CompleteTime')) {
        if (request.data().containsKey('StartTime')) {
          toComplete.add([
            request['FullName'],
            request['PhoneNumber'],
            request['StartLocation'],
            request['DestinationLocation']
          ]);
        } else {
          toStart.add([
            request['FullName'],
            request['PhoneNumber'],
            request['StartLocation'],
            request['DestinationLocation']
          ]);
        }
      }
    }
    setState(() {});
  }

  void completeJourneyForPassenger(String passengerID) async {
    // Can be optimised
    await FirebaseFirestore.instance
        .collection('TransporterList')
        .doc(widget.journeyID)
        .collection('Requests')
        .doc(passengerID)
        .update(
            {'CompleteTime': utilities.getFormattedDateTime(DateTime.now())});
    toComplete = [];
    toStart = [];
    var requests = await FirebaseFirestore.instance
        .collection('TransporterList')
        .doc(widget.journeyID)
        .collection('Requests')
        .get();
    await FirebaseFirestore.instance
        .collection("UserInformation")
        .doc(passengerID)
        .update({"OngoingJourney": ""});
    for (var request in requests.docs) {
      if (!request.data().containsKey('CompleteTime')) {
        if (request.data().containsKey('StartTime')) {
          toComplete.add([
            request['FullName'],
            request['PhoneNumber'],
            request['StartLocation'],
            request['DestinationLocation']
          ]);
        } else {
          toStart.add([
            request['FullName'],
            request['PhoneNumber'],
            request['StartLocation'],
            request['DestinationLocation']
          ]);
        }
      }
    }
    if (toComplete.isEmpty && toStart.isEmpty) {
      // if no passengers left to complete journey and no passengers left to
      // start journey, journey is completed, increment completed journey count
      var userData = await FirebaseFirestore.instance
          .collection('UserInformation')
          .doc(userID)
          .get();
      int totalJourneyCompleted =
          userData.data()!.containsKey('TotalJourneyCompleted')
              ? userData['TotalJourneyCompleted']
              : 0;
      await FirebaseFirestore.instance
          .collection('UserInformation')
          .doc(userID)
          .update({'TotalJourneyCompleted': totalJourneyCompleted + 1});
    }
    setState(() {});
  }

  void deleteJourney() async {
    await FirebaseFirestore.instance
        .collection('TransporterList')
        .doc(widget.journeyID)
        .delete();
  }

  void switchVisibility() async {
    await FirebaseFirestore.instance
        .collection('TransporterList')
        .doc(widget.journeyID)
        .update({'IsJourneyAvailable': !isAvailable});
    setState(() {
      isAvailable = !isAvailable;
    });
  }

  void editPopUp() {
    Utilities utilities = Utilities();
    TextEditingController availableSeatsController = TextEditingController();
    TextEditingController numberPlateController = TextEditingController();
    TextEditingController leaveTimeController = TextEditingController();
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => AlertDialog(
                title: const Text('Edit Details'),
                content: Column(children: [
                  TextField(
                      keyboardType: TextInputType.number,
                      controller: availableSeatsController,
                      decoration:
                          const InputDecoration(labelText: 'Available Seats')),
                  TextField(
                      controller: numberPlateController,
                      decoration:
                          const InputDecoration(labelText: 'Number Plate')),
                  TextFormField(
                    controller: leaveTimeController,
                    readOnly: true,
                    decoration: const InputDecoration(
                        labelText: 'Leave Time', filled: true),
                    onTap: () async {
                      TimeOfDay time = TimeOfDay.now();
                      FocusScope.of(context).requestFocus(FocusNode());
                      TimeOfDay? picked = await showTimePicker(
                          builder: (context, child) {
                            return Theme(
                                data: Theme.of(context).copyWith(
                                    colorScheme: ColorScheme.light(
                                      primary: MyColorScheme.darkColor,
                                      onPrimary: MyColorScheme.baseColor,
                                      onSurface: MyColorScheme.darkColor,
                                    ),
                                    textButtonTheme: TextButtonThemeData(
                                        style: TextButton.styleFrom(
                                            foregroundColor: MyColorScheme
                                                .darkColor // button text color
                                            ))),
                                child: child!);
                          },
                          context: context,
                          initialTime: time);
                      if (picked != null && picked != time) {
                        leaveTimeController.text = picked.toString();
                        leaveTimeController.text = picked.format(context);
                        time = picked;
                      }
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Cant be empty';
                      }
                      return null;
                    },
                  )
                ]),
                actions: <Widget>[
                  ElevatedButton(
                    child: const Text('CANCEL'),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  ElevatedButton(
                    child: const Text('UPDATE'),
                    onPressed: () async {
                      String invalidMessage = '';
                      try {
                        int availableSeats =
                            int.parse(availableSeatsController.text);
                        if (availableSeats < journeyDetails[5]) {
                          invalidMessage +=
                              'Available Seats cannot be reduced!\n';
                        }
                        if (leaveTimeController.text == '') {
                          invalidMessage += 'Leave Time cannot be empty!\n';
                        }
                        if (numberPlateController.text == '') {
                          invalidMessage += 'Number Plate cannot be empty!\n';
                        } else {
                          Validators validator = Validators();
                          if (!validator.validateNumberPlate(
                              numberPlateController.text)) {
                            invalidMessage +=
                                'Number Plate is not according to required format!\n';
                          }
                        }
                        //TODO: cannot allow more available seats than possible for a vehicle,
                        // maybe check leave time also should be atleast 2 hrs later than update time
                      } catch (e) {
                        invalidMessage += 'Inputs must have valid values!\n';
                      }
                      if (invalidMessage.isNotEmpty) {
                        utilities.alertMessage(
                            context, 'Invalid Input', invalidMessage);
                      } else {
                        await FirebaseFirestore.instance
                            .collection('TransporterList')
                            .doc(widget.journeyID)
                            .update({
                          'LeaveTime': leaveTimeController.text,
                          'AvailableSeats':
                              int.parse(availableSeatsController.text),
                          'NumberPlate': numberPlateController.text
                        });
                        journeyDetails[1] = leaveTimeController.text;
                        journeyDetails[5] =
                            int.parse(availableSeatsController.text);
                        journeyDetails[9] = numberPlateController.text;
                        setState(() {});
                        Navigator.pop(context);
                      }
                    },
                  ),
                ])));
  }
}
