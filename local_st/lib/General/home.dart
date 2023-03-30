import 'package:flutter/material.dart';
import 'package:local_st/Data-Services/utilities.dart';
import 'package:local_st/Reusable/bottom_navigation_bar.dart';
import 'package:local_st/Reusable/navigation_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math';

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
  late SharedPreferences sharedPreferences;
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
    //height and width of screen
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
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
      body: Stack(children: <Widget>[
        Container(
          height: h,
          color: const Color.fromARGB(255, 249, 244, 243),
        ),
        SingleChildScrollView(
          child: SizedBox(
            height: h,
            child: Column(
              children: [
                Row(
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, h * 0.05, 0, h * 0.02),
                      child: Column(
                        children: [
                          ClipOval(
                              child: Image(
                            height: h * 0.1,
                            width: h * 0.1,
                            fit: BoxFit.cover,
                            image: const AssetImage('assets/images/panda.jpg'),
                          )),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, h * 0.06, 0, h * 0.02),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            greeting + ",",
                            style: const TextStyle(fontFamily: 'Montserrat'),
                          ),
                          Text(
                            userName,
                            style: TextStyle(
                                fontFamily: 'Montserrat', fontSize: h * 0.04),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, h * 0.07, 0, h * 0.02),
                      child: Stack(
                        children: [
                          ClipOval(
                              child: Icon(Icons.notifications,
                                  size: h * 0.05, color: Colors.orangeAccent)),
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
                            fontSize: h * 0.04,
                            fontWeight: FontWeight.bold,
                            color: Colors.green))),
                Padding(
                  padding: EdgeInsets.fromLTRB(
                      w * 0.05, h * 0.05, w * 0.05, h * 0.03),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: const Color.fromARGB(255, 195, 219, 230)),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, h * 0.02, 0, 0),
                          child: Text('Upcoming Journey',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: h * 0.03)),
                        ),
                        Padding(
                            padding: EdgeInsets.fromLTRB(
                                w * 0.05, h * 0.03, w * 0.05, h * 0.03),
                            child: IntrinsicHeight(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  //Dummy Data
                                  Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('01:59 AM',
                                            style:
                                                TextStyle(fontSize: h * 0.028))
                                      ]),
                                  Padding(
                                      padding: EdgeInsets.fromLTRB(
                                          w * 0.03, 0, w * 0.03, 0),
                                      child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            const Icon(Icons.location_on_rounded),
                                            Expanded(
                                              child: Container(
                                                  width: 2, color: Colors.grey),
                                            ),
                                            const Icon(Icons.location_on_rounded)
                                          ])),
                                  Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                0, 0, 0, h * 0.03),
                                            child: Text('PDPU',
                                                style: TextStyle(
                                                    fontSize: h * 0.028))),
                                        Text('Satellite',
                                            style:
                                                TextStyle(fontSize: h * 0.028))
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
                      fontSize: h * 0.04, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(w * 0.05, 0, w * 0.05, 0),
                  child: Text(
                    facts[randomNumber],
                    style: TextStyle(fontSize: h * 0.025),
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
          ),
        ),
      ]),
    );
  }

  Future<void> initial() async {
    sharedPreferences = await SharedPreferences.getInstance();
    String fullName = sharedPreferences.get('userName').toString();
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
}
