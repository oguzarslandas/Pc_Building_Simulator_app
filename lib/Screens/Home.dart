
import 'package:pc_building_simulator/Screens/Dashboard.dart';
import 'package:pc_building_simulator/Utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _State();
}

class _State extends State<Home> {

  int tabNo = 0;
  CupertinoTabController? controller;


  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        CupertinoTabScaffold(
          backgroundColor: primaryColor,
          controller: controller,
          tabBar: CupertinoTabBar(
            onTap: (value) {
              setState(() {
                tabNo = value;
              });
            },
            activeColor: primaryColor,
            inactiveColor: appTextSecondaryColor,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home), label: 'Anasayfa'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.area_chart), label: 'Mining'),

              ///             BottomNavigationBarItem(icon: Container()),
              BottomNavigationBarItem(
                  icon: Icon(Icons.device_thermostat), label: 'Sıcaklıklar'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings), label: 'Ayarlar'),
            ],
          ),
          tabBuilder: (context, index) => (index == 0)
              ? DashboardPage()
              : (index == 1)
              ? DashboardPage()
              : DashboardPage()
        ),
   //     overlayVisible ? OverlayWidget() : Container(),
      ],
    );
  }
}
