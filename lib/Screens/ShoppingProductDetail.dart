
import 'dart:async';
import 'dart:convert';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
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

class ShopProductDetail extends StatefulWidget {
  ShopProductDetail({
    Key? key,
    required this.svgSrc,
    required this.headline,
    required this.detail,
    required this.price,
    required this.address,
    required this.status,
  }) : super(key: key);

  final List svgSrc;
  final String headline;
  final String detail;
  final int price;
  final String address;
  final String status;

  @override
  State<ShopProductDetail> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<ShopProductDetail> {


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
      //  title: Text('Ne Satıyorsun?', style: CustomStyle.boldTitleTextStyle,),
        elevation: 1,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon:Icon(Boxicons.bxs_chevron_left, color: secondaryPrimaryColor,)
        ),
        centerTitle: false,
     //   backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * .35,
            child: PageView.builder(
              itemCount: widget.svgSrc.length,
              itemBuilder: (context, index) {
                return Image.network(
                  widget.svgSrc[index],
                  fit: BoxFit.contain,
                );
              },
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
            height: MediaQuery.of(context).size.height * .52,
            width: double.maxFinite,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Divider(
                  thickness: 1,
                  color: AppColors.midGrayColor.withOpacity(0.2),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(widget.price.toString() + 'currency'.tr, style: CustomStyle.headlineTextStyle,),
                      IconButton(
                          onPressed: (){

                          },
                          icon: Icon(Boxicons.bx_like)
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(widget.headline, style: CustomStyle.headlineTextStyle),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('📍'+widget.address, style: CustomStyle.slocationTextStyle),
                      Text(widget.status, style: CustomStyle.titleTextStyle),
                    ],
                  ),
                ),
                Divider(
                  thickness: 1,
                  color: AppColors.midGrayColor.withOpacity(0.2),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(widget.detail, style: CustomStyle.primaryTextStyle),
                ),
              ],
            )
          ),
        ],
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