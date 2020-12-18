import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gimig_gastro_application/components/elements/setting_category.dart';
import 'package:gimig_gastro_application/dialogs/table_number_dialog.dart';
import 'package:gimig_gastro_application/main/constants.dart';
import 'package:gimig_gastro_application/screens/account/login_screen.dart';

class SettingsScreen extends StatefulWidget {
  static const String id = 'settings_screen';
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final _auth = FirebaseAuth.instance;
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([]);
  }

  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        backgroundColor: Color(0xFF373737),
        body: Stack(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                width: MediaQuery.of(context).size.width * 0.08,
                height: MediaQuery.of(context).size.width * 0.08,
                color: kBackgroundColor.withOpacity(0),
                child: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                  size: 40,
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.all(22.0),
                child: Text(
                  "Einstellungen",
                  style: kFoodCardTitleTextStyle.copyWith(color: Colors.white),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    SettingCategory(
                      name: "Abmelden",
                      icon: "images/icons/outline_login_white_48dp.png",
                      backgroundColor: Color(0xFF373737),
                      borderColor: Color(0xFFFF6633),
                      buttonAction: () {
                        _auth.signOut();
                        Navigator.pushNamed(context, LoginScreen.id);
                      },
                    ),
                    SettingCategory(
                      name: "Tischnummer",
                      icon: "images/icons/outline_filter_7_white_48dp.png",
                      backgroundColor: Color(0xFF373737),
                      borderColor: Color(0xFFFF6633),
                      buttonAction: () {
                        showDialog(
                          context: context,
                          builder: (_) => TableNumberDialog(),
                        );
                      },
                    ),
                    SettingCategory(
                      name: "Farben",
                      icon: "images/icons/outline_color_lens_white_48dp.png",
                      backgroundColor: Color(0xFF373737),
                      borderColor: Color(0xFFFF6633),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
