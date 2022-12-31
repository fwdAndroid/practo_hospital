import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:practo_hospital/widgets/app-theme.dart';
import 'package:practo_hospital/widgets/chat_room.dart';
import 'package:flutter/material.dart';


class AllChats extends StatefulWidget {
  final userid;
  final hospitald;
  final name;
  AllChats({required this.hospitald, required this.userid, required this.name});
  @override
  State<AllChats> createState() => _AllChatsState();
}

class _AllChatsState extends State<AllChats> {
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
          Container(
            margin: EdgeInsets.only(top: 10, left: 20, right: 20),
            child: TextFormField(
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                border: InputBorder.none,
                hintText: 'Search through Matches',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              margin: EdgeInsets.only(left: 10),
              child: Text(
                "Messages",
                textAlign: TextAlign.left,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("appointments")
                    .doc("details")
                    .collection("records")
                    .where("status", isEqualTo: "start")
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
                                return ChatRoom(
                                 hospitalName: documentSnapshot['hospitalName'],
                                  userid: documentSnapshot['id'],
                                  hispitalid: documentSnapshot['hospitalid'],
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
