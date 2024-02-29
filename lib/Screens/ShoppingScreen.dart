
import 'dart:async';
import 'dart:convert';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:pc_building_simulator/Screens/SellScreen1.dart';
import 'package:pc_building_simulator/Screens/ShoppingProductDetail.dart';
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

class ShopListPage extends StatefulWidget {
  const ShopListPage({Key? key,}) : super(key: key);

  @override
  State<ShopListPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<ShopListPage> {
  
  String _address = 'Konum bilgisi alınamadı';
  
  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      List<Placemark> placemarks = await placemarkFromCoordinates(
          position.latitude, position.longitude);
      Placemark place = placemarks[0];
      setState(() {
        _address = "${place.administrativeArea}, ${place.subAdministrativeArea}";
      });
    } catch (e) {
      print('Konum alınamadı: $e');
      setState(() {
        _address = 'Konum bilgisi alınamadı';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        title: Text('Yakınında', style: CustomStyle.boldTitleTextStyle,),
        elevation: 1,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon:Icon(Boxicons.bxs_chevron_left, color: secondaryPrimaryColor,)
        ),
        centerTitle: false,
        backgroundColor: primaryColor,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Text('📍'+_address, style: CustomStyle.titleTextStyle,),
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterFloat,
      floatingActionButton: InkWell(
        splashColor: Colors.transparent,
        onTap: () {
          /*   setState(() {
              if(OnePref.getPremium() == true) {
                _checkItemInArray(countryAreaCode + _phoneController.text);
              }
              else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => PurchasePage(),
                  ),
                );
              }
            });*/
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => SellPage1(),
            ),
          );
        },
        child: SizedBox(
          width: 70,
          height: 70,
          child: Container(
            width: 65,
            height: 65,
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: AppColors.primaryG),
                borderRadius: BorderRadius.circular(35),
                boxShadow: const [
                  BoxShadow(color: Colors.black12, blurRadius: 2)
                ]),
            child: const Icon(Boxicons.bx_camera,
                color: AppColors.whiteColor, size: 32),
          ),
        ),
      ),
      body: Stack(
        children: <Widget>[
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance.collection('sellProducts').snapshots(),
                  builder: (context,
                      AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    return GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, // İzgara sütun sayısı
                          crossAxisSpacing: 12.0, // İzgara arasındaki yatay boşluk
                          mainAxisSpacing: 36.0, // İzgara arasındaki dikey boşluk
                        ),
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ShoppingCategoryCard(
                            title: snapshot.data!.docs[index]['headline'],
                            svgSrc: snapshot.data!.docs[index]['photoUrl'],
                            price: snapshot.data!.docs[index]['price'],
                            location: snapshot.data!.docs[index]['address'],
                            detail: snapshot.data!.docs[index]['detail'],
                            press: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) =>  ShopProductDetail(
                                  svgSrc: snapshot.data!.docs[index]['photoUrl'],
                                  headline: snapshot.data!.docs[index]['headline'],
                                  detail: snapshot.data!.docs[index]['detail'],
                                  address: snapshot.data!.docs[index]['address'],
                                  price: snapshot.data!.docs[index]['price'],
                                  status: snapshot.data!.docs[index]['status'],

                                )),
                              );
                            },
                            color: cardColor,
                          );

                        });

                }
              ),
            ),
          )
        ],
      ),
    );
  }
}