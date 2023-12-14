import 'dart:async';

import 'package:pc_building_simulator/Screens/Dashboard.dart';
import 'package:pc_building_simulator/Screens/LocationScren.dart';
import 'package:pc_building_simulator/Screens/LoginScren.dart';
import 'package:pc_building_simulator/Utils/common.dart';
import 'package:pc_building_simulator/Utils/constant.dart';
import 'package:pc_building_simulator/Utils/images.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Utils/colors.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  late SharedPreferences localdata;
  bool? islogin;

  void init() async {
    localdata = await SharedPreferences.getInstance();
    islogin = (localdata.getBool('login') ?? false);
    print(islogin);
    if (islogin ?? false) {
      await Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const DashboardPage()));
    }
    else {
      await Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LocationPage()));
    }
  }


  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5), () => init());
  }


  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: <Widget>[
            Container(
              //     color: colors.secondcolor,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      colorFilter:
                      ColorFilter.mode(Colors.black.withOpacity(0.1),
                          BlendMode.dstATop),
                      image: const ExactAssetImage(backgroundImg),
                      fit: BoxFit.fitHeight
                  )
              ),
            ),
            Center(
              child: Column(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CircleAvatar(
                          backgroundColor: secondaryPrimaryColor.withOpacity
                            (0.45),
                          radius: 65.0,
                          child: Image.asset(
                            appLogo,
                            height: MediaQuery.of(context).size.height * 0.10,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 16),
                          child: Text(
                              mAppName,
                              style: CustomStyle.headlineTextStyle
                          ),
                        ),
                      ],
                    ),
                  ),
                  spinkit,
                  const SizedBox(
                    height: 50,
                  ),
                ],
              ),
            )
          ],
        ));
  }
}