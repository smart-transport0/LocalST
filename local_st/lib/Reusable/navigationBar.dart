import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:local_st/General/aboutUs.dart';
import 'package:local_st/General/joinedJourneys.dart';
import 'package:local_st/General/listedJourneys.dart';
import 'package:local_st/General/login.dart';
import 'package:local_st/General/profile.dart';
import 'package:local_st/General/startNewJourney.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NavBar extends StatefulWidget {
  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  late SharedPreferences sharedPreferences;
  String userName = '', phoneNumber = '', emailID = '';

  @override
  void initState() {
    super.initState();
    initial();
  }

  Widget popup(BuildContext context) {
    return AlertDialog(
        title: Text('Logout'),
        content: Text('Do you really want to logout?'),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel')),
          TextButton(
              onPressed: () async {
                sharedPreferences.remove('phoneNumber');
                sharedPreferences.remove('email');
                sharedPreferences.remove('userName');
                await FirebaseAuth.instance.signOut();
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute<void>(
                        builder: (BuildContext context) => const Login()),
                    (Route<dynamic> route) => false);
              },
              child: Text('Confirm'))
        ]);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Color.fromARGB(230, 254, 254, 255),
      child: ListView(
        children: [
          ListTile(),
          ListTile(
              leading: FaIcon(FontAwesomeIcons.userLarge),
              title: Text('Profile', style: TextStyle(fontSize: 18)),
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Profile(phoneNumber)))),
          ListTile(
            leading: FaIcon(FontAwesomeIcons.mapLocationDot),
            title: Text('Listed Journeys', style: TextStyle(fontSize: 18)),
            onTap: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => ListedJourney())),
          ),
          ListTile(
            leading: FaIcon(FontAwesomeIcons.plus),
            title: Text('Joined Journeys', style: TextStyle(fontSize: 18)),
            onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => JoinedJourneys())),
          ),
          ListTile(
            leading: FaIcon(FontAwesomeIcons.clockRotateLeft),
            title: Text('Journey History', style: TextStyle(fontSize: 18)),
          ),
          ListTile(
            leading: FaIcon(FontAwesomeIcons.circleInfo),
            title: Text('About Us', style: TextStyle(fontSize: 18)),
            onTap: () => {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => About()))
            },
          ),
          ListTile(
              leading: FaIcon(FontAwesomeIcons.arrowRightFromBracket),
              title: Text('Logout', style: TextStyle(fontSize: 18)),
              onTap: () {
                showDialog(
                    context: context, builder: (context) => popup(context));
              }),
        ],
      ),
    );
  }

  Future<String> initial() async {
    sharedPreferences = await SharedPreferences.getInstance();
    phoneNumber = sharedPreferences.getString('phoneNumber')!;
    emailID = sharedPreferences.getString('email')!;
    userName = sharedPreferences.getString('userName')!;
    return userName;
  }
}
