import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:local_st/Admin/manageUsers.dart';
import 'package:local_st/Data-Services/utilities.dart';
import 'package:local_st/General/register.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  State<Home> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Home> {
  //firebase auth object
  FirebaseAuth auth = FirebaseAuth.instance;

  //Receiver OTP
  String verificationIdReceived = '';
  //TextEditingController
  TextEditingController userIDController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  ManageUsers manageUsers = ManageUsers();
  Utilities utilities = Utilities();
  Widget build(BuildContext context) {
    //height and width of screen
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Stack(children: <Widget>[
      SafeArea(
          child: Scaffold(
              body: Stack(
        children: [
          Container(
            height: h * 0.315,
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/images/pikb29.jpg'))),
          ),
          Column(children: <Widget>[
            Expanded(
                flex: 4,
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
                        color: Colors.black87))),
            Expanded(
                flex: 11,
                child: SingleChildScrollView(
                    child: Container(
                        height: h * 0.73,
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 82, 133, 177),
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(35),
                                topRight: Radius.circular(35))),
                        child: Padding(
                            padding: EdgeInsets.fromLTRB(
                                w * 0.07, h * 0.08, w * 0.07, h * 0.05),
                            child: Column(children: <Widget>[
                              Visibility(
                                visible: false,
                                child: Column(children: <Widget>[
                                  Container(
                                      child: Material(
                                    borderRadius: BorderRadius.circular(30),
                                    elevation: 15,
                                    child: TextField(
                                        controller: userIDController,
                                        cursorColor:
                                            Color.fromARGB(255, 8, 54, 88),
                                        style: const TextStyle(
                                            color: Colors.black),
                                        decoration: InputDecoration(
                                            fillColor: Colors.white,
                                            prefixIcon: const Icon(Icons.person,
                                                color: Color.fromARGB(
                                                    255, 8, 54, 88)),
                                            labelText:
                                                "Phone Number / Organization Email",
                                            labelStyle: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 8, 54, 88),
                                              fontWeight: FontWeight.w800,
                                              fontSize: h * 0.020,
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                                // ignore: prefer_const_constructors
                                                borderSide: BorderSide(
                                                    color: Color.fromARGB(
                                                        255, 8, 54, 88),
                                                    width: 2.0),
                                                borderRadius:
                                                    BorderRadius.circular(30)),
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                    width: 2.0,
                                                    color: Colors.transparent),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        30)))),
                                  )),
                                  Container(
                                      padding: EdgeInsets.fromLTRB(
                                          0, h * 0.05, 0, h * 0.05),
                                      child: Material(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          elevation: 15,
                                          child: TextField(
                                              cursorColor: Color.fromARGB(
                                                  255, 8, 54, 88),
                                              obscureText: true,
                                              obscuringCharacter: "•",
                                              controller: passwordController,
                                              style: const TextStyle(
                                                  color: Colors.black),
                                              decoration: InputDecoration(
                                                  fillColor: Colors.white,
                                                  prefixIcon: Icon(Icons.lock,
                                                      color: Color.fromARGB(
                                                          255, 8, 54, 88)),
                                                  labelText: "Password",
                                                  labelStyle: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 8, 54, 88),
                                                    fontWeight: FontWeight.w800,
                                                    fontSize: h * 0.020,
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                          // ignore: prefer_const_constructors
                                                          borderSide: BorderSide(
                                                              color: Color.fromARGB(
                                                                  255, 8, 54, 88),
                                                              width: 2.0),
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  30)),
                                                  enabledBorder: OutlineInputBorder(
                                                      borderSide: const BorderSide(
                                                          width: 2.0,
                                                          color: Colors
                                                              .transparent),
                                                      borderRadius:
                                                          BorderRadius.circular(30)))))),
                                  Container(
                                      padding: EdgeInsets.fromLTRB(
                                          0, 0, 0, h * 0.05),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Container(
                                                child: TextButton(
                                                    onPressed: null,
                                                    child: Text(
                                                        "Forgot Password?",
                                                        style: TextStyle(
                                                            fontSize: h * 0.02,
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            decoration:
                                                                TextDecoration
                                                                    .underline)))),
                                            Container(
                                                child: TextButton(
                                                    onPressed: () => {
                                                          Navigator.pushReplacement(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      ((context) =>
                                                                          Register())))
                                                        },
                                                    child: Text("Register",
                                                        style: TextStyle(
                                                            fontSize: h * 0.02,
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            decoration:
                                                                TextDecoration
                                                                    .underline))))
                                          ])),
                                  Container(
                                      child: ElevatedButton(
                                          onPressed: () => {login()},
                                          style: ButtonStyle(
                                              elevation:
                                                  MaterialStateProperty.all(15),
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      Color.fromARGB(
                                                          255, 8, 54, 88)),
                                              shape: MaterialStateProperty.all<
                                                      RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(18.0),
                                                      side: BorderSide(color: Color.fromARGB(255, 8, 54, 88))))),
                                          child: Padding(padding: EdgeInsets.fromLTRB(w * 0.05, h * 0.005, w * 0.05, h * 0.005), child: Text('Login', style: TextStyle(fontFamily: 'comic', fontSize: w * 0.08, color: Colors.blue.shade50)))))
                                ]),
                              ),
                              Visibility(
                                visible: true,
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                        padding: EdgeInsets.fromLTRB(
                                            0, h * 0.05, 0, h * 0.05),
                                        child: Material(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            elevation: 15,
                                            child: TextField(
                                                cursorColor: Color.fromARGB(
                                                    255, 8, 54, 88),
                                                obscureText: true,
                                                obscuringCharacter: "•",
                                                controller: passwordController,
                                                style: const TextStyle(
                                                    color: Colors.black),
                                                decoration: InputDecoration(
                                                    fillColor: Colors.white,
                                                    prefixIcon: Icon(Icons.lock,
                                                        color: Color.fromARGB(
                                                            255, 8, 54, 88)),
                                                    labelText: "OTP",
                                                    labelStyle: TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 8, 54, 88),
                                                      fontWeight:
                                                          FontWeight.w800,
                                                      fontSize: h * 0.020,
                                                    ),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                            // ignore: prefer_const_constructors
                                                            borderSide: BorderSide(
                                                                color: Color.fromARGB(
                                                                    255, 8, 54, 88),
                                                                width: 2.0),
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                    30)),
                                                    enabledBorder: OutlineInputBorder(
                                                        borderSide: const BorderSide(
                                                            width: 2.0,
                                                            color: Colors
                                                                .transparent),
                                                        borderRadius: BorderRadius.circular(30)))))),
                                    Container(
                                        child: ElevatedButton(
                                            onPressed: () => {login()},
                                            style: ButtonStyle(
                                                elevation: MaterialStateProperty.all(
                                                    15),
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                        Color.fromARGB(
                                                            255, 8, 54, 88)),
                                                shape: MaterialStateProperty.all<
                                                        RoundedRectangleBorder>(
                                                    RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(18.0),
                                                        side: BorderSide(color: Color.fromARGB(255, 8, 54, 88))))),
                                            child: Padding(padding: EdgeInsets.fromLTRB(w * 0.05, h * 0.005, w * 0.05, h * 0.005), child: Text('Login', style: TextStyle(fontFamily: 'comic', fontSize: w * 0.08, color: Colors.blue.shade50)))))
                                  ],
                                ),
                              )
                            ])))))
          ]),
        ],
      )))
    ]);
  }

  void login() async {
    String userID = userIDController.text;
    String password = passwordController.text;
    if (userID == "" || password == "") {
      String errorMessage = "";
      if (userID == "") {
        errorMessage += "UserID cannot be empty\n";
      }
      if (password == "") {
        errorMessage += "Password cannot be empty";
      }
      utilities.AlertMessage(context, 'Invalid Input', errorMessage);
    } else {
      if (userID.startsWith('\$')) {
        String phoneNumber = userID.substring(1);
        String OGpassword = ManageUsers.encrypt(password);
        await FirebaseFirestore.instance
            .collection('Admin')
            .doc(phoneNumber)
            .get()
            .then((result) => {
                  if (!result.exists)
                    {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => AlertDialog(
                                title: const Text('Invalid input'),
                                content: Text('Invalid UserID'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, 'OK'),
                                    child: const Text('OK'),
                                  ),
                                ],
                              )))
                    }
                  else
                    {
                      if (result['Password'] != OGpassword)
                        {
                          utilities.AlertMessage(
                              context, 'Invalid input', 'Incorrect Password!')
                        }
                      else
                        {verifyNumber()}
                    }
                });
      } else {}
    }
  }

  void verifyNumber() async {
    String phoneNumber = userIDController.text.substring(1);
    auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {},
        verificationFailed: (FirebaseAuthException exception) {
          // Navigator.of(context)
          //     .push(MaterialPageRoute(builder: (context) => Register()));
          print('aavi ja chal');
        },
        codeSent: (String verificationID, int? resendToken) {
          verificationIdReceived = verificationID;
          setState(() {});
        },
        codeAutoRetrievalTimeout: (String verificationID) {});
  }

  void verifyCode() async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationIdReceived, smsCode: userIDController.text);

    await auth
        .signInWithCredential(credential)
        .then((value) => {setState(() {})});
  }
}
