import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:local_st/Reusable/bottomNavigationBar.dart';
import 'package:local_st/Reusable/colors.dart';
import 'package:local_st/Reusable/navigationBar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ListedJourneyDetails extends StatefulWidget {
  String journeyID = "";
  ListedJourneyDetails(String journeyID) {
    this.journeyID = journeyID;
  }
  @override
  State<ListedJourneyDetails> createState() => _ListedJourneyDetailsState();
}

class _ListedJourneyDetailsState extends State<ListedJourneyDetails> {
  void initState() {
    super.initState();
    initial();
  }

  @override
  late SharedPreferences sharedPreferences;
  bool pendingVisibility = false;
  bool acceptedVisibility = false;
  List journeyDetails = [];
  List pendingRequests = [];
  List acceptedRequests = [];
  String journeyDate = "";
  String journeyDay = "";
  String journeyLeaveTime = "";
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
                                        icon: const FaIcon(
                                            Icons.notifications_off)),
                                    IconButton(
                                        onPressed: () {},
                                        icon: const FaIcon(Icons.chat)),
                                    IconButton(
                                        onPressed: () {},
                                        icon: const FaIcon(Icons.check_box))
                                  ]))
                            ]))),
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
                  return CircularProgressIndicator();
                }
              } else {
                return CircularProgressIndicator();
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
    await FirebaseFirestore.instance
        .collection('TransporterList')
        .doc(widget.journeyID)
        .update({'PendingRequestsCount' : data['PendingRequestsCount'] - 1, 
                 'AcceptedRequestsCount': data['AcceptedRequestsCount'] + 1});
    await FirebaseFirestore.instance
        .collection('TransporterList')
        .doc(widget.journeyID)
        .collection('ActiveRequests')
        .doc(userID)
        .delete();
    setState(() {
      initial();
    });
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

  Future<List> fetchJourneyDetails() async {
    return journeyDetails;
  }

  Future<void> initial() async {
    sharedPreferences = await SharedPreferences.getInstance();
    var phoneNumber = sharedPreferences.getString('phoneNumber');
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
    int year = int.parse(journeyDetails[0].substring(0, 2)),
        month = int.parse(journeyDetails[0].substring(3, 5)),
        date = int.parse(journeyDetails[0].substring(6));
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
}
