import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:local_st/Data-Services/utilities.dart';
import 'package:local_st/General/availableJourneyDetails.dart';
import 'package:local_st/Reusable/bottomNavigationBar.dart';
import 'package:local_st/Reusable/navigationBar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class JoinedJourneys extends StatefulWidget {
  const JoinedJourneys({Key? key}) : super(key: key);

  @override
  State<JoinedJourneys> createState() => _JoinedJourneysState();
}

class _JoinedJourneysState extends State<JoinedJourneys> {
  @override
  late SharedPreferences sharedPreferences;
  String userID = "";
  Utilities utilities = Utilities();
  List joinedJourneys = [];
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Joined Journeys',
          ),
          centerTitle: true,
          backgroundColor: Colors.black,
          elevation: 0,
        ),
        drawer: NavBar(),
        bottomNavigationBar: BottomNavBar(1),
        body: Container(
          child: FutureBuilder(
            future: fetchJoinedJourneys(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (joinedJourneys.isEmpty) {
                  return Center(
                    child: Text('No joined journeys yet :(',
                        style: TextStyle(fontSize: h * 0.04),
                        textAlign: TextAlign.center),
                  );
                } else {
                  return ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemCount: joinedJourneys.length,
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
                                                          joinedJourneys[index]
                                                              [3])))
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
                                                  'Date ${joinedJourneys[index][0]}',
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
                                                          '${joinedJourneys[index][5]}',
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
                                                        '${joinedJourneys[index][4]}',
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
                                                '${joinedJourneys[index][1]}',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w900,
                                                    color:
                                                        Colors.blue.shade900),
                                              ),
                                              SizedBox(height: h * 0.01),
                                              Text('Destination Place'),
                                              Text(
                                                '${joinedJourneys[index][2]}',
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
                return CircularProgressIndicator();
              }
            },
          ),
        ));
  }

  Future<List> fetchJoinedJourneys() async {
    if (joinedJourneys.isNotEmpty) joinedJourneys.clear();
    var collectionObject =
        FirebaseFirestore.instance.collection('TransporterList');
    var result = await collectionObject.get();
    for (var res in result.docs) {
      String temp = res.id.substring(0, 10);
      if (temp != userID) {
        joinedJourneys.add([
          res['JourneyDate'],
          res['SourcePlace'],
          res['DestinationPlace'],
          res.id,
          res['AcceptedRequestsCount'],
          res['PendingRequestsCount']
        ]);
      }
    }
    return joinedJourneys;
  }

  Future<void> initial() async {
    sharedPreferences = await SharedPreferences.getInstance();
    userID = utilities
        .remove91(sharedPreferences.getString('phoneNumber').toString());
  }
}
