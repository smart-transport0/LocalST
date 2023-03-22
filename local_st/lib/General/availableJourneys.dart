import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:local_st/Data-Services/utilities.dart';
import 'package:local_st/General/availableJourneyDetails.dart';
import 'package:local_st/Reusable/bottomNavigationBar.dart';
import 'package:local_st/Reusable/loading.dart';
import 'package:local_st/Reusable/navigationBar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AvailableJourneys extends StatefulWidget {
  const AvailableJourneys({Key? key}) : super(key: key);

  @override
  State<AvailableJourneys> createState() => _AvailableJourneysState();
}

class _AvailableJourneysState extends State<AvailableJourneys> {
  @override
  void initState() {
    super.initState();
    initial();
  }

  Utilities utilities = Utilities();
  late SharedPreferences sharedPreferences;
  String userID = "";
  List availableJourneys = [];
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Available Journeys',
          ),
          centerTitle: true,
          backgroundColor: Colors.black,
          elevation: 0,
        ),
        drawer: NavBar(),
        bottomNavigationBar: BottomNavBar(1),
        body: Container(
          child: FutureBuilder(
            future: fetchAvailableJourneys(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (availableJourneys.isEmpty) {
                  return Center(
                    child: Text('No available journeys yet :(',
                        style: TextStyle(fontSize: h * 0.04),
                        textAlign: TextAlign.center),
                  );
                } else {
                  return ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemCount: availableJourneys.length,
                      itemBuilder: (context, index) {
                        return Container(
                            width: w * 0.85,
                            child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                color: Colors.white70,
                                child: ListTile(
                                    onTap: () => {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      AvailableJourneyDetails(
                                                          availableJourneys[
                                                              index][3])))
                                        },
                                    title: Padding(
                                      padding: EdgeInsets.fromLTRB(
                                          0.0, h * 0.03, 0.0, h * 0.03),
                                      child: Column(children: <Widget>[
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: <Widget>[
                                              Text(
                                                  'Date ${availableJourneys[index][0]}',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w900,
                                                      color: Colors
                                                          .blue.shade900)),
                                              Row(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            0, 0, w * 0.03, 0),
                                                    child: Container(
                                                        width: 25,
                                                        height: 25,
                                                        decoration:
                                                            BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          color: Colors.red,
                                                        ),
                                                        child: Center(
                                                            child: Text(
                                                          '${availableJourneys[index][5]}',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w900),
                                                        ))),
                                                  ),
                                                  Container(
                                                      width: 25,
                                                      height: 25,
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: Colors.green,
                                                      ),
                                                      child: Center(
                                                          child: Text(
                                                        '${availableJourneys[index][4]}',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w900),
                                                      ))),
                                                ],
                                              ),
                                            ]),
                                        SizedBox(height: h * 0.01),
                                        Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: <Widget>[
                                              Text('Source Place'),
                                              Text(
                                                '${availableJourneys[index][1]}',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w900,
                                                    color:
                                                        Colors.blue.shade900),
                                              ),
                                              SizedBox(height: h * 0.01),
                                              Text('Destination Place'),
                                              Text(
                                                '${availableJourneys[index][2]}',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w900,
                                                    color:
                                                        Colors.blue.shade900),
                                              ),
                                              SizedBox(height: h * 0.01),
                                              Text('Transporter Name'),
                                              Text(
                                                '${availableJourneys[index][6]}',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w900,
                                                    color:
                                                        Colors.blue.shade900),
                                              )
                                            ])
                                      ]),
                                    ))));
                      });
                }
              } else {
                return Loading();
              }
            },
          ),
        ));
  }

  Future<List> fetchAvailableJourneys() async {
    if (availableJourneys.isNotEmpty) availableJourneys.clear();
    var result =
        await FirebaseFirestore.instance.collection('TransporterList').get();
    for (var res in result.docs) {
      String temp = res.id.substring(0, 10);
      if (temp != userID) {
        if (res['AvailableSeats'] > res['AcceptedRequestsCount']) {
          var transporterInfo = await FirebaseFirestore.instance
              .collection('UserInformation')
              .doc(utilities.add91(temp))
              .get();
          String transporterName =
              transporterInfo['FirstName'] + ' ' + transporterInfo['LastName'];
          // Add a constraint to check time limit and if user is already a member
          availableJourneys.add([
            res['JourneyDate'],
            res['SourcePlace'],
            res['DestinationPlace'],
            res.id,
            res['AcceptedRequestsCount'],
            res['PendingRequestsCount'],
            transporterName
          ]);
        }
      }
    }
    return availableJourneys;
  }

  Future<void> initial() async {
    sharedPreferences = await SharedPreferences.getInstance();
    userID = utilities
        .remove91(sharedPreferences.getString('phoneNumber').toString());
  }
}
