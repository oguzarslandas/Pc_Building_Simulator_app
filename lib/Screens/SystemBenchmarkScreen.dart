import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:get/get.dart';
import 'package:pc_building_simulator/Model/product.dart';
import 'package:pc_building_simulator/Network/Api/ApiService.dart';
import 'package:pc_building_simulator/Screens/BenchmarkDetailScreen.dart';
import 'package:pc_building_simulator/Utils/colors.dart';
import 'package:pc_building_simulator/Utils/common.dart';
import 'package:pc_building_simulator/Utils/images.dart';
import 'package:pc_building_simulator/Widgets/CategoryCard.dart';
import 'package:pc_building_simulator/Widgets/DeviceCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nb_utils/nb_utils.dart';

class KeyValueModel {
  String key;
  String value;

  KeyValueModel({required this.key, required this.value});
}

class BenchmarkPage extends StatefulWidget {
  const BenchmarkPage({
    Key? key,
  }) : super(key: key);

  @override
  State<BenchmarkPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<BenchmarkPage> {

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
          backgroundColor: primaryColor,
          appBar: AppBar(
            title: Text('benchmarks'.tr, style: CustomStyle.primaryTextStyle,),
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
                icon:Icon(Boxicons.bxs_chevron_left, color: secondaryPrimaryColor,)),
            centerTitle: true,
            backgroundColor: primaryColor,
            bottom: TabBar(
              tabs: <Widget>[
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(Boxicons.bx_microchip, color: secondaryPrimaryColor,),
                      Text('cpu'.tr, style: CustomStyle.primaryTextStyle,)
                    ],
                  ),
                ),
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(Boxicons.bx_line_chart, color: secondaryPrimaryColor),
                      Text('gpu'.tr, style: CustomStyle.primaryTextStyle,)
                    ],
                  ),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              Center(
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance.collection('products').snapshots(),
                  builder: (context,
                      AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    List<Product> products = snapshot.data!.docs.map((doc) {
                      // JsonQueryDocumentSnapshot'u Product'a dönüştür
                      Map<String, dynamic> data = doc.data();
                      return Product(
                        name: data['name'],
                        price: data['price'],
                        uid: data['uid'],
                        brand: data['brand'],
                        desc: data['desc'],
                        socket: data['socket'],
                        benchpoint: data['benchpoint'],
                        avgMark: data['avgMark'],
                        watt: data['watt'],
                        result: data['result'],
                        imgUrl: data['imgUrl'],
                        buyUrl: data['buyUrl'],
                        classcpu: data['classcpu'],
                        clockspeed: data['clockspeed'],
                        turbospeed: data['turbospeed'],
                        core: data['core'],
                        thread: data['thread'],
                        cache: data['cache'],
                      );
                    }).toList();
                    products.sort((a, b) => b.benchpoint.compareTo(a.benchpoint));

                    return ListView.builder(
                        itemCount: products.length,
                        itemBuilder: (BuildContext context, int index) {
                            return products[index].result == '0' ? Card(
                                child: ListTile(
                                  leading: const Icon(Boxicons.bx_chip, color: secondaryPrimaryColor,),
                                  title: Text("${products[index].name}", style: CustomStyle.primaryTextStyle,),
                                  //         subtitle: Text("${pdata[index].price}", style: CustomStyle.primaryTextStyle,),
                                  trailing: Text("${products[index].benchpoint}" + " pts", style: CustomStyle.priceTextStyle,),
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(
                                        builder: (context) => BenchmarkDetailPage(
                                      name: products[index].name.toString(),
                                        points: double.parse(products[index].benchpoint.toString()),
                                          result: '0',
                                          classProd: products[index].classcpu,
                                          socket: products[index].socket,
                                          clockspeed: products[index].clockspeed,
                                          turbospeed: products[index].turbospeed,
                                          core: products[index].core,
                                          threads: products[index].thread,
                                          cache: products[index].cache,
                                          avgmark: products[index].avgMark,


                                        )));
                                  },
                                )
                            ) : SizedBox.shrink();
                        });
                  },
                ),
              ),
/**************************************************************************************************************** */
              Center(
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance.collection('products').snapshots(),
                  builder: (context,
                      AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    List<Product> products = snapshot.data!.docs.map((doc) {
                      // JsonQueryDocumentSnapshot'u Product'a dönüştür
                      Map<String, dynamic> data = doc.data();
                      return Product(
                        name: data['name'],
                        price: data['price'],
                        uid: data['uid'],
                        brand: data['brand'],
                        desc: data['desc'],
                        socket: data['socket'],
                        benchpoint: data['benchpoint'],
                        avgMark: data['avgMark'],
                        watt: data['watt'],
                        result: data['result'],
                        imgUrl: data['imgUrl'],
                        buyUrl: data['buyUrl'],
                        classcpu: data['classcpu'],
                        clockspeed: data['clockspeed'],
                        turbospeed: data['turbospeed'],
                        core: data['core'],
                        thread: data['thread'],
                        cache: data['cache'],
                      );
                    }).toList();
                    products.sort((a, b) => b.benchpoint.compareTo(a.benchpoint));

                    return ListView.builder(
                        itemCount: products.length,
                        itemBuilder: (BuildContext context, int index) {
                          return products[index].result == '3' ? Card(
                              child: ListTile(
                                leading: const Icon(Boxicons.bx_chip, color: secondaryPrimaryColor,),
                                title: Text("${products[index].name}", style: CustomStyle.primaryTextStyle,),
                                //         subtitle: Text("${pdata[index].price}", style: CustomStyle.primaryTextStyle,),
                                trailing: Text("${products[index].benchpoint}" + " pts", style: CustomStyle.priceTextStyle,),
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(
                                      builder: (context) => BenchmarkDetailPage(
                                    name: products[index].name.toString(),
                                      points: double.parse(products[index].benchpoint.toString()),
                                        result: '3',
                                        classProd: products[index].classcpu,
                                        socket: products[index].socket,
                                        clockspeed: products[index].clockspeed,
                                        turbospeed: products[index].turbospeed,
                                        core: products[index].core,
                                        threads: products[index].thread,
                                        cache: products[index].cache,
                                        avgmark: products[index].avgMark,
                                      )));
                                },
                              )
                          ) : SizedBox.shrink();
                        });
                  },
                ),
              ),
            ],
          ),



      ),
    );
  }
}
