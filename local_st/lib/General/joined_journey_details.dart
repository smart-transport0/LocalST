import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:local_st/Chat/chat.dart';
import 'package:local_st/Data-Services/realtimeDatabaseOperations.dart';
import 'package:local_st/Data-Services/utilities.dart';
import 'package:local_st/Reusable/bottom_navigation_bar.dart';
import 'package:local_st/Reusable/colors.dart';
import 'package:local_st/Reusable/loading.dart';
import 'package:local_st/Reusable/navigation_bar.dart';
import 'package:local_st/Reusable/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'dart:math';

class JoinedJourneyDetails extends StatefulWidget {
  final String journeyID;
  const JoinedJourneyDetails(this.journeyID, {Key? key}) : super(key: key);

  @override
  State<JoinedJourneyDetails> createState() => _JoinedJourneyDetailsState();
}

class _JoinedJourneyDetailsState extends State<JoinedJourneyDetails> {
  late SharedPreferences sharedPreferences;
  Utilities utilities = Utilities();
  TextEditingController feedbackController = TextEditingController();
  String userEmail = "";
  String journeyDate = "";
  String journeyDay = "";
  String journeyLeaveTime = "";
  String buttonValue = "JOIN";
  String chatName = "";
  String userID = "a";
  List journeyDetails = [];
  List acceptedRequests = [];
  List pendingRequests = [];
  List toStart = [];
  List toComplete = [];
  bool acceptedVisibility = true;
  bool pendingVisibility = true;
  bool hasStarted = false;
  bool hasSubmittedFeedback = false;
  bool hasCompletedJourney = false;
  double _rating = 0;
  var journeyData;

