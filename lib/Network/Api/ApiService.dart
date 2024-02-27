import 'dart:convert';
import 'package:pc_building_simulator/Model/product.dart';
import 'package:pc_building_simulator/Network/Api/ApiConfig.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class APIService {
  static var client = http.Client();

  static Future otpLogin(String username, String password,) async {
    var requestHeaders = <String, String>{
      'Content-Type': 'application/json'
    };
    var url = Uri.https(Config.apiURL, Config.loginAPI);
    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode({
        'username': username,
        'password': password,
      }),
    );
    Map<String, dynamic> result = jsonDecode(response.body);
    //dynamic result = jsonDecode(response.body);
    return result;
  }


  static Future authenticateAPI(String username, String password,) async {
    var requestHeaders = <String, String>{
      'Content-Type': 'application/json'
    };
    var url = Uri.https(Config.apiURL, Config.authenticate);
    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode({
        'username': username,
        'password': password,
      }),
    );
    Map<String, dynamic> result = jsonDecode(response.body);
    //dynamic result = jsonDecode(response.body);
    return result;
  }

  static Future prodiotAPI() async {
    var requestHeaders = <String, String>{
      'Content-Type': 'application/json'
    };
    var url = Uri.http(Config.apiURL, Config.prodiot);
    var response = await client.get(
      url,
      headers: requestHeaders,
    );
    Map<String, dynamic> result = jsonDecode(response.body);
    //dynamic result = jsonDecode(response.body);
    return result;
  }

  static Future deviceListAPI() async {
    var requestHeaders = <String, String>{
      'Content-Type': 'application/json',
    };
    var url = Uri.https(Config.apiURL, Config.definedDevices);
    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode({
        "userid" : "D3E30B44-01F9-4480-B7CE-B2D4D2ECA5D7"
      }),
    );
  }

  static addproduct(Map pdata) async {

    print(pdata);
    var url = Uri.parse("${Config.apiURL}add_product");

    try {
      final res = await http.post(url, body: pdata);

      if (res.statusCode == 200) {

        var data = jsonDecode(res.body.toString());
        print(data);

      } else {
        print("Failed to get response");
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  static getProduct(String result) async {
    List<Product> products = [];

    var url = Uri.parse("${Config.apiURL}get_product");

    try {
      final res = await http.get(url);

      if (res.statusCode == 200) {
        var data = jsonDecode(res.body);
        print(data);

        data.forEach((value) => {
          if(value['presult'] == result) {
            products.add(Product(
                name: value['pname'],
                brand: value['pbrand'],
                desc: value['pdesc'],
                price: value['pprice'],
                socket: value['psocket'],
                watt: value['pwatt'],
                benchpoint: value['pbenchpoint'],
                result: value['presult'],
                imgUrl: value['pimgurl'],
                buyUrl: value['pbuyurl'], uid: '', classcpu: '', clockspeed: '', turbospeed: '', core: '', thread: '', cache: '',
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

  static Future deviceAcceptAPI(int id, status) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };
    var url = Uri.https(Config.apiURL, Config.deviceStatus);
    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode({
        "id" : id,
        "status" : status
      }),
    );
/**    var result = deviceListModelFromJson(response.body);
    deviceList = result;
    //  List<dynamic> result = jsonDecode(response.body);
    return result;*/
  }


}
