
import 'package:country_flags/country_flags.dart';
import 'package:get/get.dart';
import 'package:pc_building_simulator/Screens/Dashboard.dart';
import 'package:pc_building_simulator/Utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pc_building_simulator/Utils/common.dart';
import 'package:pc_building_simulator/Utils/images.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({Key? key}) : super(key: key);

  @override
  State<LocationPage> createState() => _State();
}

class _State extends State<LocationPage> {

  int tabNo = 0;
  CupertinoTabController? controller;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(8),
        width: double.infinity,
        color: primaryColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Select Your Location',
              style: CustomStyle.locationTextStyle,
            ),
            SizedBox(
              height: 45,
            ),
            Container(
              width: MediaQuery.of(context).size.width * .50,
              child: OutlinedButton(
                onPressed: () {
                  var locale = Locale('en', 'UK');
                  Get.updateLocale(locale);
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const DashboardPage()));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CountryFlag.fromCountryCode(
                      'gb',
                      height: MediaQuery.of(context).size.width * .07,
                      width: MediaQuery.of(context).size.width * .07,
                      borderRadius: 8,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text('United Kingdom', style: CustomStyle.primaryTextStyle,),
                  ],
                ),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(width: 2.0, color: thirdPrimaryColor),
                  shape: StadiumBorder()
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * .50,
              child: OutlinedButton(
                onPressed: () {
                  var locale = Locale('en', 'US');
                  Get.updateLocale(locale);
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const DashboardPage()));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CountryFlag.fromCountryCode(
                      'us',
                      height: MediaQuery.of(context).size.width * .07,
                      width: MediaQuery.of(context).size.width * .07,
                      borderRadius: 8,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text('USA', style: CustomStyle.primaryTextStyle,),
                  ],
                ),
                style: OutlinedButton.styleFrom(
                    side: BorderSide(width: 2.0, color: thirdPrimaryColor),
                    shape: StadiumBorder()
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * .50,
              child: OutlinedButton(
                onPressed: () {
                  var locale = Locale('en', 'CA');
                  Get.updateLocale(locale);
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const DashboardPage()));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CountryFlag.fromCountryCode(
                      'ca',
                      height: MediaQuery.of(context).size.width * .07,
                      width: MediaQuery.of(context).size.width * .07,
                      borderRadius: 8,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text('Canada', style: CustomStyle.primaryTextStyle,),
                  ],
                ),
                style: OutlinedButton.styleFrom(
                    side: BorderSide(width: 2.0, color: thirdPrimaryColor),
                    shape: StadiumBorder()
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * .50,
              child: OutlinedButton(
                onPressed: () {
                  var locale = Locale('de', 'DE');
                  Get.updateLocale(locale);
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const DashboardPage()));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CountryFlag.fromCountryCode(
                      'de',
                      height: MediaQuery.of(context).size.width * .07,
                      width: MediaQuery.of(context).size.width * .07,
                      borderRadius: 8,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text('Germany', style: CustomStyle.primaryTextStyle,),
                  ],
                ),
                style: OutlinedButton.styleFrom(
                    side: BorderSide(width: 2.0, color: thirdPrimaryColor),
                    shape: StadiumBorder()
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * .50,
              child: OutlinedButton(
                onPressed: () {
                  var locale = Locale('it', 'IT');
                  Get.updateLocale(locale);
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const DashboardPage()));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CountryFlag.fromCountryCode(
                      'it',
                      height: MediaQuery.of(context).size.width * .07,
                      width: MediaQuery.of(context).size.width * .07,
                      borderRadius: 8,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text('Italy', style: CustomStyle.primaryTextStyle,),
                  ],
                ),
                style: OutlinedButton.styleFrom(
                    side: BorderSide(width: 2.0, color: thirdPrimaryColor),
                    shape: StadiumBorder()
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * .50,
              child: OutlinedButton(
                onPressed: () {
                  var locale = Locale('fr', 'FR');
                  Get.updateLocale(locale);
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const DashboardPage()));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CountryFlag.fromCountryCode(
                      'fr',
                      height: MediaQuery.of(context).size.width * .07,
                      width: MediaQuery.of(context).size.width * .07,
                      borderRadius: 8,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text('France', style: CustomStyle.primaryTextStyle,),
                  ],
                ),
                style: OutlinedButton.styleFrom(
                    side: BorderSide(width: 2.0, color: thirdPrimaryColor),
                    shape: StadiumBorder()
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * .50,
              child: OutlinedButton(
                onPressed: () {
                  var locale = Locale('es', 'ES');
                  Get.updateLocale(locale);
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const DashboardPage()));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CountryFlag.fromCountryCode(
                      'es',
                      height: MediaQuery.of(context).size.width * .07,
                      width: MediaQuery.of(context).size.width * .07,
                      borderRadius: 8,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text('Spain', style: CustomStyle.primaryTextStyle,),
                  ],
                ),
                style: OutlinedButton.styleFrom(
                    side: BorderSide(width: 2.0, color: thirdPrimaryColor),
                    shape: StadiumBorder()
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * .50,
              child: OutlinedButton(
                onPressed: () {
                  var locale = Locale('tr', 'TR');
                  Get.updateLocale(locale);
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const DashboardPage()));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CountryFlag.fromCountryCode(
                      'tr',
                      height: MediaQuery.of(context).size.width * .07,
                      width: MediaQuery.of(context).size.width * .07,
                      borderRadius: 8,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text('Turkey', style: CustomStyle.primaryTextStyle,),
                  ],
                ),
                style: OutlinedButton.styleFrom(
                    side: BorderSide(width: 2.0, color: thirdPrimaryColor),
                    shape: StadiumBorder()
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * .50,
              child: OutlinedButton(
                onPressed: () {
                  var locale = Locale('HI');
                  Get.updateLocale(locale);
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const DashboardPage()));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CountryFlag.fromCountryCode(
                      'in',
                      height: MediaQuery.of(context).size.width * .07,
                      width: MediaQuery.of(context).size.width * .07,
                      borderRadius: 8,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text('India', style: CustomStyle.primaryTextStyle,),
                  ],
                ),
                style: OutlinedButton.styleFrom(
                    side: BorderSide(width: 2.0, color: thirdPrimaryColor),
                    shape: StadiumBorder()
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * .50,
              child: OutlinedButton(
                onPressed: () {
                  var locale = Locale('ZH');
                  Get.updateLocale(locale);
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const DashboardPage()));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CountryFlag.fromCountryCode(
                      'cn',
                      height: MediaQuery.of(context).size.width * .07,
                      width: MediaQuery.of(context).size.width * .07,
                      borderRadius: 8,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text('China', style: CustomStyle.primaryTextStyle,),
                  ],
                ),
                style: OutlinedButton.styleFrom(
                    side: BorderSide(width: 2.0, color: thirdPrimaryColor),
                    shape: StadiumBorder()
                ),
              ),
            ),
            SizedBox(
              height: 45,
            ),
            TextButton(onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const DashboardPage()));
            }, child: Text('continue without select'))
          ],
        ),
      ),
    );
  }
}
