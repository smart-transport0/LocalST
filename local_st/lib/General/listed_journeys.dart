import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:local_st/Data-Services/utilities.dart';
import 'package:local_st/General/listed_journey_details.dart';
import 'package:local_st/General/start_new_journey.dart';
import 'package:local_st/Reusable/bottom_navigation_bar.dart';
import 'package:local_st/Reusable/colors.dart';
import 'package:local_st/Reusable/loading.dart';
import 'package:local_st/Reusable/navigation_bar.dart';
import 'package:local_st/Reusable/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math';

class ListedJourney extends StatefulWidget {
  final String userID;
  const ListedJourney({Key? key, required this.userID}) : super(key: key);
  @override
  State<ListedJourney> createState() => _ListedJourneyState();
}

class _ListedJourneyState extends State<ListedJourney> {
  late SharedPreferences sharedPreferences;
  Utilities utilities = Utilities();

  @override
  Widget build(BuildContext context) {
    SizeConfig sizeConfig = SizeConfig(context);
    double h = sizeConfig.screenHeight;
    double w = sizeConfig.screenWidth;
    return Scaffold(
      appBar: AppBar(
          title: const Text('Your Listed Journeys'),
          centerTitle: true,
          backgroundColor: Colors.black,
          elevation: 0),
      drawer: const NavBar(),
      bottomNavigationBar: BottomNavBar(2),
      floatingActionButton: Visibility(
        child: FloatingActionButton(
            child: Icon(Icons.add, color: Colors.red, size: h * 0.04),
            backgroundColor: MyColorScheme.bgColor,
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => const StartNewJourney()));
            }),
      ),
      body: StreamBuilder(
        stream: getStream(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.docs.isEmpty) {
              return Center(
                  child: Text('No journeys listed yet!',
                      style: TextStyle(fontSize: max(h, w) * 0.03)));
            }
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
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          ListedJourneyDetails(
                                              journeyID: snapshot
                                                  .data!.docs[index].id)))
                                },
                            title: Padding(
                              padding: EdgeInsets.fromLTRB(
                                  0.0, h * 0.03, 0.0, h * 0.03),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: <Widget>[
                                          Text(
                                              '${snapshot.data!.docs[index]['JourneyDate']}',
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
                                                    decoration:
                                                        const BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: Colors.red,
                                                    ),
                                                    child: Center(
                                                        child: Text(
                                                      '${snapshot.data!.docs[index]['PendingRequestsCount']}',
                                                      style: const TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w900),
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
                                                    '${snapshot.data!.docs[index]['AcceptedRequestsCount']}',
                                                    style: const TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w900),
                                                  ))),
                                            ],
                                          ),
                                        ]),
                                    SizedBox(height: h * 0.01),
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(
                                          w * 0.13, 0, 0, 0),
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            const Text('Source Place'),
                                            Text(
                                              '${snapshot.data!.docs[index]['SourcePlace']}',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w900,
                                                  color: Colors.blue.shade900),
                                            ),
                                            SizedBox(height: h * 0.01),
                                            const Text('Destination Place'),
                                            Text(
                                              '${snapshot.data!.docs[index]['DestinationPlace']}',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w900,
                                                  color: Colors.blue.shade900),
                                            )
                                          ]),
                                    )
                                  ]),
                            ))),
                  );
                });
          } else {
            return const Loading();
          }
        },
      ),
    );
  }

  Stream<QuerySnapshot> getStream() {
    return FirebaseFirestore.instance
        .collection('TransporterList')
        .where("TransporterID", isEqualTo: widget.userID)
        .snapshots();
  }
}
