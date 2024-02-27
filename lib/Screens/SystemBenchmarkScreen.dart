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
                    return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (BuildContext context, int index) {
                            return snapshot.data!.docs[index]['result'] == '0' ? Card(
                                child: ListTile(
                                  leading: const Icon(Boxicons.bx_chip, color: secondaryPrimaryColor,),
                                  title: Text("${snapshot.data!.docs[index]['name']}", style: CustomStyle.primaryTextStyle,),
                                  //         subtitle: Text("${pdata[index].price}", style: CustomStyle.primaryTextStyle,),
                                  trailing: Text("${snapshot.data!.docs[index]['benchpoint']}" + " pts", style: CustomStyle.priceTextStyle,),
                                  onTap: () {
                                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BenchmarkDetailPage(
                                      name: snapshot.data!.docs[index]['name'].toString(), points: double.parse(snapshot.data!.docs[index]['benchpoint']))));
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
                    return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (BuildContext context, int index) {
                          return snapshot.data!.docs[index]['result'] == '3' ? Card(
                              child: ListTile(
                                leading: const Icon(Boxicons.bx_chip, color: secondaryPrimaryColor,),
                                title: Text("${snapshot.data!.docs[index]['name']}", style: CustomStyle.primaryTextStyle,),
                                //         subtitle: Text("${pdata[index].price}", style: CustomStyle.primaryTextStyle,),
                                trailing: Text("${snapshot.data!.docs[index]['benchpoint']}" + " pts", style: CustomStyle.priceTextStyle,),
                                onTap: () {
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BenchmarkDetailPage(
                                    name: snapshot.data!.docs[index]['name'].toString(), points: double.parse(snapshot.data!.docs[index]['benchpoint']))));
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
