import 'package:flutter/material.dart';
import 'package:practo_hospital/main/bottom_screens/chat_page.dart';
import 'package:practo_hospital/main/chat_appointments/pastchat.dart';
import 'package:practo_hospital/tab/past_appointment.dart';
import 'package:practo_hospital/tab/status_appointment.dart';
import 'package:practo_hospital/tab/upcomming_appointment.dart';

class ChatAppointment extends StatefulWidget {
  ChatAppointment({super.key});

  @override
  State<ChatAppointment> createState() => _ChatAppointmentState();
}

/// AnimationControllers can be created with `vsync: this` because of TickerProviderStateMixin.
class _ChatAppointmentState extends State<ChatAppointment>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text(
          'My Chats',
          style: TextStyle(color: Colors.black),
        ),
        bottom: TabBar(
          indicatorColor: Colors.blue,
          labelColor: Colors.black,
          controller: _tabController,
          tabs: const <Widget>[
            Tab(
              text: 'Current Chat',
            ),
            Tab(
              text: 'Past Chat',
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          ChatPage(
            hospitald: "",
            userid: "",
            name: "",
          ),
          PastChat(
            hospitald: "",
            userid: "",
            name: "",
          ),
        ],
      ),
    );
  }
}
