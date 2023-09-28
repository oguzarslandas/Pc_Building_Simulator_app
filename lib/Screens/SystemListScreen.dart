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


class SystemListPage extends StatefulWidget {
  SystemListPage({
    Key? key,
    this.result,
  }) : super(key: key);

  final result;

  @override
  State<SystemListPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<SystemListPage> {

  List<Product> productDetailList = [];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: primaryColor,
        appBar: AppBar(
          title: Text('Hazır Sistemler', style: CustomStyle.thirdTextStyle,),
          elevation: 1,
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon:Icon(Boxicons.bxs_chevron_left)),
          centerTitle: true,
          backgroundColor: primaryColor,
        ),
        body: FutureBuilder(
          future: APIService.getProduct("3"),
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
                    return Container(
                      padding: EdgeInsets.all(8),
                      margin: EdgeInsets.all(8),
                      decoration: CustomStyle.secondBoxDecoration,
                  //    height: MediaQuery.of(context).size.height * 0.15,
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("${pdata[index].name}", style: CustomStyle.thirdTextStyle,),
                              Text("${pdata[index].desc}", style: CustomStyle.thirdTextStyle,),
                              Text("${pdata[index].price}", style: CustomStyle.thirdTextStyle,),
                            ],
                          ),
                          SizedBox(
                              width: 45,
                              height: 45,
                              child: Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Image.asset(appLogo),
                              )
                          ),
                        ],
                      ),
                    );
                  });
            }
          },
        )
    );
  }
}
