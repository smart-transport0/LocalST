import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:local_st/Chat/chat.dart';
import 'package:local_st/Chat/chat_room_design.dart';
import 'package:local_st/Data-Services/utilities.dart';
import 'package:local_st/Reusable/bottom_navigation_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Reusable/colors.dart';
import '../Reusable/navigation_bar.dart';

class ChatRooms extends StatefulWidget {
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
    // TODO: Optimize the journey data fetched in this widget
    return Scaffold(
        appBar: AppBar(
            title: Text('Journey Chats'),
            backgroundColor: MyColorScheme.darkColor),
        drawer: const NavBar(),
        bottomNavigationBar: BottomNavBar(4),
        body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
                    Widget>[
              Padding(
                  padding: EdgeInsets.only(top: 16, left: 16, right: 16),
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
                          contentPadding: EdgeInsets.all(8),
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
                          return FilledButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.resolveWith<Color?>(
                                (Set<MaterialState> states) {
                                  if (states.contains(MaterialState.pressed)) {
                                    return Theme.of(context)
                                        .colorScheme
                                        .primary
                                        .withGreen(245)
                                        .withBlue(242)
                                        .withRed(249);
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
                                          userJourneyChats[index]['journeyID'],
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
