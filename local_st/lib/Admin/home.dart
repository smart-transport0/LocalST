import 'package:flutter/material.dart';
import 'package:local_st/Reusable/Admin/bottom_navigation_bar.dart';
import 'package:local_st/Reusable/colors.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Smart Transportation',
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      bottomNavigationBar: BottomNavBar(2),
      body: Stack(
        children: [Container(color: MyColorScheme.baseColor)],
      ),
    );
  }
}
