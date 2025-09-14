import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:evently_v2/config/themes/dark_theme.dart';
import 'package:evently_v2/config/themes/light_theme.dart';
import 'package:evently_v2/config/themes/themes_manager.dart';
import 'package:evently_v2/core/cashing/cashing.dart';
import 'package:evently_v2/core/providers/providers_manager.dart';
import 'package:evently_v2/core/providers/user_provider.dart';
import 'package:evently_v2/core/routes/routes_manager.dart';
import 'package:evently_v2/config/firebase/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Cashing.initApp();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseFirestore.instance.enableNetwork();
  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: Locale('en'),
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => UserProvider()),
          ChangeNotifierProvider(create: (context) => ProvidersManager()),
        ],
        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemesManager lightTheme = LightTheme();
    final ThemesManager darkTheme = DarkTheme();
    final ProvidersManager providerManager = Provider.of<ProvidersManager>(
      context,
    );

    return ScreenUtilInit(
      designSize: Size(393, 793),
      builder: (context, child) => MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        debugShowCheckedModeBanner: false,
        onGenerateRoute: RoutesManager.getRoute,
        initialRoute: RoutesManager.splash,
        theme: lightTheme.themeData,
        darkTheme: darkTheme.themeData,
        themeMode: providerManager.themeMode,
        themeAnimationDuration: Duration(milliseconds: 500),
        themeAnimationCurve: Curves.linear,
      ),
    );
  }
}
