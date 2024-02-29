
import 'dart:async';
import 'dart:convert';

import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
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
import 'package:pc_building_simulator/resources/firestore_methods.dart';

class KeyValueModel {
  String key;
  String value;

  KeyValueModel({required this.key, required this.value});
}

class AddProductPage extends StatefulWidget {
  const AddProductPage({Key? key,}) : super(key: key);

  @override
  State<AddProductPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<AddProductPage> {

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

  Uint8List? _file;
  bool isLoading = false;
  String? result;
  String? brand;
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _benchController = TextEditingController();
  final TextEditingController _wattController = TextEditingController();
  final TextEditingController _socketController = TextEditingController();
  final TextEditingController _buyUrlController = TextEditingController();

  final TextEditingController _classController = TextEditingController();
  final TextEditingController _clockspeedController = TextEditingController();
  final TextEditingController _turbospeedController = TextEditingController();
  final TextEditingController _coresController = TextEditingController();
  final TextEditingController _threadsController = TextEditingController();
  final TextEditingController _cacheController = TextEditingController();

  List<KeyValueModel> category = [
    KeyValueModel(key: "İşlemci", value: "0"),
    KeyValueModel(key: "Anakart", value: "1"),
    KeyValueModel(key: "Ram", value: "2"),
    KeyValueModel(key: "Ekran Kartı", value: "3"),
    KeyValueModel(key: "PC Kasa", value: "4"),
    KeyValueModel(key: "PSU", value: "5"),
    KeyValueModel(key: "HDD", value: "6"),
    KeyValueModel(key: "SSD", value: "7"),
    KeyValueModel(key: "Monitör", value: "8"),
    KeyValueModel(key: "Klavye", value: "9"),
    KeyValueModel(key: "Mouse", value: "10"),
    KeyValueModel(key: "Klavye Mouse Set", value: "11"),
    KeyValueModel(key: "Kulaklık", value: "12"),
  ];

  List<KeyValueModel> brands = [
    KeyValueModel(key: "AMD", value: "AMD"),
    KeyValueModel(key: "NVIDIA", value: "NVIDIA"),
    KeyValueModel(key: "MSI", value: "MSI"),
    KeyValueModel(key: "ASUS", value: "ASUS"),
    KeyValueModel(key: "GIGABYTE", value: "GIGABYTE"),
    KeyValueModel(key: "CORSAIR", value: "CORSAIR"),
    KeyValueModel(key: "GSKILL", value: "GSKILL"),
    KeyValueModel(key: "PATRIOT", value: "PATRIOT"),
    KeyValueModel(key: "DELL", value: "DELL"),
    KeyValueModel(key: "SAMSUNG", value: "SAMSUNG"),
    KeyValueModel(key: "LG", value: "LG"),
    KeyValueModel(key: "RAZER", value: "RAZER"),
    KeyValueModel(key: "HP", value: "HP"),
  ];


  void uploadProduct() async {
    if (result != null) {
      setState(() {
        isLoading = true;
      });
      // start the loading
      try {
        // upload to storage and db
        String res = await FireStoreMethods().uploadPost(
          _nameController.text,
          _descriptionController.text,
          brand!,
          _priceController.text,
          _benchController.text,
          _wattController.text,
          _socketController.text,
          _buyUrlController.text,
          result!,
          _file,
            _classController.text,
            _clockspeedController.text,
            _turbospeedController.text,
            _coresController.text,
            _threadsController.text,
            _cacheController.text
        );
        if (res == "success") {
          setState(() {
            isLoading = false;
          });
          if (context.mounted) {
            showSnackBar(
              context,
              'Paylaşıldı!',
            );
          }
          clearImage();
        } else {
          if (context.mounted) {
            showSnackBar(context, res);
            isLoading = false;
          }
        }
      } catch (err) {
        setState(() {
          isLoading = false;
        });
        showSnackBar(
          context,
          err.toString(),
        );
      }
    }
  }

  void clearImage() {
    setState(() {
      _file = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: primaryColor,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text('AddProductPage', style: CustomStyle.primaryTextStyle,),
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
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Container(
                child: Column(
                  children: [
                    isLoading
                        ? const LinearProgressIndicator()
                        : const Padding(padding: EdgeInsets.only(top: 0.0)),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 0),
                              child: Column(
                                children: [
                                  _file != null ? SizedBox.shrink() : IconButton.outlined(
                                      onPressed: () async {
                                        Uint8List file = await pickImage(ImageSource.camera);
                                        setState(() {
                                          _file = file;
                                        });
                                      },
                                      icon: Icon(Icons.add)),
                                  _file != null ? SizedBox(
                                    height: 100.0,
                                    width: 100.0,
                                    child: AspectRatio(
                                      aspectRatio: 487 / 451,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                              fit: BoxFit.contain,
                                              alignment: FractionalOffset.topCenter,
                                              image: MemoryImage(_file!),
                                            )),
                                      ),
                                    ),
                                  ) : SizedBox.shrink(),

                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                                    child: DropdownButton<String>(
                                      isExpanded: true,
                                      value: result,
                                      dropdownColor: primaryColor,
                                      icon: const Icon(Icons.keyboard_arrow_down,
                                          color: secondaryPrimaryColor),
                                      elevation: 16,
                                      style: CustomStyle.thirdTextStyle,
                                      underline: Container(
                                        height: 1,
                                        color: secondaryPrimaryColor,
                                      ),
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          result = newValue;
                                          print(result);
                                        });
                                      },
                                      hint: Text('Kategori', style: CustomStyle.thirdTextStyle,),
                                      items: category
                                          .map((data) => DropdownMenuItem<String>(
                                        child: Text(data.key),
                                        value: data.value,
                                      ))
                                          .toList(),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                                    child: DropdownButton<String>(
                                      isExpanded: true,
                                      value: brand,
                                      dropdownColor: primaryColor,
                                      icon: const Icon(Icons.keyboard_arrow_down,
                                          color: secondaryPrimaryColor),
                                      elevation: 16,
                                      style: CustomStyle.thirdTextStyle,
                                      underline: Container(
                                        height: 1,
                                        color: secondaryPrimaryColor,
                                      ),
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          brand = newValue;
                                          print(brand);
                                        });
                                      },
                                      hint: Text('Kategori', style: CustomStyle.thirdTextStyle,),
                                      items: brands
                                          .map((data) => DropdownMenuItem<String>(
                                        child: Text(data.key),
                                        value: data.value,
                                      ))
                                          .toList(),
                                    ),
                                  ),

                                  SizedBox(
                                    width: MediaQuery.of(context).size.width * 0.9,
                                    child: TextField(
                                      controller: _nameController,
                                      decoration: const InputDecoration(
                                          hintText: "Ürün Başlığı",
                                       //   border: InputBorder.none
                                      ),
                                      maxLines: 1,
                                    ),
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width * 0.9,
                                    child: TextField(
                                      controller: _descriptionController,
                                      decoration: const InputDecoration(
                                          hintText: "Ürün Detayı",
                                      ),
                                      maxLines: 1,
                                    ),
                                  ),
                         /*         SizedBox(
                                    width: MediaQuery.of(context).size.width * 0.9,
                                    child: TextField(
                                      controller: _brandController,
                                      decoration: const InputDecoration(
                                          hintText: "Marka",
                                //          border: InputBorder.none
                                      ),
                                      maxLines: 1,
                                    ),
                                  ),*/
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width * 0.9,
                                    child: TextField(
                                      controller: _priceController,
                                      keyboardType: TextInputType.number,
                                      decoration: const InputDecoration(
                                          hintText: "Fiyat",
                                    //      border: InputBorder.none
                                      ),
                                      maxLines: 1
                                    ),
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width * 0.9,
                                    child: TextField(
                                      controller: _benchController,
                                      keyboardType: TextInputType.number,
                                      decoration: const InputDecoration(
                                          hintText: "Benchmark Puanı",
                                      //    border: InputBorder.none
                                      ),
                                      maxLines: 1,
                                    ),
                                  ),

                                  SizedBox(
                                    width: MediaQuery.of(context).size.width * 0.9,
                                    child: TextField(
                                      controller: _wattController,
                                      keyboardType: TextInputType.number,
                                      decoration: const InputDecoration(
                                          hintText: "Watt Değeri",
                                  //        border: InputBorder.none
                                      ),
                                      maxLines: 1,
                                    ),
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width * 0.9,
                                    child: TextField(
                                      controller: _socketController,
                                      decoration: const InputDecoration(
                                          hintText: "Soket",
                                      //    border: InputBorder.none
                                      ),
                                      maxLines: 1,
                                    ),
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width * 0.9,
                                    child: TextField(
                                      controller: _classController,
                                      decoration: const InputDecoration(
                                        hintText: "Class",
                                        //       border: InputBorder.none
                                      ),
                                      maxLines: 1,
                                    ),
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width * 0.9,
                                    child: TextField(
                                      controller: _buyUrlController,
                                      decoration: const InputDecoration(
                                          hintText: "Satın alım URL'si",
                                   //       border: InputBorder.none
                                      ),
                                      maxLines: 1,
                                    ),
                                  ),

                                  result == '0' ?
                                      Column(
                                        children: [
                                          SizedBox(
                                            width: MediaQuery.of(context).size.width * 0.9,
                                            child: TextField(
                                              controller: _cacheController,
                                              decoration: const InputDecoration(
                                                hintText: "Cache",
                                                //       border: InputBorder.none
                                              ),
                                              maxLines: 1,
                                            ),
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context).size.width * 0.9,
                                            child: TextField(
                                              controller: _coresController,
                                              decoration: const InputDecoration(
                                                hintText: "Core",
                                                //       border: InputBorder.none
                                              ),
                                              maxLines: 1,
                                            ),
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context).size.width * 0.9,
                                            child: TextField(
                                              controller: _threadsController,
                                              decoration: const InputDecoration(
                                                hintText: "Threads",
                                                //       border: InputBorder.none
                                              ),
                                              maxLines: 1,
                                            ),
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context).size.width * 0.9,
                                            child: TextField(
                                              controller: _clockspeedController,
                                              decoration: const InputDecoration(
                                                hintText: "Clockspeed",
                                                //       border: InputBorder.none
                                              ),
                                              maxLines: 1,
                                            ),
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context).size.width * 0.9,
                                            child: TextField(
                                              controller: _turbospeedController,
                                              decoration: const InputDecoration(
                                                hintText: "Turbospeed",
                                                //       border: InputBorder.none
                                              ),
                                              maxLines: 1,
                                            ),
                                          ),
                                        ],
                                      ) : SizedBox.shrink(),

                                  isLoading
                                      ? const CircularProgressIndicator()
                                      : ElevatedButton(
                                      onPressed: () {
                                        uploadProduct();
                                      },
                                      child: Text('Gönder'))

                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}