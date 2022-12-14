import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:responsive_framework/utils/scroll_behavior.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skindisease/views/login/Screens/Welcome/welcome_screen.dart';
import 'package:skindisease/views/login/constants.dart';
import 'package:skindisease/views/navmenu/body.dart';
import 'package:skindisease/views/tflite/body.dart';

import 'Views/splash/body.dart';

Future<SharedPreferences> _sPrefs = SharedPreferences.getInstance();

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  HttpOverrides.global = new MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();

  //SyncData().fetchAllDataFromSrv();
  if (await checkLogin()) {
    //SyncData().fetchAllDataFromSrv();
    runApp(_MaiPageWidget());
  } else
    runApp(_MainLoginWidget());
}

class _MainLoginWidget extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, widget) => ResponsiveWrapper.builder(
        BouncingScrollWrapper.builder(context, widget),
        maxWidth: 1200,
        minWidth: 450,
        defaultScale: true,
        breakpoints: [
          ResponsiveBreakpoint.resize(450, name: MOBILE),
          ResponsiveBreakpoint.autoScale(800, name: TABLET),
          ResponsiveBreakpoint.autoScale(1000, name: TABLET),
          ResponsiveBreakpoint.resize(1200, name: DESKTOP),
          ResponsiveBreakpoint.autoScale(2460, name: "4K"),
        ],
      ),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [Locale('ar', 'AE')],
      locale: Locale('ar', 'AE'),
      debugShowCheckedModeBanner: false,
      title: 'Dermatologist',
      theme: ThemeData(
        primaryColor: Colors.red[900],
        scaffoldBackgroundColor: Colors.white,
      ),
      home: SliderIntro(),
      routes: {
        '/index': (context) => (IndexPage()),
      },
    );
  }
}

class _MaiPageWidget extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, widget) => ResponsiveWrapper.builder(
        BouncingScrollWrapper.builder(context, widget),
        maxWidth: 1200,
        minWidth: 450,
        defaultScale: true,
        breakpoints: [
          ResponsiveBreakpoint.resize(450, name: MOBILE),
          ResponsiveBreakpoint.autoScale(800, name: TABLET),
          ResponsiveBreakpoint.autoScale(1000, name: TABLET),
          ResponsiveBreakpoint.resize(1200, name: DESKTOP),
          ResponsiveBreakpoint.autoScale(2460, name: "4K"),
        ],
      ),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [Locale('ar', 'AE')],
      locale: Locale('ar', 'AE'),
      debugShowCheckedModeBanner: false,
      title: 'Dermatologist',
      theme: ThemeData(
        primaryColor: Colors.red[900],
        scaffoldBackgroundColor: Colors.white,
      ),
      home: NavigationPageScreen(),
    );
  }
}

Future<bool> checkLogin() async {
  final SharedPreferences prefs = await _sPrefs;
  print(prefs.get("UseCredentials"));
  if (prefs.get("UseCredentials") != null) {
    Map<String, dynamic> userStr = jsonDecode(prefs.get("UseCredentials"));
    return int.parse(userStr["userID"]) > 0 ? true : false;
  }

  return false;
}
