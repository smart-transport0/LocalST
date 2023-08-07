import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:local_st/Data-Services/utilities.dart';
import 'package:local_st/General/profile.dart';
import 'package:local_st/Reusable/bottom_navigation_bar.dart';
import 'package:local_st/Reusable/loading.dart';
import 'package:local_st/Reusable/navigation_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math';
import '../Reusable/size_config.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Home> {
  @override
  void initState() {
    super.initState();
    initial();
  }

  String userName = "", greeting = "";
  String userID = '';
  bool hasOngoingJourney = false;
  String ongoingJourneyID = "";
  String journeyContent = "";
  String transporterName = '';
  late SharedPreferences sharedPreferences;
  TextEditingController controller = TextEditingController();
  Utilities utilities = Utilities();
  List<String> facts = [
    "There were an estimated 6.5 million deaths worldwide from air pollution-related diseases in 2012, WHO data shows.",
    '91% of the world\'s population are breathing in polluted air every day.',
    'At least 1 in 10 people die from Air Pollution-related diseases.',
    'Air Pollution is a greater threat to Life Expectancy than smoking, HIV or war.',
    'Air Pollution has nearly \$3 Trillion Economic Cost, equivalent to 3.3% of the world\'s GDP.',
    'Death Rates from air pollution are highest in low-to-middle income countries.',
    'Climate Change increases risks of wildfires and air pollution from it.',
    '10 of the world\'s 15 most polluted cities are in India.',
    'None of the World\'s 100 biggest cities are able to meet WHO\'s updated guidelines.',
    'Air Pollution contributes to the spread of COVID-19.',
    'More than nine out of 10 of the world\'s population - 92% - lives in places where air pollution exceeds safe limits, according to research from the World Health Organization (WHO).',
    'Air pollution fourth-largest threat to human health, behind high blood pressure, dietary risks and smoking.',
    'There were an estimated 6.5 million deaths worldwide from air pollution-related diseases in 2012, WHO data shows. That\'s 11.6% of all global deaths - more than the number of people killed by HIV/AIDS, tuberculosis and road injuries combined.',
    'Almost all deaths (94%) linked to air pollution occur in low- and middle-income countries, the WHO says.',
    'It found that air pollution led to one in 10 deaths in 2013, which cost the global economy about \$225 billion in lost labour income.',
    'Another fact about air pollution is that the tiny particles, known as PM2.5, have a diameter of less than 2.5 micrometers and can penetrate deep into the lungs and cardiovascular system, increasing the risk of disease.',
    'WHO guidelines state annual average concentrations of PM2.5 should be below 10 micrograms (mcg) per cubic meter, but the vast majority of the world\'s population is living in areas exceeding this limit.',
    'Over the past four years, Mumbai, Delhi and Bengaluru have consistently featured on TomTom\'s top 10 most congested cities in the world for traffic.'
  ];

  @override
  Widget build(BuildContext context) {
    // height and width of screen
    SizeConfig sizeConfig = SizeConfig(context);
    double h = sizeConfig.safeBlockVertical;
    double w = sizeConfig.safeBlockHorizontal * 1.6;
    if (w >= 1000) {
      w *= 0.6;
    }
    Random random = Random();
    int randomNumber = random.nextInt(16);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Smart Transportation',
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      drawer: const NavBar(),
      bottomNavigationBar: BottomNavBar(2),
      extendBody: true,
      body: SafeArea(
        child: Stack(children: <Widget>[
          Container(
            height: h,
            color: const Color.fromARGB(255, 249, 244, 243),
          ),
          SingleChildScrollView(
            child: SizedBox(
              height: h,
              child: FutureBuilder(
                  future: hasOngoingCheck(),
                  builder: (context, AsyncSnapshot<bool> snapshot) {
                    if (!snapshot.hasData) {
                      return const Loading();
                    } else if (snapshot.data == false) {
                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Padding(
                                padding: EdgeInsets.fromLTRB(
                                    0, h * 0.05, 0, h * 0.02),
                                child: Column(
                                  children: [
                                    ClipOval(
                                        child: Image(
                                      height: h * 0.1,
                                      width: h * 0.1,
                                      fit: BoxFit.cover,
                                      image: const AssetImage(
                                          'assets/images/panda.jpg'),
                                    )),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(
                                    0, h * 0.06, 0, h * 0.02),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      greeting + ",",
                                      style: const TextStyle(
                                          fontFamily: 'Montserrat'),
                                    ),
                                    Text(
                                      userName,
                                      style: TextStyle(
                                          fontFamily: 'Montserrat',
                                          fontSize: w * 0.04),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(
                                    0, h * 0.07, 0, h * 0.02),
                                child: Stack(
                                  children: [
                                    ClipOval(
                                        child: Icon(Icons.notifications,
                                            size: h * 0.05,
                                            color: Colors.orangeAccent)),
                                    Container(
                                        width: w * 0.05,
                                        margin: EdgeInsets.fromLTRB(
                                            w * 0.05, h * 0.006, 0, 0),
                                        child: const Text('2',
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w900)))
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Padding(
                              padding: EdgeInsets.fromLTRB(0, h * 0.035, 0, 0),
                              child: Text("Let's travel eco-friendly today!",
                                  style: TextStyle(
                                      fontSize: w * 0.04,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green))),
                          Padding(
                            padding: EdgeInsets.fromLTRB(
                                w * 0.05, h * 0.05, w * 0.05, h * 0.03),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color:
                                      const Color.fromARGB(255, 195, 219, 230)),
                              child: Column(
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.fromLTRB(0, h * 0.02, 0, 0),
                                    child: Text('Upcoming Journey',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: w * 0.025)),
                                  ),
                                  Padding(
                                      padding: EdgeInsets.fromLTRB(w * 0.05,
                                          h * 0.03, w * 0.05, h * 0.03),
                                      child: IntrinsicHeight(
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            //Dummy Data
                                            Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text('01:59 AM',
                                                      style: TextStyle(
                                                          fontSize: w * 0.023))
                                                ]),
                                            Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    w * 0.03, 0, w * 0.03, 0),
                                                child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      const Icon(Icons
                                                          .location_on_rounded),
                                                      Expanded(
                                                        child: Container(
                                                            width: 2,
                                                            color: Colors.grey),
                                                      ),
                                                      const Icon(Icons
                                                          .location_on_rounded)
                                                    ])),
                                            Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                      padding:
                                                          EdgeInsets.fromLTRB(0,
                                                              0, 0, h * 0.03),
                                                      child: Text('PDPU',
                                                          style: TextStyle(
                                                              fontSize:
                                                                  w * 0.023))),
                                                  Text('Satellite',
                                                      style: TextStyle(
                                                          fontSize: w * 0.023))
                                                ]),
                                          ],
                                        ),
                                      ))
                                ],
                              ),
                            ),
                          ),
                          Text(
                            "\n#FactOfTheDay",
                            style: TextStyle(
                                fontSize: w * 0.04,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          Container(
                              padding:
                                  EdgeInsets.fromLTRB(w * 0.05, 0, w * 0.05, 0),
                              child: Text(
                                facts[randomNumber],
                                style: TextStyle(fontSize: w * 0.025),
                                textAlign: TextAlign.center,
                              ))
                        ],
                      );
                    } else {
                      return Column(
                        children: [
                          StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                              stream: FirebaseFirestore.instance
                                  .collection("TransporterList")
                                  .doc(ongoingJourneyID)
                                  .snapshots(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<
                                          DocumentSnapshot<
                                              Map<String, dynamic>>>
                                      snap) {
                                if (!snap.hasData) {
                                  return const Loading();
                                } else {
                                  var ongoingJourneyData = snap.data!.data();
                                  return Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        w * 0.03, h * 0.03, w * 0.03, h * 0.03),
                                    child: Column(children: <Widget>[
                                      Card(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                        child: Container(
                                          padding: EdgeInsets.fromLTRB(w * 0.03,
                                              h * 0.03, w * 0.03, h * 0.03),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                  padding: EdgeInsets.fromLTRB(
                                                      w * 0.02,
                                                      h * 0.015,
                                                      w * 0.02,
                                                      h * 0.015),
                                                  alignment: Alignment.center,
                                                  color: Colors.blue,
                                                  child: Text(
                                                      ongoingJourneyData![
                                                          'NumberPlate'])),
                                              Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: <Widget>[
                                                    Text(ongoingJourneyData[
                                                        'LeaveTime']),
                                                    ElevatedButton(
                                                        child: Text(
                                                            ongoingJourneyData[
                                                                'TransporterID']),
                                                        onPressed: () async {
                                                          _callNumber("+91 " +
                                                              ongoingJourneyData[
                                                                  'TransporterID']);
                                                        })
                                                  ]),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Padding(
                                                          padding: EdgeInsets
                                                              .fromLTRB(
                                                                  w * 0.03,
                                                                  0,
                                                                  w * 0.03,
                                                                  0),
                                                          child: SizedBox(
                                                            // make it based on text size
                                                            height: h * 0.1,
                                                            child: Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .min,
                                                                children: [
                                                                  const Icon(Icons
                                                                      .location_on_rounded),
                                                                  Expanded(
                                                                    child: Container(
                                                                        width:
                                                                            2,
                                                                        color: Colors
                                                                            .grey),
                                                                  ),
                                                                  const Icon(Icons
                                                                      .location_on_rounded)
                                                                ]),
                                                          )),
                                                      Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(ongoingJourneyData[
                                                                'SourcePlace']),
                                                            Text(''),
                                                            Text(ongoingJourneyData[
                                                                'DestinationPlace'])
                                                          ]),
                                                    ],
                                                  ),
                                                  IconButton(
                                                      icon: const Icon(
                                                          Icons.copy),
                                                      onPressed: () async {
                                                        journeyContent =
                                                            await _getJourneyContent();
                                                        Clipboard.setData(
                                                            ClipboardData(
                                                                text:
                                                                    journeyContent));
                                                      }),
                                                ],
                                              ),
                                              const Text(
                                                  'Journey Status: Ongoing'),
                                              TextButton(
                                                  child: Text(transporterName),
                                                  onPressed: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                Profile(
                                                                    userID)));
                                                  })
                                            ],
                                          ),
                                        ),
                                      ),
                                    ]),
                                  );
                                }
                              }),
                          Container(
                            padding: EdgeInsets.fromLTRB(
                                w * 0.03, 0, w * 0.03, h * 0.03),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                              child: Container(
                                padding: EdgeInsets.fromLTRB(
                                    w * 0.01, h * 0.01, w * 0.01, h * 0.01),
                                child: Column(
                                  children: [
                                    Text('Passengers'),
                                    Container(
                                      child: StreamBuilder(
                                        stream: FirebaseFirestore.instance
                                            .collection('TransporterList')
                                            .doc(ongoingJourneyID)
                                            .collection('Requests')
                                            .where('Status',
                                                isEqualTo: 'Accepted')
                                            .snapshots(),
                                        builder: (BuildContext context,
                                            AsyncSnapshot<
                                                    QuerySnapshot<
                                                        Map<String, dynamic>>>
                                                snapshot) {
                                          var passengers = snapshot.data!.docs;
                                          return passengers.isNotEmpty
                                              ? Container(
                                                  padding: EdgeInsets.fromLTRB(
                                                      w * 0.05, 0, w * 0.05, 0),
                                                  child: ListView.builder(
                                                      shrinkWrap: true,
                                                      itemCount:
                                                          passengers.length,
                                                      itemBuilder:
                                                          (context, index) {
                                                        return Column(
                                                          children: [
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                TextButton(
                                                                    child: Text(passengers[index]
                                                                            [
                                                                            'FullName']
                                                                        .toString()),
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.push(
                                                                          context,
                                                                          MaterialPageRoute(
                                                                              builder: (context) => Profile(passengers[index]['PhoneNumber'])));
                                                                    }),
                                                                ElevatedButton(
                                                                    child: Text(
                                                                        passengers[index]
                                                                            [
                                                                            'PhoneNumber']),
                                                                    onPressed:
                                                                        () async {
                                                                      _callNumber("+91 " +
                                                                          passengers[index]
                                                                              [
                                                                              'PhoneNumber']);
                                                                    })
                                                              ],
                                                            ),
                                                            Row(children: [
                                                              Text('status')
                                                            ])
                                                          ],
                                                        );
                                                      }),
                                                )
                                              : const Loading();
                                        },
                                      ),
                                    ),
                                    // bring it just after the list
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(
                                          0, h * 0.04, 0, 0),
                                      child: Text('Safety Tools'),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Column(
                                          children: [
                                            IconButton(
                                                icon: Icon(Icons.school),
                                                onPressed: () {
                                                  // call organization
                                                  _callNumber('');
                                                }),
                                            smallText('University', h)
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            IconButton(
                                                icon: Icon(Icons.emergency),
                                                onPressed: () {
                                                  // call emergency contact number
                                                  _callNumber('');
                                                }),
                                            smallText('Emergency', h)
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            IconButton(
                                                icon: Icon(Icons.local_police),
                                                onPressed: () {
                                                  // call local police
                                                  _callNumber('100');
                                                }),
                                            smallText('Police', h)
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            IconButton(
                                                icon: Icon(
                                                    Icons.fire_extinguisher),
                                                onPressed: () {
                                                  // call fire fighters
                                                  _callNumber('101');
                                                }),
                                            smallText('Fire', h)
                                          ],
                                        )
                                      ],
                                    ),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Column(
                                            children: [
                                              IconButton(
                                                  icon: Icon(
                                                      Icons.local_hospital,
                                                      semanticLabel:
                                                          'hospital'),
                                                  onPressed: () {
                                                    _callNumber('102');
                                                  }),
                                              smallText('Ambulance', h)
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              IconButton(
                                                  icon: Icon(Icons.mic),
                                                  onPressed: () {
                                                    // record audio and send to emergency contact number and admin
                                                  }),
                                              smallText('Record', h)
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              IconButton(
                                                  icon: Icon(Icons.dangerous),
                                                  onPressed: () {
                                                    // notify emergency contact number and admin
                                                  }),
                                              smallText('Danger', h)
                                            ],
                                          ),
                                        ])
                                  ],
                                ),
                              ),
                            ),
                          ),
                          // Current location of transporter
                          // Journey status})
                        ],
                      );
                    }
                  }),
            ),
          ),
        ]),
      ),
    );
  }

  Future<void> initial() async {
    sharedPreferences = await SharedPreferences.getInstance();
    String fullName = sharedPreferences.get('userName').toString();
    userID = sharedPreferences.get('phoneNumber').toString();

    setState(() {
      for (int i = 0; i < fullName.length; i++) {
        if (fullName[i] == ' ') {
          break;
        } else {
          userName += fullName[i];
        }
      }
      int currentHour = DateTime.now().hour;
      if (currentHour >= 4 && currentHour <= 12) {
        greeting = "Good Morning";
      } else if (currentHour >= 12 && currentHour <= 17) {
        greeting = "Good Afternoon";
      } else if (currentHour > 17) {
        greeting = "Good Evening";
      }
    });
  }

  getRequests(String journeyID) async {
    var requestData = await FirebaseFirestore.instance
        .collection('TransporterList')
        .doc(journeyID)
        .collection('Requests')
        .get();
    return requestData;
  }

  Future<bool> hasOngoingCheck() async {
    var userInfo = await FirebaseFirestore.instance
        .collection('UserInformation')
        .doc(userID)
        .get();
    if (userInfo.data()!.containsKey('OngoingJourney') &&
        userInfo['OngoingJourney'] != "") {
      hasOngoingJourney = true;
      ongoingJourneyID = userInfo['OngoingJourney'];
      transporterName =
          await _getTransporterName('+91 ' + ongoingJourneyID.substring(0, 10));
    } else {
      hasOngoingJourney = false;
    }
    return hasOngoingJourney;
  }

  Future<bool> _callNumber(String number) async {
    bool? res = await FlutterPhoneDirectCaller.callNumber(number);
    return res ?? false;
  }

  Future<String> _getJourneyContent() async {
    // populate journey details in string and return
    var snap = await FirebaseFirestore.instance
        .collection('TransporterDetails')
        .doc(ongoingJourneyID)
        .get();
    return snap.id;
  }

  Future<String> _getTransporterName(String transporterID) async {
    var data = await FirebaseFirestore.instance
        .collection("UserInformation")
        .doc(transporterID)
        .get();
    return data['FirstName'] + ' ' + data['LastName'];
  }

  Widget smallText(String text, double h) {
    return Text(text, style: TextStyle(fontSize: h * 0.017));
  }
}
