
import 'dart:async';
import 'dart:convert';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:pc_building_simulator/Network/Api/ApiConfig.dart';
import 'package:pc_building_simulator/Screens/BestPC.dart';
import 'package:pc_building_simulator/Screens/PcBuildScreen.dart';
import 'package:pc_building_simulator/Screens/PsuCalculatorScreen.dart';
import 'package:pc_building_simulator/Screens/ShopScreen.dart';
import 'package:pc_building_simulator/Screens/ShoppingScreen.dart';
import 'package:pc_building_simulator/Screens/SystemBenchmarkScreen.dart';
import 'package:pc_building_simulator/Utils/colors.dart';
import 'package:pc_building_simulator/Utils/common.dart';
import 'package:pc_building_simulator/Utils/images.dart';
import 'package:pc_building_simulator/Widgets/CategoryCard.dart';
import 'package:pc_building_simulator/Widgets/DeviceCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pc_building_simulator/Widgets/DrawerList.dart';

import 'AddProductScreen.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key,}) : super(key: key);

  @override
  State<DashboardPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<DashboardPage> {

  static const colorizeTextStyle = TextStyle(
    fontSize: 20.0,
    fontWeight: FontWeight.w600,
    fontFamily: 'Red Hat Display',
  );

  Future<void> _checkLocationPermission(BuildContext context) async {

    final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;
    LocationPermission permission = await _geolocatorPlatform.checkPermission();

    if (permission == LocationPermission.always || permission == LocationPermission.whileInUse) {
      print('tam konum izni verildi!');
    }
    else if (permission == LocationPermission.denied) {
      permission = await _geolocatorPlatform.requestPermission();
      if (permission == LocationPermission.always) {
        print('tam konum izni verildi');

      } else if(permission == LocationPermission.whileInUse) {
        print('konum yalnızca kullanırken izin verildi');
      }
    }
  }

  @override
  void initState() {
    _checkLocationPermission(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerList(),
      drawerScrimColor: thirdPrimaryColor.withOpacity(0.50),
      drawerDragStartBehavior: DragStartBehavior.start,
      drawerEdgeDragWidth: MediaQuery.of(context).size.width,
      backgroundColor: primaryColor,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('PC CREATOR', style: CustomStyle
            .primaryTextStyle,),
        centerTitle: true,
    /*    flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: AppColors.primaryG, // Başlangıç ve bitiş renkleri
              begin: Alignment.topLeft, // Başlangıç noktası
              end: Alignment.bottomRight, // Bitiş noktası
              stops: [0.0, 1.0], // Başlangıç ve bitiş renklerinin konumu
              tileMode: TileMode.clamp, // Eğer gradient boyunca bir alan dışına taşıyorsa, nasıl davranacağını belirler
            ),
          ),
        ),*/
        backgroundColor: primaryColor,
        iconTheme: const IconThemeData(color: thirdPrimaryColor),
        elevation: 1,
      ),
      //  bottomNavigationBar: BottomNavBar(),
      body: Stack(
        children: <Widget>[
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  HeartBeat(
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        gradient: LinearGradient(
                          colors: AppColors.primaryG, // Başlangıç ve bitiş renkleri
                          begin: Alignment.bottomLeft, // Başlangıç noktası
                          end: Alignment.topRight, // Bitiş noktası
                          stops: [0.0, 1.0], // Başlangıç ve bitiş renklerinin konumu
                          tileMode: TileMode.clamp, // Eğer gradient boyunca bir alan dışına taşıyorsa, nasıl davranacağını belirler
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) =>  ShoppingPage()),
                                );
                              },
                              child: Container(
                                margin: const EdgeInsets.symmetric(vertical: 5),
                                width: MediaQuery.of(context).size.width * 0.75,
                                height: MediaQuery.of(context).size.height * 0.08,
                                //     color: Colors.cyan,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            AnimatedTextKit(
                                              animatedTexts: [
                                                ColorizeAnimatedText(
                                                  'HEMEN SATMAYA BAŞLA!',
                                                  textStyle: colorizeTextStyle,
                                                  colors: AppColors.animationColor,
                                                  speed: const Duration(milliseconds: 200),
                                                ),
                                              ],
                                              isRepeatingAnimation: true,
                                              repeatForever: true,

                                              onTap: () {
                                                print("Tap Event");
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(builder: (context) => ShoppingPage()),
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: SizedBox(
                                              width: 60,
                                              height: 60,
                                              child: Image.asset(pckasa2)),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),


                  Expanded(
                    child: Container(
                      child: GridView.count(
                        physics: const BouncingScrollPhysics(),
                        crossAxisCount: 1,
                        childAspectRatio: 3,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 0,
                        children: [
                          CategoryCard(
                            title: 'Ekle',
                            svgSrc: psu,
                            press: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const AddProductPage()),
                              );
                            },
                            color: cardColor,
                          ),
                          CategoryCard(
                            title: 'pcbuild'.tr,
                            svgSrc: graphiccard3,
                            press: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const PcBuildPage()),
                              );
                            },
                            color: cardColor,
                          ),
                          CategoryCard(
                            title: 'systembenchmark'.tr,
                            svgSrc: bench,
                            press: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const BenchmarkPage()),
                              );
                            },
                            color: cardColor,
                          ),
                          CategoryCard(
                              title: 'psucalculator'.tr,
                              svgSrc: psu,
                              press: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const PsuCalculatorPage()),
                                );
                              },
                              color: cardColor,
                          ),
                          CategoryCard(
                            title: 'readysystems'.tr,
                            svgSrc: pckasa,
                            press: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => BestPcPage()),
                              );
                            },
                            color: cardColor,
                          ),
                          CategoryCard(
                            title: 'best'.tr,
                            svgSrc: best,
                            press: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => BestPcPage()),
                              );
                            },
                            color: cardColor,
                          ),
                        ],
                      ),
                    )
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}