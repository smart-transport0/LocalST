import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:local_st/Data-Services/utilities.dart';
import 'package:local_st/Data-Services/validators.dart';
import 'package:local_st/General/home.dart';
import 'package:local_st/Reusable/bottom_navigation_bar.dart';
import 'package:local_st/Reusable/colors.dart';
import 'package:local_st/Reusable/navigation_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:local_st/Data-Services/realtimeDatabaseOperations.dart';

class StartNewJourney extends StatefulWidget {
  const StartNewJourney({Key? key}) : super(key: key);

  @override
  State<StartNewJourney> createState() => _StartNewJourneyState();
}

class _StartNewJourneyState extends State<StartNewJourney> {
  late SharedPreferences sharedPreferences;
  TextEditingController journeyDateController = TextEditingController();
  TextEditingController leaveTimeController = TextEditingController();
  TextEditingController availableSeatsController =
      TextEditingController(text: '1');
  TextEditingController paidUnpaidController = TextEditingController();
  TextEditingController numberPlateController = TextEditingController();
  TextEditingController sourceController = TextEditingController();
  TextEditingController destinationController = TextEditingController();
  TextEditingController routeController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  Validators validators = Validators();
  Utilities utilities = Utilities();
  List<String> vehicleTypes = ['2-Wheeler', '3-Wheeler', '4-Wheeler'];
  List<String> paidUnpaid = ['Paid', 'Unpaid'];
  var selectedVehicleType, paidUnpaidValue;
  @override
  void initState() {
    super.initState();
    initial();
  }

