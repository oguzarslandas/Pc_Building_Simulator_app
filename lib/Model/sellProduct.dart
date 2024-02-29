
import 'package:cloud_firestore/cloud_firestore.dart';

class SellProduct {
  final String uid;
  final String headline;
  final String detail;
  final int price;
  final String status;
  final String address;
  final List photoUrl;

  const SellProduct(
      {
        required this.uid,
        required this.headline,
        required this.detail,
        required this.status,
        required this.price,
        required this.address,
        required this.photoUrl,
      });

  static SellProduct fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return SellProduct(
      uid: snapshot["uid"],
      headline: snapshot["headline"],
      detail: snapshot["detail"],
      status: snapshot["status"],
      price: snapshot["price"],
      address: snapshot["address"],
      photoUrl: snapshot["photoUrl"],
    );
  }

  Map<String, dynamic> toJson() => {
    "uid": uid,
    "headline": headline,
    "detail": detail,
    "status": status,
    "price": price,
    "address": address,
    "photoUrl": photoUrl,
  };
}

