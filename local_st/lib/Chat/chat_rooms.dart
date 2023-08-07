import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:local_st/Chat/chat.dart';
import 'package:local_st/Chat/chat_room_design.dart';
import 'package:local_st/Data-Services/utilities.dart';
import 'package:local_st/Reusable/bottom_navigation_bar.dart';
import 'package:local_st/Reusable/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Reusable/colors.dart';
import '../Reusable/navigation_bar.dart';

class ChatRooms extends StatefulWidget {
  const ChatRooms({Key? key}) : super(key: key);

  @override
  State<ChatRooms> createState() => _ChatRoomsState();
}

class _ChatRoomsState extends State<ChatRooms> {
  late SharedPreferences sharedPreferences;
  String userID = "";
  Utilities utilities = Utilities();

  @override
  void initState() {
    initial();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig sizeConfig = SizeConfig(context);
    double h = sizeConfig.screenHeight;
    // TODO: Optimize the journey data fetched in this widget
    return Scaffold(
        appBar: AppBar(
            title: const Text('Journey Chats'),
            backgroundColor: MyColorScheme.darkColor),
        drawer: const NavBar(),
        bottomNavigationBar: BottomNavBar(4),
        body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
                    Widget>[
              Padding(
                  padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
                  child: TextField(
                      decoration: InputDecoration(
                          hintText: "Search...",
                          hintStyle: TextStyle(color: Colors.grey.shade600),
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.grey.shade600,
                            size: 20,
                          ),
                          filled: true,
                          fillColor: Colors.grey.shade100,
                          contentPadding: const EdgeInsets.all(8),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide:
                                  BorderSide(color: Colors.grey.shade100)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide:
                                  BorderSide(color: Colors.grey.shade100))))),
              StreamBuilder<Object>(
                  stream: FirebaseDatabase.instance
                      .reference()
                      .child('Chat')
                      .orderByChild('JourneyDateTime')
                      .onValue,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting ||
                        !snapshot.hasData ||
                        snapshot.hasError ||
                        snapshot.data == null) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      var journeyChats = Map<dynamic, dynamic>.from(
                          (snapshot.data! as Event).snapshot.value
                              as Map<dynamic, dynamic>);
                      var userJourneyChats = [];
                      journeyChats.forEach((key, value) {
                        if (value['Members'].containsKey(userID)) {
                          userJourneyChats
                              .add({'journeyID': key, 'data': value});
                        }
                      });
                      return ListView.builder(
                        itemCount: userJourneyChats.length,
                        shrinkWrap: true,
                        padding: const EdgeInsets.only(top: 16),
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.fromLTRB(0, 0, 0, h * 0.02),
                            child: Material(
                              elevation: 1,
                              child: FilledButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.resolveWith<Color?>(
                                    (Set<MaterialState> states) {
                                      if (states
                                          .contains(MaterialState.pressed)) {
                                        return Theme.of(context)
                                            .colorScheme
                                            .primary
                                            .withGreen(228)
                                            .withBlue(221)
                                            .withRed(233);
                                      }
                                      return Theme.of(context)
                                          .colorScheme
                                          .primary
                                          .withOpacity(0);
                                    },
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ChatUI(
                                              userJourneyChats[index]
                                                  ['journeyID'],
                                              userJourneyChats[index]['data']
                                                  ['GroupName'])));
                                },
                                child: ChatRoomDesign(
                                  name: userJourneyChats[index]['data']
                                      ['GroupName'],
                                  messageText: userJourneyChats[index]['data']
                                      ['LastMessage']['Message'],
                                  time: userJourneyChats[index]['data']
                                      ['LastMessage']['Time'],
                                  isMessageRead: userJourneyChats[index]['data']
                                          ['Members'][userID]['Unread'] >
                                      0,
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }
                  }),
            ])));
  }

  void initial() async {
    sharedPreferences = await SharedPreferences.getInstance();
    userID = sharedPreferences.getString('phoneNumber').toString();
  }
}
