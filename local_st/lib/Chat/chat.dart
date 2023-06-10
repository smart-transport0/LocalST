import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:local_st/Data-Services/realtimeDatabaseOperations.dart';
import 'package:local_st/Data-Services/utilities.dart';
import 'package:local_st/Reusable/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatUI extends StatefulWidget {
  String journeyID;
  String chatName;
  ChatUI(this.journeyID, this.chatName, {Key? key}) : super(key: key);
  @override
  State<ChatUI> createState() => _ChatUIState();
}

class _ChatUIState extends State<ChatUI> {
  late SharedPreferences sharedPreferences;
  String userID = "";
  Utilities utilities = Utilities();
  TextEditingController messageController = TextEditingController();
  ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    initial();
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
          title: Text(widget.chatName),
          backgroundColor: MyColorScheme.darkColor),
      body: Stack(
        children: <Widget>[
          Column(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(bottom: w * 0.1),
                  child: StreamBuilder(
                      stream: FirebaseDatabase.instance
                          .reference()
                          .child('Chat')
                          .child(widget.journeyID)
                          .child("Messages")
                          .onValue,
                      builder: (context, AsyncSnapshot snapshot) {
                        if (snapshot.connectionState ==
                                ConnectionState.waiting ||
                            !snapshot.hasData ||
                            snapshot.hasError ||
                            snapshot.data.snapshot.value == null ||
                            userID == "") {
                          return const Center(
                              child: Text('No messages here yet!',
                                  style: TextStyle(fontSize: 18)));
                        } else if (snapshot.hasData) {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            if (_controller.hasClients) {
                              _controller
                                  .jumpTo(_controller.position.maxScrollExtent);
                            } else {
                              setState(() => null);
                            }
                          });
                          List snapshotKeys =
                              (snapshot.data.snapshot.value.keys).toList();
                          return ListView.builder(
                            controller: _controller,
                            shrinkWrap: true,
                            itemCount: snapshot.data.snapshot.value.length,
                            scrollDirection: Axis.vertical,
                            physics: const ClampingScrollPhysics(),
                            padding: const EdgeInsets.only(top: 10, bottom: 10),
                            itemBuilder: (context, index) {
                              // TODO: Show name instead of phone number?
                              String sender = snapshot.data.snapshot
                                  .value[snapshotKeys[index]]['sender'];
                              String time = snapshot.data.snapshot
                                  .value[snapshotKeys[index]]['time'];
                              String content = snapshot.data.snapshot
                                  .value[snapshotKeys[index]]['content'];
                              return Container(
                                  padding: const EdgeInsets.only(
                                      left: 14, right: 14, top: 10, bottom: 10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Align(
                                    alignment: userID == sender
                                        ? Alignment.centerRight
                                        : Alignment.centerLeft,
                                    child: Container(
                                      width: w * 0.6,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: (userID == sender
                                            ? Colors.grey.shade200
                                            : Colors.blue[200]),
                                      ),
                                      padding: const EdgeInsets.all(16),
                                      child: Column(
                                        children: [
                                          Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                Text(sender,
                                                    style: const TextStyle(
                                                        color:
                                                            Colors.blueAccent)),
                                                Text(time,
                                                    style: const TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.grey)),
                                              ]),
                                          Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(content,
                                                  style: const TextStyle(
                                                      fontSize: 15)))
                                        ],
                                      ),
                                    ),
                                  ));
                            },
                          );
                        } else {
                          return Container();
                        }
                      }),
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: const EdgeInsets.only(left: 10, bottom: 10, top: 10),
              height: 60,
              width: double.infinity,
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        color: Colors.lightBlue,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: TextField(
                      controller: messageController,
                      decoration: const InputDecoration(
                          hintText: "Write message...",
                          hintStyle: TextStyle(color: Colors.black54),
                          border: InputBorder.none),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  FloatingActionButton(
                    onPressed: () {
                      if (messageController.text.isNotEmpty) {
                        RealTimeDatabase rdb = RealTimeDatabase();
                        DateTime datetime = DateTime.now();
                        String messageID = utilities.padCharacters(
                            datetime.year.toString(), "0", 2);
                        messageID += utilities.padCharacters(
                                datetime.month.toString(), "0", 2) +
                            utilities.padCharacters(
                                datetime.day.toString(), "0", 2) +
                            utilities.padCharacters(
                                datetime.hour.toString(), "0", 2);
                        messageID += utilities.padCharacters(
                                datetime.minute.toString(), "0", 2) +
                            utilities.padCharacters(
                                datetime.second.toString(), "0", 2);
                        messageID += userID;
                        String time = utilities.padCharacters(
                                datetime.hour.toString(), "0", 2) +
                            ':' +
                            utilities.padCharacters(
                                datetime.minute.toString(), "0", 2);
                        rdb.setDataIntoRTDB(
                            "Chat/" +
                                widget.journeyID +
                                "/Messages/" +
                                messageID,
                            {
                              // TODO: Find a solution to show full datetime or just time and date some other way
                              "content": messageController.text.trim(),
                              "time": time,
                              "sender": userID
                            });
                        messageController.text = "";
                      }
                    },
                    child: const Icon(
                      Icons.send,
                      color: Colors.white,
                      size: 18,
                    ),
                    backgroundColor: Colors.blue,
                    elevation: 0,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void initial() async {
    sharedPreferences = await SharedPreferences.getInstance();
    userID = utilities
        .remove91(sharedPreferences.getString('phoneNumber').toString());
  }
}
