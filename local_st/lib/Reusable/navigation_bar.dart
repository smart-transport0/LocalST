import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:local_st/Data-Services/utilities.dart';
import 'package:local_st/General/about_us.dart';
import 'package:local_st/General/joined_journeys.dart';
import 'package:local_st/General/listed_journeys.dart';
import 'package:local_st/General/login.dart';
import 'package:local_st/General/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  late SharedPreferences sharedPreferences;
  String userName = '', phoneNumber = '', emailID = '';
  Utilities utilities = Utilities();
  @override
  void initState() {
    super.initState();
    initial();
  }

  Widget popup(BuildContext context) {
    return AlertDialog(
        title: const Text('Logout'),
        content: const Text('Do you really want to logout?'),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel')),
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
              child: const Text('Confirm'))
        ]);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color.fromARGB(230, 254, 254, 255),
      child: ListView(
        children: [
          const ListTile(),
          ListTile(
              leading: const FaIcon(FontAwesomeIcons.userLarge),
              title: const Text('Profile', style: TextStyle(fontSize: 18)),
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Profile(phoneNumber)))),
          ListTile(
            leading: const FaIcon(FontAwesomeIcons.mapLocationDot),
            title:
                const Text('Listed Journeys', style: TextStyle(fontSize: 18)),
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    ListedJourney(userID: utilities.remove91(phoneNumber)))),
          ),
          ListTile(
            leading: const FaIcon(FontAwesomeIcons.plus),
            title:
                const Text('Joined Journeys', style: TextStyle(fontSize: 18)),
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const JoinedJourneys())),
          ),
          const ListTile(
            leading: FaIcon(FontAwesomeIcons.clockRotateLeft),
            title: Text('Journey History', style: TextStyle(fontSize: 18)),
          ),
          ListTile(
            leading: const FaIcon(FontAwesomeIcons.circleInfo),
            title: const Text('About Us', style: TextStyle(fontSize: 18)),
            onTap: () => {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const About()))
            },
          ),
          ListTile(
              leading: const FaIcon(FontAwesomeIcons.arrowRightFromBracket),
              title: const Text('Logout', style: TextStyle(fontSize: 18)),
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
