import 'package:flutter/material.dart';
import 'package:practo_hospital/widgets/alll_chat_widget.dart';

class ChatPage extends StatelessWidget {
  final hospitald;
  final userid;
  final name;

  ChatPage({Key? key, required this.hospitald, required this.userid, required this.name})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: AllChats(
        hospitald: hospitald,
        name: name,
        userid: userid,
      ),
    );
  }
}
