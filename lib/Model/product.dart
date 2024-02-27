
import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final String name;
  final String uid;
  final String brand;
  final String price;
  final String desc;
  final String socket;
  final String benchpoint;
  final String watt;
  final String result;
  final String imgUrl;
  final String buyUrl;
  final String classcpu;
  final String clockspeed;
  final String turbospeed;
  final String core;
  final String thread;
  final String cache;

  const Product(
      {required this.name,
        required this.uid,
        required this.brand,
        required this.price,
        required this.desc,
        required this.socket,
        required this.benchpoint,
        required this.watt,
        required this.result,
        required this.imgUrl,
        required this.buyUrl,
        required this.classcpu,
        required this.clockspeed,
        required this.turbospeed,
        required this.core,
        required this.thread,
        required this.cache,
      });

  static Product fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Product(
        name: snapshot["name"],
        uid: snapshot["uid"],
        brand: snapshot["brand"],
        price: snapshot["price"],
        desc: snapshot["desc"],
        socket: snapshot["socket"],
        benchpoint: snapshot["benchpoint"],
        watt: snapshot["watt"],
        result: snapshot['result'],
        imgUrl: snapshot['imgUrl'],
        buyUrl: snapshot['buyUrl'],
      classcpu: snapshot['classcpu'],
      clockspeed: snapshot['clockspeed'],
      turbospeed: snapshot['turbospeed'],
      core: snapshot['core'],
      thread: snapshot['thread'],
      cache: snapshot['cache'],
    );
  }

  Map<String, dynamic> toJson() => {
    "name": name,
    "uid": uid,
    "brand": brand,
    "price": price,
    "desc": desc,
    "socket": socket,
    "benchpoint": benchpoint,
    "watt": watt,
    'result': result,
    'imgUrl': imgUrl,
    'buyUrl': buyUrl,
    'classcpu': classcpu,
    'clockspeed': clockspeed,
    'turbospeed': turbospeed,
    'core': core,
    'thread': thread,
    'cache': cache,
  };
}

