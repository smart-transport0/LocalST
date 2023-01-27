import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:local_st/Reusable/bottomNavigationBar.dart';
import 'package:local_st/Reusable/navigationBar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Home> {
  @override
  void initState() {
    super.initState();
    initial();
  }

  @override
  String userName = "", greeting = "";
  late SharedPreferences sharedPreferences;
  Widget build(BuildContext context) {
    //height and width of screen
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Smart Transportation',
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      drawer: NavBar(),
      bottomNavigationBar: BottomNavBar(2),
      extendBody: true,
      body: Stack(children: <Widget>[
        Container(
          height: h,
          color: Color.fromARGB(255, 249, 244, 243),
        ),
        SingleChildScrollView(
          child: Container(
            height: h,
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                          w * 0.05, h * 0.05, w * 0.05, h * 0.02),
                      child: Column(
                        children: [
                          ClipOval(
                              child: Image(
                            height: h * 0.1,
                            width: h * 0.1,
                            fit: BoxFit.cover,
                            image: AssetImage('assets/images/panda.jpg'),
                          )),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.fromLTRB(0, h * 0.06, w * 0.05, h * 0.02),
                      child: Container(
                        width: w * 0.5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              greeting + ",",
                              style: TextStyle(fontFamily: 'Montserrat'),
                            ),
                            Text(
                              userName,
                              style: TextStyle(
                                  fontFamily: 'Montserrat', fontSize: h * 0.04),
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.fromLTRB(w * 0.05, h * 0.07, 0, h * 0.02),
                      child: Stack(
                        children: [
                          ClipOval(
                              child: Icon(Icons.notifications,
                                  size: h * 0.05, color: Colors.orangeAccent)),
                          Container(
                              width: w * 0.05,
                              margin: EdgeInsets.fromLTRB(
                                  w * 0.05, h * 0.006, 0, 0),
                              child: Text('2',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w900)))
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                    padding: EdgeInsets.fromLTRB(0, h * 0.035, 0, 0),
                    child: Text("Let's travel eco-friendly today!",
                        style: TextStyle(
                            fontSize: h * 0.04,
                            fontWeight: FontWeight.bold,
                            color: Colors.green))),
                Padding(
                  padding: EdgeInsets.fromLTRB(
                      w * 0.05, h * 0.05, w * 0.05, h * 0.03),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color.fromARGB(255, 195, 219, 230)),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, h * 0.02, 0, 0),
                          child: Text('Upcoming Journey',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: h * 0.03)),
                        ),
                        Padding(
                            padding: EdgeInsets.fromLTRB(
                                w * 0.05, h * 0.03, w * 0.05, h * 0.03),
                            child: IntrinsicHeight(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('01:59 AM',
                                            style:
                                                TextStyle(fontSize: h * 0.028))
                                      ]),
                                  Padding(
                                      padding: EdgeInsets.fromLTRB(
                                          w * 0.03, 0, w * 0.03, 0),
                                      child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(Icons.location_on_rounded),
                                            Expanded(
                                              child: Container(
                                                  width: 2, color: Colors.grey),
                                            ),
                                            Icon(Icons.location_on_rounded)
                                          ])),
                                  Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                0, 0, 0, h * 0.03),
                                            child: Text('PDPU',
                                                style: TextStyle(
                                                    fontSize: h * 0.028))),
                                        Text('Satellite',
                                            style:
                                                TextStyle(fontSize: h * 0.028))
                                      ]),
                                ],
                              ),
                            ))
                      ],
                    ),
                  ),
                ),
                Text(
                  "\n#FactOfTheDay",
                  style: TextStyle(
                      fontSize: h * 0.04, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(w * 0.05, 0, w * 0.05, 0),
                  child: Text(
                    "There were an estimated 6.5 million deaths worldwide from air pollution-related diseases in 2012, WHO data shows.",
                    style: TextStyle(fontSize: h * 0.025),
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
          ),
        ),
      ]),
    );
  }

  Future<void> initial() async {
    sharedPreferences = await SharedPreferences.getInstance();
    int idx = 0;
    String fullName = sharedPreferences.get('userName').toString();
    setState(() {
      for (int i = 0; i < fullName.length; i++) {
        if (fullName[i] == ' ') {
          break;
        } else {
          userName += fullName[i];
        }
      }
      int currentHour = new DateTime.now().hour;
      print(currentHour);
      if (currentHour >= 4 && currentHour <= 12)
        greeting = "Good Morning";
      else if (currentHour >= 12 && currentHour <= 17)
        greeting = "Good Afternoon";
      else if (currentHour > 17) greeting = "Good Evening";
    });
  }
}
