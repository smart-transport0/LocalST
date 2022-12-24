import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:local_st/General/register.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  State<Home> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Home> {
  Widget build(BuildContext context) {
    //height and width of screen
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    //TextEditingController
    TextEditingController userID = TextEditingController();

    return Stack(children: <Widget>[
      SafeArea(
          child: Scaffold(
              body: Column(children: <Widget>[
        Expanded(
            flex: 2,
            child: Center(
                child: Text('Smart Transportation',
                    style: TextStyle(
                        shadows: <Shadow>[
                          Shadow(
                            offset: const Offset(3.0, 3.0),
                            blurRadius: 5.0,
                            color: Colors.grey,
                          )
                        ],
                        fontSize: h * 0.037,
                        letterSpacing: 2,
                        fontFamily: 'NotoSans',
                        fontWeight: FontWeight.w900,
                        color: Colors.black87)))),
        Expanded(
            flex: 7,
            child: SingleChildScrollView(
              child: Container(
                  height: h * 0.73,
                  decoration: BoxDecoration(
                      color: Colors.blue.shade900,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(35),
                          topRight: Radius.circular(35))),
                  child: Padding(
                      padding: EdgeInsets.fromLTRB(
                          w * 0.07, h * 0.08, w * 0.07, h * 0.05),
                      child: Column(children: <Widget>[
                        Container(
                          child: Material(
                            borderRadius: BorderRadius.circular(30),
                            elevation: 15,
                            child: TextField(
                                controller: userID,
                                cursorColor: Colors.blue,
                                style: const TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    prefixIcon: const Icon(Icons.person),
                                    labelText:
                                        "Phone Number / Organization Email",
                                    labelStyle: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      fontSize: h * 0.020,
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                        // ignore: prefer_const_constructors
                                        borderSide: BorderSide(
                                            color: Colors.blue, width: 2.0),
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            width: 2.0,
                                            color: Colors.transparent),
                                        borderRadius:
                                            BorderRadius.circular(30)))),
                          ),
                        ),
                        Container(
                          padding:
                              EdgeInsets.fromLTRB(0, h * 0.05, 0, h * 0.05),
                          child: Material(
                            borderRadius: BorderRadius.circular(30),
                            elevation: 15,
                            child: TextField(
                                obscureText: true,
                                obscuringCharacter: "•",
                                style: const TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    prefixIcon: Icon(Icons.lock),
                                    labelText: "Password",
                                    labelStyle: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      fontSize: h * 0.020,
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                        // ignore: prefer_const_constructors
                                        borderSide: BorderSide(
                                            color: Color.fromARGB(
                                                255, 46, 141, 218),
                                            width: 2.0),
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            width: 2.0,
                                            color: Colors.transparent),
                                        borderRadius:
                                            BorderRadius.circular(30)))),
                          ),
                        ),
                        Container(
                            padding: EdgeInsets.fromLTRB(0, 0, 0, h * 0.05),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                      child: TextButton(
                                          onPressed: null,
                                          child: Text("Forgot Password?",
                                              style: TextStyle(
                                                  fontSize: h * 0.02,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w700,
                                                  decoration: TextDecoration
                                                      .underline)))),
                                  Container(
                                      child: TextButton(
                                          onPressed: () => {
                                                Navigator.pushReplacement(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: ((context) =>
                                                            Register())))
                                              },
                                          child: Text("Register",
                                              style: TextStyle(
                                                  fontSize: h * 0.02,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w700,
                                                  decoration: TextDecoration
                                                      .underline))))
                                ])),
                        Container(
                            child: ElevatedButton(
                                onPressed: null,
                                style: ButtonStyle(
                                    elevation: MaterialStateProperty.all(15),
                                    backgroundColor: MaterialStateProperty.all(
                                        Color.fromARGB(255, 62, 124, 217)),
                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(18.0),
                                            side: BorderSide(
                                                color: Colors.blue.shade900)))),
                                child: Padding(
                                    padding: EdgeInsets.fromLTRB(w * 0.05,
                                        h * 0.005, w * 0.05, h * 0.005),
                                    child: Text('Login', style: TextStyle(fontFamily: 'comic', fontSize: w * 0.08, color: Colors.blue.shade50)))))
                      ]))),
            ))
      ])))
    ]);
  }
}
