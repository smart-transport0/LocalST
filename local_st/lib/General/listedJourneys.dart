import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:local_st/Data-Services/utilities.dart';
import 'package:local_st/General/listedJourneyDetails.dart';
import 'package:local_st/General/startNewJourney.dart';
import 'package:local_st/Reusable/bottomNavigationBar.dart';
import 'package:local_st/Reusable/colors.dart';
import 'package:local_st/Reusable/loading.dart';
import 'package:local_st/Reusable/navigationBar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ListedJourney extends StatefulWidget {
  String userID;
  ListedJourney({Key? key, required this.userID}) : super(key: key);
  @override
  State<ListedJourney> createState() => _ListedJourneyState();
}

class _ListedJourneyState extends State<ListedJourney> {
  late SharedPreferences sharedPreferences;
  Utilities utilities = Utilities();

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
        child: StreamBuilder(
          stream: getStream(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemCount: snapshot.data?.docs.length,
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
                                                ListedJourneyDetails(snapshot
                                                    .data!.docs[index].id)))
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
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Colors.red,
                                                  ),
                                                  child: Center(
                                                      child: Text(
                                                    '${snapshot.data!.docs[index]['PendingRequestsCount']}',
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
                                                  '${snapshot.data!.docs[index]['AcceptedRequestsCount']}',
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
                                          '${snapshot.data!.docs[index]['SourcePlace']}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w900,
                                              color: Colors.blue.shade900),
                                        ),
                                        SizedBox(height: h * 0.01),
                                        Text('Destination Place'),
                                        Text(
                                          '${snapshot.data!.docs[index]['DestinationPlace']}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w900,
                                              color: Colors.blue.shade900),
                                        )
                                      ])
                                ]),
                              ))),
                    );
                  });
            } else {
              return const Loading();
            }
          },
        ),
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
