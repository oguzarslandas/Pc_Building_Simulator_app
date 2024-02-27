import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pc_building_simulator/Model/product.dart';
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
        Product product = Product(
            name: name,
            uid: prodId,
            brand: brand,
            desc: desc,
            price: price,
            socket: socket,
            benchpoint: bench,
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
