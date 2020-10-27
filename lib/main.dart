import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gimig_gastro_application/functions/firebase_functions.dart';
import 'package:gimig_gastro_application/main/route_generator.dart';
import 'package:gimig_gastro_application/screens/welcome_screen.dart';

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIOverlays([]);
  runApp(MyApp());
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  FirebaseFunctions firebaseFunctions = FirebaseFunctions();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: RouteGenerator.generateRoute,
      initialRoute: WelcomeScreen.id,
    );
  }
}
