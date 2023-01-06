import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:practo_hospital/main/chat_appointments/past_chat_room.dart';
import 'package:practo_hospital/widgets/app-theme.dart';
import 'package:practo_hospital/widgets/chat_room.dart';
import 'package:flutter/material.dart';

class AllPastChat extends StatefulWidget {
  final userid;
  final hospitald;
  final name;
  AllPastChat(
      {required this.hospitald, required this.userid, required this.name});
  @override
  State<AllPastChat> createState() => _AllPastChatState();
}

class _AllPastChatState extends State<AllPastChat> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.hospitald);
    print(widget.userid);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("hospital_appointment")
                    .doc("details")
                    .collection("records")
                    .where("status", isEqualTo: "complete")
                    .where("hospitalid",
                        isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                    .snapshots(includeMetadataChanges: true),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return const Center(
                      child: Text('No Data Found'),
                    );
                  }

                  if (snapshot.hasData) {
                    print(FirebaseAuth.instance.currentUser!.uid);

                    return ListView.builder(
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, int index) {
                          final DocumentSnapshot documentSnapshot =
                              snapshot.data!.docs[index];
                          return InkWell(
                            onTap: () {
                              Navigator.push(context,
                                  CupertinoPageRoute(builder: (context) {
                                return PastChatRoom(
                                  hospitalName:
                                      documentSnapshot['hospitalName'],
                                  paitientid: documentSnapshot['id'],
                                  hospitalId: documentSnapshot['hospitalid'],
                                  paitientname: documentSnapshot['name'],
                                  // user : widget.doctorid,
                                );
                              }));
                            },
                            child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                    margin: const EdgeInsets.only(top: 20),
                                    child: Row(children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            documentSnapshot['hospitalName'],
                                            style: MyTheme.heading2.copyWith(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400),
                                          ),
                                          Text(documentSnapshot['name'],
                                              style: TextStyle(
                                                  color: Color(0xff858585),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400)),
                                        ],
                                      ),
                                    ]))),
                          );
                        });
                  } else {
                    return Center(child: CircularProgressIndicator.adaptive());
                  }
                }),
          )
        ],
      ),
    );
  }
}
