import 'package:flutter/material.dart';
import 'package:practo_hospital/tab/past_appointment.dart';
import 'package:practo_hospital/tab/status_appointment.dart';
import 'package:practo_hospital/tab/upcomming_appointment.dart';

class HospitalAppointments extends StatefulWidget {
  HospitalAppointments({super.key});

  @override
  State<HospitalAppointments> createState() => _HospitalAppointmentsState();
}

/// AnimationControllers can be created with `vsync: this` because of TickerProviderStateMixin.
class _HospitalAppointmentsState extends State<HospitalAppointments>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text(
          'My Appointments',
          style: TextStyle(color: Colors.black),
        ),
        bottom: TabBar(
          indicatorColor: Colors.blue,
          labelColor: Colors.black,
          controller: _tabController,
          tabs: const <Widget>[
            Tab(
              text: 'Status',
            ),
            Tab(
              text: 'Upcomming',
            ),
            Tab(
              text: 'Past',
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[StatusAppointment(), UpComing(), Past()],
      ),
    );
  }
}
