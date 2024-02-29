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

class BestPriceCpuPage extends StatefulWidget {
  const BestPriceCpuPage({
    Key? key,
  }) : super(key: key);

  @override
  State<BestPriceCpuPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<BestPriceCpuPage> {

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        backgroundColor: primaryColor,
        appBar: AppBar(
          title: Text('Fiyat Performans', style: CustomStyle.primaryTextStyle,),
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon:Icon(Boxicons.bxs_chevron_left, color: secondaryPrimaryColor,)),
          centerTitle: true,
          backgroundColor: primaryColor,
        ),
        body:  Center(
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
              products.sort((a, b) => b.avgMark.compareTo(a.avgMark));

              return ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (BuildContext context, int index) {

                    return products[index].result == '0' ? Card(
                        child: ListTile(
                          leading: const Icon(Boxicons.bx_chip, color: secondaryPrimaryColor,),
                          title: Text("${products[index].name}", style: CustomStyle.primaryTextStyle,),
                          //         subtitle: Text("${pdata[index].price}", style: CustomStyle.primaryTextStyle,),
                          trailing: Text(
                            "${products[index].avgMark}" + " pts",
                            style: CustomStyle.priceTextStyle,
                          ),
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => BenchmarkDetailPage(
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



      ),
    );
  }
}
