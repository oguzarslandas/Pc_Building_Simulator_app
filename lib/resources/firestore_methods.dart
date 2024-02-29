import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pc_building_simulator/Model/product.dart';
import 'package:pc_building_simulator/Model/sellProduct.dart';
import 'package:pc_building_simulator/resources/storage_methods.dart';
import 'package:uuid/uuid.dart';

class FireStoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> uploadPost(
      String name,
      String desc,
      String brand,
      String price,
      String bench,
      String watt,
      String socket,
      String buyUrl,
      String result,
      Uint8List? file,
      String classcpu,
      String clockspeed,
      String turbospeed,
      String core,
      String thread,
      String cache,
      ) async {

    String res = "Some error occurred";
    try {
      if (file != null) {
        String photoUrl =
            await StorageMethods().uploadImageToStorage('products', file, true);
        String prodId = const Uuid().v1(); // creates unique id based on time
        int decimalPlaces = 2;

        var roundedString = int.parse(bench) / int.parse(price);
        double avgMarks = double.parse(roundedString.toStringAsFixed(decimalPlaces));

        Product product = Product(
            name: name,
            uid: prodId,
            brand: brand,
            desc: desc,
            price: int.parse(price),
            socket: socket,
            benchpoint: int.parse(bench),
            avgMark: avgMarks,
            watt: watt,
            result: result,
            imgUrl: photoUrl,
            buyUrl: buyUrl,
            classcpu: classcpu,
            clockspeed: clockspeed,
            turbospeed: turbospeed,
            core: core,
            thread: thread,
            cache: cache
        );
        _firestore.collection('products').doc(prodId).set(product.toJson());
        res = "success";
      } else {
        res = "Resim Eklemediniz!";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<String> sellProduct(
      String headline,
      String detail,
      String price,
      String status,
      String adress,
      var file,
      ) async {

    String res = "Some error occurred";
    try {
      if (file != null) {
        List photoList = [];
        for (var i = 0; i < file.length; i++) {
          Uint8List img = await file[i].readAsBytes();
          String photoUrl = await StorageMethods().uploadImageToStorage('sellProducts', img, true);
          photoList.add(photoUrl);
        }



        String prodId = const Uuid().v1(); // creates unique id based on time
        SellProduct sellProduct = SellProduct(
            headline: headline,
            uid: prodId,
            detail: detail,
            status: status,
            price: int.parse(price),
            address: adress,
            photoUrl: photoList,
        );
        _firestore.collection('sellProducts').doc(prodId).set(sellProduct.toJson());
        res = "success";
      } else {
        res = "Resim Eklemediniz!";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  // Delete Post
  Future<String> deletePost(String postId) async {
    String res = "Some error occurred";
    try {
      await _firestore.collection('posts').doc(postId).delete();
      res = 'success';
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<List<Map<String, dynamic>>> getAllDocuments() async {
    try {
      QuerySnapshot querySnapshot = await _firestore.collection('products').get();
      return querySnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
    } catch (e) {
      print('Hata: $e');
      return [];
    }
  }

}
