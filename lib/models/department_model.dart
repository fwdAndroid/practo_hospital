import 'package:cloud_firestore/cloud_firestore.dart';

class Department_Model {
  String uid;
  String departmentName;
  String description;
  String specilization;

  Department_Model({
    required this.uid,
    required this.departmentName,
    required this.description,
    required this.specilization,
  });

  ///Converting OBject into Json Object
  Map<String, dynamic> toJson() => {
        'departmentName': departmentName,
        'uid': uid,
        'description': description,
        'specilization': specilization,
      };

  ///
  static Department_Model fromSnap(DocumentSnapshot snaps) {
    var snapshot = snaps.data() as Map<String, dynamic>;

    return Department_Model(
      departmentName: snapshot['departmentName'],
      uid: snapshot['uid'],
      specilization: snapshot['specilization'],
      description: snapshot['description'],
    );
  }
}