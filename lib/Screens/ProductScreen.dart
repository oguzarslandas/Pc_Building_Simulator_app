import 'dart:async';
import 'dart:convert';

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
        body: FutureBuilder(
          future: APIService.getProduct(widget.result),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              List<Product> pdata = snapshot.data;

              return ListView.builder(
                  itemCount: pdata.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      child: ListTile(
                        leading: Container(
                          height: size.height * 0.10,
                            width: size.width * 0.15,
                            child: pdata[index].imgUrl != null ? Image.asset("${pdata[index].imgUrl}" )
                        : Image.asset(noimage)
                        ),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Container(
                                  child: Text("${pdata[index].name}", style: CustomStyle.headlineTextStyle,)),
                            ),
                            Text("${pdata[index].price}" + 'currency'.tr, style: CustomStyle.priceTextStyle,),
                          ],
                        ),
                        subtitle: Column(
                          children: [
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                        //        decoration: CustomStyle.secondBoxDecoration,
                                child: Text("${pdata[index].desc}", style: CustomStyle.titleTextStyle,)
                            ),
                       //     SizedBox(height: 5,),
                         /**   ElevatedButton(
                              onPressed: () => setState(() {
                                final Uri toLaunch = Uri.parse(pdata[index].buyUrl.toString());
                                _launchInBrowser(toLaunch);
                              }),
                                child: Text('buy'.tr, style: CustomStyle.primaryTextStyle,),
                              style: CustomStyle.buyButtonStyle,
                            ),*/
                            Align(
                              alignment: Alignment.centerRight,
                              child: Container(
                                height: size.height * .05,
                                child: Image.asset(buyonamazon),
                              ),
                            )
                          ],
                        ),
                   //     trailing: Text("${pdata[index].price}", style: CustomStyle.priceTextStyle,),
                        onTap: () {

                            productDetailList.add(Product(
                                name: pdata[index].name,
                                brand: pdata[index].brand,
                                desc: pdata[index].desc,
                                price: pdata[index].price,
                                benchpoint: pdata[index].benchpoint,
                                watt: pdata[index].watt,
                                socket: pdata[index].socket,
                                result: pdata[index].result
                            ));
                            Navigator.of(context).pop(productDetailList);

                        },
                      ),
                    );
                  });
            }
          },
        )
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

