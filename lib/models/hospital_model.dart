import 'package:cloud_firestore/cloud_firestore.dart';

class HospitalModel {
  String uid;
  String address;
  String email;
  String name;
  String pass;

  HospitalModel({
    required this.uid,
    required this.address,
    required this.email,
    required this.pass,
    required this.name,
  });

  ///Converting OBject into Json Object
  Map<String, dynamic> toJson() => {
        'name': name,
        'uid': uid,
        'email': email,
        'pass': pass,
        'address': address,
      };

  ///
  static HospitalModel fromSnap(DocumentSnapshot snaps) {
    var snapshot = snaps.data() as Map<String, dynamic>;

    return HospitalModel(
        name: snapshot['name'],
        uid: snapshot['uid'],
        email: snapshot['email'],
        pass: snapshot['pass'],
        address: snapshot['address']);
  }
}
