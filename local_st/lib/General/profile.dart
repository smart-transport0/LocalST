import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:local_st/Reusable/bottom_navigation_bar.dart';
import 'package:local_st/Reusable/colors.dart';
import 'package:local_st/Reusable/loading.dart';
import 'package:local_st/Reusable/navigation_bar.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:local_st/Reusable/size_config.dart';

class Profile extends StatefulWidget {
  final String userID;
  const Profile(this.userID, {Key? key}) : super(key: key);
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  List<List<double>> points = [
    [0, 1],
    [1, 4],
    [2, 7],
    [18, 30],
    [20, 12],
    [22, 6]
  ];
  double averageRating = 0;
  String userName = "", phoneNumber = "", email = "";
  String profileUrl = '';
  @override
  void initState() {
    super.initState();
    initial();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig sizeConfig = SizeConfig(context);
    double h = sizeConfig.screenHeight;
    double w = sizeConfig.screenWidth;
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Profile',
          ),
          centerTitle: true,
          backgroundColor: Colors.black,
          elevation: 0,
        ),
        drawer: const NavBar(),
        bottomNavigationBar: BottomNavBar(2),
        body: Stack(children: <Widget>[
          Container(color: MyColorScheme.baseColor),
          SingleChildScrollView(
            child: SizedBox(
                height: h,
                child: Column(children: <Widget>[
                  Padding(
                      padding: EdgeInsets.fromLTRB(
                          w * 0.04, h * 0.03, w * 0.04, h * 0.03),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Column(children: [
                              Text(userName,
                                  style: TextStyle(
                                      fontSize: h * 0.03,
                                      fontWeight: FontWeight.w700)),
                              Text('Points',
                                  style: TextStyle(fontSize: h * 0.025)),
                              Text('#Rank\n Average Rating: ${averageRating}',
                                  style: TextStyle(fontSize: h * 0.025))
                            ]),
                            ClipOval(child:
                                FutureBuilder(builder: (context, snapshot) {
                              if (profileUrl == "") {
                                return const Loading();
                              }
                              return Image.network(profileUrl.toString(),
                                  height: h * 0.1,
                                  width: h * 0.1,
                                  fit: BoxFit.cover);
                            }))
                          ])),
                  Container(
                      height: h * 0.3,
                      margin: EdgeInsets.fromLTRB(w * 0.005, 0, w * 0.005, 0),
                      child:
                          ListView(scrollDirection: Axis.horizontal, children: <
                              Widget>[
                        Container(
                          padding: EdgeInsets.fromLTRB(
                              w * 0.01, h * 0.01, w * 0.01, h * 0.01),
                          margin: EdgeInsets.fromLTRB(0, 0, w * 0.05, 0),
                          decoration: BoxDecoration(
                              color: MyColorScheme.darkColor,
                              border: Border.all(
                                color: MyColorScheme.darkColor,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(w * 0.05)),
                          child: Column(children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 0, 0, h * 0.01),
                              child: Text('Total',
                                  style: TextStyle(
                                      fontSize: h * 0.03,
                                      fontWeight: FontWeight.bold,
                                      color: MyColorScheme.baseColor)),
                            ),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                      decoration: BoxDecoration(
                                          color: MyColorScheme.baseColor,
                                          border: Border.all(
                                            color: MyColorScheme.baseColor,
                                            width: 2,
                                          ),
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(w * 0.03),
                                            bottomRight:
                                                Radius.circular(w * 0.03),
                                          )),
                                      width: w * 0.45,
                                      padding: EdgeInsets.fromLTRB(w * 0.01,
                                          h * 0.01, w * 0.01, h * 0.01),
                                      margin: EdgeInsets.fromLTRB(
                                          w * 0.015, 0, w * 0.015, h * 0.01),
                                      child: Text('Journeys Listed\n0',
                                          textAlign: TextAlign.center,
                                          style:
                                              TextStyle(fontSize: h * 0.025))),
                                  Container(
                                      width: w * 0.45,
                                      padding: EdgeInsets.fromLTRB(w * 0.01,
                                          h * 0.01, w * 0.01, h * 0.01),
                                      margin: EdgeInsets.fromLTRB(
                                          w * 0.015, 0, w * 0.015, h * 0.01),
                                      child: Text('Journeys Joined\n0',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: h * 0.025,
                                              color: MyColorScheme.baseColor)))
                                ]),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                      width: w * 0.45,
                                      padding: EdgeInsets.fromLTRB(w * 0.01,
                                          h * 0.01, w * 0.01, h * 0.01),
                                      margin: EdgeInsets.fromLTRB(
                                          w * 0.015, h * 0.01, w * 0.015, 0),
                                      child: Text('Passengers travelled\n0',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: h * 0.025,
                                              color: MyColorScheme.baseColor))),
                                  Container(
                                    decoration: BoxDecoration(
                                        color: MyColorScheme.baseColor,
                                        border: Border.all(
                                          color: MyColorScheme.baseColor,
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(w * 0.03),
                                          bottomRight:
                                              Radius.circular(w * 0.03),
                                        )),
                                    width: w * 0.45,
                                    padding: EdgeInsets.fromLTRB(
                                        w * 0.01, h * 0.01, w * 0.01, h * 0.01),
                                    margin: EdgeInsets.fromLTRB(
                                        w * 0.015, h * 0.01, w * 0.015, 0),
                                    child: Text('Fuel Saved\n0',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: h * 0.025)),
                                  )
                                ])
                          ]),
                        ),
                        Container(
                            padding: EdgeInsets.fromLTRB(
                                w * 0.01, h * 0.01, w * 0.01, h * 0.01),
                            margin: EdgeInsets.fromLTRB(0, 0, w * 0.05, 0),
                            decoration: BoxDecoration(
                                color: MyColorScheme.darkColor,
                                border: Border.all(
                                  color: MyColorScheme.darkColor,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(w * 0.05)),
                            child: Column(children: [
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 0, 0, h * 0.01),
                                child: Text('Total',
                                    style: TextStyle(
                                        fontSize: h * 0.03,
                                        fontWeight: FontWeight.bold,
                                        color: MyColorScheme.baseColor)),
                              ),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                        decoration: BoxDecoration(
                                            color: MyColorScheme.baseColor,
                                            border: Border.all(
                                              color: MyColorScheme.baseColor,
                                              width: 2,
                                            ),
                                            borderRadius: BorderRadius.only(
                                              topLeft:
                                                  Radius.circular(w * 0.03),
                                              bottomRight:
                                                  Radius.circular(w * 0.03),
                                            )),
                                        width: w * 0.45,
                                        padding: EdgeInsets.fromLTRB(w * 0.01,
                                            h * 0.01, w * 0.01, h * 0.01),
                                        margin: EdgeInsets.fromLTRB(
                                            w * 0.015, 0, w * 0.015, h * 0.01),
                                        child: Text('Journeys Listed\n0',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: h * 0.025))),
                                    Container(
                                        width: w * 0.45,
                                        padding: EdgeInsets.fromLTRB(w * 0.01,
                                            h * 0.01, w * 0.01, h * 0.01),
                                        margin: EdgeInsets.fromLTRB(
                                            w * 0.015, 0, w * 0.015, h * 0.01),
                                        child: Text('Journeys Joined\n0',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: h * 0.025,
                                                color:
                                                    MyColorScheme.baseColor)))
                                  ]),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                        width: w * 0.45,
                                        padding: EdgeInsets.fromLTRB(w * 0.01,
                                            h * 0.01, w * 0.01, h * 0.01),
                                        margin: EdgeInsets.fromLTRB(
                                            w * 0.015, h * 0.01, w * 0.015, 0),
                                        child: Text('Passengers travelled\n0',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: h * 0.025,
                                                color:
                                                    MyColorScheme.baseColor))),
                                    Container(
                                        decoration: BoxDecoration(
                                            color: MyColorScheme.baseColor,
                                            border: Border.all(
                                              color: MyColorScheme.baseColor,
                                              width: 2,
                                            ),
                                            borderRadius: BorderRadius.only(
                                              topLeft:
                                                  Radius.circular(w * 0.03),
                                              bottomRight:
                                                  Radius.circular(w * 0.03),
                                            )),
                                        width: w * 0.45,
                                        padding: EdgeInsets.fromLTRB(w * 0.01,
                                            h * 0.01, w * 0.01, h * 0.01),
                                        margin: EdgeInsets.fromLTRB(
                                            w * 0.015, h * 0.01, w * 0.015, 0),
                                        child: Text('Fuel Saved\n0',
                                            textAlign: TextAlign.center,
                                            style:
                                                TextStyle(fontSize: h * 0.025)))
                                  ])
                            ]))
                      ])),
                  Container(
                      margin:
                          EdgeInsets.fromLTRB(0, h * 0.05, w * 0.05, h * 0.05),
                      child: AspectRatio(
                          aspectRatio: 2,
                          child: LineChart(
                              LineChartData(
                                  gridData: FlGridData(show: false),
                                  titlesData: FlTitlesData(
                                      rightTitles: AxisTitles(
                                          sideTitles:
                                              SideTitles(showTitles: false)),
                                      topTitles: AxisTitles(
                                          sideTitles:
                                              SideTitles(showTitles: false))),
                                  lineBarsData: [
                                    LineChartBarData(
                                        belowBarData: BarAreaData(show: false),
                                        spots: points
                                            .map((point) =>
                                                FlSpot(point[0], point[1]))
                                            .toList(),
                                        isCurved: false,
                                        color: const Color.fromARGB(
                                            255, 52, 140, 108))
                                  ]),
                              swapAnimationDuration:
                                  const Duration(milliseconds: 150), // Optional
                              swapAnimationCurve: Curves.linear)))
                ])),
          )
        ]));
  }

  Future<void> initial() async {
    var userData = await FirebaseFirestore.instance
        .collection('UserInformation')
        .doc(widget.userID)
        .get();
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref = storage.ref().child('Admin/ProfilePhoto/${widget.userID}');
    profileUrl = await ref.getDownloadURL();
    userName = userData['FirstName'] + ' ' + userData['LastName'];
    phoneNumber = widget.userID;
    email = userData['OrganizationEmailID'];
    var feedbackDoc = await FirebaseFirestore.instance
        .collection('Feedback')
        .doc(phoneNumber)
        .get();
    if (feedbackDoc.data() != null &&
        feedbackDoc.data()!.containsKey('AverageRating')) {
      averageRating = feedbackDoc['AverageRating'];
    }
    setState(() {});
  }
}
