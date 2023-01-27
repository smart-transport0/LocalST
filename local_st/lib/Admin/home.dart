import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:local_st/Reusable/Admin/bottomNavigationBar.dart';
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
        title: Text(
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
