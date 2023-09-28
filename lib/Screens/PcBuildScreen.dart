
import 'dart:async';
import 'dart:convert';

import 'package:flutter_boxicons/flutter_boxicons.dart';
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

  int totalPrice = 0;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: primaryColor,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text('Sistem Hazırla', style: CustomStyle.thirdTextStyle,),
        elevation: 1,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon:Icon(Boxicons.bxs_chevron_left)),
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
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            child: Column(
                              children: [
                         /**       Container(
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              decoration: CustomStyle.secondBoxDecoration,
                              child: DropdownButton<String>(
                              isExpanded: true,
                                value: maincard,
                                dropdownColor: primaryColor,
                                icon: const Icon(Icons.keyboard_arrow_down,
                                    color: Colors.white),
                                elevation: 16,
                                style: TextStyle(color: Colors.white),
                                underline: Container(
                                  height: 0,
                                  color: primaryColor,
                                ),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    maincard = newValue;
                                  });
                                },
                                items: teams
                                    .map((data) => DropdownMenuItem<String>(
                                  child: Text(data.key),
                                  value: data.value,
                                ))
                                    .toList(),
                              ),
                            ),*/
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
                                                          child: Text(process.isEmpty ? 'İşlemci' : process[0].name.toString(), style: CustomStyle.primaryTextStyle),
                                                        alignment: Alignment.centerLeft,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.end,
                                                        children: [
                                                          Text(process.isEmpty ? '0' : process[0].price.toString(), style: CustomStyle.priceTextStyle),
                                                          Text('₺', style: TextStyle(color: hold, fontSize: 14, fontWeight: FontWeight.w600, fontStyle: FontStyle.italic),),
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
                                             totalPrice = totalPrice + int.parse(process.last.price.toString());
                                           });
                                          },
                                          child: Icon(Boxicons.bx_search_alt, color: cardColor,),
                                        style: CustomStyle.primaryButtonStyle,
                                      ) : ElevatedButton(
                                        onPressed: () async {
                                          setState(() {
                                            totalPrice = totalPrice - int.parse(process.last.price.toString());
                                            process.removeLast();
                                          });
                                        },
                                        child: Icon(Boxicons.bx_trash_alt, color: cardColor,),
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
                                                        child: Text(maincard.isEmpty ? 'Anakart' : maincard[0].name.toString(), style: CustomStyle.primaryTextStyle),
                                                        alignment: Alignment.centerLeft,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.end,
                                                        children: [
                                                          Text(maincard.isEmpty ? '0' : maincard[0].price.toString(), style: CustomStyle.priceTextStyle),
                                                          Text('₺', style: TextStyle(color: hold, fontSize: 14, fontWeight: FontWeight.w600, fontStyle: FontStyle.italic),),
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
                                            totalPrice = totalPrice + int.parse(maincard.last.price.toString());
                                          });
                                        },
                                        child: Icon(Boxicons.bx_search_alt, color: cardColor,),
                                        style: CustomStyle.primaryButtonStyle,
                                      ) : ElevatedButton(
                                        onPressed: () async {
                                          setState(() {
                                            totalPrice = totalPrice - int.parse(maincard.last.price.toString());
                                            maincard.removeLast();
                                          });
                                        },
                                        child: Icon(Boxicons.bx_trash_alt, color: cardColor,),
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
                                                        child: Text(ram.isEmpty ? 'RAM' : ram[0].name.toString(), style: CustomStyle.primaryTextStyle),
                                                        alignment: Alignment.centerLeft,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.end,
                                                        children: [
                                                          Text(ram.isEmpty ? '0' : ram[0].price.toString(), style: CustomStyle.priceTextStyle),
                                                          Text('₺', style: TextStyle(color: hold, fontSize: 14, fontWeight: FontWeight.w600, fontStyle: FontStyle.italic),),
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
                                                builder: (context) => ProductPage(result: "3",),
                                              ));

                                          setState(() {
                                            ram = value;
                                            totalPrice = totalPrice + int.parse(ram.last.price.toString());
                                          });
                                        },
                                        child: Icon(Boxicons.bx_search_alt, color: cardColor,),
                                        style: CustomStyle.primaryButtonStyle,
                                      ) : ElevatedButton(
                                        onPressed: () async {
                                          setState(() {
                                            totalPrice = totalPrice - int.parse(ram.last.price.toString());
                                            ram.removeLast();
                                          });
                                        },
                                        child: Icon(Boxicons.bx_trash_alt, color: cardColor,),
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
                                                        child: Text(graphcard.isEmpty ? 'Ekran Kartı' : graphcard[0].name.toString(), style: CustomStyle.primaryTextStyle),
                                                        alignment: Alignment.centerLeft,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.end,
                                                        children: [
                                                          Text(graphcard.isEmpty ? '0' : graphcard[0].price.toString(), style: CustomStyle.priceTextStyle),
                                                          Text('₺', style: TextStyle(color: hold, fontSize: 14, fontWeight: FontWeight.w600, fontStyle: FontStyle.italic),),
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

                                          setState(() => graphcard = value);
                                        },
                                        child: Icon(Boxicons.bx_search_alt, color: cardColor,),
                                        style: CustomStyle.primaryButtonStyle,
                                      ) : ElevatedButton(
                                        onPressed: () async {
                                          setState(() {
                                            totalPrice = totalPrice - int.parse(graphcard.last.price.toString());
                                            graphcard.removeLast();
                                          });
                                        },
                                        child: Icon(Boxicons.bx_trash_alt, color: cardColor,),
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
                                                        child: Text(pccase.isEmpty ? 'Bilgisayar Kasaları' : pccase[0].name.toString(), style: CustomStyle.primaryTextStyle),
                                                        alignment: Alignment.centerLeft,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.end,
                                                        children: [
                                                          Text(pccase.isEmpty ? '0' : pccase[0].price.toString(), style: CustomStyle.priceTextStyle),
                                                          Text('₺', style: TextStyle(color: hold, fontSize: 14, fontWeight: FontWeight.w600, fontStyle: FontStyle.italic),),
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
                                      ElevatedButton(
                                        onPressed: () async {
                                          final value = await Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => ProductPage(result: "0",),
                                              ));

                                          setState(() => pccase = value);
                                        },
                                        child: Icon(Boxicons.bx_search_alt, color: cardColor,),
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
                        Text('Total', style: CustomStyle.primaryTextStyle),
                        Text(totalPrice.toString() + ' TL', style: CustomStyle.priceTotalTextStyle,
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