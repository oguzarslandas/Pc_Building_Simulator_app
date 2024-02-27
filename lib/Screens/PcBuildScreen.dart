
import 'dart:async';
import 'dart:convert';

import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:get/get.dart';
import 'package:pc_building_simulator/Model/product.dart';
import 'package:pc_building_simulator/Screens/ProductScreen.dart';
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

class PcBuildPage extends StatefulWidget {
  const PcBuildPage({Key? key,}) : super(key: key);

  @override
  State<PcBuildPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<PcBuildPage> {

  List<Product> process = [];
  List<Product> maincard = [];
  List<Product> ram = [];
  List<Product> graphcard = [];
  List<Product> pccase = [];
  List<Product> psu = [];
  List<Product> ssd = [];
  List<Product> hdd = [];
  List<Product> monitor = [];
  List<Product> keyboard = [];
  List<Product> mouse = [];
  List<Product> keyboardmouse = [];
  List<Product> headspeaker = [];

  int totalPrice = 0;
  int totalWatt = 0;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: primaryColor,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text('pcbuild'.tr, style: CustomStyle.primaryTextStyle,),
        elevation: 1,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon:Icon(Boxicons.bxs_chevron_left, color: secondaryPrimaryColor,)),
        centerTitle: true,
        backgroundColor: primaryColor,
      ),
      //  bottomNavigationBar: BottomNavBar(),
      body: Stack(
        children: <Widget>[
          /*        Container(
            // Here the height of the container is 45% of our total height
            height: MediaQuery.of(context).size.height * .20,
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50)
              ),
              image: DecorationImage(
                  alignment: Alignment.centerLeft,
                  image: const AssetImage(
                      appLogo),
                  colorFilter: ColorFilter.mode(
                    Colors.grey.withOpacity(0.3),
                    BlendMode.modulate,
                  )),
            ),
          ),*/
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: Row(
                      children: [
                        Text('selectparts'.tr, style: CustomStyle.primaryTextStyle,),
                        Container(
                          child: Row(
                            children: [
                              Icon(Boxicons.bxs_bolt, color: price,),
                              Text(totalWatt.toString() + 'W')
                            ],
                          ),
                        )
                      ],
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 0),
                            child: Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.all(8),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          children: [
                                            Container(
                                              decoration: process.isEmpty ? CustomStyle.secondBoxDecoration : CustomStyle.correctBoxDecoration,
                                              height: size.height * 0.072,
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                                child: Center(
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Align(
                                                          child: Text(process.isEmpty ? 'cpu'.tr : process[0].name.toString(),
                                                              style: process.isEmpty ? CustomStyle.primaryTextStyle : CustomStyle.pcbuildTextStyle, maxLines: 1,),
                                                        alignment: Alignment.centerLeft,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.end,
                                                        children: [
                                                          Text(process.isEmpty ? '0' : process[0].price.toString(), style: CustomStyle.priceTextStyle),
                                                          Text('currency'.tr, style: TextStyle(color: hold, fontSize: 14, fontWeight: FontWeight.w600, fontStyle: FontStyle.italic),),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      process.isEmpty ? ElevatedButton(
                                          onPressed: () async {
                                            final value = await Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => ProductPage(result: "0",),
                                                ));

                                           setState(() {
                                             process = value;
                                             totalWatt = totalWatt + int.parse(process.last.watt.toString());
                                             totalPrice = totalPrice + int.parse(process.last.price.toString());
                                           });
                                          },
                                          child: Icon(Boxicons.bx_search_alt, color: secondaryPrimaryColor,),
                                        style: CustomStyle.primaryButtonStyle,
                                      ) : ElevatedButton(
                                        onPressed: () async {
                                          setState(() {
                                            totalWatt = totalWatt - int.parse(process.last.watt.toString());
                                            totalPrice = totalPrice - int.parse(process.last.price.toString());
                                            process.removeLast();
                                          });
                                        },
                                        child: Icon(Boxicons.bx_trash_alt, color: secondaryPrimaryColor,),
                                        style: CustomStyle.primaryButtonStyle,
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.all(8),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          children: [
                                            Container(
                                              decoration: maincard.isEmpty ? CustomStyle.secondBoxDecoration : CustomStyle.correctBoxDecoration,
                                              height: size.height * 0.072,
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                                child: Center(
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Align(
                                                        child: Text(maincard.isEmpty ? 'motherboard'.tr : maincard[0].name.toString(),
                                                            style: maincard.isEmpty ? CustomStyle.primaryTextStyle : CustomStyle.pcbuildTextStyle, maxLines: 1,),
                                                        alignment: Alignment.centerLeft,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.end,
                                                        children: [
                                                          Text(maincard.isEmpty ? '0' : maincard[0].price.toString(), style: CustomStyle.priceTextStyle),
                                                          Text('currency'.tr, style: TextStyle(color: hold, fontSize: 14, fontWeight: FontWeight.w600, fontStyle: FontStyle.italic),),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      maincard.isEmpty ? ElevatedButton(
                                        onPressed: () async {
                                          final value = await Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => ProductPage(result: "1",),
                                              ));

                                          setState(() {
                                            maincard = value;
                                            totalWatt = totalWatt + int.parse(maincard.last.watt.toString());
                                            totalPrice = totalPrice + int.parse(maincard.last.price.toString());
                                          });
                                        },
                                        child: Icon(Boxicons.bx_search_alt, color: secondaryPrimaryColor,),
                                        style: CustomStyle.primaryButtonStyle,
                                      ) : ElevatedButton(
                                        onPressed: () async {
                                          setState(() {
                                            totalWatt = totalWatt - int.parse(maincard.last.watt.toString());
                                            totalPrice = totalPrice - int.parse(maincard.last.price.toString());
                                            maincard.removeLast();
                                          });
                                        },
                                        child: Icon(Boxicons.bx_trash_alt, color: secondaryPrimaryColor,),
                                        style: CustomStyle.primaryButtonStyle,
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.all(8),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          children: [
                                            Container(
                                              decoration: ram.isEmpty ? CustomStyle.secondBoxDecoration : CustomStyle.correctBoxDecoration,
                                              height: size.height * 0.072,
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                                child: Center(
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Align(
                                                        child: Text(ram.isEmpty ? 'ram'.tr : ram[0].name.toString(),
                                                            style: ram.isEmpty ? CustomStyle.primaryTextStyle : CustomStyle.pcbuildTextStyle, maxLines: 1,),
                                                        alignment: Alignment.centerLeft,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.end,
                                                        children: [
                                                          Text(ram.isEmpty ? '0' : ram[0].price.toString(), style: CustomStyle.priceTextStyle),
                                                          Text('currency'.tr, style: TextStyle(color: hold, fontSize: 14, fontWeight: FontWeight.w600, fontStyle: FontStyle.italic),),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      ram.isEmpty ? ElevatedButton(
                                        onPressed: () async {
                                          final value = await Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => ProductPage(result: "2",),
                                              ));

                                          setState(() {
                                            ram = value;
                                            totalWatt = totalWatt + int.parse(ram.last.watt.toString());
                                            totalPrice = totalPrice + int.parse(ram.last.price.toString());
                                          });
                                        },
                                        child: Icon(Boxicons.bx_search_alt, color: secondaryPrimaryColor,),
                                        style: CustomStyle.primaryButtonStyle,
                                      ) : ElevatedButton(
                                        onPressed: () async {
                                          setState(() {
                                            totalWatt = totalWatt - int.parse(ram.last.watt.toString());
                                            totalPrice = totalPrice - int.parse(ram.last.price.toString());
                                            ram.removeLast();
                                          });
                                        },
                                        child: Icon(Boxicons.bx_trash_alt, color: secondaryPrimaryColor,),
                                        style: CustomStyle.primaryButtonStyle,
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.all(8),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          children: [
                                            Container(
                                              decoration: graphcard.isEmpty ? CustomStyle.secondBoxDecoration : CustomStyle.correctBoxDecoration,
                                              height: size.height * 0.072,
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                                child: Center(
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Align(
                                                        child: Text(graphcard.isEmpty ? 'gpu'.tr : graphcard[0].name.toString(),
                                                            style: graphcard.isEmpty ? CustomStyle.primaryTextStyle : CustomStyle.pcbuildTextStyle, maxLines: 1,),
                                                        alignment: Alignment.centerLeft,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.end,
                                                        children: [
                                                          Text(graphcard.isEmpty ? '0' : graphcard[0].price.toString(), style: CustomStyle.priceTextStyle),
                                                          Text('currency'.tr, style: TextStyle(color: hold, fontSize: 14, fontWeight: FontWeight.w600, fontStyle: FontStyle.italic),),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      graphcard.isEmpty ? ElevatedButton(
                                        onPressed: () async {
                                          final value = await Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => ProductPage(result: "3",),
                                              ));

                                          setState(() {
                                            graphcard = value;
                                            totalWatt = totalWatt + int.parse(graphcard.last.watt.toString());
                                            totalPrice = totalPrice + int.parse(graphcard.last.price.toString());
                                          });
                                        },
                                        child: Icon(Boxicons.bx_search_alt, color: secondaryPrimaryColor,),
                                        style: CustomStyle.primaryButtonStyle,
                                      ) : ElevatedButton(
                                        onPressed: () async {
                                          setState(() {
                                            totalWatt = totalWatt - int.parse(graphcard.last.watt.toString());
                                            totalPrice = totalPrice - int.parse(graphcard.last.price.toString());
                                            graphcard.removeLast();
                                          });
                                        },
                                        child: Icon(Boxicons.bx_trash_alt, color: secondaryPrimaryColor,),
                                        style: CustomStyle.primaryButtonStyle,
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.all(8),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          children: [
                                            Container(
                                              decoration: pccase.isEmpty ? CustomStyle.secondBoxDecoration : CustomStyle.correctBoxDecoration,
                                              height: size.height * 0.072,
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                                child: Center(
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Align(
                                                        child: Text(pccase.isEmpty ? 'pccase'.tr : pccase[0].name.toString(),
                                                            style: pccase.isEmpty ? CustomStyle.primaryTextStyle : CustomStyle.pcbuildTextStyle, maxLines: 1,),
                                                        alignment: Alignment.centerLeft,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.end,
                                                        children: [
                                                          Text(pccase.isEmpty ? '0' : pccase[0].price.toString(), style: CustomStyle.priceTextStyle),
                                                          Text('currency'.tr, style: TextStyle(color: hold, fontSize: 14, fontWeight: FontWeight.w600, fontStyle: FontStyle.italic),),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      pccase.isEmpty ? ElevatedButton(
                                        onPressed: () async {
                                          final value = await Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => ProductPage(result: "4",),
                                              ));

                                          setState(() => pccase = value);
                                        },
                                        child: Icon(Boxicons.bx_search_alt, color: secondaryPrimaryColor,),
                                        style: CustomStyle.primaryButtonStyle,
                                      ) : ElevatedButton(
                                        onPressed: () async {
                                          setState(() {
                                            totalPrice = totalPrice - int.parse(pccase.last.price.toString());
                                            pccase.removeLast();
                                          });
                                        },
                                        child: Icon(Boxicons.bx_trash_alt, color: secondaryPrimaryColor,),
                                        style: CustomStyle.primaryButtonStyle,
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.all(8),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          children: [
                                            Container(
                                              decoration: psu.isEmpty ? CustomStyle.secondBoxDecoration : CustomStyle.correctBoxDecoration,
                                              height: size.height * 0.072,
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                                child: Center(
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Align(
                                                        child: Text(psu.isEmpty ? 'psu'.tr : psu[0].name.toString(),
                                                            style: psu.isEmpty ? CustomStyle.primaryTextStyle : CustomStyle.pcbuildTextStyle, maxLines: 1,),
                                                        alignment: Alignment.centerLeft,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.end,
                                                        children: [
                                                          Text(psu.isEmpty ? '0' : psu[0].price.toString(), style: CustomStyle.priceTextStyle),
                                                          Text('currency'.tr, style: TextStyle(color: hold, fontSize: 14, fontWeight: FontWeight.w600, fontStyle: FontStyle.italic),),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      psu.isEmpty ? ElevatedButton(
                                        onPressed: () async {
                                          final value = await Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => ProductPage(result: "5",),
                                              ));

                                          setState(() {
                                            psu = value;
                                            totalPrice = totalPrice + int.parse(psu.last.price.toString());
                                          });
                                        },
                                        child: Icon(Boxicons.bx_search_alt, color: secondaryPrimaryColor,),
                                        style: CustomStyle.primaryButtonStyle,
                                      ) : ElevatedButton(
                                        onPressed: () async {
                                          setState(() {
                                            totalPrice = totalPrice - int.parse(psu.last.price.toString());
                                            psu.removeLast();
                                          });
                                        },
                                        child: Icon(Boxicons.bx_trash_alt, color: secondaryPrimaryColor,),
                                        style: CustomStyle.primaryButtonStyle,
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.all(8),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          children: [
                                            Container(
                                              decoration: hdd.isEmpty ? CustomStyle.secondBoxDecoration : CustomStyle.correctBoxDecoration,
                                              height: size.height * 0.072,
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                                child: Center(
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Align(
                                                        child: Text(hdd.isEmpty ? 'hdd'.tr : hdd[0].name.toString(),
                                                            style: hdd.isEmpty ? CustomStyle.primaryTextStyle : CustomStyle.pcbuildTextStyle, maxLines: 1,),
                                                        alignment: Alignment.centerLeft,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.end,
                                                        children: [
                                                          Text(hdd.isEmpty ? '0' : hdd[0].price.toString(), style: CustomStyle.priceTextStyle),
                                                          Text('currency'.tr, style: TextStyle(color: hold, fontSize: 14, fontWeight: FontWeight.w600, fontStyle: FontStyle.italic),),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      hdd.isEmpty ? ElevatedButton(
                                        onPressed: () async {
                                          final value = await Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => ProductPage(result: "6",),
                                              ));

                                          setState(() {
                                            hdd = value;
                                            totalPrice = totalPrice + int.parse(hdd.last.price.toString());
                                          });
                                        },
                                        child: Icon(Boxicons.bx_search_alt, color: secondaryPrimaryColor,),
                                        style: CustomStyle.primaryButtonStyle,
                                      ) : ElevatedButton(
                                        onPressed: () async {
                                          setState(() {
                                            totalPrice = totalPrice - int.parse(hdd.last.price.toString());
                                            hdd.removeLast();
                                          });
                                        },
                                        child: Icon(Boxicons.bx_trash_alt, color: secondaryPrimaryColor,),
                                        style: CustomStyle.primaryButtonStyle,
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.all(8),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          children: [
                                            Container(
                                              decoration: ssd.isEmpty ? CustomStyle.secondBoxDecoration : CustomStyle.correctBoxDecoration,
                                              height: size.height * 0.072,
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                                child: Center(
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Align(
                                                        child: Text(ssd.isEmpty ? 'ssd'.tr : ssd[0].name.toString(),
                                                            style: ssd.isEmpty ? CustomStyle.primaryTextStyle : CustomStyle.pcbuildTextStyle, maxLines: 1,),
                                                        alignment: Alignment.centerLeft,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.end,
                                                        children: [
                                                          Text(ssd.isEmpty ? '0' : ssd[0].price.toString(), style: CustomStyle.priceTextStyle),
                                                          Text('currency'.tr, style: TextStyle(color: hold, fontSize: 14, fontWeight: FontWeight.w600, fontStyle: FontStyle.italic),),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      ssd.isEmpty ? ElevatedButton(
                                        onPressed: () async {
                                          final value = await Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => ProductPage(result: "7",),
                                              ));

                                          setState(() {
                                            ssd = value;
                                            totalPrice = totalPrice + int.parse(ssd.last.price.toString());
                                          });
                                        },
                                        child: Icon(Boxicons.bx_search_alt, color: secondaryPrimaryColor,),
                                        style: CustomStyle.primaryButtonStyle,
                                      ) : ElevatedButton(
                                        onPressed: () async {
                                          setState(() {
                                            totalPrice = totalPrice - int.parse(ssd.last.price.toString());
                                            ssd.removeLast();
                                          });
                                        },
                                        child: Icon(Boxicons.bx_trash_alt, color: secondaryPrimaryColor,),
                                        style: CustomStyle.primaryButtonStyle,
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.all(8),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          children: [
                                            Container(
                                              decoration: monitor.isEmpty ? CustomStyle.secondBoxDecoration : CustomStyle.correctBoxDecoration,
                                              height: size.height * 0.072,
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                                child: Center(
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Align(
                                                        child: Text(monitor.isEmpty ? 'monitor'.tr : monitor[0].name.toString(),
                                                            style: monitor.isEmpty ? CustomStyle.primaryTextStyle : CustomStyle.pcbuildTextStyle, maxLines: 1,),
                                                        alignment: Alignment.centerLeft,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.end,
                                                        children: [
                                                          Text(monitor.isEmpty ? '0' : monitor[0].price.toString(), style: CustomStyle.priceTextStyle),
                                                          Text('currency'.tr, style: TextStyle(color: hold, fontSize: 14, fontWeight: FontWeight.w600, fontStyle: FontStyle.italic),),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      monitor.isEmpty ? ElevatedButton(
                                        onPressed: () async {
                                          final value = await Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => ProductPage(result: "8",),
                                              ));

                                          setState(() {
                                            monitor = value;
                                            totalPrice = totalPrice + int.parse(monitor.last.price.toString());
                                          });
                                        },
                                        child: Icon(Boxicons.bx_search_alt, color: secondaryPrimaryColor,),
                                        style: CustomStyle.primaryButtonStyle,
                                      ) : ElevatedButton(
                                        onPressed: () async {
                                          setState(() {
                                            totalPrice = totalPrice - int.parse(monitor.last.price.toString());
                                            monitor.removeLast();
                                          });
                                        },
                                        child: Icon(Boxicons.bx_trash_alt, color: secondaryPrimaryColor,),
                                        style: CustomStyle.primaryButtonStyle,
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.all(8),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          children: [
                                            Container(
                                              decoration: keyboard.isEmpty ? CustomStyle.secondBoxDecoration : CustomStyle.correctBoxDecoration,
                                              height: size.height * 0.072,
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                                child: Center(
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Align(
                                                        child: Text(keyboard.isEmpty ? 'keyboard'.tr : keyboard[0].name.toString(),
                                                            style: keyboard.isEmpty ? CustomStyle.primaryTextStyle : CustomStyle.pcbuildTextStyle, maxLines: 1,),
                                                        alignment: Alignment.centerLeft,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.end,
                                                        children: [
                                                          Text(keyboard.isEmpty ? '0' : keyboard[0].price.toString(), style: CustomStyle.priceTextStyle),
                                                          Text('currency'.tr, style: TextStyle(color: hold, fontSize: 14, fontWeight: FontWeight.w600, fontStyle: FontStyle.italic),),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      keyboard.isEmpty ? ElevatedButton(
                                        onPressed: () async {
                                          final value = await Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => ProductPage(result: "9",),
                                              ));

                                          setState(() {
                                            keyboard = value;
                                            totalPrice = totalPrice + int.parse(keyboard.last.price.toString());
                                          });
                                        },
                                        child: Icon(Boxicons.bx_search_alt, color: secondaryPrimaryColor,),
                                        style: CustomStyle.primaryButtonStyle,
                                      ) : ElevatedButton(
                                        onPressed: () async {
                                          setState(() {
                                            totalPrice = totalPrice - int.parse(keyboard.last.price.toString());
                                            keyboard.removeLast();
                                          });
                                        },
                                        child: Icon(Boxicons.bx_trash_alt, color: secondaryPrimaryColor,),
                                        style: CustomStyle.primaryButtonStyle,
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.all(8),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          children: [
                                            Container(
                                              decoration: mouse.isEmpty ? CustomStyle.secondBoxDecoration : CustomStyle.correctBoxDecoration,
                                              height: size.height * 0.072,
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                                child: Center(
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Align(
                                                        child: Text(mouse.isEmpty ? 'mouse'.tr : mouse[0].name.toString(),
                                                            style: mouse.isEmpty ? CustomStyle.primaryTextStyle : CustomStyle.pcbuildTextStyle, maxLines: 1,),
                                                        alignment: Alignment.centerLeft,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.end,
                                                        children: [
                                                          Text(mouse.isEmpty ? '0' : mouse[0].price.toString(), style: CustomStyle.priceTextStyle),
                                                          Text('currency'.tr, style: TextStyle(color: hold, fontSize: 14, fontWeight: FontWeight.w600, fontStyle: FontStyle.italic),),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      mouse.isEmpty ? ElevatedButton(
                                        onPressed: () async {
                                          final value = await Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => ProductPage(result: "10",),
                                              ));

                                          setState(() {
                                            mouse = value;
                                            totalPrice = totalPrice + int.parse(mouse.last.price.toString());
                                          });
                                        },
                                        child: Icon(Boxicons.bx_search_alt, color: secondaryPrimaryColor,),
                                        style: CustomStyle.primaryButtonStyle,
                                      ) : ElevatedButton(
                                        onPressed: () async {
                                          setState(() {
                                            totalPrice = totalPrice - int.parse(mouse.last.price.toString());
                                            mouse.removeLast();
                                          });
                                        },
                                        child: Icon(Boxicons.bx_trash_alt, color: secondaryPrimaryColor,),
                                        style: CustomStyle.primaryButtonStyle,
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.all(8),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          children: [
                                            Container(
                                              decoration: keyboardmouse.isEmpty ? CustomStyle.secondBoxDecoration : CustomStyle.correctBoxDecoration,
                                              height: size.height * 0.072,
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                                child: Center(
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Align(
                                                        child: Text(keyboardmouse.isEmpty ? 'keyboardmouse'.tr : keyboardmouse[0].name.toString(),
                                                            style: keyboardmouse.isEmpty ? CustomStyle.primaryTextStyle : CustomStyle.pcbuildTextStyle, maxLines: 1,),
                                                        alignment: Alignment.centerLeft,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.end,
                                                        children: [
                                                          Text(keyboardmouse.isEmpty ? '0' : keyboardmouse[0].price.toString(), style: CustomStyle.priceTextStyle),
                                                          Text('currency'.tr, style: TextStyle(color: hold, fontSize: 14, fontWeight: FontWeight.w600, fontStyle: FontStyle.italic),),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      keyboardmouse.isEmpty ? ElevatedButton(
                                        onPressed: () async {
                                          final value = await Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => ProductPage(result: "11",),
                                              ));

                                          setState(() {
                                            keyboardmouse = value;
                                            totalPrice = totalPrice + int.parse(keyboardmouse.last.price.toString());
                                          });
                                        },
                                        child: Icon(Boxicons.bx_search_alt, color: secondaryPrimaryColor,),
                                        style: CustomStyle.primaryButtonStyle,
                                      ) : ElevatedButton(
                                        onPressed: () async {
                                          setState(() {
                                            totalPrice = totalPrice - int.parse(keyboardmouse.last.price.toString());
                                            keyboardmouse.removeLast();
                                          });
                                        },
                                        child: Icon(Boxicons.bx_trash_alt, color: secondaryPrimaryColor,),
                                        style: CustomStyle.primaryButtonStyle,
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.all(8),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          children: [
                                            Container(
                                              decoration: headspeaker.isEmpty ? CustomStyle.secondBoxDecoration : CustomStyle.correctBoxDecoration,
                                              height: size.height * 0.072,
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                                child: Center(
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Align(
                                                        child: Text(headspeaker.isEmpty ? 'headspeaker'.tr : headspeaker[0].name.toString(),
                                                            style: headspeaker.isEmpty ? CustomStyle.primaryTextStyle : CustomStyle.pcbuildTextStyle, maxLines: 1,),
                                                        alignment: Alignment.centerLeft,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.end,
                                                        children: [
                                                          Text(headspeaker.isEmpty ? '0' : headspeaker[0].price.toString(), style: CustomStyle.priceTextStyle),
                                                          Text('currency'.tr, style: TextStyle(color: hold, fontSize: 14, fontWeight: FontWeight.w600, fontStyle: FontStyle.italic),),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      headspeaker.isEmpty ? ElevatedButton(
                                        onPressed: () async {
                                          final value = await Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => ProductPage(result: "12",),
                                              ));

                                          setState(() {
                                            headspeaker = value;
                                            totalPrice = totalPrice + int.parse(headspeaker.last.price.toString());
                                          });
                                        },
                                        child: Icon(Boxicons.bx_search_alt, color: secondaryPrimaryColor,),
                                        style: CustomStyle.primaryButtonStyle,
                                      ) : ElevatedButton(
                                        onPressed: () async {
                                          setState(() {
                                            totalPrice = totalPrice - int.parse(headspeaker.last.price.toString());
                                            headspeaker.removeLast();
                                          });
                                        },
                                        child: Icon(Boxicons.bx_trash_alt, color: secondaryPrimaryColor,),
                                        style: CustomStyle.primaryButtonStyle,
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Divider(
                    color: Colors.grey,
                    thickness: 0,
                  ),
                  Container(
               //     decoration: CustomStyle.secondBoxDecoration,
                    height: size.height * 0.09,
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('total'.tr, style: CustomStyle.primaryTextStyle),
                        Text(totalPrice.toString() + '.0' + 'currency'.tr, style: CustomStyle.priceTotalTextStyle,
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: Colors.grey,
                    thickness: 0,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}