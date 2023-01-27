import 'package:flutter/material.dart';
import 'package:local_st/Reusable/bottomNavigationBar.dart';
import 'package:local_st/Reusable/navigationBar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StartJourney extends StatefulWidget {
  const StartJourney({Key? key}) : super(key: key);

  @override
  State<StartJourney> createState() => _StartJourneyState();
}

class _StartJourneyState extends State<StartJourney> {
  @override
  late SharedPreferences sharedPreferences;
  void initState() {
    super.initState();
    initial();
  }

  int view = 0;

  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(title: Text('Start a new journey'), centerTitle: true),
        drawer: NavBar(),
        bottomNavigationBar: BottomNavBar(0),
        body: Center(
            child: Column(
          children: <Widget>[],
        )));
  }

  Future<void> initial() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }
}
