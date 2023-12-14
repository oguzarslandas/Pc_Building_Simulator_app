
import 'dart:async';
import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:get/get.dart';
import 'package:pc_building_simulator/Network/Api/ApiConfig.dart';
import 'package:pc_building_simulator/Screens/BestSystemScreen.dart';
import 'package:pc_building_simulator/Screens/PcBuildScreen.dart';
import 'package:pc_building_simulator/Screens/PsuCalculatorScreen.dart';
import 'package:pc_building_simulator/Screens/SystemBenchmarkScreen.dart';
import 'package:pc_building_simulator/Screens/SystemListScreen.dart';
import 'package:pc_building_simulator/Utils/colors.dart';
import 'package:pc_building_simulator/Utils/common.dart';
import 'package:pc_building_simulator/Utils/images.dart';
import 'package:pc_building_simulator/Widgets/CategoryCard.dart';
import 'package:pc_building_simulator/Widgets/DeviceCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pc_building_simulator/Widgets/DrawerList.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key,}) : super(key: key);

  @override
  State<DashboardPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<DashboardPage> {

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
        backgroundColor: primaryColor,
        iconTheme: const IconThemeData(color: thirdPrimaryColor),
        elevation: 1,
      ),
      //  bottomNavigationBar: BottomNavBar(),
      body: Stack(
        children: <Widget>[
          /*        Container(
            // Here the height of the container is 45% of our total height
            height: MediaQuery.of(context).size.height * .20,
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50)
              ),
              image: DecorationImage(
                  alignment: Alignment.centerLeft,
                  image: const AssetImage(
                      appLogo),
                  colorFilter: ColorFilter.mode(
                    Colors.grey.withOpacity(0.3),
                    BlendMode.modulate,
                  )),
            ),
          ),*/
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
         /**         const SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      //  color: primaryColor.withOpacity(0.5)
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 5),
                            width: MediaQuery.of(context).size.width * 0.75,
                            //     color: Colors.cyan,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: const [
                                        Text(
                                          'AYŞE YILMAZ',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700, fontSize: 18),
                                          maxLines: 1,
                                        ),
                                        Text(
                                          'Yazılım Mühendisi',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w300, fontSize: 18),
                                          maxLines: 1,
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),*/

                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.04,
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
                                MaterialPageRoute(builder: (context) => SystemListPage()),
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
                                MaterialPageRoute(builder: (context) => BestSystemPage()),
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