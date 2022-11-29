import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:practo_hospital/auth/signup.dart';
import 'package:practo_hospital/database/firebasemethods.dart';
import 'package:practo_hospital/main/mainScreen.dart';
import 'package:practo_hospital/widgets/utils.dart';

class MainAuth extends StatefulWidget {
  const MainAuth({super.key});

  @override
  State<MainAuth> createState() => _MainAuthState();
}

class _MainAuthState extends State<MainAuth> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.clear();
    _passController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
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
            height: 10,
          ),
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Color(0xfff0092E1).withOpacity(.6),
                fixedSize: const Size(350, 60),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40)),
              ),
              onPressed: login,
              child: _isLoading == true
                  ? const Center(
                      child: CircularProgressIndicator.adaptive(),
                    )
                  : Text(
                      'Confrim',
                      style: GoogleFonts.getFont('Montserrat',
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          fontSize: 15,
                          fontStyle: FontStyle.normal),
                    ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Center(
              child: TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (builder) => SignUp()));
                  },
                  child: Text("Create An Account")))
        ],
      ),
    );
  }

  void login() async {
    setState(() {
      _isLoading = true;
    });
    String rse = await FirebaseMethods().loginUpUser(
      email: _emailController.text,
      pass: _passController.text,
    );

    print(rse);
    setState(() {
      _isLoading = false;
    });
    if (rse == 'sucess') {
      Navigator.push(
          context, MaterialPageRoute(builder: (builder) => MainScreen()));
    } else {
      showSnakBar(rse, context);
    }
  }
}
