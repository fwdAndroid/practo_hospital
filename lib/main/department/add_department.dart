import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:practo_hospital/database/firebasemethods.dart';
import 'package:practo_hospital/main/bottom_screens/home_screen.dart';
import 'package:practo_hospital/main/mainScreen.dart';
import 'package:practo_hospital/widgets/utils.dart';

import 'package:uuid/uuid.dart';

class AddDepartment extends StatefulWidget {
  const AddDepartment({Key? key}) : super(key: key);

  @override
  State<AddDepartment> createState() => _AddDepartmentState();
}

class _AddDepartmentState extends State<AddDepartment> {
  bool _isLoading = false;

  TextEditingController descController = TextEditingController();
  TextEditingController specializationController = TextEditingController();
  TextEditingController departmentName = TextEditingController();

  var uuid;

  @override
  Widget build(BuildContext context) {
    final inputBorder =
        OutlineInputBorder(borderSide: Divider.createBorderSide(context));
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Add Departments"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Image.asset(
              "asset/splash.png",
              height: 200,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: RichText(
              text: TextSpan(
                text: 'Department Name',
                style: GoogleFonts.getFont(
                  'Montserrat',
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                  fontSize: 16,
                  fontStyle: FontStyle.normal,
                ),
                children: <TextSpan>[
                  TextSpan(
                      text: '*',
                      style: GoogleFonts.getFont(
                        'Montserrat',
                        fontWeight: FontWeight.w500,
                        color: Colors.red,
                        fontSize: 12,
                        fontStyle: FontStyle.normal,
                      )),
                ],
              ),
            ),
          ),
          Container(
              margin: EdgeInsets.only(top: 5, left: 15, right: 15),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: new BorderRadius.circular(30),
                  border: Border.all(color: Color(0xffD2D2D2))),
              child: TextFormField(
                controller: departmentName,
                validator: (v) {
                  if (v!.isEmpty) {
                    return " Please Enter Address..\ ";
                  }

                  return null;
                },
                decoration: InputDecoration(
                  hintText: 'Enter Department Name',
                  contentPadding: EdgeInsets.only(left: 20),
                  border: InputBorder.none,
                  hintStyle: GoogleFonts.getFont('Montserrat',
                      fontWeight: FontWeight.w600,
                      color: Color(0xff8D8989),
                      fontSize: 15,
                      fontStyle: FontStyle.normal),
                ),
              )),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: RichText(
              text: TextSpan(
                text: 'Specialization',
                style: GoogleFonts.getFont(
                  'Montserrat',
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                  fontSize: 16,
                  fontStyle: FontStyle.normal,
                ),
                children: <TextSpan>[
                  TextSpan(
                      text: '*',
                      style: GoogleFonts.getFont(
                        'Montserrat',
                        fontWeight: FontWeight.w500,
                        color: Colors.red,
                        fontSize: 12,
                        fontStyle: FontStyle.normal,
                      )),
                ],
              ),
            ),
          ),
          Container(
              margin: EdgeInsets.only(top: 5, left: 15, right: 15),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: new BorderRadius.circular(30),
                  border: Border.all(color: Color(0xffD2D2D2))),
              child: TextFormField(
                controller: specializationController,
                validator: (v) {
                  if (v!.isEmpty) {
                    return " Enter Department Specialization\ ";
                  }

                  return null;
                },
                decoration: InputDecoration(
                  hintText: 'Enter Department Specialization',
                  contentPadding: EdgeInsets.only(left: 20),
                  border: InputBorder.none,
                  hintStyle: GoogleFonts.getFont('Montserrat',
                      fontWeight: FontWeight.w600,
                      color: Color(0xff8D8989),
                      fontSize: 15,
                      fontStyle: FontStyle.normal),
                ),
              )),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: RichText(
              text: TextSpan(
                text: 'Description',
                style: GoogleFonts.getFont(
                  'Montserrat',
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                  fontSize: 16,
                  fontStyle: FontStyle.normal,
                ),
                children: <TextSpan>[
                  TextSpan(
                      text: '*',
                      style: GoogleFonts.getFont(
                        'Montserrat',
                        fontWeight: FontWeight.w500,
                        color: Colors.red,
                        fontSize: 12,
                        fontStyle: FontStyle.normal,
                      )),
                ],
              ),
            ),
          ),
          Container(
              margin: EdgeInsets.only(top: 5, left: 15, right: 15),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: new BorderRadius.circular(30),
                  border: Border.all(color: Color(0xffD2D2D2))),
              child: TextFormField(
                controller: descController,
                validator: (v) {
                  if (v!.isEmpty) {
                    return " Enter Description\ ";
                  }

                  return null;
                },
                decoration: InputDecoration(
                  hintText: 'Enter Description',
                  contentPadding: EdgeInsets.only(left: 20),
                  border: InputBorder.none,
                  hintStyle: GoogleFonts.getFont('Montserrat',
                      fontWeight: FontWeight.w600,
                      color: Color(0xff8D8989),
                      fontSize: 15,
                      fontStyle: FontStyle.normal),
                ),
              )),
          SizedBox(
            height: 30,
          ),
          Center(
            child: ElevatedButton(
              onPressed: add,
              child: _isLoading == true
                  ? const Center(
                      child: CircularProgressIndicator.adaptive(),
                    )
                  : Text("Add"),
              style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                  fixedSize: Size(200, 50),
                  textStyle: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.bold)),
            ),
          )
        ],
      ),
    );
  }

  add() async {
    String ui = Uuid().v1();

    setState(() {
      _isLoading = true;
    });
    String rse = await FirebaseMethods().departmentAdd(
        description: descController.text,
        specialization: specializationController.text,
        departmentName: departmentName.text,
        uid: FirebaseAuth.instance.currentUser!.uid,
        );

    print(rse);
    setState(() {
      _isLoading = false;
    });
    if (rse == 'success') {
      // showSnakBar(rse, context);
      Navigator.push(
          context, MaterialPageRoute(builder: (builder) => MainScreen()));
    } else {
      showSnakBar(rse, context);
    }
  }
}
