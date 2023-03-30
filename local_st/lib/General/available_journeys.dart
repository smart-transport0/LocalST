import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:local_st/Data-Services/utilities.dart';
import 'package:local_st/General/available_journey_details.dart';
import 'package:local_st/Reusable/bottom_navigation_bar.dart';
import 'package:local_st/Reusable/loading.dart';
import 'package:local_st/Reusable/navigation_bar.dart';

class AvailableJourneys extends StatefulWidget {
  final String userID;
  const AvailableJourneys({Key? key, required this.userID}) : super(key: key);
  @override
  State<AvailableJourneys> createState() => _AvailableJourneysState();
}

class _AvailableJourneysState extends State<AvailableJourneys> {
  Utilities utilities = Utilities();
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Available Journeys',
          ),
          centerTitle: true,
          backgroundColor: Colors.black,
          elevation: 0,
        ),
        drawer: const NavBar(),
        bottomNavigationBar: BottomNavBar(1),
        body: StreamBuilder(
          stream: fetchAvailableJourneysStream(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.active &&
                snapshot.hasData) {
              if (snapshot.data!.docs.isEmpty) {
                return Center(
                  child: Text('No available journeys yet :(',
                      style: TextStyle(fontSize: h * 0.04),
                      textAlign: TextAlign.center),
                );
              } else {
                return ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    itemCount: snapshot.data?.docs.length,
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
                                                    AvailableJourneyDetails(
                                                        snapshot.data!
                                                            .docs[index].id)))
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
                                                'Date ${snapshot.data?.docs[index]['JourneyDate']}',
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
                                                          const BoxDecoration(
                                                        shape:
                                                            BoxShape.circle,
                                                        color: Colors.red,
                                                      ),
                                                      child: Center(
                                                          child: Text(
                                                        '${snapshot.data?.docs[index]['PendingRequestsCount']}',
                                                        style: const TextStyle(
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
                                                    decoration: const BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: Colors.green,
                                                    ),
                                                    child: Center(
                                                        child: Text(
                                                      '${snapshot.data?.docs[index]['AcceptedRequestsCount']}',
                                                      style: const TextStyle(
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
                                            const Text('Source Place'),
                                            Text(
                                              '${snapshot.data?.docs[index]['SourcePlace']}',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w900,
                                                  color:
                                                      Colors.blue.shade900),
                                            ),
                                            SizedBox(height: h * 0.01),
                                            const Text('Destination Place'),
                                            Text(
                                              '${snapshot.data?.docs[index]['DestinationPlace']}',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w900,
                                                  color:
                                                      Colors.blue.shade900),
                                            ),
                                            SizedBox(height: h * 0.01),
                                            const Text('Transporter Phone Number'),
                                            Text(
                                              '${snapshot.data?.docs[index]['TransporterID']}',
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
              return const Loading();
            }
          },
        ));
  }

  Stream<QuerySnapshot> fetchAvailableJourneysStream() {
    return FirebaseFirestore.instance
        .collection('TransporterList')
        .where("TransporterID", isNotEqualTo: widget.userID)
        .where("IsJourneyAvailable", isEqualTo: true)
        .snapshots();
  }
}
