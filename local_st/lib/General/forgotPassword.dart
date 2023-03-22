import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:local_st/Admin/manageUsers.dart';
import 'package:local_st/Data-Services/utilities.dart';
import 'package:local_st/Data-Services/validators.dart';
import 'package:local_st/General/login.dart';
import 'package:local_st/General/register.dart';
import 'package:local_st/Reusable/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);
  @override
  State<ForgotPassword> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<ForgotPassword> {
  late SharedPreferences sharedPreferences;

  @override
  void initState() {
    super.initState();
    initial();
  }

  //firebase auth object
  FirebaseAuth auth = FirebaseAuth.instance;
  Utilities utilities = Utilities();
  Validators validators = Validators();
  //Receiver OTP
  String verificationIdReceived = '';
  String OTPmessage = "";
  bool OTPMessageVisibility = false;
  int OTPVisibility = 1;
  //TextEditingController
  TextEditingController userIDController = TextEditingController();
  TextEditingController OTPController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController newPasswordConfirmController = TextEditingController();
  ManageUsers manageUsers = ManageUsers();

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
                                visible: (OTPVisibility == 1),
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
                                          0, h * 0.05, 0, h * 0.02),
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
                                                                          Login())))
                                                        },
                                                    child: Text("Login",
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
                                          onPressed: () => {resetPassword()},
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
                                              child: Text('Send OTP', style: TextStyle(fontFamily: 'Montserrat', fontSize: w * 0.08, color: MyColorScheme.baseColor)))))
                                ]),
                              ),
                              Visibility(
                                visible: (OTPVisibility == 2),
                                child: Column(
                                  children: <Widget>[
                                    Visibility(
                                      visible: OTPMessageVisibility,
                                      child: Padding(
                                        padding: EdgeInsets.fromLTRB(
                                            0, 0.03 * h, 0, 0),
                                        child: Text(OTPmessage),
                                      ),
                                    ),
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
                              ),
                              Visibility(
                                visible: (OTPVisibility == 3),
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                        padding: EdgeInsets.fromLTRB(
                                            0, h * 0.03, 0, h * 0.03),
                                        child: Material(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            elevation: 15,
                                            child: TextField(
                                                cursorColor:
                                                    MyColorScheme.darkColor,
                                                obscureText: true,
                                                obscuringCharacter: "•",
                                                controller:
                                                    newPasswordController,
                                                style: TextStyle(
                                                    color: MyColorScheme
                                                        .darkColor),
                                                decoration: InputDecoration(
                                                    fillColor:
                                                        MyColorScheme.baseColor,
                                                    prefixIcon: Icon(Icons.lock,
                                                        color: MyColorScheme
                                                            .darkColor),
                                                    labelText: "New Password",
                                                    labelStyle: TextStyle(
                                                      color: MyColorScheme
                                                          .darkColor,
                                                      fontWeight:
                                                          FontWeight.w800,
                                                      fontSize: h * 0.020,
                                                    ),
                                                    focusedBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: MyColorScheme
                                                                .darkColor,
                                                            width: 2.0),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30)),
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
                                            0, h * 0.03, 0, h * 0.03),
                                        child: Material(
                                            borderRadius: BorderRadius.circular(
                                                30),
                                            elevation: 15,
                                            child: TextField(
                                                cursorColor: MyColorScheme
                                                    .darkColor,
                                                obscureText: true,
                                                obscuringCharacter: "•",
                                                controller:
                                                    newPasswordConfirmController,
                                                style: TextStyle(
                                                    color: MyColorScheme
                                                        .darkColor),
                                                decoration: InputDecoration(
                                                    fillColor: MyColorScheme
                                                        .baseColor,
                                                    prefixIcon: Icon(Icons.lock,
                                                        color: MyColorScheme
                                                            .darkColor),
                                                    labelText:
                                                        "Confirm New Password",
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
                                            onPressed: () => {updatePassword()},
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
                                                child: Text('Change Password', style: TextStyle(fontFamily: 'Montserrat', fontSize: w * 0.04, color: MyColorScheme.baseColor)))))
                                  ],
                                ),
                              )
                            ])))))
          ]),
        ],
      )))
    ]);
  }

  void resetPassword() async {
    await FirebaseFirestore.instance
        .collection('UserInformation')
        .doc(utilities.add91(userIDController.text))
        .get()
        .then((result) async => {
              if (!result.exists)
                {
                  await FirebaseFirestore.instance
                      .collection('Mapping/Permanent/MailtoPhone')
                      .doc(userIDController.text)
                      .get()
                      .then((result) => {
                            if (!result.exists)
                              utilities.AlertMessage(
                                  context, 'Invalid Input', 'Invalid UserID')
                            else
                              {verifyNumber(result['PhoneNumber'])}
                          })
                }
              else
                {verifyNumber(userIDController.text)}
            });
  }

  Future<void> initial() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  void verifyNumber(String phoneNumber) async {
    auth.verifyPhoneNumber(
        phoneNumber: utilities.add91(phoneNumber),
        verificationCompleted: (PhoneAuthCredential credential) async {},
        verificationFailed: (FirebaseAuthException exception) {
          print('Verification failed');
        },
        codeSent: (String verificationID, int? resendToken) {
          verificationIdReceived = verificationID;
          setState(() {
            OTPVisibility = 2;
            OTPmessage =
                "OTP has been sent to XXXXXXX" + phoneNumber.substring(7);
            OTPMessageVisibility = true;
          });
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
                OTPVisibility = 3;
              })
            })
        .onError((error, stackTrace) => {
              utilities.AlertMessage(context, 'Incorrect OTP',
                  'OTP incorrect or timed out! Try again.'),
              setState(() {
                OTPVisibility = 1;
                userIDController.text = "";
                OTPController.text = "";
              })
            });
  }

  Future<void> updatePassword() async {
    if (validators.validatePassword(newPasswordController.text).length == 0) {
      if (newPasswordController.text == newPasswordConfirmController.text) {
        String encryptedPassword =
            ManageUsers.encrypt(newPasswordController.text);
        await FirebaseFirestore.instance
            .collection('UserInformation')
            .doc(utilities.add91(userIDController.text))
            .update({'Password': encryptedPassword});
        utilities.AlertMessageWithWidget(context, 'Successfully Updated',
            'Your password has been successfully reset.', Login());
      } else {
        utilities.AlertMessage(context, 'Invalid Input',
            'Confirm Password should match New Password.');
      }
    } else {
      utilities.AlertMessage(context, 'Invalid Input',
          'Password must atleast 8 characters long, must contain atleast one lowercase alphabet, uppercase alphabet, digit and special character.');
    }
  }
}
