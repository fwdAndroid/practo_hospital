import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:practo_hospital/main/department/add_department.dart';
import 'package:practo_hospital/main/pages/edit_department.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Hospital Department",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (builder) => AddDepartment()));
          },
          child: Icon(Icons.local_fire_department),
        ),
        body: SingleChildScrollView(
            child: FirebaseAuth.instance.currentUser != null
                ? StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('departments')
                        .doc("departmentsdetails")
                        .collection(FirebaseAuth.instance.currentUser!.uid)
                        // .where(
                        //   'status',
                        //   isNotEqualTo: 'pending',
                        // )

                        .where('uid',
                            isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                        .snapshots(),
                    builder: (context,
                        AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                            snapshot) {
                      if (snapshot.hasError) {
                        return const Center(
                          child: Text('Something went wrong'),
                        );
                      }
                      if (snapshot.hasData) {
                        return Column(
                          children: [
                            // Padding(
                            //   padding: const EdgeInsets.all(8.0),
                            //   child: Text(
                            //     '29 Decemeber 2002',
                            //     textAlign: TextAlign.start,
                            //     style:
                            //         TextStyle(color: Colors.black, fontWeight: FontWeight.w900),
                            //   ),
                            // ),
                            Container(
                              height: MediaQuery.of(context).size.height,
                              child: ListView.builder(
                                  itemCount: snapshot.data!.docs.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    final DocumentSnapshot documentSnapshot =
                                        snapshot.data!.docs[index];
                                    return Column(
                                      children: [
                                        ListTile(
                                          onTap: () {
                                            // Navigator.push(
                                            //   context,
                                            //   MaterialPageRoute(
                                            //     builder: (builder) =>
                                            //         AppointCurrentDetail(),
                                            //   ),
                                            // );
                                          },
                                          title: Text(documentSnapshot[
                                              'departmentName']),
                                          subtitle: Text(documentSnapshot[
                                              'specilization']),
                                          trailing: FittedBox(
                                            child: Row(
                                              children: [
                                                IconButton(
                                                    onPressed: () async {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (builder) =>
                                                                  Edit_Department(
                                                                    uuid: documentSnapshot[
                                                                        'uuid'],
                                                                  )));
                                                    },
                                                    icon: Icon(
                                                      Icons.edit,
                                                      color: Colors.yellow,
                                                    )),
                                                IconButton(
                                                    onPressed: () async {
                                                      await FirebaseFirestore
                                                          .instance
                                                          .collection(
                                                              'departments')
                                                          .doc(
                                                              "departmentsdetails")
                                                          .collection(
                                                              FirebaseAuth
                                                                  .instance
                                                                  .currentUser!
                                                                  .uid)
                                                          .doc(documentSnapshot
                                                              .id)
                                                          .delete();
                                                    },
                                                    icon: Icon(
                                                      Icons.delete,
                                                      color: Colors.red,
                                                    )),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Divider()
                                      ],
                                    );
                                  }),
                            ),
                          ],
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator.adaptive(),
                        );
                      }
                    })
                : const Center(
                    child: Text('No Appointment Pending'),
                  )));
  }
}
