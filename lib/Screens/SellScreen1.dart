
import 'dart:async';
import 'dart:convert';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:pc_building_simulator/Model/sellCategory.dart';
import 'package:pc_building_simulator/Screens/SellScreen2.dart';
import 'package:pc_building_simulator/Utils/colors.dart';
import 'package:pc_building_simulator/Utils/common.dart';
import 'package:pc_building_simulator/Utils/images.dart';
import 'package:pc_building_simulator/Widgets/CategoryCard.dart';
import 'package:pc_building_simulator/Widgets/DeviceCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pc_building_simulator/Widgets/DrawerList.dart';
import 'package:pc_building_simulator/Widgets/ShoppingCategoryCard.dart';

import 'AddProductScreen.dart';

class SellPage1 extends StatefulWidget {
  const SellPage1({Key? key,}) : super(key: key);

  @override
  State<SellPage1> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<SellPage1> {

  String _address = 'Konum bilgisi alınamadı';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        title: Text('Ne Satıyorsun?', style: CustomStyle.boldTitleTextStyle,),
        elevation: 1,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon:Icon(Boxicons.bxs_chevron_left, color: secondaryPrimaryColor,)
        ),
        centerTitle: false,
        backgroundColor: primaryColor,
      ),
      body: ListView.builder(
        itemCount: SellCategory.list.length,
        itemBuilder: (context, index) {
          String key = SellCategory.list.keys.elementAt(index);
          String value = SellCategory.list[key]!;

          return Column(
            children: [
              ListTile(
                title: Text('$value', style: CustomStyle.thirdTextStyle,),
                onTap: () {
                  Navigator.of(context).push(_customPageRouteBuilder(SellPage2()));
                },
              ),
              Divider(
                thickness: 1,
                color: AppColors.midGrayColor.withOpacity(0.5),
              )
            ],
          );
        },
      ),
    );
  }

  PageRouteBuilder _customPageRouteBuilder(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOutQuart;
        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);
        return SlideTransition(position: offsetAnimation, child: child);
      },
    );
  }
}