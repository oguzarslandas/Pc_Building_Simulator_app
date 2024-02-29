import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:get/get.dart';
import 'package:pc_building_simulator/Model/bestPCmodel.dart';
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

class BestPcPage extends StatefulWidget {
  const BestPcPage({
    Key? key,
  }) : super(key: key);

  @override
  State<BestPcPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<BestPcPage> {

  bool showDetail = false;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Scaffold(
        backgroundColor: primaryColor,
        appBar: AppBar(
          title: Text('best'.tr, style: CustomStyle.primaryTextStyle,),
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
                    Icon(Boxicons.bx_desktop, color: secondaryPrimaryColor,size: 18,),
                    Expanded(child: Text('Masaüstü', style: CustomStyle.primaryTextStyle, overflow: TextOverflow.ellipsis,))
                  ],
                ),
              ),
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(Boxicons.bx_laptop, color: secondaryPrimaryColor, size: 18,),
                    Expanded(child: Text('Notebook', style: CustomStyle.primaryTextStyle,  overflow: TextOverflow.ellipsis,))
                  ],
                ),
              ),
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(Boxicons.bx_server, color: secondaryPrimaryColor, size: 18,),
                    Expanded(child: Text('Server', style: CustomStyle.primaryTextStyle, overflow: TextOverflow.ellipsis,))
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
                stream: FirebaseFirestore.instance.collection('bestDesktop').snapshots(),
                builder: (context,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  List<BestPC> products = snapshot.data!.docs.map((doc) {
                    // JsonQueryDocumentSnapshot'u Product'a dönüştür
                    Map<String, dynamic> data = doc.data();
                    return BestPC(
                      cpu: data['cpu'],
                      gpu: data['gpu'],
                      motherboard: data['motherboard'],
                      ram: data['ram'],
                      point: data['point'],
                      classprod: data['classprod'],
                      name: data['name'],
                      drive: data['drive'],

                    );
                  }).toList();
                  products.sort((a, b) => b.point.compareTo(a.point));

                  return ListView.builder(
                      itemCount: products.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                            child: Column(
                              children: [
                                ListTile(
                                  leading: const Icon(Icons.monitor_rounded, color: secondaryPrimaryColor,),
                                  title: Text("${products[index].name}", style: CustomStyle.primaryTextStyle,),
                                  subtitle: Text("${products[index].cpu}," + "${products[index].gpu}," + "${products[index].motherboard}",
                                    overflow: TextOverflow.ellipsis,
                                    style: CustomStyle.titleTextStyle,),
                                  trailing: Text("${products[index].point}" + " pts", style: CustomStyle.priceTextStyle,),
                                  onTap: () {
                                    setState(() {
                                      _showDesktopDetail(
                                          products[index].cpu,
                                          products[index].gpu,
                                          products[index].drive,
                                          products[index].ram,
                                          products[index].motherboard,
                                      );
                                    });
                                  },
                                ),
                              ],
                            )
                        );
                      });
                },
              ),
            ),
            /**************************************************************************************************************** */
            Center(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance.collection('bestLaptop').snapshots(),
                builder: (context,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }


                  List<BestPC> products = snapshot.data!.docs.map((doc) {
                    // JsonQueryDocumentSnapshot'u Product'a dönüştür
                    Map<String, dynamic> data = doc.data();
                    return BestPC(
                      cpu: data['cpu'],
                      gpu: data['gpu'],
                      motherboard: data['motherboard'],
                      ram: data['ram'],
                      point: data['point'],
                      classprod: data['classprod'],
                      name: data['name'],
                      drive: data['drive'],

                    );
                  }).toList();
                  products.sort((a, b) => b.point.compareTo(a.point));

                  return ListView.builder(
                      itemCount: products.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                            child: ListTile(
                              leading: const Icon(Icons.laptop_chromebook_outlined, color: secondaryPrimaryColor,),
                              title: Text("${products[index].name}", style: CustomStyle.primaryTextStyle,),
                              subtitle: Text("${products[index].cpu}," + "${products[index].gpu}," + "${products[index].motherboard}",
                                overflow: TextOverflow.ellipsis,
                                style: CustomStyle.titleTextStyle,),
                              trailing: Text("${products[index].point}" + " pts", style: CustomStyle.priceTextStyle,),
                              onTap: () {
                                _showLaptopDetail(
                                  products[index].cpu,
                                  products[index].gpu,
                                  products[index].drive,
                                  products[index].ram,
                                  products[index].motherboard,
                                );
                              },
                            )
                        );
                      });
                },
              ),
            ),
            /**************************************************************************************************************** */
            Center(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance.collection('bestServer').snapshots(),
                builder: (context,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }


                  List<BestPC> products = snapshot.data!.docs.map((doc) {
                    // JsonQueryDocumentSnapshot'u Product'a dönüştür
                    Map<String, dynamic> data = doc.data();
                    return BestPC(
                      cpu: data['cpu'],
                      gpu: data['gpu'],
                      motherboard: data['motherboard'],
                      ram: data['ram'],
                      point: data['point'],
                      classprod: data['classprod'],
                      name: data['name'],
                      drive: data['drive'],

                    );
                  }).toList();
                  products.sort((a, b) => b.point.compareTo(a.point));

                  return ListView.builder(
                      itemCount: products.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                            child: ListTile(
                              leading: const Icon(Boxicons.bx_server, color: secondaryPrimaryColor,),
                              title: Text("${products[index].name}", style: CustomStyle.primaryTextStyle,),
                              subtitle: Text("${products[index].cpu}," + "${products[index].gpu}," + "${products[index].motherboard}",
                                overflow: TextOverflow.ellipsis,
                                style: CustomStyle.titleTextStyle,),
                              trailing: Text("${products[index].point}" + " pts", style: CustomStyle.priceTextStyle,),
                              onTap: () {
                                _showServerDetail(
                                  products[index].cpu,
                                  products[index].gpu,
                                  products[index].drive,
                                  products[index].ram,
                                  products[index].motherboard,
                                );
                              },
                            )
                        );
                      });
                },
              ),
            ),
          ],
        ),

      ),
    );
  }

  late OverlayEntry _overlayDesktop;
  late OverlayEntry _overlayLaptop;
  late OverlayEntry _overlayServer;

  void _showDesktopDetail(cpu, gpu, drive, ram, motherboard) async {
    _overlayDesktop = OverlayEntry(
        builder: (context) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                _overlayDesktop.remove();
              },
              child: Container(
                padding: EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0), // Bulanıklaştırma miktarı
                      child: Container(
                        color: Colors.black.withOpacity(0.8), // Bulanıklaştırma rengi ve opaklık
                      ),
                    ),
                    Container(
                      height: MediaQuery.sizeOf(context).height * .85,
                      child: Container(
                        width: MediaQuery.sizeOf(context).width * .99,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text('CPU', style: CustomStyle.headlineTextStyle,),
                            ),
                            Container(
                              padding: EdgeInsets.all(8),
                              child: Expanded(
                                  child: Text("${cpu}",
                                    overflow: TextOverflow.fade,
                                    style: CustomStyle.thirdTextStyle,)),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text('GPU', style: CustomStyle.headlineTextStyle,),
                            ),
                            Container(
                              padding: EdgeInsets.all(8),
                              child: Expanded(
                                  child: Text("${gpu}",
                                    overflow: TextOverflow.fade,
                                    style: CustomStyle.thirdTextStyle,)),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text('Drive', style: CustomStyle.headlineTextStyle,),
                            ),
                            Container(
                              padding: EdgeInsets.all(8),
                              child: Expanded(
                                child: Text("${drive}",
                                  overflow: TextOverflow.fade,
                                  style: CustomStyle.thirdTextStyle,),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text('RAM', style: CustomStyle.headlineTextStyle,),
                            ),
                            Container(
                              padding: EdgeInsets.all(8),
                              child: Expanded(
                                child: Text("${ram}",
                                  overflow: TextOverflow.fade,
                                  style: CustomStyle.thirdTextStyle,),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text('Motherboard', style: CustomStyle.headlineTextStyle,),
                            ),
                            Container(
                              padding: EdgeInsets.all(8),
                              child: Expanded(
                                child: Text("${motherboard}",
                                  overflow: TextOverflow.fade,
                                  style: CustomStyle.thirdTextStyle,),
                              ),
                            ),
                          ],
                        ),
                      )
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
    );
    Overlay.of(context).insert(_overlayDesktop);
  }

  void _showLaptopDetail(cpu, gpu, drive, ram, motherboard) async {
    _overlayLaptop = OverlayEntry(
        builder: (context) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                _overlayLaptop.remove();
              },
              child: Container(
                padding: EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0), // Bulanıklaştırma miktarı
                      child: Container(
                        color: Colors.black.withOpacity(0.8), // Bulanıklaştırma rengi ve opaklık
                      ),
                    ),
                    Container(
                        height: MediaQuery.sizeOf(context).height * .85,
                        child: Container(
                          width: MediaQuery.sizeOf(context).width * .99,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text('CPU', style: CustomStyle.headlineTextStyle,),
                              ),
                              Container(
                                padding: EdgeInsets.all(8),
                                child: Expanded(
                                    child: Text("${cpu}",
                                      overflow: TextOverflow.fade,
                                      style: CustomStyle.thirdTextStyle,)),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text('GPU', style: CustomStyle.headlineTextStyle,),
                              ),
                              Container(
                                padding: EdgeInsets.all(8),
                                child: Expanded(
                                    child: Text("${gpu}",
                                      overflow: TextOverflow.fade,
                                      style: CustomStyle.thirdTextStyle,)),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text('Drive', style: CustomStyle.headlineTextStyle,),
                              ),
                              Container(
                                padding: EdgeInsets.all(8),
                                child: Expanded(
                                  child: Text("${drive}",
                                    overflow: TextOverflow.fade,
                                    style: CustomStyle.thirdTextStyle,),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text('RAM', style: CustomStyle.headlineTextStyle,),
                              ),
                              Container(
                                padding: EdgeInsets.all(8),
                                child: Expanded(
                                  child: Text("${ram}",
                                    overflow: TextOverflow.fade,
                                    style: CustomStyle.thirdTextStyle,),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text('Motherboard', style: CustomStyle.headlineTextStyle,),
                              ),
                              Container(
                                padding: EdgeInsets.all(8),
                                child: Expanded(
                                  child: Text("${motherboard}",
                                    overflow: TextOverflow.fade,
                                    style: CustomStyle.thirdTextStyle,),
                                ),
                              ),
                            ],
                          ),
                        )
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
    );
    Overlay.of(context).insert(_overlayLaptop);
  }

  void _showServerDetail(cpu, gpu, drive, ram, motherboard) async {
    _overlayServer = OverlayEntry(
        builder: (context) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                _overlayServer.remove();
              },
              child: Container(
                padding: EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0), // Bulanıklaştırma miktarı
                      child: Container(
                        color: Colors.black.withOpacity(0.8), // Bulanıklaştırma rengi ve opaklık
                      ),
                    ),
                    Container(
                        height: MediaQuery.sizeOf(context).height * .85,
                        child: Container(
                          width: MediaQuery.sizeOf(context).width * .99,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text('CPU', style: CustomStyle.headlineTextStyle,),
                              ),
                              Container(
                                padding: EdgeInsets.all(8),
                                child: Expanded(
                                    child: Text("${cpu}",
                                      overflow: TextOverflow.fade,
                                      style: CustomStyle.thirdTextStyle,)),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text('GPU', style: CustomStyle.headlineTextStyle,),
                              ),
                              Container(
                                padding: EdgeInsets.all(8),
                                child: Expanded(
                                    child: Text("${gpu}",
                                      overflow: TextOverflow.fade,
                                      style: CustomStyle.thirdTextStyle,)),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text('Drive', style: CustomStyle.headlineTextStyle,),
                              ),
                              Container(
                                padding: EdgeInsets.all(8),
                                child: Expanded(
                                  child: Text("${drive}",
                                    overflow: TextOverflow.fade,
                                    style: CustomStyle.thirdTextStyle,),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text('RAM', style: CustomStyle.headlineTextStyle,),
                              ),
                              Container(
                                padding: EdgeInsets.all(8),
                                child: Expanded(
                                  child: Text("${ram}",
                                    overflow: TextOverflow.fade,
                                    style: CustomStyle.thirdTextStyle,),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text('Motherboard', style: CustomStyle.headlineTextStyle,),
                              ),
                              Container(
                                padding: EdgeInsets.all(8),
                                child: Expanded(
                                  child: Text("${motherboard}",
                                    overflow: TextOverflow.fade,
                                    style: CustomStyle.thirdTextStyle,),
                                ),
                              ),
                            ],
                          ),
                        )
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
    );
    Overlay.of(context).insert(_overlayServer);
  }
}
