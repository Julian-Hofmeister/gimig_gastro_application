import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gimig_gastro_application/authentication/screen/login_screen.dart';
import 'package:gimig_gastro_application/main/constants.dart';
import 'package:gimig_gastro_application/settings/dialogs/table_number_dialog.dart';

class SettingsScreen extends StatefulWidget {
  static const String id = 'settings_screen';

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

final _auth = FirebaseAuth.instance;

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[100],
      body: Stack(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              width: 100,
              height: 100,
              color: kBackgroundColor.withOpacity(0),
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.black87,
                size: 40,
              ),
            ),
          ),
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.7,
              height: MediaQuery.of(context).size.height,
              color: Colors.white,
              child: Column(
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "Einstellungen",
                    style: TextStyle(
                      fontSize: 20,
                      letterSpacing: 1,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Divider(
                    indent: 30,
                    endIndent: 30,
                  ),
                  SettingItem(
                    title: "Tischnummer",
                    icon: Icons.aspect_ratio_rounded,
                    buttonAction: () {
                      showDialog(
                        context: context,
                        builder: (_) => TableNumberDialog(),
                      );
                    },
                  ),
                  SettingItem(
                    title: "Farben",
                    icon: Icons.color_lens_outlined,
                    buttonAction: () {
                      showDialog(
                        context: context,
                        builder: (_) => TableNumberDialog(),
                      );
                    },
                  ),
                  SettingItem(
                    title: "Abmelden",
                    icon: Icons.logout,
                    buttonAction: () {
                      _auth.signOut();
                      Navigator.pushNamed(context, LoginScreen.id);
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SettingItem extends StatelessWidget {
  SettingItem({this.title, this.icon, this.buttonAction});

  final String title;
  final IconData icon;
  final Function buttonAction;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: buttonAction,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 30),
        height: 70,
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                  fontSize: 16, color: Colors.black87, letterSpacing: 0.5),
            ),
            Icon(
              icon,
              color: Colors.black87,
            )
          ],
        ),
      ),
    );
  }
}
