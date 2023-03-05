import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:local_st/Admin/manageUsers.dart';
import 'package:local_st/Admin/pendingRequest.dart';
import 'package:local_st/Data-Services/utilities.dart';
import 'package:local_st/General/forgotPassword.dart';
import 'package:local_st/General/home.dart';
import 'package:local_st/General/register.dart';
import 'package:local_st/Reusable/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);
  @override
  State<Login> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Login> {
  late SharedPreferences sharedPreferences;

  @override
  void initState() {
    super.initState();
    initial();
  }

  //firebase auth object
  FirebaseAuth auth = FirebaseAuth.instance;

  //Receiver OTP
  String verificationIdReceived = '';
  bool OTPVisibility = false;
  //TextEditingController
  TextEditingController userIDController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController OTPController = TextEditingController();
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
          Container(height: h * 0.4, color: MyColorScheme.darkColor),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 0.12 * h, 0, 0),
            child: Container(
              height: h * 0.2,
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: AssetImage('assets/images/bike1.png'),
              )),
            ),
          ),
          Column(children: <Widget>[
            Expanded(
                flex: 5,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0, h * 0.05, 0, 0),
                  child: Text('Smart Transportation',
                      style: TextStyle(
                          fontSize: h * 0.045,
                          letterSpacing: 2,
                          fontFamily: 'comic',
                          fontWeight: FontWeight.w900,
                          color: MyColorScheme.baseColor)),
                )),
            Expanded(
                flex: 11,
                child: SingleChildScrollView(
                    child: Container(
                        height: h * 0.73,
                        decoration: BoxDecoration(
                            color: MyColorScheme.baseColor,
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(35),
                                topRight: Radius.circular(35))),
                        child: Padding(
                            padding: EdgeInsets.fromLTRB(
                                w * 0.07, h * 0.08, w * 0.07, h * 0.05),
                            child: Column(children: <Widget>[
                              Visibility(
                                visible: !OTPVisibility,
                                child: Column(children: <Widget>[
                                  Container(
                                      child: Material(
                                    borderRadius: BorderRadius.circular(30),
                                    elevation: 15,
                                    child: TextField(
                                        controller: userIDController,
                                        cursorColor: MyColorScheme.darkColor,
                                        style: TextStyle(
                                            color: MyColorScheme.darkColor),
                                        decoration: InputDecoration(
                                            fillColor: MyColorScheme.baseColor,
                                            prefixIcon: Icon(Icons.person,
                                                color: MyColorScheme.darkColor),
                                            labelText:
                                                "Phone Number / Organization Email",
                                            labelStyle: TextStyle(
                                              color: MyColorScheme.darkColor,
                                              fontWeight: FontWeight.w800,
                                              fontSize: h * 0.020,
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                                // ignore: prefer_const_constructors
                                                borderSide: BorderSide(
                                                    color:
                                                        MyColorScheme.darkColor,
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
                                              cursorColor:
                                                  MyColorScheme.darkColor,
                                              obscureText: true,
                                              obscuringCharacter: "•",
                                              controller: passwordController,
                                              style: TextStyle(
                                                  color:
                                                      MyColorScheme.darkColor),
                                              decoration: InputDecoration(
                                                  fillColor:
                                                      MyColorScheme.baseColor,
                                                  prefixIcon: Icon(Icons.lock,
                                                      color: MyColorScheme
                                                          .darkColor),
                                                  labelText: "Password",
                                                  labelStyle: TextStyle(
                                                    color:
                                                        MyColorScheme.darkColor,
                                                    fontWeight: FontWeight.w800,
                                                    fontSize: h * 0.020,
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                          // ignore: prefer_const_constructors
                                                          borderSide: BorderSide(
                                                              color: MyColorScheme
                                                                  .darkColor,
                                                              width: 2.0),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      30)),
                                                  enabledBorder: OutlineInputBorder(
                                                      borderSide:
                                                          const BorderSide(
                                                              width: 2.0,
                                                              color: Colors
                                                                  .transparent),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30)))))),
                                  Container(
                                      padding: EdgeInsets.fromLTRB(
                                          0, 0, 0, h * 0.05),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Container(
                                                child: TextButton(
                                                    onPressed: () => {
                                                          Navigator.pushReplacement(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      ((context) =>
                                                                          ForgotPassword())))
                                                        },
                                                    child: Text(
                                                        "Forgot Password?",
                                                        style: TextStyle(
                                                            fontSize: h * 0.02,
                                                            color: MyColorScheme
                                                                .darkColor,
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
                                                            color: MyColorScheme
                                                                .darkColor,
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
                                              backgroundColor: MaterialStateProperty.all(
                                                  MyColorScheme.darkColor),
                                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              18.0),
                                                      side: BorderSide(
                                                          color: MyColorScheme
                                                              .darkColor)))),
                                          child: Padding(
                                              padding: EdgeInsets.fromLTRB(w * 0.05, h * 0.005, w * 0.05, h * 0.005),
                                              child: Text('Login', style: TextStyle(fontFamily: 'Montserrat', fontSize: w * 0.08, color: MyColorScheme.baseColor)))))
                                ]),
                              ),
                              Visibility(
                                visible: OTPVisibility,
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
                                                cursorColor:
                                                    MyColorScheme.darkColor,
                                                obscureText: true,
                                                obscuringCharacter: "•",
                                                controller: OTPController,
                                                style: TextStyle(
                                                    color: MyColorScheme
                                                        .darkColor),
                                                decoration: InputDecoration(
                                                    fillColor:
                                                        MyColorScheme.baseColor,
                                                    prefixIcon: Icon(Icons.lock,
                                                        color: MyColorScheme
                                                            .darkColor),
                                                    labelText: "OTP",
                                                    labelStyle: TextStyle(
                                                      color: MyColorScheme
                                                          .darkColor,
                                                      fontWeight:
                                                          FontWeight.w800,
                                                      fontSize: h * 0.020,
                                                    ),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                            // ignore: prefer_const_constructors
                                                            borderSide: BorderSide(
                                                                color: MyColorScheme
                                                                    .darkColor,
                                                                width: 2.0),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        30)),
                                                    enabledBorder: OutlineInputBorder(
                                                        borderSide:
                                                            const BorderSide(
                                                                width: 2.0,
                                                                color: Colors
                                                                    .transparent),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    30)))))),
                                    Container(
                                        child: ElevatedButton(
                                            onPressed: () => {verifyCode()},
                                            style: ButtonStyle(
                                                elevation: MaterialStateProperty.all(
                                                    15),
                                                backgroundColor: MaterialStateProperty.all(
                                                    MyColorScheme.darkColor),
                                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                    RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(
                                                            18.0),
                                                        side: BorderSide(
                                                            color: MyColorScheme
                                                                .darkColor)))),
                                            child: Padding(
                                                padding: EdgeInsets.fromLTRB(w * 0.05, h * 0.005, w * 0.05, h * 0.005),
                                                child: Text('Login', style: TextStyle(fontFamily: 'Montserrat', fontSize: w * 0.08, color: MyColorScheme.baseColor)))))
                                  ],
                                ),
                              )
                            ])))))
          ]),
        ],
      )))
    ]);
  }

  Future<void> initial() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  void login() async {
    String userID = userIDController.text;
    String password = passwordController.text;
    if (userID == "" || password == "") {
      String errorMessage = "";
      if (userID == "") errorMessage += "UserID cannot be empty\n";
      if (password == "") errorMessage += "Password cannot be empty";
      utilities.AlertMessage(context, 'Invalid Input', errorMessage);
    } else {
      if (userID.startsWith('\$')) {
        String phoneNumber = utilities.add91(userID.substring(1));
        String OGpassword = ManageUsers.encrypt(password);
        await FirebaseFirestore.instance
            .collection('Admin')
            .doc(phoneNumber)
            .get()
            .then((result) => {
                  if (!result.exists)
                    {
                      utilities.AlertMessage(
                          context, 'Invalid Input', 'Invalid UserID')
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
      } else {
        String OGpassword = ManageUsers.encrypt(password);
        var user = await FirebaseFirestore.instance
            .collection('UserInformation')
            .doc(utilities.add91(userID))
            .get();
        if (user.exists) {
          var variablePassword = ManageUsers.decrypt(user['Password']);
          if (variablePassword.compareTo(password) == 0) {
            sharedPreferences.setString('phoneNumber', utilities.add91(userID));
            sharedPreferences.setString('email', user['OrganizationEmailID']);
            sharedPreferences.setString(
                'userName', user['FirstName'] + " " + user['LastName']);
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => Home()));
          } else {
            utilities.AlertMessage(
                context, 'Incorrect Input', 'Incorrect password!');
          }
        } else {
          var mapping = await FirebaseFirestore.instance
              .collection('Mapping/Permanent/MailtoPhone')
              .doc(userID)
              .get();
          if (!mapping.exists) {
            utilities.AlertMessage(context, 'Invalid Input', 'Invalid UserID');
          } else {
            var phoneNumber = mapping['PhoneNumber'];
            var user = await FirebaseFirestore.instance
                .collection('UserInformation')
                .doc(phoneNumber)
                .get();
            var variablePassword = ManageUsers.decrypt(user['Password']);
            if (variablePassword.compareTo(password) == 0) {
              sharedPreferences.setString('phoneNumber', phoneNumber);
              sharedPreferences.setString('email', user['OrganizationEmailID']);
              sharedPreferences.setString(
                  'userName', user['FirstName'] + " " + user['LastName']);
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => Home()));
            } else {
              utilities.AlertMessage(
                  context, 'Incorrect Input', 'Incorrect Password');
            }
          }
        }
      }
    }
  }

  void verifyNumber() async {
    auth.verifyPhoneNumber(
        phoneNumber: utilities.add91(userIDController.text.substring(1)),
        verificationCompleted: (PhoneAuthCredential credential) async {},
        verificationFailed: (FirebaseAuthException exception) {
          print('Verification failed');
        },
        codeSent: (String verificationID, int? resendToken) {
          verificationIdReceived = verificationID;
          OTPVisibility = true;
          setState(() {});
        },
        codeAutoRetrievalTimeout: (String verificationID) {});
  }

  void verifyCode() async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationIdReceived, smsCode: OTPController.text);
    await auth
        .signInWithCredential(credential)
        .then((value) => {
              setState(() {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => PendingRequest())));
              })
            })
        .onError((error, stackTrace) => {
              utilities.AlertMessage(context, 'Incorrect OTP',
                  'OTP incorrect or timed out! Try again.'),
              setState(() {
                OTPVisibility = false;
                userIDController.text = "";
                OTPController.text = "";
              })
            });
  }
}
