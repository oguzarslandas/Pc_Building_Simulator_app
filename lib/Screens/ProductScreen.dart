import 'dart:async';
import 'dart:convert';

import 'package:flutter_boxicons/flutter_boxicons.dart';
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
                    return ListTile(
                      leading: const Icon(Boxicons.bxs_chevrons_right, color: cardColor,),
                      title: Text("${pdata[index].name}", style: CustomStyle.thirdTextStyle,),
                      subtitle: Text("${pdata[index].desc}", style: CustomStyle.thirdTextStyle,),
                      trailing: Text("${pdata[index].price}", style: CustomStyle.thirdTextStyle,),
                      onTap: () {

                          productDetailList.add(Product(
                              name: pdata[index].name,
                              desc: pdata[index].desc,
                              price: pdata[index].price,
                              benchpoint: pdata[index].benchpoint,
                              result: pdata[index].result
                          ));
                          Navigator.of(context).pop(productDetailList);

                      },
                    );
                  });
            }
          },
        )
    );
  }
}
