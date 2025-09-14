import 'package:evently_v2/core/assets/assets_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:evently_v2/core/routes/routes_manager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () async {
      final prefs = await SharedPreferences.getInstance();
      final introSeen = prefs.getBool('introScreen_seen') ?? false;
      final onboardingSeen = prefs.getBool('onboarding_seen') ?? false;
      final isLoggedIn = FirebaseAuth.instance.currentUser != null;

      if (!mounted) return;

      if (!introSeen) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          RoutesManager.introScreen,
              (route) => false,
        );
        return;
      }

      if (!onboardingSeen) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          RoutesManager.onBoardingScreen,
              (route) => false,
        );
        return;
      }

      if (!isLoggedIn) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          RoutesManager.loginScreen,
              (route) => false,
        );
        return;
      }

      Navigator.pushNamedAndRemoveUntil(
        context,
        RoutesManager.homeLayout,
            (route) => false,
      );
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: Image.asset(PngAssets.logo)),
            Image.asset(PngAssets.logoBrand),
          ],
        ),
      ),
    );
  }


}
