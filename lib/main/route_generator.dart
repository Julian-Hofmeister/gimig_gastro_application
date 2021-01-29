import 'package:flutter/material.dart';
import 'package:gimig_gastro_application/authentication/screen/login_screen.dart';
import 'package:gimig_gastro_application/authentication/screen/registration_screen.dart';
import 'package:gimig_gastro_application/main_interface/screens/category_screen/class/category_class.dart';
import 'package:gimig_gastro_application/main.dart';
import 'package:gimig_gastro_application/main/screen_arguments.dart';
import 'package:gimig_gastro_application/main_interface/screens/cart_screen/screens/cart_screen.dart';
import 'package:gimig_gastro_application/main_interface/screens/category_screen/screens/category_screen_connected.dart';
import 'package:gimig_gastro_application/main_interface/screens/home_screen/screens/welcome_screen.dart';
import 'package:gimig_gastro_application/main_interface/screens/item_screen/screens/item_screen_connected.dart';
import 'package:gimig_gastro_application/settings/screens/settings_screen.dart';
import 'package:gimig_gastro_application/unused/big_card_screen.dart';
import 'package:gimig_gastro_application/unused/category_screen.dart';
import 'package:gimig_gastro_application/unused/small_card_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    final ScreenArguments arguments = settings.arguments;

    switch (settings.name) {
      case AuthenticationWrapper.id:
        return MaterialPageRoute(builder: (_) => AuthenticationWrapper());

      case WelcomeScreen.id:
        return MaterialPageRoute(builder: (_) => WelcomeScreen());

      case CategoryScreen.id:
        if (args is Category) {
          return MaterialPageRoute(
            builder: (_) => CategoryScreen(
              category: args,
            ),
          );
        }
        return _errorRoute();

      case BigCardScreen.id:
        if (args is Category) {
          return MaterialPageRoute(
            builder: (_) => BigCardScreen(
              category: args,
            ),
          );
        }
        return _errorRoute();

      case SmallCardScreen.id:
        if (args is Category) {
          return MaterialPageRoute(
            builder: (_) => SmallCardScreen(
              category: args,
            ),
          );
        }
        return _errorRoute();

      case CartScreen.id:
        return MaterialPageRoute(builder: (_) => CartScreen());

      case LoginScreen.id:
        return MaterialPageRoute(
          builder: (_) => LoginScreen(),
        );

      case RegistrationScreen.id:
        return MaterialPageRoute(
          builder: (_) => RegistrationScreen(),
        );

      case SettingsScreen.id:
        return MaterialPageRoute(builder: (_) => SettingsScreen());

      case ItemScreenConnected.id:
        if (args != null) {
          return MaterialPageRoute(
            builder: (_) => ItemScreenConnected(
              path: arguments.path,
              title: arguments.title,
            ),
          );
        }
        return _errorRoute();

      case CategoryScreenConnected.id:
        if (args != null) {
          return MaterialPageRoute(
            builder: (_) => CategoryScreenConnected(
              path: arguments.path,
              title: arguments.title,
            ),
          );
        }
        return _errorRoute();

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            title: Text("ERROR"),
          ),
        );
      },
    );
  }
}
