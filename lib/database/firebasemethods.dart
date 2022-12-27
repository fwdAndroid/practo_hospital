import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:practo_hospital/models/department_model.dart';
import 'package:practo_hospital/models/hospital_model.dart';
import 'package:uuid/uuid.dart';

class FirebaseMethods {
  Future<String> updateuser({
    required String email,
    required String pass,
    required String address,
    required String name,
  }) async {
    String res = 'Some error occured';
    try {
      if (email.isNotEmpty ||
          pass.isNotEmpty ||
          address.isNotEmpty ||
          name.isNotEmpty) {
        // UserCredential cred = await FirebaseAuth.instance
        //     .createUserWithEmailAndPassword(email: email, password: pass);

        //Add User to the database with modal
        HospitalModel userModel = HospitalModel(
            address: address,
            uid: FirebaseAuth.instance.currentUser!.uid,
            email: email,
            name: name,
            pass: pass);
        await FirebaseFirestore.instance
            .collection('hispitals')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .update(userModel.toJson());
        res = 'sucess';
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  //Update Department
  Future<String> updateDepartment({
    required String departmentName,
    required String departmentSpecialization,
    required String departmentDescription,
  }) async {
    String res = 'Some error occured';
    try {
      if (departmentDescription.isNotEmpty ||
          departmentName.isNotEmpty ||
          departmentSpecialization.isNotEmpty) {
        var uuid = Uuid().v1();
        // UserCredential cred = await FirebaseAuth.instance
        //     .createUserWithEmailAndPassword(email: email, password: pass);

        //Add User to the database with modal
        Department_Model userModel = Department_Model(
            uuid: uuid,
            uid: FirebaseAuth.instance.currentUser!.uid,
            description: departmentDescription,
            departmentName: departmentName,
            specilization: departmentSpecialization);
        await FirebaseFirestore.instance
            .collection('departments')
            .doc("departmentsdetails")
            .collection(FirebaseAuth.instance.currentUser!.uid)
            .doc(uuid)
            .update(userModel.toJson());
        res = 'sucess';
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  //Register User with Add User
  Future<String> signUpUser({
    required String email,
    required String pass,
    required String address,
    required String name,
  }) async {
    String res = 'Some error occured';
    try {
      if (email.isNotEmpty ||
          pass.isNotEmpty ||
          address.isNotEmpty ||
          name.isNotEmpty) {
        UserCredential cred = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: pass);

        //Add User to the database with modal
        HospitalModel userModel = HospitalModel(
            address: address,
            uid: cred.user!.uid,
            email: email,
            name: name,
            pass: pass);
        await FirebaseFirestore.instance
            .collection('hispitals')
            .doc(cred.user!.uid)
            .set(userModel.toJson());
        res = 'sucess';
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  ///Login User with Add Useer
  Future<String> loginUpUser({
    required String email,
    required String pass,
  }) async {
    String res = 'Some error occured';
    try {
      if (email.isNotEmpty || pass.isNotEmpty) {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: pass);

        res = 'sucess';
      }
    } on FirebaseException catch (e) {
      if (e == 'WrongEmail') {
        print(e.message);
      }
      if (e == 'WrongPassword') {
        print(e.message);
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

//Add Department
  Future<String> departmentAdd(
      {required String description,
      required String specialization,
      required String uid,
      required String departmentName}) async {
    String res =
        'Update all the fields data to store it because doctor information will be updated in sequences ';
    try {
      if (description.isNotEmpty || specialization.isNotEmpty) {
        String uuid = Uuid().v1();

        Department_Model serviceModel = Department_Model(
            description: description,
            specilization: specialization,
            uid: uid,
            departmentName: departmentName,
            uuid: uuid);

        FirebaseFirestore.instance
            .collection('departments')
            .doc("departmentsdetails")
            .collection(FirebaseAuth.instance.currentUser!.uid)
            .doc(uuid)
            .set(
              serviceModel.toJson(),
            );
        res = 'Success';
      }
    } catch (error) {
      res = error.toString();
    }
    return res;
  }

  //Edit Department
  //Add Department
  Future<String> editDepartment(
      {required String description,
      required String specialization,
      required String uid,
      required String departmentName}) async {
    String res =
        'Update all the fields data to store it because doctor information will be updated in sequences ';
    try {
      if (description.isNotEmpty || specialization.isNotEmpty) {
        String uuid = Uuid().v1();

        Department_Model serviceModel = Department_Model(
            description: description,
            specilization: specialization,
            uid: uid,
            departmentName: departmentName,
            uuid: uuid);

        FirebaseFirestore.instance
            .collection('departments')
            .doc("departmentsdetails")
            .collection(FirebaseAuth.instance.currentUser!.uid)
            .doc(uuid)
            .set(
              serviceModel.toJson(),
            );
        res = 'Success';
      }
    } catch (error) {
      res = error.toString();
    }
    return res;
  }
}
