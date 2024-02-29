import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:get/get.dart';
import 'package:pc_building_simulator/Model/product.dart';
import 'package:pc_building_simulator/Network/Api/ApiService.dart';
import 'package:pc_building_simulator/Utils/Globals.dart';
import 'package:pc_building_simulator/Utils/colors.dart';
import 'package:pc_building_simulator/Utils/common.dart';
import 'package:pc_building_simulator/Utils/images.dart';
import 'package:pc_building_simulator/Widgets/CategoryCard.dart';
import 'package:pc_building_simulator/Widgets/DeviceCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:url_launcher/url_launcher.dart';

class KeyValueModel {
  String key;
  String value;

  KeyValueModel({required this.key, required this.value});
}

class ProductPage extends StatefulWidget {
  ProductPage({
    Key? key,
    required this.result,
  }) : super(key: key);

  final result;

  @override
  State<ProductPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<ProductPage> {

  List<Product> productDetailList = [];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: primaryColor,
        appBar: AppBar(
          title: Text('products'.tr, style: CustomStyle.primaryTextStyle,),
          elevation: 1,
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon:Icon(Boxicons.bxs_chevron_left, color: secondaryPrimaryColor,)),
          centerTitle: true,
          backgroundColor: primaryColor,
        ),

        body: StreamBuilder(
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
                    return widget.result == snapshot.data!.docs[index]['result'] ?
                    Card(
                      child: ListTile(
                        leading: Container(
                            height: size.height * 0.10,
                            width: size.width * 0.15,
                            child: snapshot.data!.docs[index]['imgUrl'] != null ?  SizedBox(
                              height: MediaQuery.of(context).size.height * 0.35,
                              width: double.infinity,
                              child: Image.network(
                                snapshot.data!.docs[index]['imgUrl'].toString(),
                                fit: BoxFit.cover,
                              ),
                            ) : Image.asset(noimage)
                        ),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Container(
                                  child: Text("${snapshot.data!.docs[index]['name']}", style: CustomStyle.headlineTextStyle,)),
                            ),
                            Text("${snapshot.data!.docs[index]['price']}" + 'currency'.tr, style: CustomStyle.priceTextStyle,),
                          ],
                        ),
                        subtitle: Column(
                          children: [
                            Container(
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                                //        decoration: CustomStyle.secondBoxDecoration,
                                child: Text("${snapshot.data!.docs[index]['desc']}", style: CustomStyle.titleTextStyle,)
                            ),
                            //     SizedBox(height: 5,),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Container(
                                height: size.height * .05,
                                child: InkWell(
                                    onTap: () {
                                      final Uri toLaunch = Uri.parse(snapshot.data!.docs[index]['buyUrl'].toString());
                                      _launchInBrowser(toLaunch);
                                    },
                                    child: Image.asset(buyonamazon)),
                              ),
                            )
                          ],
                        ),
                        //     trailing: Text("${pdata[index].price}", style: CustomStyle.priceTextStyle,),
                        onTap: () {

                          productDetailList.add(Product(
                            name: snapshot.data!.docs[index]['name'],
                            brand: snapshot.data!.docs[index]['brand'],
                            desc: snapshot.data!.docs[index]['desc'],
                            price: snapshot.data!.docs[index]['price'],
                            benchpoint: snapshot.data!.docs[index]['benchpoint'],
                            avgMark: snapshot.data!.docs[index]['avgMark'],
                            watt: snapshot.data!.docs[index]['watt'],
                            socket: snapshot.data!.docs[index]['socket'],
                            result: snapshot.data!.docs[index]['result'],
                            uid:  snapshot.data!.docs[index]['uid'],
                            imgUrl: snapshot.data!.docs[index]['imgUrl'],
                            buyUrl: snapshot.data!.docs[index]['buyUrl'],
                            classcpu: snapshot.data!.docs[index]['classcpu'],
                            clockspeed: snapshot.data!.docs[index]['clockspeed'],
                            core: snapshot.data!.docs[index]['core'],
                            thread: snapshot.data!.docs[index]['thread'],
                            turbospeed: snapshot.data!.docs[index]['turbospeed'],
                            cache: snapshot.data!.docs[index]['cache'],
                          ));
                          Navigator.of(context).pop(productDetailList);

                        },
                      ),
                    ) : SizedBox.shrink();

                });
          },
        ),
    );
  }

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.inAppWebView,
    )) {
      throw Exception('Could not launch $url');
    }
  }

}

