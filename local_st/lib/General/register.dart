import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:local_st/Admin/manage_users.dart';
import 'package:local_st/Data-Services/utilities.dart';
import 'package:local_st/Data-Services/validators.dart';
import 'package:local_st/Reusable/colors.dart';
import 'package:local_st/Reusable/size_config.dart';
import 'login.dart';
import 'package:intl/intl.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

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
  FilePickerResult? idCardPicker;
  FilePickerResult? profilePhotoPicker;
  List<String> roles = ['Student', 'Faculty', 'Other'];
  String roleValue = 'Student';

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

  @override
  Widget build(BuildContext context) {
    //height and width of screen
    SizeConfig sizeConfig = SizeConfig(context);
    double h = sizeConfig.screenHeight;
    double w = sizeConfig.screenWidth;

    return Stack(children: <Widget>[
      SafeArea(
          child: Scaffold(
              body: Stack(
        children: [
          Container(height: h * 0.315, color: MyColorScheme.darkColor),
          Padding(
            padding: outerVisibility == 1
                ? EdgeInsets.fromLTRB(0, 0.095 * h, 0.55 * w, 0)
                : (outerVisibility == 2
                    ? EdgeInsets.fromLTRB(0, 0.095 * h, 0.20 * w, 0)
                    : ((outerVisibility == 3)
                        ? EdgeInsets.fromLTRB(0.20 * w, 0.1 * h, 0, 0)
                        : EdgeInsets.fromLTRB(0.55 * w, 0.095 * h, 0, 0))),
            child: Container(
              height: h * 0.17,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/bike1.png'))),
            ),
          ),
          Column(children: <Widget>[
            Expanded(
                flex: 4,
                child: Stack(
                  children: [
                    Padding(
                        padding: EdgeInsets.fromLTRB(0, h * 0.03, 0, 0),
                        child: Text('Smart Transportation',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: h * 0.045,
                              letterSpacing: 2,
                              fontFamily: 'NotoSans',
                              fontWeight: FontWeight.w900,
                              color: MyColorScheme.baseColor,
                            ))),
                  ],
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
                                          cursorColor: MyColorScheme.darkColor,
                                          style: TextStyle(
                                              color: MyColorScheme.darkColor),
                                          decoration: InputDecoration(
                                              filled: true,
                                              fillColor:
                                                  MyColorScheme.baseColor,
                                              prefixIcon: Icon(Icons.person,
                                                  color:
                                                      MyColorScheme.darkColor),
                                              labelText: "First Name",
                                              labelStyle: TextStyle(
                                                color: MyColorScheme.darkColor,
                                                fontWeight: FontWeight.w600,
                                                fontSize: h * 0.020,
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                  // ignore: prefer_const_constructors
                                                  borderSide: BorderSide(
                                                      color: MyColorScheme
                                                          .darkColor,
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
                                          cursorColor: MyColorScheme.darkColor,
                                          style: TextStyle(
                                              color: MyColorScheme.darkColor),
                                          decoration: InputDecoration(
                                              filled: true,
                                              fillColor:
                                                  MyColorScheme.baseColor,
                                              prefixIcon: Icon(Icons.person,
                                                  color:
                                                      MyColorScheme.darkColor),
                                              labelText: "Middle Name",
                                              labelStyle: TextStyle(
                                                color: MyColorScheme.darkColor,
                                                fontWeight: FontWeight.w600,
                                                fontSize: h * 0.020,
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                  // ignore: prefer_const_constructors
                                                  borderSide: BorderSide(
                                                      color: MyColorScheme
                                                          .darkColor,
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
                                          cursorColor: MyColorScheme.darkColor,
                                          style: TextStyle(
                                              color: MyColorScheme.darkColor),
                                          decoration: InputDecoration(
                                              filled: true,
                                              fillColor:
                                                  MyColorScheme.baseColor,
                                              prefixIcon: Icon(Icons.person,
                                                  color:
                                                      MyColorScheme.darkColor),
                                              labelText: "Last Name",
                                              labelStyle: TextStyle(
                                                color: MyColorScheme.darkColor,
                                                fontWeight: FontWeight.w600,
                                                fontSize: h * 0.020,
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                  // ignore: prefer_const_constructors
                                                  borderSide: BorderSide(
                                                      color: MyColorScheme
                                                          .darkColor,
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
                                  ElevatedButton(
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
                                                      .isNotEmpty) {
                                                    errorMessage += 'First Name' +
                                                        validators.validateName(
                                                            firstNameController
                                                                .text);
                                                  }
                                                  if (validators
                                                      .validateName(
                                                          middleNameController
                                                              .text)
                                                      .isNotEmpty) {
                                                    errorMessage += 'Middle Name' +
                                                        validators.validateName(
                                                            middleNameController
                                                                .text);
                                                  }
                                                  if (validators
                                                      .validateName(
                                                          lastNameController
                                                              .text)
                                                      .isNotEmpty) {
                                                    errorMessage += 'Last Name' +
                                                        validators.validateName(
                                                            lastNameController
                                                                .text);
                                                  }
                                                }),
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            AlertDialog(
                                                              title: const Text(
                                                                  'Invalid input'),
                                                              content: Text(
                                                                  errorMessage),
                                                              actions: <Widget>[
                                                                TextButton(
                                                                  onPressed: () =>
                                                                      Navigator.pop(
                                                                          context,
                                                                          'OK'),
                                                                  child:
                                                                      const Text(
                                                                          'OK'),
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
                                                  MyColorScheme.darkColor),
                                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(18.0),
                                              side: BorderSide(
                                                  color: MyColorScheme
                                                      .darkColor)))),
                                      child: Padding(
                                          padding: EdgeInsets.fromLTRB(w * 0.05,
                                              h * 0.005, w * 0.05, h * 0.005),
                                          child: Text('NEXT', style: TextStyle(fontFamily: 'Montserrat', fontSize: w * 0.06, color: MyColorScheme.baseColor)))),
                                  TextButton(
                                      onPressed: () => {
                                            Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: ((context) =>
                                                        const Login())))
                                          },
                                      child: Padding(
                                          padding: EdgeInsets.fromLTRB(
                                              0, h * 0.01, 0, 0),
                                          child: Text(
                                              "Already have an account? Login",
                                              style: TextStyle(
                                                  fontSize: h * 0.02,
                                                  color:
                                                      MyColorScheme.darkColor,
                                                  fontWeight: FontWeight.w700,
                                                  decoration: TextDecoration
                                                      .underline))))
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
                                            fillColor: MyColorScheme.baseColor,
                                            prefixIcon: Icon(Icons.cake,
                                                color: MyColorScheme.darkColor),
                                            labelText: "Date of Birth",
                                            labelStyle: TextStyle(
                                                color: MyColorScheme.darkColor,
                                                fontWeight: FontWeight.w600,
                                                fontSize: h * 0.020),
                                            filled: true,
                                            focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color:
                                                        MyColorScheme.darkColor,
                                                    width: 2.0),
                                                borderRadius:
                                                    BorderRadius.circular(30)),
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
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
                                            builder: (context, child) {
                                              return Theme(
                                                  data: Theme.of(context)
                                                      .copyWith(
                                                          colorScheme:
                                                              ColorScheme.light(
                                                            primary:
                                                                MyColorScheme
                                                                    .darkColor,
                                                            onPrimary:
                                                                MyColorScheme
                                                                    .baseColor,
                                                            onSurface:
                                                                MyColorScheme
                                                                    .darkColor,
                                                          ),
                                                          textButtonTheme:
                                                              TextButtonThemeData(
                                                                  style: TextButton
                                                                      .styleFrom(
                                                            foregroundColor: Colors
                                                                .blueAccent, // button text color
                                                          ))),
                                                  child: child!);
                                            },
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
                                          cursorColor: MyColorScheme.darkColor,
                                          style: TextStyle(
                                              color: MyColorScheme.darkColor),
                                          decoration: InputDecoration(
                                              filled: true,
                                              fillColor:
                                                  MyColorScheme.baseColor,
                                              prefixIcon: Icon(Icons.pin,
                                                  color:
                                                      MyColorScheme.darkColor),
                                              labelText: "Roll Number",
                                              labelStyle: TextStyle(
                                                color: MyColorScheme.darkColor,
                                                fontWeight: FontWeight.w600,
                                                fontSize: h * 0.020,
                                              ),
                                              hintText: "e.g. 12BCH123",
                                              focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: MyColorScheme
                                                          .darkColor,
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
                                  Padding(
                                      padding: EdgeInsets.fromLTRB(
                                          0, 0, 0, h * 0.05),
                                      child: Material(
                                        borderRadius: BorderRadius.circular(30),
                                        elevation: 15,
                                        color: MyColorScheme.baseColor,
                                        child: Row(
                                          children: [
                                            Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    0.03 * w, 0, 0, 0),
                                                child: const Icon(Icons.person)),
                                            DropdownButton(
                                                iconSize: 0,
                                                focusColor:
                                                    MyColorScheme.bgColor,
                                                hint: Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      w * 0.03, 0, 0, 0),
                                                  child: Text('Role',
                                                      style: TextStyle(
                                                          fontSize: h * 0.020,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: MyColorScheme
                                                              .darkColor)),
                                                ),
                                                value: roleValue,
                                                onChanged: (newValue) {
                                                  setState(() {
                                                    roleValue =
                                                        newValue!.toString();
                                                  });
                                                },
                                                items: roles.map((options) {
                                                  return DropdownMenuItem(
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.fromLTRB(
                                                                w * 0.05,
                                                                0,
                                                                w * 0.05,
                                                                0),
                                                        child: Text(options,
                                                            style: const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                      ),
                                                      value: options);
                                                }).toList(),
                                                style: TextStyle(
                                                    color: MyColorScheme
                                                        .darkColor)),
                                          ],
                                        ),
                                      )),
                                  Container(
                                    padding:
                                        EdgeInsets.fromLTRB(0, 0, 0, h * 0.05),
                                    child: Material(
                                      borderRadius: BorderRadius.circular(30),
                                      elevation: 15,
                                      child: SizedBox(
                                        height: h * 0.08,
                                        width: w,
                                        child: TextButton(
                                            style: ButtonStyle(
                                                shape: MaterialStateProperty.all<
                                                        RoundedRectangleBorder>(
                                                    RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30))),
                                                backgroundColor:
                                                    MaterialStateProperty
                                                        .resolveWith<Color?>(
                                                            (Set<MaterialState>
                                                                states) {
                                                  if (states.contains(
                                                      MaterialState.pressed)) {
                                                    return Theme.of(context)
                                                        .colorScheme
                                                        .primary
                                                        .withOpacity(0.5);
                                                  }
                                                  return Theme.of(context)
                                                      .colorScheme
                                                      .primary
                                                      .withRed(249)
                                                      .withGreen(245)
                                                      .withBlue(
                                                          242); // Use the component's default.
                                                })),
                                            onPressed: () async {
                                              idCardPicker = await FilePicker
                                                  .platform
                                                  .pickFiles(
                                                      type: FileType.image);
                                            },
                                            child: Row(
                                              children: [
                                                Padding(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            w * 0.01,
                                                            0,
                                                            w * 0.05,
                                                            0),
                                                    child: Icon(
                                                        Icons.remember_me,
                                                        color: MyColorScheme
                                                            .darkColor)),
                                                Text('ID Card Photo',
                                                    style: TextStyle(
                                                        color: MyColorScheme
                                                            .darkColor,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: h * 0.020)),
                                              ],
                                            )),
                                      ),
                                    ),
                                  ),
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                    ElevatedButton(
                                        onPressed: () => {
                                              setState(() {
                                                outerVisibility = 1;
                                              })
                                            },
                                        style: ButtonStyle(
                                            elevation: MaterialStateProperty.all(
                                                15),
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
                                            padding:
                                                EdgeInsets.fromLTRB(w * 0.05, h * 0.005, w * 0.05, h * 0.005),
                                            child: Text('BACK', style: TextStyle(fontFamily: 'Montserrat', fontSize: w * 0.06, color: MyColorScheme.baseColor)))),
                                    ElevatedButton(
                                        onPressed: () => {
                                              if (validators
                                                      .checkNotEmpty(
                                                          dateOfBirthController
                                                              .text)
                                                      .isEmpty &&
                                                  validators
                                                      .validateRollNumber(
                                                          rollNumberController
                                                              .text)
                                                      .isEmpty &&
                                                  idCardPicker != null &&
                                                  idCardPicker?.files !=
                                                      null)
                                                {
                                                  setState(() {
                                                    outerVisibility = 3;
                                                  })
                                                }
                                              else
                                                {
                                                  setState(() {
                                                    errorMessage = '';
                                                    if (validators
                                                        .checkNotEmpty(
                                                            dateOfBirthController
                                                                .text)
                                                        .isNotEmpty) {
                                                      errorMessage +=
                                                          'Date of Birth ' +
                                                              validators.checkNotEmpty(
                                                                  dateOfBirthController
                                                                      .text);
                                                    }
                                                    errorMessage += validators
                                                        .validateRollNumber(
                                                            rollNumberController
                                                                .text);
                                                    if (idCardPicker ==
                                                        null) {
                                                      errorMessage +=
                                                          'IDCard not added!\n';
                                                    }
                                                  }),
                                                  Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder:
                                                              (context) =>
                                                                  AlertDialog(
                                                                    title: const Text(
                                                                        'Invalid input'),
                                                                    content:
                                                                        Text(errorMessage),
                                                                    actions: <
                                                                        Widget>[
                                                                      TextButton(
                                                                        onPressed: () =>
                                                                            Navigator.pop(context, 'OK'),
                                                                        child:
                                                                            const Text('OK'),
                                                                      ),
                                                                    ],
                                                                  )))
                                                }
                                            },
                                        style: ButtonStyle(
                                            elevation:
                                                MaterialStateProperty.all(
                                                    15),
                                            backgroundColor: MaterialStateProperty.all(
                                                MyColorScheme.darkColor),
                                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            18.0),
                                                    side: BorderSide(
                                                      color: MyColorScheme
                                                          .darkColor,
                                                    )))),
                                        child: Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                w * 0.05,
                                                h * 0.005,
                                                w * 0.05,
                                                h * 0.005),
                                            child: Text('NEXT',
                                                style: TextStyle(
                                                    fontFamily: 'Montserrat',
                                                    fontSize: w * 0.06,
                                                    color: MyColorScheme.baseColor))))
                                  ])
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
                                              controller: phoneNumberController,
                                              cursorColor: MyColorScheme
                                                  .darkColor,
                                              keyboardType: TextInputType.phone,
                                              style: TextStyle(
                                                  color: MyColorScheme
                                                      .darkColor),
                                              decoration: InputDecoration(
                                                  filled: true,
                                                  fillColor: MyColorScheme
                                                      .baseColor,
                                                  prefixIcon: Icon(Icons.phone,
                                                      color: MyColorScheme
                                                          .darkColor),
                                                  labelText: "Phone Number",
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
                                                              color:
                                                                  MyColorScheme
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
                                                              30)))),
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
                                              controller:
                                                  emergencyContactNumberController,
                                              cursorColor: MyColorScheme
                                                  .darkColor,
                                              keyboardType: TextInputType.phone,
                                              style: TextStyle(
                                                  color: MyColorScheme
                                                      .darkColor),
                                              decoration: InputDecoration(
                                                  filled: true,
                                                  fillColor: MyColorScheme
                                                      .baseColor,
                                                  prefixIcon: Icon(
                                                      Icons.add_call,
                                                      color: MyColorScheme
                                                          .darkColor),
                                                  labelText:
                                                      "Emergency Contact Number",
                                                  labelStyle: TextStyle(
                                                    color:
                                                        MyColorScheme.darkColor,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: h * 0.020,
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                          // ignore: prefer_const_constructors
                                                          borderSide: BorderSide(
                                                              color:
                                                                  MyColorScheme
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
                                                              30)))),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.fromLTRB(
                                            0, 0, 0, h * 0.05),
                                        child: Material(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          elevation: 15,
                                          child: SizedBox(
                                            height: h * 0.08,
                                            width: w,
                                            child: TextButton(
                                                style: ButtonStyle(
                                                    shape: MaterialStateProperty.all<
                                                            RoundedRectangleBorder>(
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        30))),
                                                    backgroundColor:
                                                        MaterialStateProperty
                                                            .resolveWith<
                                                                Color?>((Set<
                                                                    MaterialState>
                                                                states) {
                                                      if (states.contains(
                                                          MaterialState
                                                              .pressed)) {
                                                        return Theme.of(context)
                                                            .colorScheme
                                                            .primary
                                                            .withOpacity(0.5);
                                                      }
                                                      return Theme.of(context)
                                                          .colorScheme
                                                          .primary
                                                          .withRed(249)
                                                          .withGreen(245)
                                                          .withBlue(
                                                              242); // Use the component's default.
                                                    })),
                                                onPressed: () async {
                                                  profilePhotoPicker =
                                                      await FilePicker.platform
                                                          .pickFiles(
                                                              type: FileType
                                                                  .image);
                                                },
                                                child: Row(
                                                  children: [
                                                    Padding(
                                                        padding:
                                                            EdgeInsets.fromLTRB(
                                                                w * 0.01,
                                                                0,
                                                                w * 0.05,
                                                                0),
                                                        child: Icon(
                                                            Icons.person_pin,
                                                            color: MyColorScheme
                                                                .darkColor)),
                                                    Text('Profile Photo',
                                                        style: TextStyle(
                                                            color: MyColorScheme
                                                                .darkColor,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize:
                                                                h * 0.020)),
                                                  ],
                                                )),
                                          ),
                                        ),
                                      ),
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            ElevatedButton(
                                                onPressed: () => {
                                                      setState(() {
                                                        outerVisibility = 2;
                                                      })
                                                    },
                                                style: ButtonStyle(
                                                    elevation: MaterialStateProperty.all(
                                                        15),
                                                    backgroundColor:
                                                        MaterialStateProperty.all(
                                                            MyColorScheme
                                                                .darkColor),
                                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(
                                                            18.0),
                                                        side: BorderSide(
                                                            color: MyColorScheme
                                                                .darkColor)))),
                                                child: Padding(
                                                    padding: EdgeInsets.fromLTRB(w * 0.02, h * 0.005, w * 0.02, h * 0.005),
                                                    child: Text('BACK', style: TextStyle(fontFamily: 'Montserrat', fontSize: w * 0.06, color: MyColorScheme.baseColor)))),
                                            ElevatedButton(
                                                onPressed: (() {
                                                  errorMessage = '';
                                                  if (validators.validatePhoneNumber(phoneNumberController.text).isNotEmpty ||
                                                      emergencyContactNumberController
                                                              .text ==
                                                          phoneNumberController
                                                              .text ||
                                                      validators
                                                          .validatePhoneNumber(
                                                              emergencyContactNumberController
                                                                  .text)
                                                          .isNotEmpty ||
                                                      profilePhotoPicker ==
                                                          null) {
                                                    if (validators
                                                        .validatePhoneNumber(
                                                            phoneNumberController
                                                                .text)
                                                        .isNotEmpty) {
                                                      errorMessage =
                                                          'Invalid Phone Number\n';
                                                    }
                                                    if (validators
                                                        .validatePhoneNumber(
                                                            emergencyContactNumberController
                                                                .text)
                                                        .isNotEmpty) {
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
                                                    if (profilePhotoPicker ==
                                                        null) {
                                                      errorMessage +=
                                                          'You must select a profile photo to be verified with ID Card\n';
                                                    }

                                                    Navigator.of(context).push(
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                AlertDialog(
                                                                    title: const Text(
                                                                        'Invalid input'),
                                                                    content: Text(
                                                                        errorMessage),
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
                                                    elevation: MaterialStateProperty.all(
                                                        15),
                                                    backgroundColor:
                                                        MaterialStateProperty.all(
                                                            MyColorScheme
                                                                .darkColor),
                                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(
                                                            18.0),
                                                        side: BorderSide(
                                                            color: MyColorScheme
                                                                .darkColor)))),
                                                child: Padding(
                                                    padding: EdgeInsets.fromLTRB(w * 0.02, h * 0.005, w * 0.02, h * 0.005),
                                                    child: Text('SEND OTP', style: TextStyle(fontFamily: 'Montserrat', fontSize: w * 0.06, color: MyColorScheme.baseColor))))
                                          ])
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
                                              obscureText: true,
                                              cursorColor: MyColorScheme
                                                  .darkColor,
                                              keyboardType: TextInputType
                                                  .number,
                                              style: TextStyle(
                                                  color: MyColorScheme
                                                      .darkColor),
                                              decoration: InputDecoration(
                                                  filled: true,
                                                  fillColor: MyColorScheme
                                                      .baseColor,
                                                  prefixIcon: Icon(
                                                      Icons.lock_rounded,
                                                      color: MyColorScheme
                                                          .darkColor),
                                                  labelText: "OTP",
                                                  labelStyle: TextStyle(
                                                    color:
                                                        MyColorScheme.darkColor,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: h * 0.020,
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                          // ignore: prefer_const_constructors
                                                          borderSide: BorderSide(
                                                              color:
                                                                  MyColorScheme
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
                                                              30)))),
                                        ),
                                      ),
                                      ElevatedButton(
                                          onPressed: (() {
                                            verifyCode();
                                          }),
                                          style: ButtonStyle(
                                              elevation:
                                                  MaterialStateProperty.all(15),
                                              backgroundColor:
                                                  MaterialStateProperty.all(
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
                                              child: Text('VERIFY', style: TextStyle(fontFamily: 'Montserrat', fontSize: w * 0.06, color: MyColorScheme.baseColor))))
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
                                          cursorColor: MyColorScheme.darkColor,
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          style: TextStyle(
                                              color: MyColorScheme.darkColor),
                                          decoration: InputDecoration(
                                              filled: true,
                                              fillColor:
                                                  MyColorScheme.baseColor,
                                              prefixIcon: Icon(Icons.email,
                                                  color:
                                                      MyColorScheme.darkColor),
                                              labelText: "Organization Email",
                                              labelStyle: TextStyle(
                                                color: MyColorScheme.darkColor,
                                                fontWeight: FontWeight.w800,
                                                fontSize: h * 0.020,
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                  // ignore: prefer_const_constructors
                                                  borderSide: BorderSide(
                                                      color: MyColorScheme
                                                          .darkColor,
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
                                          cursorColor: MyColorScheme.darkColor,
                                          style: TextStyle(
                                              color: MyColorScheme.darkColor),
                                          decoration: InputDecoration(
                                              filled: true,
                                              fillColor:
                                                  MyColorScheme.baseColor,
                                              prefixIcon: Icon(
                                                  Icons.fingerprint,
                                                  color:
                                                      MyColorScheme.darkColor),
                                              labelText: "Password",
                                              labelStyle: TextStyle(
                                                color: MyColorScheme.darkColor,
                                                fontWeight: FontWeight.w600,
                                                fontSize: h * 0.020,
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                  // ignore: prefer_const_constructors
                                                  borderSide: BorderSide(
                                                      color: MyColorScheme
                                                          .darkColor,
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
                                          cursorColor: MyColorScheme.darkColor,
                                          style: TextStyle(
                                              color: MyColorScheme.darkColor),
                                          decoration: InputDecoration(
                                              filled: true,
                                              fillColor:
                                                  MyColorScheme.baseColor,
                                              prefixIcon: Icon(
                                                  Icons.fingerprint,
                                                  color:
                                                      MyColorScheme.darkColor),
                                              labelText: "Confirm Password",
                                              labelStyle: TextStyle(
                                                color: MyColorScheme.darkColor,
                                                fontWeight: FontWeight.w600,
                                                fontSize: h * 0.020,
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                  // ignore: prefer_const_constructors
                                                  borderSide: BorderSide(
                                                      color: MyColorScheme
                                                          .darkColor,
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
                                  ElevatedButton(
                                      onPressed: (() {
                                        if (validators
                                                .validateEmail(
                                                    organizationEMailIDController
                                                        .text)
                                                .isEmpty &&
                                            validators
                                                .validatePassword(
                                                    passwordController.text)
                                                .isEmpty &&
                                            passwordController.text ==
                                                confirmPasswordController
                                                    .text) {
                                          FirebaseFirestore.instance
                                              .collection(
                                                  'Mapping/Permanent/MailtoPhone')
                                              .doc(organizationEMailIDController
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
                                                            .then((result) => {
                                                                  if (!result
                                                                      .exists)
                                                                    {
                                                                      auth
                                                                          .createUserWithEmailAndPassword(
                                                                              email: organizationEMailIDController.text,
                                                                              password: passwordController.text)
                                                                          .then((value) => {
                                                                                Navigator.of(context).push(MaterialPageRoute(
                                                                                    builder: (context) => AlertDialog(title: const Text('Verify Email'), content: Text('An email has been sent to the ${value.user?.email} please verify it by clicking it to the link on email'), actions: <Widget>[
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

                                                                                  timer = Timer.periodic(const Duration(seconds: 3), (timer) {
                                                                                    checkEmailVerified();
                                                                                  });
                                                                                })
                                                                              })
                                                                    }
                                                                  else
                                                                    {
                                                                      Navigator.of(context).push(MaterialPageRoute(
                                                                          builder: (context) => AlertDialog(title: const Text('Invalid input'), content: const Text("You have already requested registration with this email ID, please wait for admin to accept!"), actions: <Widget>[
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
                                                                        title: const Text(
                                                                            'Invalid input'),
                                                                        content:
                                                                            const Text(
                                                                                "You are already a user with this email ID!"),
                                                                        actions: <
                                                                            Widget>[
                                                                          TextButton(
                                                                            onPressed: () =>
                                                                                Navigator.pop(context, 'OK'),
                                                                            child:
                                                                                const Text('OK'),
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
                                                .isNotEmpty) {
                                              errorMessage +=
                                                  validators.validateEmail(
                                                      organizationEMailIDController
                                                          .text);
                                            }
                                            if (validators
                                                .validatePassword(
                                                    passwordController.text)
                                                .isNotEmpty) {
                                              errorMessage +=
                                                  validators.validatePassword(
                                                      passwordController.text);
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
                                                                errorMessage),
                                                            actions: <Widget>[
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
                                                  MyColorScheme.darkColor),
                                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(18.0),
                                              side: BorderSide(
                                                  color: MyColorScheme
                                                      .darkColor)))),
                                      child: Padding(
                                          padding: EdgeInsets.fromLTRB(w * 0.05,
                                              h * 0.005, w * 0.05, h * 0.005),
                                          child: Text('VERIFY', style: TextStyle(fontFamily: 'Montserrat', fontSize: w * 0.06, color: MyColorScheme.baseColor))))
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
                                                  const Register()));
                                    },
                                    codeSent: (String verificationID,
                                        int? resendToken) {
                                      verificationIdReceived = verificationID;
                                      setState(() {
                                        phoneNumberVisibility = 2;
                                      });
                                    },
                                    codeAutoRetrievalTimeout:
                                        (String verificationID) {})
                              }
                            else
                              {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => AlertDialog(
                                            title: const Text('Invalid input'),
                                            content: const Text(
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
                              content: const Text(
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

    await auth
        .signInWithCredential(credential)
        .then((value) => {
              setState(() {
                outerVisibility = 4;
              })
            })
        .onError((error, stackTrace) => {
              utilities.alertMessage(context, 'Incorrect OTP',
                  'OTP incorrect or timed out! Try again.'),
              setState(() {
                outerVisibility = 3;
                phoneNumberVisibility = 1;
                phoneNumberOTPController.text = "";
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
          rollNumberController.text,
          roleValue);
      await FirebaseFirestore.instance
          .collection('Mapping/Admin/PhonetoMail')
          .doc(utilities.add91(phoneNumberController.text))
          .set({'Email': organizationEMailIDController.text});
      await FirebaseFirestore.instance
          .collection('Mapping/Admin/MailtoPhone')
          .doc(organizationEMailIDController.text)
          .set({'PhoneNumber': utilities.add91(phoneNumberController.text)});
      if (idCardPicker != null) {
        final Reference storage = FirebaseStorage.instance.ref();
        String? path = idCardPicker!.files.single.path;
        String filePath = '';
        if (path != null) {
          filePath = path;
        }
        File file = File(filePath);
        try {
          await storage
              .child('Admin/IDCard/+91 ' + phoneNumberController.text)
              .putFile(file);
        } catch (e) {
          // Do something
        }
      }
      if (profilePhotoPicker != null) {
        final Reference storage = FirebaseStorage.instance.ref();
        String? path = profilePhotoPicker!.files.single.path;
        String filePath = '';
        if (path != null) {
          filePath = path;
        }
        File file = File(filePath);
        try {
          await storage
              .child('Admin/ProfilePhoto/+91 ' + phoneNumberController.text)
              .putFile(file);
        } catch (e) {
          // Do something
        }
      }
      Navigator.pop(context, 'OK');
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const Login()));
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => AlertDialog(
                  title: const Text('Notice'),
                  content: const Text('Please wait for Admin Acknowledgement'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'OK'),
                      child: const Text('OK'),
                    )
                  ])));
    }
  }
}
