import 'package:flutter/material.dart';

class About extends StatefulWidget {
  const About({Key? key}) : super(key: key);

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
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
      body: Column(children: <Widget>[
        Text('About Us',
            style: TextStyle(
                fontSize: h * 0.04, decoration: TextDecoration.underline)),
        Text(
            'Smart Transportation is a way of eco-friendly daily commute. \nWe believe in saving energy and resources for sustainable future.'),
        Text(''),
      ]),
    );
  }
}
