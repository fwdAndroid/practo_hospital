import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:practo_hospital/database/firebasemethods.dart';
import 'package:practo_hospital/main/mainScreen.dart';
import 'package:practo_hospital/widgets/utils.dart';

class Edit_Department extends StatefulWidget {
  final uuid;
  const Edit_Department({Key? key, required this.uuid}) : super(key: key);

  @override
  _Edit_DepartmentState createState() => _Edit_DepartmentState();
}

class _Edit_DepartmentState extends State<Edit_Department> {
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _departmentSpecialIzationController =
      TextEditingController();
  final formKey = GlobalKey<FormState>();

  bool _isLoading = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _descriptionController.clear();
    _nameController.clear();
    _departmentSpecialIzationController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final inputBorder =
        OutlineInputBorder(borderSide: Divider.createBorderSide(context));
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
          centerTitle: true,
          title: Text(
            "Edit Department",
            style: TextStyle(color: Colors.black),
          ),
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('departments')
                  .doc("departmentsdetails")
                  .collection(FirebaseAuth.instance.currentUser!.uid)
                  .doc(widget.uuid)
                  // .where(
                  //   'status',
                  //   isNotEqualTo: 'pending',
                  // )

                  .snapshots(),
              builder: (context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
                  return new CircularProgressIndicator();
                }
                var document = snapshot.data;
                _descriptionController.text = document['description'];
                _departmentSpecialIzationController.text = document['specilization'];
                _nameController.text = document['departmentName'];

                return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: RichText(
                          text: TextSpan(
                            text: 'Enter Department Name',
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
                            controller: _nameController,
                            validator: (v) {
                              if (v!.isEmpty) {
                                return "Enter Department Name";
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
                            text: 'Enter Department Specialization',
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
                            controller: _departmentSpecialIzationController,
                            validator: (v) {
                              if (v!.isEmpty) {
                                return " Enter Department Specialization";
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
                            text: 'Enter Department Description',
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
                            controller: _descriptionController,
                            validator: (v) {
                              if (v!.isEmpty) {
                                return "Enter Department Description";
                              }

                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: 'Enter Department Description',
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
                        height: 5,
                      ),
                      Center(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xfff0092E1).withOpacity(.6),
                            fixedSize: const Size(350, 30),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40)),
                          ),
                          onPressed: profileUpdates,
                          child: _isLoading == true
                              ? const Center(
                                  child: CircularProgressIndicator.adaptive(),
                                )
                              : Text(
                                  'Update',
                                  style: GoogleFonts.getFont('Montserrat',
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontStyle: FontStyle.normal),
                                ),
                        ),
                      ),
                    ]);
              }),
        ));
  }

  profileUpdates() async {
    setState(() {
      _isLoading = true;
    });
    String rse = await FirebaseMethods().updateDepartment(
        departmentDescription: _descriptionController.text,
        departmentSpecialization: _departmentSpecialIzationController.text,
        departmentName: _nameController.text,
        );

    print(rse);
    setState(() {
      _isLoading = false;
    });
    if (rse == 'success') {
      Navigator.push(
          context, MaterialPageRoute(builder: (builder) => MainScreen()));
      showSnakBar(rse, context);
    } else {
      showSnakBar(rse, context);
    }
  }
}
