import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_boxicons/flutter_boxicons.dart';
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
  int get hashCode => super.hashCode;


  static getCpu(String result, socket) async {
    List<Product> products = [];

    var url = Uri.parse("${Config.apiURL}get_product");
    try {
      final res = await http.get(url);

      if (res.statusCode == 200) {
        var data = jsonDecode(res.body);
        print(data);

        data.forEach((value) => {
          if(value['presult'] == result && value['psocket'] == socket) {
            products.add(Product(
                name: value['pname'],
                brand: value['pbrand'],
                desc: value['pdesc'],
                price: value['pprice'],
                socket: value['psocket'],
                benchpoint: value['pbenchpoint'],
                watt: value['pwatt'],
                result: value['presult']
            ))
          }
        });

        return products;

      } else {
        return [];
      }
    } catch (e) {
      print(e.toString());
    }
  }

  static getGpu(String result, brand) async {
    List<Product> products = [];

    var url = Uri.parse("${Config.apiURL}get_product");
    try {
      final res = await http.get(url);

      if (res.statusCode == 200) {
        var data = jsonDecode(res.body);
        print(data);

        data.forEach((value) => {
          if(value['presult'] == result && value['pbrand'] == brand) {
            products.add(Product(
                name: value['pname'],
                brand: value['pbrand'],
                desc: value['pdesc'],
                price: value['pprice'],
                socket: value['psocket'],
                benchpoint: value['pbenchpoint'],
                watt: value['pwatt'],
                result: value['presult']
            ))
          }
        });

        return products;

      } else {
        return [];
      }
    } catch (e) {
      print(e.toString());
    }
  }

  static getSocket(String brand) async {
    List<Socket> sockets = [];

    var url = Uri.parse("${Config.apiURL}get_socket");
    try {
      final res = await http.get(url);

      if (res.statusCode == 200) {
        var data = jsonDecode(res.body);
        print(data);

        data.forEach((value) => {
          if(value['pbrand'] == brand) {
            sockets.add(Socket(
                name: value['pname'],
                brand: value['pbrand']
            ))
          }
        });

        return sockets;

      } else {
        return [];
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: primaryColor,
      extendBodyBehindAppBar: true,
      /**   appBar: AppBar(
          title: Text('PRODIOT'),
          centerTitle: true,
          backgroundColor: primaryColor,
          elevation: 10,
          ),*/
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Bileşenleri Seçin',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Divider(
                    color: Colors.grey,
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
                                      Text(
                                        '  İşlemci',
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
                                                color: Colors.white),
                                            elevation: 16,
                                            style: TextStyle(color: Colors.white),
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
                                            hint: Text('Marka', style: CustomStyle.thirdTextStyle,),
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
                                          future: getSocket(processBrand!),
                                          builder: (BuildContext context, AsyncSnapshot snapshot) {
                                            if (!snapshot.hasData) {
                                              return const Center(
                                                child: CircularProgressIndicator(),
                                              );
                                            } else {
                                              List<Socket> pdata = snapshot.data;

                                              return Container(
                                                padding: EdgeInsets.symmetric(horizontal: 8),
                                                decoration: CustomStyle.secondBoxDecoration,
                                                child: DropdownButton<String>(
                                                  isExpanded: true,
                                                  value: processSocket,
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
                                                      processSocket = null;
                                                      processModel = null;
                                                      processSocket = newValue;
                                                    });
                                                  },
                                                  hint: Text('Soket', style: CustomStyle.thirdTextStyle,),
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
                                        processSocket != null ? FutureBuilder(
                                          future: getCpu("0", processSocket),
                                          builder: (BuildContext context, AsyncSnapshot snapshot) {
                                            if (!snapshot.hasData) {
                                              return const Center(
                                                child: CircularProgressIndicator(),
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
                                                      color: Colors.white),
                                                  elevation: 16,
                                                  style: TextStyle(color: Colors.white),
                                                  underline: Container(
                                                    height: 0,
                                                    color: primaryColor,
                                                  ),
                                                  onChanged: (String? newValue) {
                                                    setState(() {
                                                      processModel = newValue;
                                                      print(processModel);

                                                      pdata.forEach((value) => {
                                                        if(value.name == processModel) {
                                                          processModelWatt = value.watt
                                                        }
                                                      });
                                                      print(processModelWatt);

                                                      totalWatt[0] = processModelWatt.toInt();
                                                      print(totalWatt);

                                                      recommedPSU = totalWatt.reduce((a, b) => a + b);
                                                      print(recommedPSU);

                                                    });
                                                  },
                                                  hint: Text('Model', style: CustomStyle.thirdTextStyle,),
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
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(width: 0, color: Colors.grey),
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
                                      Text(
                                          '  Ekran Kartı',
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
                                                color: Colors.white),
                                            elevation: 16,
                                            style: TextStyle(color: Colors.white),
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
                                            hint: Text('Marka', style: CustomStyle.thirdTextStyle,),
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
                                          future: getGpu("3", gpuBrand),
                                          builder: (BuildContext context, AsyncSnapshot snapshot) {
                                            if (!snapshot.hasData) {
                                              return const Center(
                                                child: CircularProgressIndicator(),
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
                                                      color: Colors.white),
                                                  elevation: 16,
                                                  style: TextStyle(color: Colors.white),
                                                  underline: Container(
                                                    height: 0,
                                                    color: primaryColor,
                                                  ),
                                                  onChanged: (String? newValue) {
                                                    setState(() {
                                                      gpuModel = null;
                                                      gpuCount = null;
                                                      gpuModel = newValue;

                                                      pdata.forEach((value) => {
                                                        if(value.name == gpuModel) {
                                                          gpuModelWatt = value.watt
                                                        }
                                                      });
                                                      print(gpuModelWatt);

                                                    });
                                                  },
                                                  hint: Text('Ekran Kartı', style: CustomStyle.thirdTextStyle,),
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
                                                color: Colors.white),
                                            elevation: 16,
                                            style: TextStyle(color: Colors.white),
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
                                            hint: Text('Sayı', style: CustomStyle.thirdTextStyle,),
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
                                border: Border.all(width: 0, color: Colors.grey),
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
                                      Text(
                                          '  Anakart',
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
                                                color: Colors.white),
                                            elevation: 16,
                                            style: TextStyle(color: Colors.white),
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
                                            hint: Text('Anakart Tipi', style: CustomStyle.thirdTextStyle,),
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
                                border: Border.all(width: 0, color: Colors.grey),
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
                                      Text(
                                          '  RAM',
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
                                                color: Colors.white),
                                            elevation: 16,
                                            style: TextStyle(color: Colors.white),
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
                                            hint: Text('Bellek Modülü', style: CustomStyle.thirdTextStyle,),
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
                                                color: Colors.white),
                                            elevation: 16,
                                            style: TextStyle(color: Colors.white),
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
                                            hint: Text('Sayı', style: CustomStyle.thirdTextStyle,),
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
                                border: Border.all(width: 0, color: Colors.grey),
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
                                      Text(
                                          '  Depolama',
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
                                                color: Colors.white),
                                            elevation: 16,
                                            style: TextStyle(color: Colors.white),
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
                                            hint: Text('Tür', style: CustomStyle.thirdTextStyle,),
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
                                                color: Colors.white),
                                            elevation: 16,
                                            style: TextStyle(color: Colors.white),
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
                                            hint: Text('Sayı', style: CustomStyle.thirdTextStyle,),
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
                                border: Border.all(width: 0, color: Colors.grey),
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
                                      Text(
                                          '  Diğer',
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
                                                color: Colors.white),
                                            elevation: 16,
                                            style: TextStyle(color: Colors.white),
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
                                            hint: Text('Fan Sayısı', style: CustomStyle.thirdTextStyle,),
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
                                border: Border.all(width: 0, color: Colors.grey),
                                borderRadius: BorderRadius.circular(15)
                            ),
                          ),

                          SizedBox(height: 5,),
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
                 //   height: size.height * 0.08,
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Tavsiye Edilen Güç Kaynağı',
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