  int visibility = 1;
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Stack(children: <Widget>[
      Container(
        color: MyColorScheme.baseColor,
      ),
      Scaffold(
          appBar: AppBar(
            title: const Text('Start A New Journey'),
            centerTitle: true,
            backgroundColor: MyColorScheme.darkColor,
            elevation: 0,
          ),
          drawer: const NavBar(),
          bottomNavigationBar: BottomNavBar(0),
          body: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                  height: h,
                  color: MyColorScheme.baseColor,
                  padding: EdgeInsets.fromLTRB(0, h * 0.1, 0, h * 0.05),
                  child: Column(children: <Widget>[
                    Visibility(
                        visible: visibility == 1,
                        child: Center(
                            child: Column(children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(
                                w * 0.04, h * 0.015, w * 0.04, h * 0.015),
                            child: TextField(
                              controller: journeyDateController,
                              decoration: InputDecoration(
                                  fillColor: MyColorScheme.bgColor,
                                  prefixIcon: Icon(Icons.date_range,
                                      color: MyColorScheme.darkColor),
                                  labelText: 'Journey Date',
                                  labelStyle: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: MyColorScheme.darkColor),
                                  hintStyle: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: MyColorScheme.darkColor),
                                  filled: true,
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: MyColorScheme.baseColor,
                                          width: 2.0),
                                      borderRadius: BorderRadius.circular(30)),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: MyColorScheme.baseColor,
                                          width: 2.0),
                                      borderRadius: BorderRadius.circular(30))),
                              readOnly: true,
                              onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime.now().subtract(
                                        const Duration(
                                            days:
                                                0)), //DateTime.now() - not to allow to choose before today.
                                    lastDate: DateTime(2101),
                                    builder: (context, child) {
                                      return Theme(
                                          data: Theme.of(context).copyWith(
                                              colorScheme: ColorScheme.light(
                                                primary:
                                                    MyColorScheme.darkColor,
                                                onPrimary:
                                                    MyColorScheme.baseColor,
                                                onSurface:
                                                    MyColorScheme.darkColor,
                                              ),
                                              textButtonTheme:
                                                  TextButtonThemeData(
                                                      style: TextButton.styleFrom(
                                                          foregroundColor:
                                                              MyColorScheme
                                                                  .darkColor // button text color
                                                          ))),
                                          child: child!);
                                    });

                                if (pickedDate != null) {
                                  String formattedDate =
                                      DateFormat('yyyy-MM-dd')
                                          .format(pickedDate);
                                  journeyDateController.text = formattedDate;
                                }
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(
                                w * 0.04, h * 0.015, w * 0.04, h * 0.015),
                            child: TextFormField(
                              controller: leaveTimeController,
                              readOnly: true,
                              decoration: InputDecoration(
                                  fillColor: MyColorScheme.bgColor,
                                  labelText: 'Leave Time',
                                  prefixIcon: Icon(Icons.alarm,
                                      color: MyColorScheme.darkColor),
                                  labelStyle: TextStyle(
                                    color: MyColorScheme.darkColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  hintStyle: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                  filled: true,
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: MyColorScheme.darkColor,
                                          width: 2.0),
                                      borderRadius: BorderRadius.circular(30)),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: MyColorScheme.bgColor,
                                          width: 2.0),
                                      borderRadius: BorderRadius.circular(30))),
                              onTap: () async {
                                TimeOfDay time = TimeOfDay.now();
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                                TimeOfDay? picked = await showTimePicker(
                                    builder: (context, child) {
                                      return Theme(
                                          data: Theme.of(context).copyWith(
                                              colorScheme: ColorScheme.light(
                                                primary:
                                                    MyColorScheme.darkColor,
                                                onPrimary:
                                                    MyColorScheme.baseColor,
                                                onSurface:
                                                    MyColorScheme.darkColor,
                                              ),
                                              textButtonTheme:
                                                  TextButtonThemeData(
                                                      style: TextButton.styleFrom(
                                                          foregroundColor:
                                                              MyColorScheme
                                                                  .darkColor // button text color
                                                          ))),
                                          child: child!);
                                    },
                                    context: context,
                                    initialTime: time);
                                if (picked != null && picked != time) {
                                  leaveTimeController.text = picked.toString();
                                  leaveTimeController.text =
                                      picked.format(context);
                                  time = picked;
                                }
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Cant be empty';
                                }
                                return null;
                              },
                            ),
                          ),
                          Padding(
                              padding: EdgeInsets.fromLTRB(
                                  w * 0.04, h * 0.015, w * 0.04, h * 0.015),
                              child: Container(
                                width: w,
                                decoration: BoxDecoration(
                                    color: MyColorScheme.bgColor,
                                    borderRadius: BorderRadius.circular(30.0),
                                    border: Border.all(
                                        color: Colors.transparent,
                                        width: 2.0,
                                        style: BorderStyle.solid)),
                                child: Padding(
                                  padding:
                                      EdgeInsets.fromLTRB(w * 0.02, 0, 0, 0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const Icon(Icons.motorcycle),
                                      DropdownButtonHideUnderline(
                                          child: DropdownButton(
                                              iconSize: 0,
                                              focusColor: MyColorScheme.bgColor,
                                              hint: Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    w * 0.03, 0, 0, 0),
                                                child: Text('Vehicle Type',
                                                    style: TextStyle(
                                                        color: MyColorScheme
                                                            .darkColor,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              ), // Not necessary for Option 1
                                              value: selectedVehicleType,
                                              onChanged: (newValue) {
                                                setState(() {
                                                  selectedVehicleType =
                                                      newValue;
                                                });
                                              },
                                              items:
                                                  vehicleTypes.map((options) {
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
                                                      .darkColor))),
                                    ],
                                  ),
                                ),
                              )),
                          Padding(
                              padding: EdgeInsets.fromLTRB(
                                  w * 0.04, h * 0.015, w * 0.04, h * 0.015),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                      icon: const Icon(Icons.remove),
                                      onPressed: () => {
                                            if (int.parse(
                                                    availableSeatsController
                                                        .text) >
                                                1)
                                              {
                                                availableSeatsController
                                                    .text = (int.parse(
                                                            availableSeatsController
                                                                .text) -
                                                        1)
                                                    .toString()
                                              }
                                          }),
                                  Expanded(
                                    child: TextField(
                                        controller: availableSeatsController,
                                        readOnly: true,
                                        cursorColor: MyColorScheme.bgColor,
                                        keyboardType: TextInputType.number,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: MyColorScheme.darkColor),
                                        decoration: InputDecoration(
                                            filled: true,
                                            fillColor: MyColorScheme.bgColor,
                                            labelText: "Available Seats",
                                            labelStyle: TextStyle(
                                                color: MyColorScheme.darkColor,
                                                fontWeight: FontWeight.bold),
                                            focusedBorder: OutlineInputBorder(
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
                                  ),
                                  IconButton(
                                      icon: const Icon(Icons.add),
                                      onPressed: () => {
                                            if (int.parse(
                                                    availableSeatsController
                                                        .text) <
                                                10)
                                              {
                                                availableSeatsController
                                                    .text = (int.parse(
                                                            availableSeatsController
                                                                .text) +
                                                        1)
                                                    .toString()
                                              }
                                          }),
                                ],
                              )),
                          ElevatedButton(
                              onPressed: () => {
                                    setState(() {
                                      if (selectedVehicleType != null &&
                                          journeyDateController.text != "" &&
                                          leaveTimeController.text != "" &&
                                          selectedVehicleType != "" &&
                                          checkAvailableSeatsValid(
                                              int.parse(availableSeatsController
                                                  .text),
                                              selectedVehicleType)) {
                                        visibility = 2;
                                      } else {
                                        String msg = "";
                                        if (selectedVehicleType != null &&
                                            journeyDateController.text != "" &&
                                            leaveTimeController.text != "" &&
                                            selectedVehicleType != "") {
                                          msg = "Please fill all the fields!";
                                        }
                                        if (!checkAvailableSeatsValid(
                                            int.parse(
                                                availableSeatsController.text),
                                            selectedVehicleType)) {
                                          msg +=
                                              "Available seats invalid for this vehicle type!";
                                        }
                                        utilities.alertMessage(
                                            context, 'Invalid Input', msg);
                                      }
                                    })
                                  },
                              style: ButtonStyle(
                                  elevation: MaterialStateProperty.all(15),
                                  backgroundColor: MaterialStateProperty.all(
                                      MyColorScheme.darkColor),
                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: BorderSide(
                                          color: MyColorScheme.darkColor)))),
                              child: Padding(
                                  padding: EdgeInsets.fromLTRB(
                                      w * 0.05, h * 0.008, w * 0.05, h * 0.005),
                                  child: Text('Next',
                                      style: TextStyle(
                                          fontSize: w * 0.06,
                                          color: MyColorScheme.baseColor))))
                        ]))),
                    Visibility(
                        visible: visibility == 2,
                        child: Center(
                            child: Column(children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(
                                w * 0.04, h * 0.03, w * 0.04, h * 0.015),
                            child: TextField(
                                controller: sourceController,
                                cursorColor: MyColorScheme.darkColor,
                                style:
                                    TextStyle(color: MyColorScheme.darkColor),
                                decoration: InputDecoration(
                                    filled: true,
                                    fillColor: MyColorScheme.bgColor,
                                    prefixIcon: Icon(Icons.home,
                                        color: MyColorScheme.darkColor),
                                    labelText: "Source Place",
                                    labelStyle: TextStyle(
                                      color: MyColorScheme.darkColor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: h * 0.02,
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: MyColorScheme.darkColor,
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
                          Padding(
                            padding: EdgeInsets.fromLTRB(
                                w * 0.04, h * 0.015, w * 0.04, h * 0.015),
                            child: TextField(
                                controller: destinationController,
                                cursorColor: MyColorScheme.darkColor,
                                style:
                                    TextStyle(color: MyColorScheme.darkColor),
                                decoration: InputDecoration(
                                    filled: true,
                                    fillColor: MyColorScheme.bgColor,
                                    prefixIcon: Icon(Icons.local_parking,
                                        color: MyColorScheme.darkColor),
                                    labelText: "Destination Place",
                                    labelStyle: TextStyle(
                                      color: MyColorScheme.darkColor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: h * 0.02,
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                        // ignore: prefer_const_constructors
                                        borderSide: BorderSide(
                                            color: MyColorScheme.darkColor,
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
                          Padding(
                            padding: EdgeInsets.fromLTRB(
                                w * 0.04, h * 0.015, w * 0.04, h * 0.015),
                            child: TextField(
                                controller: routeController,
                                cursorColor: MyColorScheme.bgColor,
                                style:
                                    TextStyle(color: MyColorScheme.darkColor),
                                decoration: InputDecoration(
                                    filled: true,
                                    fillColor: MyColorScheme.bgColor,
                                    prefixIcon: Icon(Icons.route,
                                        color: MyColorScheme.darkColor),
                                    labelText: "Route",
                                    labelStyle: TextStyle(
                                      color: MyColorScheme.darkColor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: h * 0.02,
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                        // ignore: prefer_const_constructors
                                        borderSide: BorderSide(
                                            color: MyColorScheme.darkColor,
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
                          Padding(
                            padding: EdgeInsets.fromLTRB(
                                w * 0.04, h * 0.015, w * 0.04, h * 0.015),
                            child: TextField(
                                controller: numberPlateController,
                                cursorColor: MyColorScheme.bgColor,
                                style:
                                    TextStyle(color: MyColorScheme.darkColor),
                                decoration: InputDecoration(
                                    filled: true,
                                    fillColor: MyColorScheme.bgColor,
                                    prefixIcon: Icon(Icons.numbers,
                                        color: MyColorScheme.darkColor),
                                    labelText: "Number Plate",
                                    labelStyle: TextStyle(
                                      color: MyColorScheme.darkColor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: h * 0.02,
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                        // ignore: prefer_const_constructors
                                        borderSide: BorderSide(
                                            color: MyColorScheme.darkColor,
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
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton(
                                    onPressed: () => {
                                          setState(() {
                                            visibility = 1;
                                          })
                                        },
                                    style: ButtonStyle(
                                        elevation:
                                            MaterialStateProperty.all(15),
                                        backgroundColor: MaterialStateProperty.all(
                                            MyColorScheme.darkColor),
                                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(18.0),
                                                side: BorderSide(
                                                    color: MyColorScheme
                                                        .darkColor)))),
                                    child: Padding(
                                        padding: EdgeInsets.fromLTRB(w * 0.05,
                                            h * 0.008, w * 0.05, h * 0.005),
                                        child: Text('Back', style: TextStyle(fontSize: w * 0.06, color: MyColorScheme.baseColor)))),
                                ElevatedButton(
                                    onPressed: () => {
                                          setState(() {
                                            if (sourceController.text != "" &&
                                                destinationController.text !=
                                                    "" &&
                                                routeController.text != "" &&
                                                numberPlateController.text !=
                                                    "") {
                                              if (validators
                                                  .validateNumberPlate(
                                                      numberPlateController
                                                          .text)) {
                                                setState(() {
                                                  visibility = 3;
                                                });
                                              } else {
                                                utilities.alertMessage(
                                                    context,
                                                    'Invalid Input',
                                                    'NumberPlate is invald!');
                                              }
                                            } else {
                                              utilities.alertMessage(
                                                  context,
                                                  'Invalid Input',
                                                  'Please fill all the fields!');
                                            }
                                          })
                                        },
                                    style: ButtonStyle(
                                        elevation:
                                            MaterialStateProperty.all(15),
                                        backgroundColor: MaterialStateProperty.all(
                                            MyColorScheme.darkColor),
                                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(18.0),
                                                side: BorderSide(
                                                    color: MyColorScheme
                                                        .darkColor)))),
                                    child: Padding(
                                        padding: EdgeInsets.fromLTRB(w * 0.05,
                                            h * 0.008, w * 0.05, h * 0.005),
                                        child: Text('Next', style: TextStyle(fontSize: w * 0.06, color: MyColorScheme.baseColor))))
                              ])
                        ]))),
                    Visibility(
                        visible: visibility == 3,
                        child: Center(
                            child: Column(children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(
                                w * 0.04, h * 0.03, w * 0.04, h * 0.015),
                            child: Container(
                              width: w,
                              decoration: BoxDecoration(
                                  color: MyColorScheme.bgColor,
                                  borderRadius: BorderRadius.circular(30.0),
                                  border: Border.all(
                                      color: Colors.transparent,
                                      width: 2.0,
                                      style: BorderStyle.solid)),
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(w * 0.02, 0, 0, 0),
                                child: Row(
                                  children: [
                                    const Icon(Icons.currency_rupee_sharp),
                                    DropdownButton(
                                        iconSize: 0,
                                        focusColor: MyColorScheme.bgColor,
                                        hint: Padding(
                                          padding: EdgeInsets.fromLTRB(
                                              w * 0.03, 0, 0, 0),
                                          child: Text('Paid / Unpaid',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color:
                                                      MyColorScheme.darkColor)),
                                        ),
                                        value: paidUnpaidValue,
                                        onChanged: (newValue) {
                                          setState(() {
                                            paidUnpaidValue = newValue;
                                          });
                                        },
                                        items: paidUnpaid.map((options) {
                                          return DropdownMenuItem(
                                              child: Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    w * 0.05, 0, w * 0.05, 0),
                                                child: Text(options,
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              ),
                                              value: options);
                                        }).toList(),
                                        style: TextStyle(
                                            color: MyColorScheme.darkColor)),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(
                                w * 0.04, h * 0.03, w * 0.04, h * 0.015),
                            child: TextField(
                                controller: descriptionController,
                                cursorColor: MyColorScheme.darkColor,
                                style:
                                    TextStyle(color: MyColorScheme.darkColor),
                                decoration: InputDecoration(
                                    filled: true,
                                    fillColor: MyColorScheme.bgColor,
                                    prefixIcon: Icon(Icons.description,
                                        color: MyColorScheme.darkColor),
                                    labelText: "Description",
                                    labelStyle: TextStyle(
                                      color: MyColorScheme.darkColor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: h * 0.02,
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: MyColorScheme.darkColor,
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
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  margin: EdgeInsets.fromLTRB(
                                      w * 0.05, h * 0.015, w * 0.05, h * 0.015),
                                  child: ElevatedButton(
                                      onPressed: () => {
                                            setState(() {
                                              visibility = 2;
                                            })
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
                                              h * 0.008, w * 0.05, h * 0.005),
                                          child: Text('Back', style: TextStyle(fontSize: w * 0.06, color: MyColorScheme.baseColor)))),
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(
                                      w * 0.05, h * 0.015, w * 0.05, h * 0.015),
                                  child: ElevatedButton(
                                      onPressed: () => {
                                            if (paidUnpaidValue == "")
                                              {
                                                utilities.alertMessage(
                                                    context,
                                                    'Invalid Input',
                                                    'Please select Paid or Unpaid')
                                              }
                                            else
                                              {createJourney()}
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
                                              h * 0.008, w * 0.05, h * 0.005),
                                          child: Text('Create', style: TextStyle(fontSize: w * 0.06, color: MyColorScheme.baseColor)))),
                                )
                              ])
                        ])))
                  ]))))
    ]);
  }

  Future<void> initial() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<void> createJourney() async {
    String? phoneNumber = sharedPreferences.getString('phoneNumber');
    String? userName = sharedPreferences.getString('userName');
    DateTime datetime = DateTime.now();
    String journeyID = utilities.remove91(phoneNumber!);
    journeyID += utilities.padCharacters(datetime.day.toString(), "0", 2);
    journeyID += utilities.padCharacters(datetime.month.toString(), "0", 2) +
        utilities.padCharacters(datetime.year.toString(), "0", 2) +
        utilities.padCharacters(datetime.hour.toString(), "0", 2);
    journeyID += utilities.padCharacters(datetime.minute.toString(), "0", 2) +
        utilities.padCharacters(datetime.second.toString(), "0", 2);
    String journeyDateTime =
        utilities.padCharacters(datetime.day.toString(), "0", 2) +
            '/' +
            utilities.padCharacters(datetime.month.toString(), "0", 2) +
            '/' +
            utilities.padCharacters(datetime.year.toString(), "0", 2) +
            ' ' +
            utilities.padCharacters(datetime.hour.toString(), "0", 2) +
            ':' +
            utilities.padCharacters(datetime.minute.toString(), "0", 2) +
            ':' +
            utilities.padCharacters(datetime.second.toString(), "0", 2);
    await FirebaseFirestore.instance
        .collection('TransporterList')
        .doc(journeyID)
        .set({
      'JourneyDate': utilities.changeDateFormat(journeyDateController.text),
      'LeaveTime': leaveTimeController.text,
      'VehicleType': selectedVehicleType,
      'AvailableSeats': int.parse(availableSeatsController.text),
      'SourcePlace': sourceController.text,
      'DestinationPlace': destinationController.text,
      'Route': routeController.text,
      'NumberPlate': numberPlateController.text,
      'PaidUnpaid': paidUnpaidValue,
      'Description': descriptionController.text,
      'PendingRequestsCount': 0,
      'AcceptedRequestsCount': 0,
      'TransporterID': utilities.remove91(phoneNumber),
      'IsJourneyAvailable': true
    });
    // Create an entry in Chat and add transporter
    RealTimeDatabase rdb = RealTimeDatabase();
    rdb.setDataIntoRTDB('Chat/' + journeyID, {
      'GroupName': destinationController.text + ' ' + journeyDateTime,
      'LastMessage': {'Message': '', 'Time': ''},
      'Members': {
        phoneNumber: {'UserName': userName, 'Unread': 0}
      }
    });
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const Home()));
  }

  bool checkAvailableSeatsValid(
      int availableSeats, String selectedVehicleType) {
    if (selectedVehicleType == "2-Wheeler") {
      if (availableSeats > 2) {
        return false;
      }
    } else if (selectedVehicleType == "3-Wheeler") {
      if (availableSeats > 4) {
        return false;
      }
    } else if (selectedVehicleType == "4-Wheeler") {
      if (availableSeats > 8) {
        return false;
      }
    }
    return true;
  }
}
