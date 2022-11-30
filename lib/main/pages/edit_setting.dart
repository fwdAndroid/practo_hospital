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

class Edit_Setting extends StatefulWidget {
  const Edit_Setting({Key? key}) : super(key: key);

  @override
  _Edit_SettingState createState() => _Edit_SettingState();
}

class _Edit_SettingState extends State<Edit_Setting> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  bool _isLoading = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.clear();
    _addressController.clear();
    _nameController.clear();
    _passController.clear();
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
            "Edit Hospital Information",
            style: TextStyle(color: Colors.black),
          ),
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("hispitals")
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .snapshots(),
              builder: (context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
                  return new CircularProgressIndicator();
                }
                var document = snapshot.data;
                _emailController.text = document['email'];
                _addressController.text = document['address'];
                _passController.text = document['pass'];
                _nameController.text = document['name'];

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
                            text: 'Enter Hospital Name',
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
                                return "Enter Hospital Name.";
                              }

                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: 'Enter Hospital Name',
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
                            text: 'Email Address ',
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
                            controller: _emailController,
                            validator: (v) {
                              if (v!.isEmpty) {
                                return " Please Enter Email..\ ";
                              }

                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: 'Enter Your Email',
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
                            text: 'Address',
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
                            controller: _addressController,
                            validator: (v) {
                              if (v!.isEmpty) {
                                return " Please Enter Address..\ ";
                              }

                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: 'Enter Your Address',
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
                            text: 'Password',
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
                            controller: _passController,
                            validator: (v) {
                              if (v!.isEmpty) {
                                return " Please Enter Password..\ ";
                              }

                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: 'Enter Your Password',
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
    String rse = await FirebaseMethods().updateuser(
        email: _emailController.text,
        address: _addressController.text,
        name: _nameController.text,
        pass: _passController.text);

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
