import 'package:flutter/material.dart';
import 'package:gimig_gastro_application/classes/category_class.dart';
import 'package:gimig_gastro_application/main.dart';
import 'package:gimig_gastro_application/main/screen_arguments.dart';
import 'package:gimig_gastro_application/screens/account/login_screen.dart';
import 'package:gimig_gastro_application/screens/account/registration_screen.dart';
import 'package:gimig_gastro_application/screens/account/settings_screen.dart';
import 'package:gimig_gastro_application/screens/category_screen_connected.dart';
import 'package:gimig_gastro_application/screens/item_screen_connected.dart';
import 'package:gimig_gastro_application/unused/big_card_screen.dart';
import 'package:gimig_gastro_application/screens/cart_screen.dart';
import 'package:gimig_gastro_application/screens/category_screen.dart';
import 'package:gimig_gastro_application/screens/daily_menu_screen_beta.dart';
import 'package:gimig_gastro_application/screens/small_card_screen.dart';
import 'package:gimig_gastro_application/screens/welcome_screen.dart';

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

      case DailyMenuBetaScreen.id:
        if (args is Category) {
          return MaterialPageRoute(
            builder: (_) => DailyMenuBetaScreen(
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
