import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gimig_gastro_application/services/authentication_servie.dart';
import 'package:gimig_gastro_application/services/firebase_functions.dart';
import 'package:gimig_gastro_application/screens/account/login_screen.dart';
import 'package:provider/provider.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'registration_screen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  FirebaseFunctions firebaseFunctions = FirebaseFunctions();

  String email;
  String password;
  String name;

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([]);
    // firebaseFunctions.getCurrentUser();
  }

  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        resizeToAvoidBottomPadding: true,
        body: Stack(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.1,
                  vertical: 0),
              child: SingleChildScrollView(
                child: SizedBox(
                  height: MediaQuery.of(context).size.width * 0.5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.width * 0.1,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Name:",
                            style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.019,
                              color: Color(0xFF303030),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.width * 0.001,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.35,
                            height: MediaQuery.of(context).size.width * 0.08,
                            child: TextField(
                              onChanged: (value) {
                                name = value;
                              },
                              decoration: new InputDecoration(
                                border: new OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(
                                        MediaQuery.of(context).size.width *
                                            0.06),
                                  ),
                                  borderSide: new BorderSide(
                                      color: Colors.deepOrangeAccent),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      new BorderSide(color: Color(0xFFFF6633)),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(
                                        MediaQuery.of(context).size.width *
                                            0.06),
                                  ),
                                ),
                              ),
                              cursorColor: Color(0xFF303030),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "E-mail:",
                                style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.019,
                                  color: Color(0xFF303030),
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.width * 0.001,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.35,
                                height:
                                    MediaQuery.of(context).size.width * 0.08,
                                child: TextField(
                                  keyboardType: TextInputType.emailAddress,
                                  onChanged: (value) {
                                    email = value;
                                  },
                                  decoration: new InputDecoration(
                                    border: new OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(
                                            MediaQuery.of(context).size.width *
                                                0.06),
                                      ),
                                      borderSide: new BorderSide(
                                          color: Colors.deepOrangeAccent),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: new BorderSide(
                                          color: Color(0xFFFF6633)),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(
                                            MediaQuery.of(context).size.width *
                                                0.06),
                                      ),
                                    ),
                                  ),
                                  cursorColor: Color(0xFF303030),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Passwort:",
                                style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.019,
                                  color: Color(0xFF303030),
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.width * 0.001,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.35,
                                height:
                                    MediaQuery.of(context).size.width * 0.08,
                                child: TextField(
                                  obscureText: true,
                                  onChanged: (value) {
                                    password = value;
                                  },
                                  decoration: new InputDecoration(
                                    border: new OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(
                                            MediaQuery.of(context).size.width *
                                                0.06),
                                      ),
                                      borderSide: new BorderSide(
                                          color: Colors.deepOrangeAccent),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: new BorderSide(
                                          color: Color(0xFFFF6633)),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(
                                            MediaQuery.of(context).size.width *
                                                0.06),
                                      ),
                                    ),
                                  ),
                                  cursorColor: Color(0xFF303030),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.width * 0.09,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.35,
                        height: MediaQuery.of(context).size.width * 0.07,
                        child: FlatButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  MediaQuery.of(context).size.width * 0.06),
                            ),
                            color: Color(0xFFFF6633),
                            splashColor: Colors.white,
                            highlightColor: Colors.grey,
                            child: Text(
                              "Registrieren",
                              style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.03,
                                color: Colors.white,
                                letterSpacing: 1,
                              ),
                            ),
                            onPressed: () {
                              context.read<AuthenticationService>().signUp(
                                    email: email.trim(),
                                    password: password.trim(),
                                    name: name.trim(),
                                    context: context,
                                  );
                            }),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: GestureDetector(
                onDoubleTap: () {
                  {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ),
                    );
                  }
                },
                child: Container(
                  padding:
                      EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
                  height: MediaQuery.of(context).size.width * 0.1,
                  width: MediaQuery.of(context).size.width * 0.1,
                  child: Image.asset(
                    "images/logos/Gimig Logo.png",
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
