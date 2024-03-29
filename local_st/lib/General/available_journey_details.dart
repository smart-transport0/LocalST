import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:local_st/Data-Services/utilities.dart';
import 'package:local_st/Reusable/bottom_navigation_bar.dart';
import 'package:local_st/Reusable/colors.dart';
import 'package:local_st/Reusable/loading.dart';
import 'package:local_st/Reusable/navigation_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Reusable/size_config.dart';
import 'dart:math';

class AvailableJourneyDetails extends StatefulWidget {
  final String journeyID;
  const AvailableJourneyDetails(this.journeyID, {Key? key}) : super(key: key);

  @override
  State<AvailableJourneyDetails> createState() =>
      _AvailableJourneyDetailsState();
}

class _AvailableJourneyDetailsState extends State<AvailableJourneyDetails> {
  late SharedPreferences sharedPreferences;
  Utilities utilities = Utilities();
  String userEmail = "";
  String journeyDate = "";
  String journeyDay = "";
  String journeyLeaveTime = "";
  String buttonValue = "JOIN";
  List journeyDetails = [];
  List acceptedRequests = [];
  List pendingRequests = [];
  bool acceptedVisibility = true;
  bool pendingVisibility = true;
  TextEditingController startLocationController = TextEditingController();
  TextEditingController destinationLocationController = TextEditingController();
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
                                  visible: false,
                                  child: Column(children: <Widget>[
                                    IconButton(
                                        onPressed: () {},
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
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, h * 0.01, 0, 0),
                        child: ElevatedButton(
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
                                        borderRadius:
                                            BorderRadius.circular(18.0),
                                        side: BorderSide(
                                            color: MyColorScheme.darkColor)))),
                            onPressed: () => {
                                  buttonValue == 'JOIN'
                                      ? Navigator.of(context)
                                          .push(MaterialPageRoute(
                                          builder: (context) => AlertDialog(
                                            title:
                                                const Text('Passenger Details'),
                                            content: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                TextField(
                                                  controller:
                                                      startLocationController,
                                                  decoration: const InputDecoration(
                                                      hintText:
                                                          "Precise location where you will join transporter"),
                                                ),
                                                TextField(
                                                  controller:
                                                      destinationLocationController,
                                                  decoration: const InputDecoration(
                                                      hintText:
                                                          "Precise location where you will drop off"),
                                                ),
                                              ],
                                            ),
                                            actions: <Widget>[
                                              ElevatedButton(
                                                child: const Text('CANCEL'),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                              ),
                                              ElevatedButton(
                                                child:
                                                    const Text('Send Request'),
                                                onPressed: () {
                                                  if (startLocationController
                                                              .text !=
                                                          '' &&
                                                      destinationLocationController
                                                              .text !=
                                                          '') {
                                                    sendRequest();
                                                  } else {
                                                    Navigator.of(context).push(
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                AlertDialog(
                                                                    title: const Text(
                                                                        'Invalid Input'),
                                                                    content: Column(
                                                                        mainAxisSize:
                                                                            MainAxisSize.min,
                                                                        children: const [
                                                                          Text(
                                                                              'Please enter valid start location and destination location!')
                                                                        ]),
                                                                    actions: <
                                                                        Widget>[
                                                                      ElevatedButton(
                                                                        child: const Text(
                                                                            'OK'),
                                                                        onPressed:
                                                                            () {
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
                                        ))
                                      : sendRequest()
                                }),
                      )
                    ]),
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
                                                    ])
                                              ])));
                                }))
                      ]),
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
    var userID = sharedPreferences.getString("phoneNumber");
    var userName = sharedPreferences.getString("userName");
    DateTime datetime = DateTime.now();
    var data = await FirebaseFirestore.instance
        .collection('TransporterList')
        .doc(widget.journeyID)
        .get();
    if (buttonValue == 'JOIN') {
      await FirebaseFirestore.instance
          .collection('TransporterList')
          .doc(widget.journeyID)
          .collection('Requests')
          .doc(userID)
          .set({
        'PhoneNumber': userID,
        'FullName': userName,
        'TimeStamp': utilities.getFormattedDateTime(datetime),
        'StartLocation': startLocationController.text,
        'DestinationLocation': destinationLocationController.text,
        'Status': 'Pending'
      });
      await FirebaseFirestore.instance
          .collection('TransporterList')
          .doc(widget.journeyID)
          .update({'PendingRequestsCount': data['PendingRequestsCount'] + 1});
      setState(() {
        buttonValue = 'PENDING';
      });
    } else if (buttonValue == 'LEAVE') {
      await FirebaseFirestore.instance
          .collection('TransporterList')
          .doc(widget.journeyID)
          .collection('Requests')
          .doc(userID)
          .delete();
      await FirebaseFirestore.instance
          .collection('TransporterList')
          .doc(widget.journeyID)
          .update({'AcceptedRequestsCount': data['AcceptedRequestsCount'] - 1});
      setState(() {
        buttonValue = 'JOIN';
      });
    }
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => AvailableJourneyDetails(widget.journeyID)));
  }

  Future<List> fetchJourneyDetails() async {
    var journeyData = await FirebaseFirestore.instance
        .collection('TransporterList')
        .doc(widget.journeyID)
        .get();
    String transporterPhoneNumber = widget.journeyID.substring(0, 10);
    var transporterDetails = await FirebaseFirestore.instance
        .collection('UserInformation')
        .doc(utilities.add91(transporterPhoneNumber))
        .get();
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
        pendingRequests
            .add([email['Email'], request['FullName'], request['PhoneNumber']]);
      } else {
        if (email['Email'] == userEmail) buttonValue = "LEAVE";
        acceptedRequests
            .add([email['Email'], request['FullName'], request['PhoneNumber']]);
      }
    }

    int year = int.parse(journeyDetails[0].substring(0, 2)),
        month = int.parse(journeyDetails[0].substring(3, 5)),
        date = int.parse(journeyDetails[0].substring(6));
    if (mounted) {
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
  }
}
