import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:local_st/Reusable/colors.dart';

class ChatRoomDesign extends StatefulWidget {
  final String name;
  final String messageText;
  final String time;
  final bool isMessageRead;
  const ChatRoomDesign(
      {Key? key,
      required this.name,
      required this.messageText,
      required this.time,
      required this.isMessageRead})
      : super(key: key);
  @override
  _ChatRoomDesignState createState() => _ChatRoomDesignState();
}

class _ChatRoomDesignState extends State<ChatRoomDesign> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding:
            const EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            widget.name,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: MyColorScheme.darkColor),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          Text(
                            widget.messageText,
                            style: TextStyle(
                                fontSize: 13,
                                color: MyColorScheme.darkColor,
                                fontWeight: widget.isMessageRead
                                    ? FontWeight.bold
                                    : FontWeight.normal),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Text(
              widget.time,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: widget.isMessageRead
                      ? FontWeight.bold
                      : FontWeight.normal,
                  color: MyColorScheme.darkColor),
            ),
          ],
        ),
      ),
    );
  }
}