  @override
  void initState() {
    super.initState();
    initial();
  }

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
                                        child: Text('${journeyDetails[12]}',
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
                                              child: Text(
                                                  '${journeyDetails[8]}',
                                                  style: TextStyle(
                                                      fontSize: h * 0.025))),
                                        ]))
                                  ])),
                          Expanded(
                              flex: 1,
                              child: Visibility(
                                  visible: true,
                                  child: Column(children: <Widget>[
                                    IconButton(
                                        onPressed: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) => ChatUI(
                                                      widget.journeyID,
                                                      chatName)));
                                        },
                                        icon: const FaIcon(Icons.chat))
                                  ])))
                        ])),
                    Column(children: [
                      SizedBox(
                        width: width * 0.9,
                        child: Card(
                            margin:
                                EdgeInsets.fromLTRB(0, h * 0.05, 0, h * 0.03),
                            child: Padding(
                                padding: EdgeInsets.fromLTRB(
                                    w * 0.05, h * 0.02, w * 0.05, h * 0.02),
                                child: Column(children: [
                                  Padding(
                                      padding: EdgeInsets.fromLTRB(
                                          0.0, 0.0, 0.0, 0.02 * h),
                                      child: Text('TRANSPORTER DETAILS',
                                          style: TextStyle(
                                              fontSize: h * 0.02,
                                              color: Colors.grey[700],
                                              fontWeight: FontWeight.bold))),
                                  Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0.0, 0.0, 0.0, 0),
                                      child: Text(
                                          '${journeyDetails[9]} ${journeyDetails[10]}',
                                          style:
                                              TextStyle(fontSize: h * 0.025))),
                                  Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0.0, 0.0, 0.0, 0),
                                      child: Text('${journeyDetails[11]}',
                                          style:
                                              TextStyle(fontSize: h * 0.025))),
                                ]))),
                      ),
                      ElevatedButton(
                          child: Text(buttonValue,
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
                          onPressed: () => sendRequest())
                    ]),
                    Visibility(
                      // visible: hasCompletedJourney && !hasSubmittedFeedback,
                      visible: true,
                      child: TextButton(
                          onPressed: () =>
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => AlertDialog(
                                  title: const Text('Feedback'),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      RatingBar.builder(
                                        initialRating: _rating,
                                        minRating: 0,
                                        direction: Axis.horizontal,
                                        allowHalfRating: true,
                                        itemCount: 5,
                                        itemSize: 40.0,
                                        itemBuilder: (context, _) => const Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                        ),
                                        onRatingUpdate: (rating) {
                                          setState(() {
                                            _rating = rating;
                                          });
                                        },
                                      ),
                                      TextField(
                                        controller: feedbackController,
                                        decoration: const InputDecoration(
                                            hintText:
                                                "How was your travel experience?"),
                                      )
                                    ],
                                  ),
                                  actions: <Widget>[
                                    ElevatedButton(
                                      child: const Text('CANCEL',
                                          style: TextStyle(
                                              fontFamily: 'Montserrat')),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                    ElevatedButton(
                                      child: const Text('SUBMIT',
                                          style: TextStyle(
                                              fontFamily: 'Montserrat')),
                                      onPressed: () async {
                                        if (feedbackController.text != '') {
                                          await FirebaseFirestore.instance
                                              .collection('Feedback')
                                              .doc(utilities
                                                  .add91(journeyDetails[13]))
                                              .collection(widget.journeyID)
                                              .doc(userID)
                                              .set({
                                            "Rating": _rating,
                                            "Feedback": feedbackController.text
                                          });
                                          var feedbackDoc =
                                              await FirebaseFirestore.instance
                                                  .collection('Feedback')
                                                  .doc(utilities.add91(
                                                      journeyDetails[13]))
                                                  .get();
                                          double newRating = 0;
                                          int totalFeedbacks = 0;
                                          print(feedbackDoc.data());
                                          if (feedbackDoc.data() != null &&
                                              feedbackDoc.data()!.containsKey(
                                                  'AverageRating') &&
                                              feedbackDoc.data()!.containsKey(
                                                  'TotalNumberOfFeedbacks')) {
                                            print('hi');
                                            totalFeedbacks = feedbackDoc[
                                                'TotalNumberOfFeedbacks'];
                                            newRating =
                                                (feedbackDoc['AverageRating'] +
                                                        _rating) /
                                                    (totalFeedbacks + 1);
                                            await FirebaseFirestore.instance
                                                .collection('Feedback')
                                                .doc(utilities
                                                    .add91(journeyDetails[13]))
                                                .update({
                                              'AverageRating': newRating,
                                              'TotalNumberOfFeedbacks':
                                                  totalFeedbacks + 1
                                            });
                                          } else {
                                            newRating = _rating;
                                            await FirebaseFirestore.instance
                                                .collection('Feedback')
                                                .doc(utilities
                                                    .add91(journeyDetails[13]))
                                                .set({
                                              'AverageRating': newRating,
                                              'TotalNumberOfFeedbacks':
                                                  totalFeedbacks + 1
                                            });
                                          }
                                          Navigator.pop(context);
                                          setState(() {
                                            hasSubmittedFeedback = true;
                                          });
                                        } else {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      AlertDialog(
                                                          title: const Text(
                                                              'Invalid input'),
                                                          content: const Text(
                                                              'Please fill your feedback!'),
                                                          actions: <Widget>[
                                                            ElevatedButton(
                                                              child: const Text(
                                                                  'Ok'),
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                            ),
                                                          ])));
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              )),
                          child: const Text('Give Feedback')),
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
                                                    ])
                                              ])));
                                }))
                      ]),
                    ),
                    Visibility(
                      visible: true,
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
                    ),
                    Visibility(
                      visible: hasStarted,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(h * 0.03, 0, 0, 0),
                        child: Column(
                          children: [
                            Text('Passengers yet to join',
                                style: TextStyle(fontSize: w * 0.045)),
                            toStart.isNotEmpty
                                ? SizedBox(
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
                                                  child: Text(
                                                      '${toStart[index][0]}',
                                                      style: TextStyle(
                                                          fontSize:
                                                              w * 0.04))));
                                        }))
                                : Text("All passengers' journey has started",
                                    style: TextStyle(fontSize: w * 0.04)),
                            SizedBox(height: h * 0.03),
                            Text('Passengers Onboard',
                                style: TextStyle(fontSize: w * 0.045)),
                            toComplete.isNotEmpty
                                ? SizedBox(
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
                                                  child: Text(
                                                      '${toComplete[index][0]}',
                                                      style: TextStyle(
                                                          fontSize:
                                                              w * 0.04))));
                                        }))
                                : Text("All passengers' journey has completed",
                                    style: TextStyle(fontSize: w * 0.04))
                          ],
                        ),
                      ),
                    )
                  ]));
                } else {
                  return const Text('No data');
                }
              } else {
                return const Loading();
              }
            }));
  }

  void sendRequest() async {
    var data = await FirebaseFirestore.instance
        .collection('TransporterList')
        .doc(widget.journeyID)
        .get();
    if (buttonValue == 'LEAVE') {
      await FirebaseFirestore.instance
          .collection('TransporterList')
          .doc(widget.journeyID)
          .collection('Requests')
          .doc(userID)
          .delete();
      RealTimeDatabase rdb = RealTimeDatabase();
      await rdb.deleteDataIntoRTDB(
          "Chat/" + widget.journeyID + "/Members/" + userID);
      await FirebaseFirestore.instance
          .collection('TransporterList')
          .doc(widget.journeyID)
          .update({'AcceptedRequestsCount': data['AcceptedRequestsCount'] - 1});
    }
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => JoinedJourneyDetails(widget.journeyID)));
  }

  Future<List> fetchJourneyDetails() async {
    String transporterPhoneNumber = widget.journeyID.substring(0, 10);
    var transporterDetails = await FirebaseFirestore.instance
        .collection('UserInformation')
        .doc(utilities.add91(transporterPhoneNumber))
        .get();
    chatName = journeyData['SourcePlace'] +
        " to " +
        journeyData['DestinationPlace'] +
        " " +
        journeyData['LeaveTime'];
    journeyDetails.add(journeyData['JourneyDate']);
    journeyDetails.add(journeyData['LeaveTime']);
    journeyDetails.add(journeyData['SourcePlace']);
    journeyDetails.add(journeyData['DestinationPlace']);
    journeyDetails.add(journeyData['VehicleType']);
    journeyDetails.add(journeyData['AvailableSeats']);
    journeyDetails.add(journeyData['Route']);
    journeyDetails.add(journeyData['PaidUnpaid']);
    journeyDetails.add(journeyData['Description']);
    journeyDetails.add(transporterDetails['FirstName']);
    journeyDetails.add(transporterDetails['LastName']);
    journeyDetails.add(transporterDetails['OrganizationEmailID']);
    journeyDetails.add(journeyData['NumberPlate']);
    journeyDetails.add(journeyData['TransporterID']);
    var requests = await FirebaseFirestore.instance
        .collection('TransporterList')
        .doc(widget.journeyID)
        .collection('Requests')
        .get();
    pendingRequests = [];
    acceptedRequests = [];
    for (var request in requests.docs) {
      var email = await FirebaseFirestore.instance
          .collection('Mapping')
          .doc('Permanent')
          .collection('PhonetoMail')
          .doc(request['PhoneNumber'])
          .get();
      if (request['Status'] == 'Pending') {
        if (email['Email'] == userEmail) buttonValue = "PENDING";
        pendingRequests.add([
          email['Email'],
          request['FullName'],
          request['PhoneNumber'],
          request['StartLocation'],
          request['DestinationLocation']
        ]);
      } else {
        if (email['Email'] == userEmail) buttonValue = "LEAVE";
        acceptedRequests.add([
          email['Email'],
          request['FullName'],
          request['PhoneNumber'],
          request['StartLocation'],
          request['DestinationLocation']
        ]);
      }
    }
    toStart = [];
    toComplete = [];
    if (journeyData.data()!.containsKey('StartTime')) {
      hasStarted = true;
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
          // update hasCompletedJourney and hasSubmittedFeedback
        } else {
          if (request['PhoneNumber'] == userID) {
            hasCompletedJourney = true;
          }
        }
      }
    }
    int year = int.parse(journeyDetails[0].substring(0, 2)),
        month = int.parse(journeyDetails[0].substring(3, 5)),
        date = int.parse(journeyDetails[0].substring(6));
    if (mounted) {
      setState(() {
        if (hasStarted) {
          acceptedVisibility = false;
          pendingVisibility = false;
        } else {
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
        }
        journeyDate =
            date.toString() + "/" + month.toString() + "/" + year.toString();
        journeyDay = dayofweek(date, month, year);
        journeyLeaveTime = journeyDetails[1];
      });
    }
    return journeyDetails;
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

  Future<void> initial() async {
    sharedPreferences = await SharedPreferences.getInstance();
    userEmail = sharedPreferences.getString('email')!;
    userID = sharedPreferences.getString("phoneNumber")!;
    journeyData = await FirebaseFirestore.instance
        .collection('TransporterList')
        .doc(widget.journeyID)
        .get();
    var feedbackStatus = await FirebaseFirestore.instance
        .collection('Feedback')
        .doc(utilities.add91(journeyData['TransporterID']))
        .collection(widget.journeyID)
        .doc(userID)
        .get();
    if (feedbackStatus.exists) hasSubmittedFeedback = true;
    if (mounted) {
      setState(() {});
    }
  }
}
