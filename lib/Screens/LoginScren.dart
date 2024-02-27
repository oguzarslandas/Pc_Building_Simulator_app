import 'dart:async';
import 'dart:convert';
import 'package:pc_building_simulator/Network/Api/ApiService.dart';
import 'package:pc_building_simulator/Screens/Home.dart';
import 'package:pc_building_simulator/Utils/common.dart';
import 'package:pc_building_simulator/Utils/constant.dart';
import 'package:pc_building_simulator/Utils/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Utils/colors.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernamecontroller = TextEditingController();
  final _passwordcontroller = TextEditingController();

  late SharedPreferences logindata;
  bool? newuser;

  bool isLogin = true;

  void init() async {
    logindata = await SharedPreferences.getInstance();
  }

  void initState() {
    super.initState();
    init();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _usernamecontroller.dispose();
    _passwordcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,

        ///Color(0xfff1f1f1),
        body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
            return SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: ConstrainedBox(
                constraints:
                BoxConstraints(minHeight: viewportConstraints.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.35,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(
                                width: 120,
                                height: 120,
                                child: Image.asset(
                                 appLogo,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const Text(
                                mAppName,
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(30),
                          decoration: const BoxDecoration(
                            color: primaryColor,
                            //  border: Border.all(width: 1, color: colors.secondcolor),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              const Text(
                                'Hoşgeldiniz',
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.w200,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              TextField(
                                controller: _usernamecontroller,
                                autocorrect: true,
                                decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  hintText: 'Kullanıcı Adı',
                                  hintStyle: const TextStyle(
                                    color: Colors.black,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: const BorderSide(
                         //             color: Theme.of(context).primaryColor,
                        //              width: 3,
                                    ),
                                  ),
                                  prefixIcon: const IconTheme(
                                    data: IconThemeData(
                                      color: primaryColor,
                                    ),
                                    child: Icon(Icons.person_rounded),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              TextField(
                                controller: _passwordcontroller,
                                autocorrect: true,
                                obscureText: true,
                                decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  hintText: 'Şifre',
                                  hintStyle: const TextStyle(
                                    color: Colors.black,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: const BorderSide(
                          //            color: Theme.of(context).primaryColor,
                            //          width: 3,
                                    ),
                                  ),
                                  prefixIcon: const IconTheme(
                                    data: IconThemeData(
                                      color: primaryColor,
                                    ),
                                    child: Icon(Icons.lock),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Center(
                                child: ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                     isLogin = false;
                            /**         var data = {
                                       "pname" : _usernamecontroller.text,
                                       "pprice" : _usernamecontroller.text,
                                       "pdesc" : _usernamecontroller.text
                                     };

                                     APIService.addproduct(data); */
                               ///       APIService.otpLogin(_usernamecontroller.text, _passwordcontroller.text).then((dynamic result) async {});
                                     Home().launch(context, isNewTask: true, pageRouteAnimation: PageRouteAnimation.Slide);
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xfffafafa)
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(vertical: 15),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: const <Widget>[
                                        Text(
                                          'Giriş Yap',
                                          style: TextStyle(
                                            color: primaryColor,
                                            fontSize: 20,
                                          ),
                                        ),
                                        Icon(
                                          Icons.arrow_forward_ios_rounded,
                                          size: 25,
                                          color: primaryColor,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 50,
                              ),
                              isLogin == false
                                  ? const Center(child: spinkitSecondary)
                                  : const Text('')
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  _showDialog1(String errdesc) {
    showDialog(
      context: context,
      barrierDismissible: false, //sadece butonlara basınca ekrandan çıkıyor
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          title: const Text('Dikkat!'),
          content: Text(errdesc),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: MaterialButton(
           //     shape: const StadiumBorder(),
                minWidth: 80,
                color: primaryColor,
                child: const Text(
                  "Kapat",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  setState(() {
                    isLogin = true;
                  });
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
