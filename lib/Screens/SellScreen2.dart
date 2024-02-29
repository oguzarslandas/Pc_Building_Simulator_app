
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pc_building_simulator/Model/sellCategory.dart';
import 'package:pc_building_simulator/Utils/colors.dart';
import 'package:pc_building_simulator/Utils/common.dart';
import 'package:pc_building_simulator/Utils/images.dart';
import 'package:pc_building_simulator/Widgets/CategoryCard.dart';
import 'package:pc_building_simulator/Widgets/DeviceCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pc_building_simulator/Widgets/DrawerList.dart';
import 'package:pc_building_simulator/Widgets/ShoppingCategoryCard.dart';
import 'package:pc_building_simulator/Widgets/common_widget/rounded_button.dart';
import 'package:pc_building_simulator/resources/firestore_methods.dart';

import 'AddProductScreen.dart';

class SellPage2 extends StatefulWidget {
  const SellPage2({Key? key,}) : super(key: key);

  @override
  State<SellPage2> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<SellPage2> {

  String _address = 'Konum bilgisi alınamadı';
  String? status;
  String? adsHeadline;
  String? adsDetail;
  Uint8List? _file;
  bool isLoading = false;

  final TextEditingController _adsHeadlineController = TextEditingController();
  final TextEditingController _adsDetailController = TextEditingController();
  final TextEditingController _adsPriceController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }


  Future<void> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      List<Placemark> placemarks = await placemarkFromCoordinates(
          position.latitude, position.longitude);
      Placemark place = placemarks[0];
      setState(() {
        _address = "${place.administrativeArea}, ${place.subAdministrativeArea}";
      });
    } catch (e) {
      print('Konum alınamadı: $e');
      setState(() {
        _address = 'Konum bilgisi alınamadı';
      });
    }
  }

  Future getImages() async {
    final pickedFile = await picker.pickMultiImage(
        imageQuality: 100, // To set quality of images
        maxHeight: 1000, // To set maxheight of images that you want in your app
        maxWidth: 1000); // To set maxheight of images that you want in your app
    List<XFile> xfilePick = pickedFile;

    // if atleast 1 images is selected it will add
    // all images in selectedImages
    // variable so that we can easily show them in UI
    if (xfilePick.isNotEmpty) {
      for (var i = 0; i < xfilePick.length; i++) {
        selectedImages.add(File(xfilePick[i].path));
        Uint8List img = await selectedImages[0].readAsBytes();
      }
      setState(
            () {  },
      );
    } else {
      // If no image is selected it will show a
      // snackbar saying nothing is selected
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Nothing is selected')));
    }

  }

  void uploadProduct() async {
      setState(() {
        isLoading = true;
      });
      // start the loading
      try {
        // upload to storage and db
        String res = await FireStoreMethods().sellProduct(
            _adsHeadlineController.text,
            _adsDetailController.text,
            _adsPriceController.text,
            status!,
            _address,
            selectedImages
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

  List<KeyValueModel> statusCategory = [
    KeyValueModel(key: "Sıfır", value: "Sıfır"),
    KeyValueModel(key: "Yeni gibi", value: "Yeni gibi"),
    KeyValueModel(key: "İyi", value: "İyi"),
    KeyValueModel(key: "İdare Eder", value: "İdare Eder"),
    KeyValueModel(key: "Yıpranmış", value: "Yıpranmış"),
  ];


  List<File> selectedImages = []; // List of selected image
  final picker = ImagePicker();  // Instance of Image picker

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        title: Text('Bilgi Ekle', style: CustomStyle.boldTitleTextStyle,),
        elevation: 1,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon:Icon(Boxicons.bxs_chevron_left, color: secondaryPrimaryColor,)
        ),
        centerTitle: false,
        backgroundColor: primaryColor,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: DropdownButton<String>(
              isExpanded: true,
              value: status,
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
                  status = newValue;
                  print(status);
                });
              },
              hint: Text('Durum', style: CustomStyle.thirdTextStyle,),
              items: statusCategory
                  .map((data) => DropdownMenuItem<String>(
                child: Text(data.key),
                value: data.value,
              ))
                  .toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _adsHeadlineController,
              decoration: const InputDecoration(
                hintText: "Ürün Başlığı",
                hintStyle: CustomStyle.thirdTextStyle
              ),
              maxLines: 1,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _adsDetailController,
              decoration: const InputDecoration(
                labelText: "Ürün hakkında detay ver",
                  labelStyle: CustomStyle.thirdTextStyle
              ),
              maxLines: 4,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _adsPriceController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                  hintText: "Fiyat",
                  hintStyle: CustomStyle.thirdTextStyle
              ),
              maxLines: 1,
            ),
          ),
          ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.green)),
            // TO change button color
            child: const Text('Select Image from Gallery and Camera'),
            onPressed: () {
              getImages();
            },
          ),

          Expanded(
            child: SizedBox(
              width: 300.0, // To show images in particular area only
              child: selectedImages.isEmpty  // If no images is selected
                  ? const Center(child: Text('Sorry nothing selected!!'))
              // If atleast 1 images is selected
                  : GridView.builder(
                itemCount: selectedImages.length,
                gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3
                  // Horizontally only 3 images will show
                ),
                itemBuilder: (BuildContext context, int index) {
                  // TO show selected file
                  return Center(
                      child: kIsWeb
                          ? Image.network(
                          selectedImages[index].path)
                          : Image.file(selectedImages[index]));
                  // If you are making the web app then you have to
                  // use image provider as network image or in
                  // android or iOS it will as file only
                },
              ),
            ),
          ),
          Spacer(),
          RoundGradientButton(
            title: "Hemen İlan Ver",
            onPressed: () {
              uploadProduct();
            },
          ),
        ],
      )
    );
  }
  PageRouteBuilder _customPageRouteBuilder(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOutQuart;
        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);
        return SlideTransition(position: offsetAnimation, child: child);
      },
    );
  }
}