import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:local_st/Admin/pending_request.dart';
import 'package:local_st/General/start_new_journey.dart';

class BottomNavBar extends StatefulWidget {
  int selectedIndex = 2;
  BottomNavBar(int currIndex, {Key? key}) : super(key: key) {
    selectedIndex = currIndex;
  }
  @override
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
      if (index == 0) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const StartNewJourney()));
      } else if (index == 2) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const PendingRequest()));
      }
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    return SizedBox(
      height: h * 0.12,
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(30),
          topLeft: Radius.circular(30),
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          unselectedItemColor: const Color.fromARGB(255, 22, 23, 23),
          backgroundColor: const Color.fromARGB(255, 254, 254, 255),
          iconSize: 25.0,
          items: const [
            BottomNavigationBarItem(
                icon: FaIcon(FontAwesomeIcons.users), label: "Manage"),
            BottomNavigationBarItem(
                icon: FaIcon(FontAwesomeIcons.userPlus), label: "Requests"),
            BottomNavigationBarItem(
                icon: FaIcon(FontAwesomeIcons.house), label: "Home"),
            BottomNavigationBarItem(
                icon: FaIcon(FontAwesomeIcons.magnifyingGlassLocation),
                label: "Search"),
            BottomNavigationBarItem(
                icon: FaIcon(FontAwesomeIcons.flag), label: "Reports"),
          ],
          currentIndex: selectedIndex,
          selectedItemColor: const Color.fromARGB(255, 122, 187, 217),
          onTap: onItemTapped,
        ),
      ),
    );
  }
}
