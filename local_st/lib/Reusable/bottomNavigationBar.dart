import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:local_st/General/startJourney.dart';

import '../General/home.dart';

class BottomNavBar extends StatefulWidget {
  @override
  int selectedIndex = 2;
  BottomNavBar(int currIndex) {
    selectedIndex = currIndex;
  }
  State<BottomNavBar> createState() => _BottomNavBarState(selectedIndex);
}

class _BottomNavBarState extends State<BottomNavBar> {
  int selectedIndex = 2;
  _BottomNavBarState(int selIndex) {
    selectedIndex = selIndex;
  }
  void onItemTapped(int index) {
    setState(() {
      if (index == selectedIndex) return;
      if (index == 0)
        Navigator.pushReplacement(context,
            new MaterialPageRoute(builder: (context) => StartJourney()));
      else if (index == 2)
        Navigator.pushReplacement(
            context, new MaterialPageRoute(builder: (context) => Home()));
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Container(
      height: h * 0.12,
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(30),
          topLeft: Radius.circular(30),
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          unselectedItemColor: Color.fromARGB(255, 22, 23, 23),
          backgroundColor: Color.fromARGB(255, 254, 254, 255),
          iconSize: 25.0,
          items: const [
            BottomNavigationBarItem(
                icon: FaIcon(FontAwesomeIcons.locationDot), label: "Create"),
            BottomNavigationBarItem(
                icon: FaIcon(FontAwesomeIcons.userPlus), label: "Join"),
            BottomNavigationBarItem(
                icon: FaIcon(FontAwesomeIcons.house), label: "Home"),
            BottomNavigationBarItem(
                icon: FaIcon(FontAwesomeIcons.magnifyingGlassLocation),
                label: "Search"),
            BottomNavigationBarItem(
                icon: FaIcon(FontAwesomeIcons.solidCommentDots), label: "Chat"),
          ],
          currentIndex: selectedIndex,
          selectedItemColor: Color.fromARGB(255, 122, 187, 217),
          onTap: onItemTapped,
        ),
      ),
    );
  }
}
