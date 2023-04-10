import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:local_st/Data-Services/utilities.dart';
import 'package:local_st/General/joined_journey_details.dart';
import 'package:local_st/Reusable/bottom_navigation_bar.dart';
import 'package:local_st/Reusable/loading.dart';
import 'package:local_st/Reusable/navigation_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class JoinedJourneys extends StatefulWidget {
  const JoinedJourneys({Key? key}) : super(key: key);

  @override
  State<JoinedJourneys> createState() => _JoinedJourneysState();
}

class _JoinedJourneysState extends State<JoinedJourneys> {
  @override
  void initState() {
    super.initState();
    initial();
  }

  late SharedPreferences sharedPreferences;
  String userID = "";
  Utilities utilities = Utilities();
  // List joinedJourneys = [];
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Joined Journeys',
          ),
          centerTitle: true,
          backgroundColor: Colors.black,
          elevation: 0,
        ),
        drawer: const NavBar(),
        bottomNavigationBar: BottomNavBar(1),
        body: FutureBuilder<List>(
          future: fetchJoinedJourneys(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Loading();
            } else if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                if (snapshot.data!.isEmpty) {
                  return Center(
                    child: Text('No joined journeys yet',
                        style: TextStyle(fontSize: h * 0.04),
                        textAlign: TextAlign.center),
                  );
                }
                return ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    itemCount: snapshot.data?.length,
                    itemBuilder: (context, index) {
                      return SizedBox(
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
                                                    JoinedJourneyDetails(
                                                        snapshot.data?[index]
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
                                                'Date ${snapshot.data?[index][0]}',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w900,
                                                    color:
                                                        Colors.blue.shade900)),
                                            Row(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      0, 0, w * 0.03, 0),
                                                  child: Container(
                                                      width: 25,
                                                      height: 25,
                                                      decoration:
                                                          const BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: Colors.red,
                                                      ),
                                                      child: Center(
                                                          child: Text(
                                                        '${snapshot.data?[index][5]}',
                                                        style: const TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w900),
                                                      ))),
                                                ),
                                                Container(
                                                    width: 25,
                                                    height: 25,
                                                    decoration:
                                                        const BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: Colors.green,
                                                    ),
                                                    child: Center(
                                                        child: Text(
                                                      '${snapshot.data?[index][4]}',
                                                      style: const TextStyle(
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
                                            const Text('Source Place'),
                                            Text(
                                              '${snapshot.data?[index][1]}',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w900,
                                                  color: Colors.blue.shade900),
                                            ),
                                            SizedBox(height: h * 0.01),
                                            const Text('Destination Place'),
                                            Text(
                                              '${snapshot.data?[index][2]}',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w900,
                                                  color: Colors.blue.shade900),
                                            ),
                                            SizedBox(height: h * 0.01),
                                            const Text('Transporter Name'),
                                            Text(
                                              '${snapshot.data?[index][6]}',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w900,
                                                  color: Colors.blue.shade900),
                                            )
                                          ])
                                    ]),
                                  ))));
                    });
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Error! Fetching Data',
                      style: TextStyle(fontSize: h * 0.04),
                      textAlign: TextAlign.center),
                );
              } else {
                return Center(
                  child: Text('No joined journeys yet :(',
                      style: TextStyle(fontSize: h * 0.04),
                      textAlign: TextAlign.center),
                );
              }
            } else {
              return Center(
                child: Text('No joined journeys yet :(',
                    style: TextStyle(fontSize: h * 0.04),
                    textAlign: TextAlign.center),
              );
            }
          },
        ));
  }

  Future<List> fetchJoinedJourneys() async {
    List joinedJourneys = [];
    var collectionObject =
        FirebaseFirestore.instance.collection('TransporterList');
    var result = await collectionObject.get();
    for (var res in result.docs) {
      String temp = res.id.substring(0, 10);
      if (temp != userID) {
        var acceptedReqs = await collectionObject
            .doc(res.id)
            .collection('AcceptedRequests')
            .doc(utilities.add91(userID))
            .get();

        if (acceptedReqs.exists) {
          var transporterInfo = await FirebaseFirestore.instance
              .collection('UserInformation')
              .doc(utilities.add91(temp))
              .get();
          String transporterName =
              transporterInfo['FirstName'] + ' ' + transporterInfo['LastName'];
          joinedJourneys.add([
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
    return joinedJourneys;
  }

  Future<void> initial() async {
    sharedPreferences = await SharedPreferences.getInstance();
    userID = utilities
        .remove91(sharedPreferences.getString('phoneNumber').toString());
  }
}
