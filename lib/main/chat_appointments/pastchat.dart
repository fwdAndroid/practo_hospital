import 'package:flutter/material.dart';
import 'package:practo_hospital/main/chat_appointments/all_past_chat.dart';
import 'package:practo_hospital/widgets/alll_chat_widget.dart';

class PastChat extends StatelessWidget {
  final hospitald;
  final userid;
  final name;

  PastChat(
      {Key? key,
      required this.hospitald,
      required this.userid,
      required this.name})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: AllPastChat(
        hospitald: hospitald,
        name: name,
        userid: userid,
      ),
    );
  }
}
