import 'package:evently_v2/screens/auth/login_screen/login_screen.dart';
import 'package:evently_v2/screens/auth/register_screen/register_screen.dart';
import 'package:evently_v2/screens/event/event_details_screen.dart';
import 'package:evently_v2/screens/event/event_screen.dart';
import 'package:evently_v2/screens/event/event_update_screen.dart';
import 'package:evently_v2/screens/home/home_screen.dart';
import 'package:evently_v2/screens/home_layout/home_layout.dart';
import 'package:evently_v2/screens/intro_screen/intro_screen.dart';
import 'package:evently_v2/screens/love/love_screen.dart';
import 'package:evently_v2/screens/map/map_screen.dart';
import 'package:evently_v2/screens/on_boarding_screen/on_boarding_screen.dart';
import 'package:evently_v2/screens/profile/profile_screen.dart';
import 'package:evently_v2/screens/splash_screen/splash_screen.dart';
import 'package:flutter/cupertino.dart';

class RoutesManager {
  static const String splash = "/splash";
  static const String introScreen = "/introScreen";
  static const String loginScreen = "/loginScreen";
  static const String registerScreen = "/registerScreen";
  static const String onBoardingScreen = "/onBoardingScreen";
  static const String homeLayout = "/homeLayout";
  static const String homeScreen = "/homeScreen";
  static const String mapScreen = "/mapScreen";
  static const String addEventScreen = "/addEventScreen";
  static const String eventDetailsScreen = "/eventDetailsScreen";
  static const String eventUpdatesScreen = "/eventUpdatesScreen";
  static const String loveScreen = "/loveScreen";
  static const String profileScreen = "/profileScreen";

  static Route? getRoute(RouteSettings settings) {
    switch (settings.name) {
      case introScreen:
        return CupertinoPageRoute(builder: (context) => IntroScreen());
      case homeLayout:
        return CupertinoPageRoute(builder: (context) => HomeLayout());
      case splash:
        return CupertinoPageRoute(builder: (context) => SplashScreen());
      case onBoardingScreen:
        return CupertinoPageRoute(builder: (context) => OnBoardingScreen());
      case loginScreen:
        return CupertinoPageRoute(builder: (context) => LoginScreen());
      case registerScreen:
        return CupertinoPageRoute(builder: (context) => RegisterScreen());
      case homeScreen:
        return CupertinoPageRoute(builder: (context) => HomeScreen());
      case mapScreen:
        return CupertinoPageRoute(builder: (context) => MapScreen());
      case addEventScreen:
        return CupertinoPageRoute(builder: (context) => EventScreen());
      case loveScreen:
        return CupertinoPageRoute(builder: (context) => LoveScreen());
      case profileScreen:
        return CupertinoPageRoute(builder: (context) => ProfileScreen());
      case eventDetailsScreen:
        return CupertinoPageRoute(
          builder: (context) => EventDetailsScreen(),
          settings: settings,
        );
      case eventUpdatesScreen:
        return CupertinoPageRoute(
          builder: (context) => EventUpdateScreen(),
          settings: settings,
        );
    }
    return null;
  }
}
