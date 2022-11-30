// import 'package:firebase_auth/firebase_auth.dart';

// import 'package:instagram/screens/add_post_screen.dart';
// import 'package:instagram/screens/feed_screen.dart';
// import 'package:instagram/screens/profile_screen.dart';
// import 'package:instagram/screens/search_screen.dart';

import 'package:flutter/material.dart';
import 'package:practo_hospital/main/bottom_screens/appontment.dart';
import 'package:practo_hospital/main/bottom_screens/chat_page.dart';
import 'package:practo_hospital/main/bottom_screens/home_screen.dart';
import 'package:practo_hospital/main/bottom_screens/setting.dart';

const webScreenSize = 600;

List<Widget> homeScreenItems = [
  Home(),
  HospitalAppointments(),
  ChatPage(
    hospitald: "",
    userid: "",
    name: "",
  ),
  Setting(),

  // Profile()
  //  Random(),
  //  ChatPage(),
  //  Profile(),
];
