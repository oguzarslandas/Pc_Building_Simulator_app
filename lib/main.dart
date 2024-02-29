
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pc_building_simulator/Locale/Languages.dart';
import 'package:pc_building_simulator/Screens/Dashboard.dart';
import 'package:pc_building_simulator/Screens/Home.dart';
import 'package:pc_building_simulator/Screens/LocationScren.dart';
import 'package:pc_building_simulator/Screens/LoginScren.dart';
import 'package:pc_building_simulator/Screens/SplashScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'dart:ui' as ui;

var uuid = Uuid();
late SharedPreferences prefs;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void getLoginStatus() async {
    prefs = await SharedPreferences.getInstance();
 /*   globals.gAuth.googleSignIn.isSignedIn().then((value) {
      prefs.setBool("isLoggedin", value);
    });*/
  }

  @override
  void initState() {
    getLoginStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    String deviceLanguage = ui.window.locale.languageCode;
    print(deviceLanguage);

    List<String> LocaleList = ['en', 'de', 'fr', 'hi', 'zh', 'es', 'it', 'tr'];

    if (LocaleList.contains(deviceLanguage)) {
      print(deviceLanguage);
    } else {
      deviceLanguage = 'en';
    }

    return GetMaterialApp(
      // theme: Provider.of<ThemeModel>(context).currentTheme,
      debugShowCheckedModeBanner: false,
      translations: Messages(),
      locale: Locale(deviceLanguage),
      fallbackLocale:Locale(deviceLanguage),
 //     home: SplashScreen(),
      initialRoute: '/',
      routes: {
        '/': (context) => SplashPage(),
 //       '/login': (context) => LocationPage(),
        '/dashboard': (context) => DashboardPage(),
        '/homepage': (context) => Home(),
      },
    );
  }
}