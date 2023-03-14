import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:local_st/Data-Services/utilities.dart';
import 'package:local_st/General/availableJourneyDetails.dart';
import 'package:local_st/General/listedJourneyDetails.dart';
import 'package:local_st/General/startNewJourney.dart';
import 'package:local_st/Reusable/bottomNavigationBar.dart';
import 'package:local_st/Reusable/colors.dart';
import 'package:local_st/Reusable/navigationBar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ListedJourney extends StatefulWidget {
  const ListedJourney({Key? key}) : super(key: key);

  @override
  State<ListedJourney> createState() => _ListedJourneyState();
}

class _ListedJourneyState extends State<ListedJourney> {
  Utilities utilities = Utilities();
  var listedJourneys = [];
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
          title: const Text('Your Listed Journeys'),
          centerTitle: true,
          backgroundColor: Colors.black,
          elevation: 0),
      drawer: NavBar(),
      bottomNavigationBar: BottomNavBar(2),
      floatingActionButton: Visibility(
        child: new FloatingActionButton(
            child: new Icon(Icons.add, color: Colors.red, size: h * 0.04),
            backgroundColor: MyColorScheme.bgColor,
            onPressed: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => StartNewJourney()));
            }),
      ),
      body: Container(
        child: FutureBuilder(
          future: fetchListedJourneys(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (listedJourneys.length == 0) {
                return Center(
                  child: Text('You have not listed any journeys yet :(',
                      style: TextStyle(fontSize: h * 0.04),
                      textAlign: TextAlign.center),
                );
              } else {
                return ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemCount: listedJourneys.length,
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
                                                  ListedJourneyDetails(
                                                      listedJourneys[index]
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
                                              'Date ' +
                                                  '${listedJourneys[index][0]}',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w900,
                                                  color: Colors.blue.shade900)),
                                          Row(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    0, 0, w * 0.03, 0),
                                                child: Container(
                                                    width: 25,
                                                    height: 25,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: Colors.red,
                                                    ),
                                                    child: Center(
                                                        child: Text(
                                                      '${listedJourneys[index][5]}',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w900),
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
                                                    '${listedJourneys[index][4]}',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w900),
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
                                            '${listedJourneys[index][1]}',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w900,
                                                color: Colors.blue.shade900),
                                          ),
                                          SizedBox(height: h * 0.01),
                                          Text('Destination Place'),
                                          Text(
                                            '${listedJourneys[index][2]}',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w900,
                                                color: Colors.blue.shade900),
                                          )
                                        ])
                                  ]),
                                ))),
                      );
                    });
              }
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }

  Future<List> fetchListedJourneys() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    listedJourneys = [];
    String userID = utilities
        .remove91(sharedPreferences.getString('phoneNumber').toString());
    var result =
        await FirebaseFirestore.instance.collection('TransporterList').get();
    for (var res in result.docs) {
      String temp = res.id.substring(0, 10);
      if (temp == userID) {
        listedJourneys.add([
          res['JourneyDate'],
          res['SourcePlace'],
          res['DestinationPlace'],
          res.id,
          res['AcceptedRequestsCount'],
          res['PendingRequestsCount']
        ]);
      }
    }
    return listedJourneys;
  }
}
