import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:local_st/Admin/manageUsers.dart';
import 'package:local_st/Data-Services/utilities.dart';
import 'package:local_st/Data-Services/validators.dart';
import 'home.dart';
import 'package:intl/intl.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);
  @override
  State<Register> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Register> {
  //firebase auth object
  FirebaseAuth auth = FirebaseAuth.instance;

  //Receiver OTP
  String verificationIdReceived = '';

  //TextEditingController
  TextEditingController firstNameController = TextEditingController();
  TextEditingController middleNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emergencyContactNumberController =
      TextEditingController();
  TextEditingController dateOfBirthController = TextEditingController();
  TextEditingController rollNumberController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController phoneNumberOTPController = TextEditingController();
  TextEditingController organizationEMailIDController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  //Visiblity Switcher Variable
  int outerVisibility = 1;
  int phoneNumberVisibility = 1;

  //Error Message String
  String errorMessage = '';

  //Objects to access method from other class Files
  Utilities utilities = Utilities();
  Validators validators = Validators();
  ManageUsers manageUsers = ManageUsers();

  //Email Verification Variable and Object
  late User user;
  late Timer timer;

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
                child: Stack(
                  children: [
                    Container(
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
                              color: Colors.black87)),
                    ),
                  ],
                )),
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
                              w * 0.07, h * 0.075, w * 0.07, h * 0.05),
                          child: Column(children: <Widget>[
                            //Part 1 of visiblity
                            Visibility(
                                visible: (outerVisibility == 1),
                                child: Column(children: <Widget>[
                                  Container(
                                    padding:
                                        EdgeInsets.fromLTRB(0, 0, 0, h * 0.05),
                                    child: Material(
                                      borderRadius: BorderRadius.circular(30),
                                      elevation: 15,
                                      child: TextField(
                                          controller: firstNameController,
                                          cursorColor:
                                              Color.fromARGB(255, 8, 54, 88),
                                          style: const TextStyle(
                                              color: Colors.black),
                                          decoration: InputDecoration(
                                              filled: true,
                                              fillColor: Colors.white,
                                              prefixIcon: const Icon(
                                                  Icons.person,
                                                  color: Color.fromARGB(
                                                      255, 8, 54, 88)),
                                              labelText: "First Name",
                                              labelStyle: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 8, 54, 88),
                                                fontWeight: FontWeight.w600,
                                                fontSize: h * 0.020,
                                              ),
                                              focusedBorder: OutlineInputBorder(
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
                                                      color:
                                                          Colors.transparent),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30)))),
                                    ),
                                  ),
                                  Container(
                                    padding:
                                        EdgeInsets.fromLTRB(0, 0, 0, h * 0.05),
                                    child: Material(
                                      borderRadius: BorderRadius.circular(30),
                                      elevation: 15,
                                      child: TextField(
                                          controller: middleNameController,
                                          cursorColor:
                                              Color.fromARGB(255, 8, 54, 88),
                                          style: const TextStyle(
                                              color: Colors.black),
                                          decoration: InputDecoration(
                                              filled: true,
                                              fillColor: Colors.white,
                                              prefixIcon: const Icon(
                                                  Icons.person,
                                                  color: Color.fromARGB(
                                                      255, 8, 54, 88)),
                                              labelText: "Middle Name",
                                              labelStyle: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 8, 54, 88),
                                                fontWeight: FontWeight.w600,
                                                fontSize: h * 0.020,
                                              ),
                                              focusedBorder: OutlineInputBorder(
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
                                                      color:
                                                          Colors.transparent),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30)))),
                                    ),
                                  ),
                                  Container(
                                    padding:
                                        EdgeInsets.fromLTRB(0, 0, 0, h * 0.05),
                                    child: Material(
                                      borderRadius: BorderRadius.circular(30),
                                      elevation: 15,
                                      child: TextField(
                                          controller: lastNameController,
                                          cursorColor:
                                              Color.fromARGB(255, 8, 54, 88),
                                          style: const TextStyle(
                                              color: Colors.black),
                                          decoration: InputDecoration(
                                              filled: true,
                                              fillColor: Colors.white,
                                              prefixIcon: const Icon(
                                                  Icons.person,
                                                  color: Color.fromARGB(
                                                      255, 8, 54, 88)),
                                              labelText: "Last Name",
                                              labelStyle: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 8, 54, 88),
                                                fontWeight: FontWeight.w600,
                                                fontSize: h * 0.020,
                                              ),
                                              focusedBorder: OutlineInputBorder(
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
                                                      color:
                                                          Colors.transparent),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30)))),
                                    ),
                                  ),
                                  Container(
                                      child: ElevatedButton(
                                          onPressed: () => {
                                                if (validators
                                                            .validateName(
                                                                firstNameController
                                                                    .text)
                                                            .length +
                                                        validators
                                                            .validateName(
                                                                middleNameController
                                                                    .text)
                                                            .length +
                                                        validators
                                                            .validateName(
                                                                lastNameController
                                                                    .text)
                                                            .length ==
                                                    0)
                                                  {
                                                    setState(() {
                                                      outerVisibility = 2;
                                                    })
                                                  }
                                                else
                                                  {
                                                    setState(() {
                                                      errorMessage = '';
                                                      if (validators
                                                              .validateName(
                                                                  firstNameController
                                                                      .text)
                                                              .length >
                                                          0) {
                                                        errorMessage += 'First Name' +
                                                            validators.validateName(
                                                                firstNameController
                                                                    .text);
                                                      }
                                                      if (validators
                                                              .validateName(
                                                                  middleNameController
                                                                      .text)
                                                              .length >
                                                          0) {
                                                        errorMessage += 'Middle Name' +
                                                            validators.validateName(
                                                                middleNameController
                                                                    .text);
                                                      }
                                                      if (validators
                                                              .validateName(
                                                                  lastNameController
                                                                      .text)
                                                              .length >
                                                          0) {
                                                        errorMessage += 'Last Name' +
                                                            validators.validateName(
                                                                lastNameController
                                                                    .text);
                                                      }
                                                    }),
                                                    Navigator.of(context).push(
                                                        MaterialPageRoute(
                                                            builder:
                                                                (context) =>
                                                                    AlertDialog(
                                                                      title: const Text(
                                                                          'Invalid input'),
                                                                      content: Text(
                                                                          '${errorMessage}'),
                                                                      actions: <
                                                                          Widget>[
                                                                        TextButton(
                                                                          onPressed: () => Navigator.pop(
                                                                              context,
                                                                              'OK'),
                                                                          child:
                                                                              const Text('OK'),
                                                                        ),
                                                                      ],
                                                                    )))
                                                  }
                                              },
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
                                                          BorderRadius.circular(
                                                              18.0),
                                                      side: BorderSide(color: Color.fromARGB(255, 8, 54, 88))))),
                                          child: Padding(padding: EdgeInsets.fromLTRB(w * 0.05, h * 0.005, w * 0.05, h * 0.005), child: Text('Next', style: TextStyle(fontFamily: 'comic', fontSize: w * 0.08, color: Colors.blue.shade50)))))
                                ])),
                            //Part 2 of visiblity
                            Visibility(
                                visible: (outerVisibility == 2),
                                child: Column(children: <Widget>[
                                  Container(
                                    padding:
                                        EdgeInsets.fromLTRB(0, 0, 0, h * 0.05),
                                    child: Material(
                                      borderRadius: BorderRadius.circular(30),
                                      elevation: 15,
                                      child: TextField(
                                        controller:
                                            dateOfBirthController, //editing controller of this TextField
                                        decoration: InputDecoration(
                                            fillColor: Colors.white,
                                            prefixIcon: Icon(Icons.date_range,
                                                color: Color.fromARGB(
                                                    255, 8, 54, 88)),
                                            labelText: "Date of Birth",
                                            labelStyle: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 8, 54, 88),
                                                fontWeight: FontWeight.w600,
                                                fontSize: h * 0.020),
                                            filled: true,
                                            focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Color.fromARGB(
                                                        255, 8, 54, 88),
                                                    width: 2.0),
                                                borderRadius:
                                                    BorderRadius.circular(30)),
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.transparent,
                                                    width: 2.0),
                                                borderRadius:
                                                    BorderRadius.circular(30))),
                                        readOnly:
                                            true, //set it true, so that user will not able to edit text

                                        onTap: () async {
                                          DateTime? pickedDate =
                                              await showDatePicker(
                                            context: context,
                                            initialDate: DateTime(
                                                DateTime.now().year - 17),
                                            firstDate: DateTime(1800),
                                            lastDate: DateTime(
                                                DateTime.now().year - 17),
                                          );

                                          if (pickedDate != null) {
                                            String formattedDate =
                                                DateFormat('dd-MM-yyyy')
                                                    .format(pickedDate);
                                            dateOfBirthController.text =
                                                formattedDate;
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding:
                                        EdgeInsets.fromLTRB(0, 0, 0, h * 0.05),
                                    child: Material(
                                      borderRadius: BorderRadius.circular(30),
                                      elevation: 15,
                                      child: TextField(
                                          controller: rollNumberController,
                                          cursorColor:
                                              Color.fromARGB(255, 8, 54, 88),
                                          style: const TextStyle(
                                              color: Colors.black),
                                          decoration: InputDecoration(
                                              filled: true,
                                              fillColor: Colors.white,
                                              prefixIcon: const Icon(
                                                  Icons.perm_identity,
                                                  color: Color.fromARGB(
                                                      255, 8, 54, 88)),
                                              labelText: "Roll Number",
                                              labelStyle: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 8, 54, 88),
                                                fontWeight: FontWeight.w600,
                                                fontSize: h * 0.020,
                                              ),
                                              focusedBorder: OutlineInputBorder(
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
                                                      color:
                                                          Colors.transparent),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30)))),
                                    ),
                                  ),
                                  Container(
                                    padding:
                                        EdgeInsets.fromLTRB(0, 0, 0, h * 0.05),
                                    child: Material(
                                      borderRadius: BorderRadius.circular(30),
                                      elevation: 15,
                                      child: TextField(
                                          cursorColor:
                                              Color.fromARGB(255, 8, 54, 88),
                                          style: const TextStyle(
                                              color: Colors.black),
                                          decoration: InputDecoration(
                                              filled: true,
                                              fillColor: Colors.white,
                                              prefixIcon: const Icon(
                                                  Icons.credit_card,
                                                  color: Color.fromARGB(
                                                      255, 8, 54, 88)),
                                              labelText: "I-Card",
                                              labelStyle: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 8, 54, 88),
                                                fontWeight: FontWeight.w600,
                                                fontSize: h * 0.020,
                                              ),
                                              focusedBorder: OutlineInputBorder(
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
                                                      color:
                                                          Colors.transparent),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30)))),
                                    ),
                                  ),
                                  Container(
                                      padding: EdgeInsets.fromLTRB(
                                          0, 0, 0, h * 0.05),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Container(
                                                child: ElevatedButton(
                                                    onPressed: () => {
                                                          setState(() {
                                                            outerVisibility = 1;
                                                          })
                                                        },
                                                    style: ButtonStyle(
                                                        elevation:
                                                            MaterialStateProperty.all(
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
                                                    child: Padding(padding: EdgeInsets.fromLTRB(w * 0.05, h * 0.005, w * 0.05, h * 0.005), child: Text('Back', style: TextStyle(fontFamily: 'comic', fontSize: w * 0.08, color: Colors.blue.shade50))))),
                                            Container(
                                                child: ElevatedButton(
                                                    onPressed: () => {
                                                          if (validators
                                                                      .checkNotEmpty(
                                                                          dateOfBirthController
                                                                              .text)
                                                                      .length ==
                                                                  0 &&
                                                              validators
                                                                      .validateRollNumber(
                                                                          rollNumberController
                                                                              .text)
                                                                      .length ==
                                                                  0)
                                                            {
                                                              setState(() {
                                                                outerVisibility =
                                                                    3;
                                                              })
                                                            }
                                                          else
                                                            {
                                                              setState(() {
                                                                errorMessage =
                                                                    '';
                                                                if (validators
                                                                        .checkNotEmpty(dateOfBirthController
                                                                            .text)
                                                                        .length >
                                                                    0)
                                                                  errorMessage +=
                                                                      'Date of Birth ' +
                                                                          validators
                                                                              .checkNotEmpty(dateOfBirthController.text);
                                                                errorMessage +=
                                                                    validators.validateRollNumber(
                                                                        rollNumberController
                                                                            .text);
                                                              }),
                                                              Navigator.of(context).push(
                                                                  MaterialPageRoute(
                                                                      builder:
                                                                          (context) =>
                                                                              AlertDialog(
                                                                                title: const Text('Invalid input'),
                                                                                content: Text('${errorMessage}'),
                                                                                actions: <Widget>[
                                                                                  TextButton(
                                                                                    onPressed: () => Navigator.pop(context, 'OK'),
                                                                                    child: const Text('OK'),
                                                                                  ),
                                                                                ],
                                                                              )))
                                                            }
                                                        },
                                                    style: ButtonStyle(
                                                        elevation: MaterialStateProperty.all(
                                                            15),
                                                        backgroundColor: MaterialStateProperty.all(
                                                            Color.fromARGB(
                                                                255, 8, 54, 88)),
                                                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                            RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius.circular(
                                                                        18.0),
                                                                side:
                                                                    BorderSide(
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          8,
                                                                          54,
                                                                          88),
                                                                )))),
                                                    child: Padding(
                                                        padding: EdgeInsets.fromLTRB(
                                                            w * 0.05,
                                                            h * 0.005,
                                                            w * 0.05,
                                                            h * 0.005),
                                                        child: Text('Next', style: TextStyle(fontFamily: 'comic', fontSize: w * 0.08, color: Colors.blue.shade50)))))
                                          ]))
                                ])),
                            //Part 3 of visiblity
                            Visibility(
                                visible: (outerVisibility == 3),
                                child: Column(children: <Widget>[
                                  //Phone Visibility 3.1
                                  Visibility(
                                    visible: (phoneNumberVisibility == 1),
                                    child: Column(children: [
                                      Container(
                                        padding: EdgeInsets.fromLTRB(
                                            0, 0, 0, h * 0.05),
                                        child: Material(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          elevation: 15,
                                          child: TextField(
                                              controller:
                                                  emergencyContactNumberController,
                                              cursorColor: Color.fromARGB(
                                                  255, 8, 54, 88),
                                              keyboardType: TextInputType.phone,
                                              style: const TextStyle(
                                                  color: Colors.black),
                                              decoration: InputDecoration(
                                                  filled: true,
                                                  fillColor: Colors.white,
                                                  prefixIcon: Padding(
                                                      padding: EdgeInsets.fromLTRB(
                                                          w * 0.035, 0, 0, 0),
                                                      child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: <Widget>[
                                                            Icon(Icons.phone,
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        8,
                                                                        54,
                                                                        88)),
                                                            Text(' +91 ',
                                                                style: TextStyle(
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            8,
                                                                            54,
                                                                            88),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontSize: h *
                                                                        0.02))
                                                          ])),
                                                  labelText:
                                                      "Emergency Contact Number",
                                                  labelStyle: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 8, 54, 88),
                                                    fontWeight: FontWeight.w600,
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
                                                      borderSide: const BorderSide(width: 2.0, color: Colors.transparent),
                                                      borderRadius: BorderRadius.circular(30)))),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.fromLTRB(
                                            0, 0, 0, h * 0.05),
                                        child: Material(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          elevation: 15,
                                          child: TextField(
                                              controller: phoneNumberController,
                                              cursorColor: Color.fromARGB(
                                                  255, 8, 54, 88),
                                              keyboardType: TextInputType.phone,
                                              style: const TextStyle(
                                                  color: Colors.black),
                                              decoration: InputDecoration(
                                                  filled: true,
                                                  fillColor: Colors.white,
                                                  prefixIcon: Padding(
                                                      padding: EdgeInsets.fromLTRB(
                                                          w * 0.035, 0, 0, 0),
                                                      child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: <Widget>[
                                                            Icon(Icons.phone,
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        8,
                                                                        54,
                                                                        88)),
                                                            Text(' +91 ',
                                                                style: TextStyle(
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            8,
                                                                            54,
                                                                            88),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    fontSize: h *
                                                                        0.02))
                                                          ])),
                                                  labelText: "Phone Number",
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
                                                      borderSide: const BorderSide(width: 2.0, color: Colors.transparent),
                                                      borderRadius: BorderRadius.circular(30)))),
                                        ),
                                      ),
                                      Container(
                                          child: ElevatedButton(
                                              onPressed: (() {
                                                errorMessage = '';
                                                if (validators
                                                            .validatePhoneNumber(
                                                                phoneNumberController
                                                                    .text)
                                                            .length >
                                                        0 ||
                                                    emergencyContactNumberController
                                                            .text ==
                                                        phoneNumberController
                                                            .text ||
                                                    validators
                                                            .validatePhoneNumber(
                                                                emergencyContactNumberController
                                                                    .text)
                                                            .length >
                                                        0) {
                                                  if (validators
                                                          .validatePhoneNumber(
                                                              phoneNumberController
                                                                  .text)
                                                          .length >
                                                      0) {
                                                    errorMessage =
                                                        'Invalid Phone Number\n';
                                                  }
                                                  if (validators
                                                          .validatePhoneNumber(
                                                              emergencyContactNumberController
                                                                  .text)
                                                          .length >
                                                      0) {
                                                    errorMessage +=
                                                        'Invalid Emergency Contact Number\n';
                                                  }
                                                  if (phoneNumberController
                                                          .text ==
                                                      emergencyContactNumberController
                                                          .text) {
                                                    errorMessage +=
                                                        'Phone Number and Emergency Contact Number cannot be same.\n';
                                                  }

                                                  Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              AlertDialog(
                                                                  title: const Text(
                                                                      'Invalid input'),
                                                                  content: Text(
                                                                      '${errorMessage}'),
                                                                  actions: <
                                                                      Widget>[
                                                                    TextButton(
                                                                      onPressed: () => Navigator.pop(
                                                                          context,
                                                                          'OK'),
                                                                      child: const Text(
                                                                          'OK'),
                                                                    )
                                                                  ])));
                                                } else {
                                                  verifyNumber();
                                                }
                                              }),
                                              style: ButtonStyle(
                                                  elevation:
                                                      MaterialStateProperty.all(
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
                                              child: Padding(padding: EdgeInsets.fromLTRB(w * 0.05, h * 0.005, w * 0.05, h * 0.005), child: Text('Send OTP', style: TextStyle(fontFamily: 'comic', fontSize: w * 0.08, color: Colors.blue.shade50)))))
                                    ]),
                                  ),
                                  //Phone Visibility 3.2
                                  Visibility(
                                    visible: (phoneNumberVisibility == 2),
                                    child: Column(children: [
                                      Container(
                                        padding: EdgeInsets.fromLTRB(
                                            0, 0, 0, h * 0.05),
                                        child: Material(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          elevation: 15,
                                          child: TextField(
                                              controller:
                                                  phoneNumberOTPController,
                                              cursorColor: Color.fromARGB(
                                                  255, 8, 54, 88),
                                              keyboardType:
                                                  TextInputType.number,
                                              style: const TextStyle(
                                                  color: Colors.black),
                                              decoration: InputDecoration(
                                                  filled: true,
                                                  fillColor: Colors.white,
                                                  prefixIcon: const Icon(
                                                      Icons.lock_rounded,
                                                      color: Color.fromARGB(
                                                          255, 8, 54, 88)),
                                                  labelText: "OTP",
                                                  labelStyle: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 8, 54, 88),
                                                    fontWeight: FontWeight.w600,
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
                                                      borderSide:
                                                          const BorderSide(
                                                              width: 2.0,
                                                              color: Colors
                                                                  .transparent),
                                                      borderRadius: BorderRadius.circular(30)))),
                                        ),
                                      ),
                                      Container(
                                          child: ElevatedButton(
                                              onPressed: (() {
                                                verifyCode();
                                              }),
                                              style: ButtonStyle(
                                                  elevation:
                                                      MaterialStateProperty.all(
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
                                              child: Padding(padding: EdgeInsets.fromLTRB(w * 0.05, h * 0.005, w * 0.05, h * 0.005), child: Text('Verify', style: TextStyle(fontFamily: 'comic', fontSize: w * 0.08, color: Colors.blue.shade50)))))
                                    ]),
                                  )
                                ])),
                            //Part 4 of visiblity
                            Visibility(
                                visible: (outerVisibility == 4),
                                child: Column(children: <Widget>[
                                  Container(
                                    padding:
                                        EdgeInsets.fromLTRB(0, 0, 0, h * 0.05),
                                    child: Material(
                                      borderRadius: BorderRadius.circular(30),
                                      elevation: 15,
                                      child: TextField(
                                          controller:
                                              organizationEMailIDController,
                                          cursorColor:
                                              Color.fromARGB(255, 8, 54, 88),
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          style: const TextStyle(
                                              color: Colors.black),
                                          decoration: InputDecoration(
                                              filled: true,
                                              fillColor: Colors.white,
                                              prefixIcon: const Icon(
                                                  Icons.email,
                                                  color: Color.fromARGB(
                                                      255, 8, 54, 88)),
                                              labelText: "Organization Email",
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
                                                      BorderRadius.circular(
                                                          30)),
                                              enabledBorder: OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                      width: 2.0,
                                                      color:
                                                          Colors.transparent),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30)))),
                                    ),
                                  ),
                                  Container(
                                    padding:
                                        EdgeInsets.fromLTRB(0, 0, 0, h * 0.05),
                                    child: Material(
                                      borderRadius: BorderRadius.circular(30),
                                      elevation: 15,
                                      child: TextField(
                                          obscureText: true,
                                          controller: passwordController,
                                          cursorColor:
                                              Color.fromARGB(255, 8, 54, 88),
                                          style: const TextStyle(
                                              color: Colors.black),
                                          decoration: InputDecoration(
                                              filled: true,
                                              fillColor: Colors.white,
                                              prefixIcon: const Icon(
                                                  Icons.fingerprint,
                                                  color: Color.fromARGB(
                                                      255, 8, 54, 88)),
                                              labelText: "Password",
                                              labelStyle: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 8, 54, 88),
                                                fontWeight: FontWeight.w600,
                                                fontSize: h * 0.020,
                                              ),
                                              focusedBorder: OutlineInputBorder(
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
                                                      color:
                                                          Colors.transparent),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30)))),
                                    ),
                                  ),
                                  Container(
                                    padding:
                                        EdgeInsets.fromLTRB(0, 0, 0, h * 0.05),
                                    child: Material(
                                      borderRadius: BorderRadius.circular(30),
                                      elevation: 15,
                                      child: TextField(
                                          obscureText: true,
                                          controller: confirmPasswordController,
                                          cursorColor:
                                              Color.fromARGB(255, 8, 54, 88),
                                          style: const TextStyle(
                                              color: Colors.black),
                                          decoration: InputDecoration(
                                              filled: true,
                                              fillColor: Colors.white,
                                              prefixIcon: const Icon(
                                                  Icons.fingerprint,
                                                  color: Color.fromARGB(
                                                      255, 8, 54, 88)),
                                              labelText: "Confirm Password",
                                              labelStyle: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 8, 54, 88),
                                                fontWeight: FontWeight.w600,
                                                fontSize: h * 0.020,
                                              ),
                                              focusedBorder: OutlineInputBorder(
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
                                                      color:
                                                          Colors.transparent),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30)))),
                                    ),
                                  ),
                                  Container(
                                      child: ElevatedButton(
                                          onPressed: (() {
                                            if (validators
                                                        .validateEmail(
                                                            organizationEMailIDController
                                                                .text)
                                                        .length ==
                                                    0 &&
                                                validators
                                                        .validatePassword(
                                                            passwordController
                                                                .text)
                                                        .length ==
                                                    0 &&
                                                passwordController.text ==
                                                    confirmPasswordController
                                                        .text) {
                                              FirebaseFirestore.instance
                                                  .collection(
                                                      'Mapping/Permanent/MailtoPhone')
                                                  .doc(
                                                      organizationEMailIDController
                                                          .text)
                                                  .get()
                                                  .then((result) => {
                                                        if (!result.exists)
                                                          {
                                                            FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    'Mapping/Admin/MailtoPhone')
                                                                .doc(
                                                                    organizationEMailIDController
                                                                        .text)
                                                                .get()
                                                                .then(
                                                                    (result) =>
                                                                        {
                                                                          if (!result
                                                                              .exists)
                                                                            {
                                                                              auth.createUserWithEmailAndPassword(email: organizationEMailIDController.text, password: passwordController.text).then((value) => {
                                                                                    Navigator.of(context).push(MaterialPageRoute(
                                                                                        builder: (context) => AlertDialog(title: Text('Verify Email'), content: Text('An email has been sent to the ${value.user?.email} please verify it by clicking it to the link on email'), actions: <Widget>[
                                                                                              Visibility(
                                                                                                visible: false,
                                                                                                child: TextButton(
                                                                                                  onPressed: () => Navigator.pop(context, 'OK'),
                                                                                                  child: const Text('OK'),
                                                                                                ),
                                                                                              )
                                                                                            ]))),
                                                                                    setState(() {
                                                                                      user = auth.currentUser!;
                                                                                      user.sendEmailVerification();

                                                                                      timer = Timer.periodic(Duration(seconds: 3), (timer) {
                                                                                        checkEmailVerified();
                                                                                      });
                                                                                    })
                                                                                  })
                                                                            }
                                                                          else
                                                                            {
                                                                              Navigator.of(context).push(MaterialPageRoute(
                                                                                  builder: (context) => AlertDialog(title: const Text('Invalid input'), content: Text("You have already requested registration with this email ID, please wait for admin to accept!"), actions: <Widget>[
                                                                                        TextButton(
                                                                                          onPressed: () => Navigator.pop(context, 'OK'),
                                                                                          child: const Text('OK'),
                                                                                        )
                                                                                      ])))
                                                                            }
                                                                        })
                                                          }
                                                        else
                                                          {
                                                            Navigator.of(context).push(
                                                                MaterialPageRoute(
                                                                    builder: (context) =>
                                                                        AlertDialog(
                                                                            title:
                                                                                const Text('Invalid input'),
                                                                            content: Text("You are already a user with this email ID!"),
                                                                            actions: <Widget>[
                                                                              TextButton(
                                                                                onPressed: () => Navigator.pop(context, 'OK'),
                                                                                child: const Text('OK'),
                                                                              )
                                                                            ])))
                                                          }
                                                      });
                                            } else {
                                              setState(() {
                                                errorMessage = '';
                                                if (validators
                                                        .validateEmail(
                                                            organizationEMailIDController
                                                                .text)
                                                        .length >
                                                    0) {
                                                  errorMessage +=
                                                      validators.validateEmail(
                                                          organizationEMailIDController
                                                              .text);
                                                }
                                                if (validators
                                                        .validatePassword(
                                                            passwordController
                                                                .text)
                                                        .length >
                                                    0) {
                                                  errorMessage += validators
                                                      .validatePassword(
                                                          passwordController
                                                              .text);
                                                }
                                                if (passwordController.text !=
                                                    confirmPasswordController
                                                        .text) {
                                                  errorMessage +=
                                                      "Password and Confirm Password Must be Same";
                                                }
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            AlertDialog(
                                                                title: const Text(
                                                                    'Invalid input'),
                                                                content: Text(
                                                                    '${errorMessage}'),
                                                                actions: <
                                                                    Widget>[
                                                                  TextButton(
                                                                    onPressed: () =>
                                                                        Navigator.pop(
                                                                            context,
                                                                            'OK'),
                                                                    child:
                                                                        const Text(
                                                                            'OK'),
                                                                  )
                                                                ])));
                                              });
                                            }
                                          }),
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
                                                          BorderRadius.circular(
                                                              18.0),
                                                      side: BorderSide(color: Color.fromARGB(255, 8, 54, 88))))),
                                          child: Padding(padding: EdgeInsets.fromLTRB(w * 0.05, h * 0.005, w * 0.05, h * 0.005), child: Text('Verify', style: TextStyle(fontFamily: 'comic', fontSize: w * 0.08, color: Colors.blue.shade50)))))
                                ]))
                          ]))),
                ))
          ]),
        ],
      )))
    ]);
  }

  void verifyNumber() async {
    await FirebaseFirestore.instance
        .collection('Mapping/Permanent/PhonetoMail')
        .doc(utilities.add91(phoneNumberController.text))
        .get()
        .then((result) => {
              if (!result.exists)
                {
                  FirebaseFirestore.instance
                      .collection('Mapping/Admin/PhonetoMail')
                      .doc(utilities.add91(phoneNumberController.text))
                      .get()
                      .then((result) => {
                            if (!result.exists)
                              {
                                auth.verifyPhoneNumber(
                                    phoneNumber: utilities
                                        .add91(phoneNumberController.text),
                                    verificationCompleted: (PhoneAuthCredential
                                        credential) async {},
                                    verificationFailed:
                                        (FirebaseAuthException exception) {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  Register()));
                                    },
                                    codeSent: (String verificationID,
                                        int? resendToken) {
                                      verificationIdReceived = verificationID;
                                      phoneNumberVisibility = 2;
                                      setState(() {});
                                    },
                                    codeAutoRetrievalTimeout:
                                        (String verificationID) {})
                              }
                            else
                              {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => AlertDialog(
                                            title: const Text('Invalid input'),
                                            content: Text(
                                                "You have already requested registration. Please wait until admin verifies your details."),
                                            actions: <Widget>[
                                              TextButton(
                                                onPressed: () => Navigator.pop(
                                                    context, 'OK'),
                                                child: const Text('OK'),
                                              )
                                            ])))
                              }
                          })
                }
              else
                {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => AlertDialog(
                              title: const Text('Invalid input'),
                              content: Text(
                                  "You are already a user with this phone number!"),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () => Navigator.pop(context, 'OK'),
                                  child: const Text('OK'),
                                )
                              ])))
                }
            });
  }

  void verifyCode() async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationIdReceived,
        smsCode: phoneNumberOTPController.text);

    await auth.signInWithCredential(credential).then((value) => {
          setState(() {
            outerVisibility = 4;
          })
        });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  Future<void> checkEmailVerified() async {
    user = auth.currentUser!;
    await user.reload();
    if (user.emailVerified) {
      timer.cancel();
      manageUsers.verificationOfUserInformation(
          phoneNumberController.text,
          passwordController.text,
          firstNameController.text,
          middleNameController.text,
          lastNameController.text,
          dateOfBirthController.text,
          emergencyContactNumberController.text,
          organizationEMailIDController.text,
          rollNumberController.text);
      await FirebaseFirestore.instance
          .collection('Mapping/Admin/PhonetoMail')
          .doc(utilities.add91(phoneNumberController.text))
          .set({'Email': organizationEMailIDController.text});
      await FirebaseFirestore.instance
          .collection('Mapping/Admin/MailtoPhone')
          .doc(organizationEMailIDController.text)
          .set({'PhoneNumber': utilities.add91(phoneNumberController.text)});
      Navigator.pop(context, 'OK');
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Home()));
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => AlertDialog(
                  title: Text('Notice'),
                  content: Text('Please wait for Admin Acknowledgement'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'OK'),
                      child: const Text('OK'),
                    )
                  ])));
    }
  }
}
