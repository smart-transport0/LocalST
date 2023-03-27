import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:local_st/Data-Services/utilities.dart';
import 'package:local_st/Reusable/bottomNavigationBar.dart';
import 'package:local_st/Reusable/colors.dart';
import 'package:local_st/Reusable/loading.dart';
import 'package:local_st/Reusable/navigationBar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class JoinedJourneyDetails extends StatefulWidget {
  String journeyID = "";
  JoinedJourneyDetails(String journeyID) {
    this.journeyID = journeyID;
  }

  @override
  State<JoinedJourneyDetails> createState() => _JoinedJourneyDetailsState();
}

class _JoinedJourneyDetailsState extends State<JoinedJourneyDetails> {
  @override
  late SharedPreferences sharedPreferences;
  Utilities utilities = Utilities();
  String userEmail = "";
  String journeyDate = "";
  String journeyDay = "";
  String journeyLeaveTime = "";
  String buttonValue = "Join";
  List journeyDetails = [];
  List acceptedRequests = [];
  List pendingRequests = [];
  bool acceptedVisibility = true;
  bool pendingVisibility = true;

  void initState() {
    super.initState();
    initial();
  }

  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
            title: Text('${journeyDate} ${journeyLeaveTime}'),
            centerTitle: true,
            backgroundColor: Colors.black,
            elevation: 0),
        drawer: NavBar(),
        bottomNavigationBar: BottomNavBar(2),
        body: FutureBuilder(
            future: fetchJourneyDetails(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (journeyDetails.length > 0) {
                  return SingleChildScrollView(
                      child: Column(children: <Widget>[
                    Container(
                        child: Container(
                            padding: EdgeInsets.fromLTRB(
                                w * 0.03, h * 0.04, 0, h * 0.04),
                            color: MyColorScheme.bgColor,
                            child: Row(children: <Widget>[
                              Expanded(
                                  flex: 4,
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                0.0, 0.0, 0.0, h * 0.005),
                                            child: Text('SCHEDULED ON',
                                                style: TextStyle(
                                                    color: Colors.grey[700],
                                                    fontSize: h * 0.02,
                                                    fontWeight:
                                                        FontWeight.bold))),
                                        Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                0.0, 0.0, 0.0, h * 0.02),
                                            child: Text(
                                                '${journeyDetails[0]} ${journeyDay}',
                                                style: TextStyle(
                                                    fontSize: h * 0.034))),
                                        Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                0.0, 0.0, 0.0, h * 0.005),
                                            child: Text('LEAVE TIME',
                                                style: TextStyle(
                                                    color: Colors.grey[700],
                                                    fontSize: h * 0.02,
                                                    fontWeight:
                                                        FontWeight.bold))),
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
                                                    fontWeight:
                                                        FontWeight.bold))),
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
                                                    fontWeight:
                                                        FontWeight.bold))),
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
                                                    fontWeight:
                                                        FontWeight.bold))),
                                        Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                0.0, 0.0, 0.0, h * 0.02),
                                            child: Text('${journeyDetails[12]}',
                                                style: TextStyle(
                                                    fontSize: h * 0.034))),
                                        Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                0.0, 0.0, 0.0, h * 0.005),
                                            child: Text('VEHICLE TYPE',
                                                style: TextStyle(
                                                    color: Colors.grey[700],
                                                    fontSize: h * 0.02,
                                                    fontWeight:
                                                        FontWeight.bold))),
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
                                                    fontWeight:
                                                        FontWeight.bold))),
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
                                                    fontWeight:
                                                        FontWeight.bold))),
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
                                                    fontWeight:
                                                        FontWeight.bold))),
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
                                                          color:
                                                              Colors.grey[700],
                                                          fontSize: h * 0.02,
                                                          fontWeight: FontWeight
                                                              .bold))),
                                              Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      0.0, 0.0, 0.0, h * 0.02),
                                                  child: Text(
                                                      '${journeyDetails[8]}',
                                                      style: TextStyle(
                                                          fontSize:
                                                              h * 0.025))),
                                            ]))
                                      ])),
                              Expanded(
                                  flex: 1,
                                  child: Visibility(
                                      visible: false,
                                      child: Column(children: <Widget>[
                                        IconButton(
                                            onPressed: () {},
                                            icon: const FaIcon(
                                                Icons.notifications_off)),
                                        IconButton(
                                            onPressed: () {},
                                            icon: const FaIcon(Icons.chat)),
                                        IconButton(
                                            onPressed: () {},
                                            icon: const FaIcon(Icons.check_box))
                                      ])))
                            ]))),
                    Container(
                        child: Column(children: [
                      Card(
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
                                    padding:
                                        EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0),
                                    child: Text(
                                        '${journeyDetails[9]} ${journeyDetails[10]}',
                                        style: TextStyle(fontSize: h * 0.03))),
                                Padding(
                                    padding:
                                        EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0),
                                    child: Text('${journeyDetails[11]}',
                                        style: TextStyle(fontSize: h * 0.03))),
                              ]))),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, h * 0.01, 0, 0),
                        child: ElevatedButton(
                            child: Text('${buttonValue}',
                                style: TextStyle(
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
                            onPressed: () => sendRequest()),
                      )
                    ])),
                    Visibility(
                      visible: pendingVisibility,
                      child: Column(children: <Widget>[
                        Text('Pending Requests',
                            style: TextStyle(fontSize: h * 0.035)),
                        Container(
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
                                                        CrossAxisAlignment
                                                            .start,
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
                        Container(
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
                  return Text('No data');
                }
              } else {
                return Loading();
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
    if (buttonValue == 'Join') {
      await FirebaseFirestore.instance
          .collection('TransporterList')
          .doc(widget.journeyID)
          .collection('ActiveRequests')
          .doc(userID)
          .set({
        'PhoneNumber': userID,
        'FullName': userName,
        'TimeStamp': utilities.padCharacters(datetime.day.toString(), "0", 2) +
            utilities.padCharacters(datetime.month.toString(), "0", 2) +
            utilities.padCharacters(datetime.year.toString(), "0", 4) +
            utilities.padCharacters(datetime.hour.toString(), "0", 2) +
            utilities.padCharacters(datetime.minute.toString(), "0", 2) +
            utilities.padCharacters(datetime.second.toString(), "0", 2)
      });
      await FirebaseFirestore.instance
          .collection('TransporterList')
          .doc(widget.journeyID)
          .update({
        'PendingRequestsCount': data['PendingRequestsCount'] + 1
      });
    } else if (buttonValue == 'Leave') {
      await FirebaseFirestore.instance
          .collection('TransporterList')
          .doc(widget.journeyID)
          .collection('AcceptedRequests')
          .doc(userID)
          .delete();
      await FirebaseFirestore.instance
          .collection('TransporterList')
          .doc(widget.journeyID)
          .update({'AcceptedRequestsCount': data['AcceptedRequestsCount'] - 1});
    }
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => JoinedJourneyDetails(widget.journeyID)));
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
      if (email['Email'] == userEmail) buttonValue = "Pending";
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
      if (email['Email'] == userEmail) buttonValue = "Leave";
      acceptedRequests
          .add([email['Email'], request['FullName'], request['PhoneNumber']]);
    }
    int year = int.parse(journeyDetails[0].substring(0, 2)),
        month = int.parse(journeyDetails[0].substring(3, 5)),
        date = int.parse(journeyDetails[0].substring(6));
    if (this.mounted) {
      setState(() {
        if (pendingRequests.length > 0)
          pendingVisibility = true;
        else
          pendingVisibility = false;
        if (acceptedRequests.length > 0)
          acceptedVisibility = true;
        else
          acceptedVisibility = false;
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
    if (ans == 0)
      return "Sunday";
    else if (ans == 1)
      return "Monday";
    else if (ans == 2)
      return "Tuesday";
    else if (ans == 3)
      return "Wednesday";
    else if (ans == 4)
      return "Thursday";
    else if (ans == 5)
      return "Friday";
    else
      return "Saturday";
  }

  Future<void> initial() async {
    sharedPreferences = await SharedPreferences.getInstance();
    userEmail = sharedPreferences.getString('email')!;
  }
}
