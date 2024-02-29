
import 'package:cloud_firestore/cloud_firestore.dart';

class BestPC {
  final String name;
  final String cpu;
  final String gpu;
  final String motherboard;
  final String ram;
  final String classprod;
  final String drive;
  final int point;

  const BestPC(
      {required this.cpu,
        required this.name,
        required this.gpu,
        required this.motherboard,
        required this.ram,
        required this.classprod,
        required this.point,
        required this.drive,

      });

  static BestPC fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return BestPC(
      cpu: snapshot["cpu"],
      name: snapshot["name"],
      gpu: snapshot["gpu"],
      motherboard: snapshot["motherboard"],
      ram: snapshot["ram"],
      classprod: snapshot["classprod"],
      point: snapshot["point"],
      drive: snapshot["drive"],
    );
  }

  Map<String, dynamic> toJson() => {
    "cpu": cpu,
    "name": name,
    "classprod": classprod,
    "gpu": gpu,
    "drive": drive,
    "motherboard": motherboard,
    "ram": ram,
    "point": point,
  };
}

