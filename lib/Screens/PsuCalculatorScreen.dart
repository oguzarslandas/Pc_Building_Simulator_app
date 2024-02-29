import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:get/get.dart';
import 'package:pc_building_simulator/Model/product.dart';
import 'package:pc_building_simulator/Model/socket.dart';
import 'package:pc_building_simulator/Network/Api/ApiConfig.dart';
import 'package:pc_building_simulator/Utils/colors.dart';
import 'package:pc_building_simulator/Utils/common.dart';
import 'package:pc_building_simulator/Utils/images.dart';
import 'package:pc_building_simulator/Widgets/CategoryCard.dart';
import 'package:pc_building_simulator/Widgets/DeviceCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:http/http.dart' as http;
import 'package:pc_building_simulator/resources/firestore_methods.dart';

class KeyValueModel {
  final String key;
  final String value;

  KeyValueModel({required this.key, required this.value});
}

class PsuCalculatorPage extends StatefulWidget {
  const PsuCalculatorPage({
    Key? key,
  }) : super(key: key);

  @override
  State<PsuCalculatorPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<PsuCalculatorPage> {
  String? processBrand;
  String? processSocket;
  String? processModel;
  String? processModelWatt;

  String? gpuBrand;
  String? gpuModel;
  String? gpuModelWatt;
  String? gpuCount;


  String? ramSocket;
  String? ramCount;

  String? maincard;

  String? storageSocket;
  String? storageCount;

  String? fanCount;

  int uniqueId = 0;

  int recommedPSU = 0;

  final FireStoreMethods _firestoreService = FireStoreMethods();

  /// CPU

  List<KeyValueModel> processers = [
    KeyValueModel(key: "AMD", value: "AMD"),
    KeyValueModel(key: "Intel", value: "Intel"),
  ];

  /// GPU

  List<KeyValueModel> gpuBrandList  = [
    KeyValueModel(key: "AMD", value: "AMD"),
    KeyValueModel(key: "NVIDIA", value: "Nvidia"),
  ];


  List<KeyValueModel> gpuCountList = [
    KeyValueModel(key: "1", value: "1"),
    KeyValueModel(key: "2", value: "2"),
  ];


  /// RAM

  List<KeyValueModel> ramSocketList = [
    KeyValueModel(key: "32GB DDR4", value: "0"),
    KeyValueModel(key: "16GB DDR4", value: "1"),
    KeyValueModel(key: "8GB DDR4", value: "2"),
    KeyValueModel(key: "4GB DDR4", value: "3"),
    KeyValueModel(key: "32GB DDR3", value: "4"),
    KeyValueModel(key: "8GB DDR3", value: "5"),
    KeyValueModel(key: "4GB DDR3", value: "6"),
    KeyValueModel(key: "2GB DDR3", value: "7"),
  ];


  /// Anakart

  List<KeyValueModel> maincardList = [
    KeyValueModel(key: "ATX", value: "70"),
    KeyValueModel(key: "Micro-ATX", value: "60"),
    KeyValueModel(key: "Mini-ATX", value: "30"),
    KeyValueModel(key: "Thin Mini-ITX", value: "20"),
    KeyValueModel(key: "SSE CEB", value: "150"),
    KeyValueModel(key: "SSE EEB", value: "152"),
    KeyValueModel(key: "XL ATX", value: "130"),
  ];

  List<KeyValueModel> ramCountList = [
    KeyValueModel(key: "1", value: "1"),
    KeyValueModel(key: "2", value: "2"),
    KeyValueModel(key: "3", value: "3"),
    KeyValueModel(key: "4", value: "4"),
    KeyValueModel(key: "5", value: "5"),
    KeyValueModel(key: "6", value: "6"),
    KeyValueModel(key: "7", value: "7"),
    KeyValueModel(key: "8", value: "8"),
  ];

  /// Depolama

  List<KeyValueModel> storageSocketList = [
    KeyValueModel(key: "HDD", value: "20"),
    KeyValueModel(key: "SATA SSD", value: "3"),
    KeyValueModel(key: "M.2 SSD", value: "10"),
  ];

  List<KeyValueModel> storageCountList = [
    KeyValueModel(key: "1", value: "1"),
    KeyValueModel(key: "2", value: "2"),
    KeyValueModel(key: "3", value: "3"),
    KeyValueModel(key: "4", value: "4"),
    KeyValueModel(key: "5", value: "5"),
    KeyValueModel(key: "6", value: "6"),
    KeyValueModel(key: "7", value: "7"),
    KeyValueModel(key: "8", value: "8"),
  ];

  /// Fan

  List<KeyValueModel> fanCountList = [
    KeyValueModel(key: "1", value: "1"),
    KeyValueModel(key: "2", value: "2"),
    KeyValueModel(key: "3", value: "3"),
    KeyValueModel(key: "4", value: "4"),
    KeyValueModel(key: "5", value: "5"),
    KeyValueModel(key: "6", value: "6"),
    KeyValueModel(key: "7", value: "7"),
    KeyValueModel(key: "8", value: "8"),
  ];


  int cpuWatt = 0;
  int gpuWatt = 0;
  int maincardWatt = 0;
  int ramWatt = 0;
  int storageWatt = 0;
  int fanWatt = 0;

  /// cpu - gpu - mathercard- ram - storage - fan
  List<int> totalWatt = [0, 0, 0, 0, 0, 0];


  @override
  void initState() {
    super.initState();
  }

  @override
  int get hashCode => super.hashCode;

  var documents = [];
  String selectedDocument = '';

  fetchData(brand, result) async {
    List<Product> products = [];
    try {

      var data = await _firestoreService.getAllDocuments();

        documents = data;
        print(documents);
        if (documents.isNotEmpty) {

          data.forEach((value) {
            if(value['result'] == result && value['brand'] == brand) {
              products.add(Product(
                  name: value['name'],
                  brand: value['brand'],
                  desc: value['desc'],
                  price: value['price'],
                  socket: value['socket'],
                  benchpoint: value['benchpoint'],
                avgMark: value['avgMark'],
                  watt: value['watt'],
                  result: value['result'],
                  uid: value['uid'],
                  imgUrl: value['imgUrl'],
                  buyUrl: value['buyUrl'],
                  classcpu: value['classcpu'],
                  clockspeed: value['clockspeed'],
                  turbospeed: value['turbospeed'],
                  core: value['core'],
                  thread: value['thread'],
                  cache: value['cache'],
              ));
            };
          });
          return products;
        } else {
          return [];
        }
    }
    catch (e) {
      print(e.toString());
    }
  }


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: primaryColor,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text('psucalculator'.tr, style: CustomStyle.primaryTextStyle,),
        elevation: 0,
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

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'selectparts'.tr,
                      style: CustomStyle.boldTitleTextStyle
                    ),
                  ),
                  Divider(
                    color: secondaryPrimaryColor,
                    thickness: 0,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                          height: MediaQuery.of(context).size.height * 0.025,
                                          child: Image.asset(processor)),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        'cpu'.tr,
                                        style: CustomStyle.priceTextStyle
                                      ),
                                      Spacer()
                                    ],
                                  ),

                                  Container(
                                    margin: EdgeInsets.symmetric(vertical: 5),
                                    child: Column(
                                      children: [

                                        Container(
                                          padding: EdgeInsets.symmetric(horizontal: 8),
                                          decoration: CustomStyle.secondBoxDecoration,
                                          child: DropdownButton<String>(
                                            isExpanded: true,
                                            value: processBrand,
                                            dropdownColor: primaryColor,
                                            icon: const Icon(Icons.keyboard_arrow_down,
                                                color: secondaryPrimaryColor),
                                            elevation: 16,
                                            style: CustomStyle.thirdTextStyle,
                                            underline: Container(
                                              height: 0,
                                              color: primaryColor,
                                            ),
                                            onChanged: (String? newValue) {
                                              setState(() {
                                                processBrand = null;
                                                processSocket = null;
                                                processModel = null;
                                                processBrand = newValue;
                                              });
                                            },
                                            hint: Text('brand'.tr, style: CustomStyle.thirdTextStyle,),
                                            items: processers
                                                .map((data) => DropdownMenuItem<String>(
                                              child: Text(data.key),
                                              value: data.key,
                                            ))
                                                .toList(),
                                          ),
                                        ),

                                        SizedBox( height: 8),
                                        processBrand != null ? FutureBuilder(
                                          future: fetchData(processBrand, '0'),
                                          builder: (BuildContext context, AsyncSnapshot snapshot) {
                                            if (!snapshot.hasData) {
                                              return const Center(
                                                child: spinkitLoading,
                                              );
                                            } else {
                                              List<Product> pdata = snapshot.data;

                                              return Container(
                                                padding: EdgeInsets.symmetric(horizontal: 8),
                                                decoration: CustomStyle.secondBoxDecoration,
                                                child: DropdownButton<String>(
                                                  isExpanded: true,
                                                  value: processModel,
                                                  dropdownColor: primaryColor,
                                                  icon: const Icon(Icons.keyboard_arrow_down,
                                                      color: secondaryPrimaryColor),
                                                  elevation: 16,
                                                  style: CustomStyle.thirdTextStyle,
                                                  underline: Container(
                                                    height: 0,
                                                    color: primaryColor,
                                                  ),
                                                  onChanged: (String? newValue) {
                                                    setState(() {
                                                      processModel = newValue;
                                                      print(processModel);

                                                      pdata.forEach((value) {
                                                        if(value.name == processModel) {
                                                          processModelWatt = value.watt;
                                                        };
                                                      });
                                                      print(processModelWatt);

                                                      totalWatt[0] = processModelWatt.toInt();
                                                      print(totalWatt);

                                                      recommedPSU = totalWatt.reduce((a, b) => a + b);
                                                      print(recommedPSU);

                                                    });
                                                  },
                                                  hint: Text('model'.tr, style: CustomStyle.thirdTextStyle,),
                                                  items: pdata
                                                      .map((data) => DropdownMenuItem<String>(
                                                    child: Text(data.name.toString()),
                                                    value: data.name,
                                                  ))
                                                      .toList(),
                                                ),
                                              );
                                            }
                                          },
                                        ) : SizedBox.shrink(),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(width: 1, color: secondaryPrimaryColor),
                              borderRadius: BorderRadius.circular(15)
                            ),
                          ),

                          SizedBox(height: 15,),

                          Container(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                          height: MediaQuery.of(context).size.height * 0.025,
                                          child: Image.asset(graphiccard2)),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                          'gpu'.tr,
                                          style: CustomStyle.priceTextStyle
                                      ),
                                      Spacer()
                                    ],
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(vertical: 5),
                                    child: Column(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.symmetric(horizontal: 8),
                                          decoration: CustomStyle.secondBoxDecoration,
                                          child: DropdownButton<String>(
                                            isExpanded: true,
                                            value: gpuBrand,
                                            dropdownColor: primaryColor,
                                            icon: const Icon(Icons.keyboard_arrow_down,
                                                color: secondaryPrimaryColor),
                                            elevation: 16,
                                            style: CustomStyle.thirdTextStyle,
                                            underline: Container(
                                              height: 0,
                                              color: primaryColor,
                                            ),
                                            onChanged: (String? newValue) {
                                              setState(() {
                                                gpuBrand = null;
                                                gpuModel = null;
                                                gpuCount = null;
                                                gpuBrand = newValue;
                                              });
                                            },
                                            hint: Text('brand'.tr, style: CustomStyle.thirdTextStyle,),
                                            items: gpuBrandList
                                                .map((data) => DropdownMenuItem<String>(
                                              child: Text(data.key),
                                              value: data.key,
                                            ))
                                                .toList(),
                                          ),
                                        ),
                                        SizedBox( height: 8),
                                        gpuBrand != null ? FutureBuilder(
                                          future: fetchData(gpuBrand, "3"),
                                          builder: (BuildContext context, AsyncSnapshot snapshot) {
                                            if (!snapshot.hasData) {
                                              return const Center(
                                                child: spinkitLoading,
                                              );
                                            } else {
                                              List<Product> pdata = snapshot.data;

                                              return Container(
                                                padding: EdgeInsets.symmetric(horizontal: 8),
                                                decoration: CustomStyle.secondBoxDecoration,
                                                child: DropdownButton<String>(
                                                  isExpanded: true,
                                                  value: gpuModel,
                                                  dropdownColor: primaryColor,
                                                  icon: const Icon(Icons.keyboard_arrow_down,
                                                      color: secondaryPrimaryColor),
                                                  elevation: 16,
                                                  style: CustomStyle.thirdTextStyle,
                                                  underline: Container(
                                                    height: 0,
                                                    color: primaryColor,
                                                  ),
                                                  onChanged: (String? newValue) {
                                                    setState(() {
                                                      gpuModel = null;
                                                      gpuCount = null;
                                                      gpuModel = newValue;

                                                      pdata.forEach((value) {
                                                        if(value.name == gpuModel) {
                                                          gpuModelWatt = value.watt;
                                                        };
                                                      });
                                                      print(gpuModelWatt);

                                                    });
                                                  },
                                                  hint: Text('gpu'.tr, style: CustomStyle.thirdTextStyle,),
                                                  items: pdata
                                                      .map((data) => DropdownMenuItem<String>(
                                                    child: Text(data.name.toString()),
                                                    value: data.name.toString(),
                                                  ))
                                                      .toList(),
                                                ),
                                              );
                                            }
                                          },
                                        ) : SizedBox.shrink(),
                                        SizedBox( height: 8),
                                        gpuModel != null ? Container(
                                          padding: EdgeInsets.symmetric(horizontal: 8),
                                          decoration: CustomStyle.secondBoxDecoration,
                                          child: DropdownButton<String>(
                                            isExpanded: true,
                                            value: gpuCount,
                                            dropdownColor: primaryColor,
                                            icon: const Icon(Icons.keyboard_arrow_down,
                                                color: secondaryPrimaryColor),
                                            elevation: 16,
                                            style: CustomStyle.thirdTextStyle,
                                            underline: Container(
                                              height: 0,
                                              color: primaryColor,
                                            ),
                                            onChanged: (String? newValue) {
                                              setState(() {
                                                gpuCount = newValue;

                                                totalWatt[1] = gpuCount.toInt() * gpuModelWatt.toInt();
                                                print(totalWatt);

                                                recommedPSU = totalWatt.reduce((a, b) => a + b);
                                                print(recommedPSU);
                                              });
                                            },
                                            hint: Text('count'.tr, style: CustomStyle.thirdTextStyle,),
                                            items: gpuCountList
                                                .map((data) => DropdownMenuItem<String>(
                                              child: Text(data.key),
                                              value: data.key,
                                            ))
                                                .toList(),
                                          ),
                                        ) : SizedBox.shrink(),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            decoration: BoxDecoration(
                                border: Border.all(width: 1, color: secondaryPrimaryColor),
                                borderRadius: BorderRadius.circular(15)
                            ),
                          ),

                          SizedBox(height: 15,),

                          Container(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                          height: MediaQuery.of(context).size.height * 0.025,
                                          child: Image.asset(motherboard)),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                          'motherboard'.tr,
                                          style: CustomStyle.priceTextStyle
                                      ),
                                      Spacer()
                                    ],
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(vertical: 5),
                                    child: Column(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.symmetric(horizontal: 8),
                                          decoration: CustomStyle.secondBoxDecoration,
                                          child: DropdownButton<String>(
                                            isExpanded: true,
                                            value: maincard,
                                            dropdownColor: primaryColor,
                                            icon: const Icon(Icons.keyboard_arrow_down,
                                                color: secondaryPrimaryColor),
                                            elevation: 16,
                                            style: CustomStyle.primaryTextStyle,
                                            underline: Container(
                                              height: 0,
                                              color: primaryColor,
                                            ),
                                            onChanged: (String? newValue) {
                                              setState(() {
                                                print(maincard);
                                                maincard = newValue;

                                                totalWatt[2] = maincard.toInt();
                                                recommedPSU = totalWatt.reduce((a, b) => a + b);
                                                print(recommedPSU);

                                              });
                                            },
                                            hint: Text('motherboardtype'.tr, style: CustomStyle.thirdTextStyle,),
                                            items: maincardList
                                                .map((data) => DropdownMenuItem<String>(
                                              child: Text(data.key),
                                              value: data.value,
                                            ))
                                                .toList(),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            decoration: BoxDecoration(
                                border: Border.all(width: 1, color: secondaryPrimaryColor),
                                borderRadius: BorderRadius.circular(15)
                            ),
                          ),

                          SizedBox(height: 15,),

                          Container(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                          height: MediaQuery.of(context).size.height * 0.025,
                                          child: Image.asset(ram)),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                          'ram'.tr,
                                          style: CustomStyle.priceTextStyle
                                      ),
                                      Spacer()
                                    ],
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(vertical: 5),
                                    child: Column(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.symmetric(horizontal: 8),
                                          decoration: CustomStyle.secondBoxDecoration,
                                          child: DropdownButton<String>(
                                            isExpanded: true,
                                            value: ramSocket,
                                            dropdownColor: primaryColor,
                                            icon: const Icon(Icons.keyboard_arrow_down,
                                                color: secondaryPrimaryColor),
                                            elevation: 16,
                                            style: CustomStyle.primaryTextStyle,
                                            underline: Container(
                                              height: 0,
                                              color: primaryColor,
                                            ),
                                            onChanged: (String? newValue) {
                                              setState(() {
                                                ramCount = null;
                                                ramSocket = newValue;
                                              });
                                            },
                                            hint: Text('memorymodule'.tr, style: CustomStyle.thirdTextStyle,),
                                            items: ramSocketList
                                                .map((data) => DropdownMenuItem<String>(
                                              child: Text(data.key),
                                              value: data.value,
                                            ))
                                                .toList(),
                                          ),
                                        ),
                                        SizedBox( height: 8),
                                        ramSocket != null ? Container(
                                          padding: EdgeInsets.symmetric(horizontal: 8),
                                          decoration: CustomStyle.secondBoxDecoration,
                                          child: DropdownButton<String>(
                                            isExpanded: true,
                                            value: ramCount,
                                            dropdownColor: primaryColor,
                                            icon: const Icon(Icons.keyboard_arrow_down,
                                                color: secondaryPrimaryColor),
                                            elevation: 16,
                                            style: CustomStyle.primaryTextStyle,
                                            underline: Container(
                                              height: 0,
                                              color: primaryColor,
                                            ),
                                            onChanged: (String? newValue) {
                                              setState(() {
                                                ramCount = newValue;
                                                var ramTotal;

                                                if(ramSocket == "0") {
                                                  ramTotal = 12 * ramCount.toInt();
                                                } else if(ramSocket == "1") {
                                                  ramTotal = 6 * ramCount.toInt();
                                                } else if(ramSocket == "2") {
                                                  ramTotal = 3 * ramCount.toInt();
                                                } else if(ramSocket == "3") {
                                                  ramTotal = 2 * ramCount.toInt();
                                                } else if(ramSocket == "4") {
                                                  ramTotal = 6 * ramCount.toInt();
                                                } else if(ramSocket == "5") {
                                                  ramTotal = 3 * ramCount.toInt();
                                                } else if(ramSocket == "6") {
                                                  ramTotal = 2 * ramCount.toInt();
                                                } else if(ramSocket == "7") {
                                                  ramTotal = 2 * ramCount.toInt();
                                                }

                                                totalWatt[3] = ramTotal;
                                                recommedPSU = totalWatt.reduce((a, b) => a + b);
                                                print(recommedPSU);


                                              });
                                            },
                                            hint: Text('count'.tr, style: CustomStyle.thirdTextStyle,),
                                            items: ramCountList
                                                .map((data) => DropdownMenuItem<String>(
                                              child: Text(data.key),
                                              value: data.value,
                                            ))
                                                .toList(),
                                          ),
                                        ) : SizedBox.shrink()
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            decoration: BoxDecoration(
                                border: Border.all(width: 1, color: secondaryPrimaryColor),
                                borderRadius: BorderRadius.circular(15)
                            ),
                          ),

                          SizedBox(height: 15,),

                          Container(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                          height: MediaQuery.of(context).size.height * 0.025,
                                          child: Image.asset(storage)),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                          'storage'.tr,
                                          style: CustomStyle.priceTextStyle
                                      ),
                                      Spacer()
                                    ],
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(vertical: 5),
                                    child: Column(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.symmetric(horizontal: 8),
                                          decoration: CustomStyle.secondBoxDecoration,
                                          child: DropdownButton<String>(
                                            isExpanded: true,
                                            value: storageSocket,
                                            dropdownColor: primaryColor,
                                            icon: const Icon(Icons.keyboard_arrow_down,
                                                color: secondaryPrimaryColor),
                                            elevation: 16,
                                            style: CustomStyle.primaryTextStyle,
                                            underline: Container(
                                              height: 0,
                                              color: primaryColor,
                                            ),
                                            onChanged: (String? newValue) {
                                              setState(() {
                                                storageCount = null;
                                                storageSocket = newValue;
                                              });
                                            },
                                            hint: Text('type'.tr, style: CustomStyle.thirdTextStyle,),
                                            items: storageSocketList
                                                .map((data) => DropdownMenuItem<String>(
                                              child: Text(data.key),
                                              value: data.value,
                                            ))
                                                .toList(),
                                          ),
                                        ),
                                        SizedBox( height: 8),
                                        storageSocket != null ? Container(
                                          padding: EdgeInsets.symmetric(horizontal: 8),
                                          decoration: CustomStyle.secondBoxDecoration,
                                          child: DropdownButton<String>(
                                            isExpanded: true,
                                            value: storageCount,
                                            dropdownColor: primaryColor,
                                            icon: const Icon(Icons.keyboard_arrow_down,
                                                color: secondaryPrimaryColor),
                                            elevation: 16,
                                            style: CustomStyle.primaryTextStyle,
                                            underline: Container(
                                              height: 0,
                                              color: primaryColor,
                                            ),
                                            onChanged: (String? newValue) {
                                              setState(() {
                                                storageCount = newValue;
                                                var storageTotal = int.parse(storageSocket.toString()) * int.parse(storageCount.toString());
                                                print(storageTotal);

                                                if(totalWatt[4] != 0) {
                                                  totalWatt[4] = 0;
                                                  totalWatt[4] = storageTotal;
                                                }
                                                else {
                                                  totalWatt[4] = storageTotal;
                                                }

                                                recommedPSU = totalWatt.reduce((a, b) => a + b);
                                                print(recommedPSU);

                                              });
                                            },
                                            hint: Text('count'.tr, style: CustomStyle.thirdTextStyle,),
                                            items: storageCountList
                                                .map((data) => DropdownMenuItem<String>(
                                              child: Text(data.key),
                                              value: data.value,
                                            ))
                                                .toList(),
                                          ),
                                        ) : SizedBox.shrink()
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            decoration: BoxDecoration(
                                border: Border.all(width: 1, color: secondaryPrimaryColor),
                                borderRadius: BorderRadius.circular(15)
                            ),
                          ),

                          SizedBox(height: 15,),

                          Container(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                          height: MediaQuery.of(context).size.height * 0.025,
                                          child: Image.asset(application)),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                          'other'.tr,
                                          style: CustomStyle.priceTextStyle
                                      ),
                                      Spacer()
                                    ],
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(vertical: 5),
                                    child: Column(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.symmetric(horizontal: 8),
                                          decoration: CustomStyle.secondBoxDecoration,
                                          child: DropdownButton<String>(
                                            isExpanded: true,
                                            value: fanCount,
                                            dropdownColor: primaryColor,
                                            icon: const Icon(Icons.keyboard_arrow_down,
                                                color: secondaryPrimaryColor),
                                            elevation: 16,
                                            style: CustomStyle.primaryTextStyle,
                                            underline: Container(
                                              height: 0,
                                              color: primaryColor,
                                            ),
                                            onChanged: (String? newValue) {
                                              setState(() {

                                                fanCount = newValue;

                                                if(totalWatt[5] != 0) {
                                                  totalWatt[5] = totalWatt[5] - 6;
                                                  totalWatt[5] = int.parse(fanCount.toString()) * 6;
                                                }
                                                else {
                                                  totalWatt[5] = int.parse(fanCount.toString()) * 6;
                                                }

                                                recommedPSU = totalWatt.reduce((a, b) => a + b);
                                                print(recommedPSU);

                                              });
                                            },
                                            hint: Text('fancount'.tr, style: CustomStyle.thirdTextStyle,),
                                            items: fanCountList
                                                .map((data) => DropdownMenuItem<String>(
                                              child: Text(data.key),
                                              value: data.value,
                                            ))
                                                .toList(),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            decoration: BoxDecoration(
                                border: Border.all(width: 1, color: secondaryPrimaryColor),
                                borderRadius: BorderRadius.circular(15)
                            ),
                          ),

                          SizedBox(height: 5,),
                        ],
                      ),
                    ),
                  ),
                  Divider(
                    color: secondaryPrimaryColor,
                    thickness: 0,
                  ),
                  Container(
                    //     decoration: CustomStyle.secondBoxDecoration,
                 //   height: size.height * 0.08,
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'recommedpsu'.tr,
                          style: CustomStyle.primaryTextStyle,
                        ),
                        Text(
                          recommedPSU.toString() + ' watt',
                          style: CustomStyle.priceTotalTextStyle
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: secondaryPrimaryColor,
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
