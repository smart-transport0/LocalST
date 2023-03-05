import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:local_st/Data-Services/utilities.dart';
import 'package:local_st/General/availableJourneyDetails.dart';
import 'package:local_st/General/listedJourneyDetails.dart';
import 'package:local_st/Reusable/bottomNavigationBar.dart';
import 'package:local_st/Reusable/navigationBar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AvailableJourneys extends StatefulWidget {
  const AvailableJourneys({Key? key}) : super(key: key);

  @override
  State<AvailableJourneys> createState() => _AvailableJourneysState();
}

class _AvailableJourneysState extends State<AvailableJourneys> {
  @override
  Utilities utilities = Utilities();
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
                if (availableJourneys.length == 0) {
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
                                                  'Date ' +
                                                      '${availableJourneys[index][0]}',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w900,
                                                      color: Colors
                                                          .blue.shade900)),
                                              Container(
                                                  width: 25,
                                                  height: 25,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Colors.red,
                                                  ),
                                                  child: Center(
                                                      child: Text(
                                                    '10',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w900),
                                                  ))),
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

  Future<List> fetchAvailableJourneys() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    availableJourneys = [];
    String userID = utilities
        .remove91(sharedPreferences.getString('phoneNumber').toString());
    var result =
        await FirebaseFirestore.instance.collection('TransporterList').get();
    result.docs.forEach((res) {
      String temp = res.id.substring(0, 10);
      if (temp != userID) {
        availableJourneys.add([
          res['JourneyDate'],
          res['SourcePlace'],
          res['DestinationPlace'],
          res.id
        ]);
      }
    });
    return availableJourneys;
  }
}
