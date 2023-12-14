import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:get/get.dart';
import 'package:pc_building_simulator/Utils/colors.dart';
import 'package:pc_building_simulator/Utils/common.dart';

class DrawerList extends StatefulWidget {
  const DrawerList({
    Key? key,
  }) : super(key: key);


  @override
  _TopBarState createState() => _TopBarState();
}

class _TopBarState extends State<DrawerList> {
  int tab = 0;
  bool ispopup = false;
  bool ispopupfolders = false;
  bool ispopuplocation = false;

  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.75,
        child: Drawer(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(0), bottomRight: Radius.circular(0)),
          ),
          backgroundColor: primaryColor,
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(width: 0, color: thirdPrimaryColor)),
                      child: ListTile(
                        onTap: () {
                          setState(() {
                            ispopup = !ispopup;
                            ispopupfolders = false;
                          });
                        },
                        title: Row(
                          children: [
                            Icon(Boxicons.bxs_wrench, color: thirdPrimaryColor,),
                            SizedBox(width: 5),
                            Text(
                              'parts'.tr,
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Red Hat Display',
                                  color: thirdPrimaryColor),
                            ),
                          ],
                        ),
                        trailing: Icon(
                          ispopup ? Icons.keyboard_arrow_down_rounded : Icons.keyboard_arrow_right_rounded,
                          size: 28,
                        ),
                      ),
                    ),
                    ispopup ? _pcPartsList() : const SizedBox.shrink(),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(width: 0, color: thirdPrimaryColor)),
                      child: ListTile(
                        //    leading: Icon(BoxIcons.bx_edit),
                        onTap: () {
                          setState(() {
                            ispopupfolders = !ispopupfolders;
                            ispopup = false;
                            ispopuplocation = false;
                          });
                        },
                        title: Row(
                          children: [
                            Icon(Boxicons.bxs_bar_chart_alt_2, color: thirdPrimaryColor,),
                            SizedBox(width: 5),
                            Text(
                              'benchmarks'.tr,
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Red Hat Display',
                                  color: thirdPrimaryColor),
                            ),
                          ],
                        ),
                        trailing: Icon(
                          ispopupfolders ? Icons.keyboard_arrow_down_rounded : Icons.keyboard_arrow_right_rounded,
                          size: 28,
                        ),
                      ),
                    ),
                    ispopupfolders ? _benchmarkList() : const SizedBox.shrink(),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(width: 0, color: thirdPrimaryColor)),
                      child: ListTile(
                        //    leading: Icon(BoxIcons.bx_edit),
                        onTap: () {
                          setState(() {
                            ispopuplocation = !ispopuplocation;
                            ispopup = false;
                            ispopupfolders = false;
                          });
                        },
                        title: Row(
                          children: [
                            Icon(Boxicons.bxs_edit_location, color: thirdPrimaryColor,),
                            SizedBox(width: 5),
                            Text(
                              'location'.tr,
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Red Hat Display',
                                  color: thirdPrimaryColor),
                            ),
                          ],
                        ),
                        trailing: Icon(
                          ispopuplocation ? Icons.keyboard_arrow_down_rounded : Icons.keyboard_arrow_right_rounded,
                          size: 28,
                        ),
                      ),
                    ),
                    ispopuplocation ? _locationList() : const SizedBox.shrink(),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(width: 0, color: thirdPrimaryColor)),
                      child: ListTile(
                        //    leading: Icon(BoxIcons.bx_edit),
                        onTap: () {
                          setState(() {
                            ispopuplocation = !ispopuplocation;
                            ispopup = false;
                            ispopupfolders = false;
                          });
                        },
                        title: Row(
                          children: [
                            Icon(Boxicons.bxs_message_alt_detail, color: thirdPrimaryColor,),
                            SizedBox(width: 5),
                            Text(
                              'feedback'.tr,
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Red Hat Display',
                                  color: thirdPrimaryColor),
                            ),
                          ],
                        ),
                        trailing: Icon(
                          ispopuplocation ? Icons.keyboard_arrow_down_rounded : Icons.keyboard_arrow_right_rounded,
                          size: 28,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(
                thickness: 1,
                color: thirdPrimaryColor,
                endIndent: 0,
                indent: 0,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.10,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('CodeGarage', style: CustomStyle.boldTitleTextStyle,),
                    Text('v1.0.0', style: CustomStyle.titleTextStyle,)
                  ],
                )
              )
            ],
          ),
        ),
      ),
    );
  }

  _pcPartsList() {
    return Container(
      margin: const EdgeInsets.only(left: 5),
      height: MediaQuery.of(context).size.height * 0.27,
      child: ListView(
        children: [
          ListTile(
            //    leading: Icon(BoxIcons.bx_edit),
            title: Row(
              children: [
                Icon(Boxicons.bxs_circle, color: thirdPrimaryColor, size: 10,),
                SizedBox(width: 5),
                Text(
                  'cpu'.tr,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Red Hat Display',
                      color: thirdPrimaryColor),
                ),
              ],
            ),
            trailing: Icon(
              Icons.keyboard_arrow_right_rounded,
              size: 20,
            ),
          ),
          ListTile(
            //  leading: Icon(BoxIcons.bx_calendar),
            title: Row(
              children: [
                Icon(Boxicons.bxs_circle, color: thirdPrimaryColor, size: 10,),
                SizedBox(width: 5),
                Text(
                  'motherboard'.tr,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Red Hat Display',
                      color: thirdPrimaryColor),
                ),
              ],
            ),
            trailing: Icon(
              Icons.keyboard_arrow_right_rounded,
              size: 20,
            ),
          ),
          ListTile(
            //    leading: Icon(BoxIcons.bx_edit),
            onTap: () {
              Navigator.pushNamed(context, '/activeedu');
            },
            title: Row(
              children: [
                Icon(Boxicons.bxs_circle, color: thirdPrimaryColor, size: 10,),
                SizedBox(width: 5),
                Text(
                  'gpu'.tr,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Red Hat Display',
                      color: thirdPrimaryColor),
                ),
              ],
            ),
            trailing: const Icon(
              Icons.keyboard_arrow_right_rounded,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }

  _benchmarkList() {
    return Container(
      margin: const EdgeInsets.only(left: 5),
      height: MediaQuery.of(context).size.height * 0.18,
      child: ListView(
        children: [
          ListTile(
            //    leading: Icon(BoxIcons.bx_edit),
            onTap: () {
              Navigator.pushNamed(context, '/mydoc');
            },
            title: const Row(
              children: [
                Icon(Boxicons.bxs_circle, color: thirdPrimaryColor, size: 10,),
                SizedBox(width: 5),
                Text(
                  'CPU Benchmarks',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Red Hat Display',
                      color: thirdPrimaryColor),
                ),
              ],
            ),
            trailing: const Icon(
              Icons.keyboard_arrow_right_rounded,
              size: 20,
            ),
          ),
          ListTile(
            //    leading: Icon(BoxIcons.bx_edit),
            onTap: () {
              Navigator.pushNamed(context, '/mydoc');
            },
            title: const Row(
              children: [
                Icon(Boxicons.bxs_circle, color: thirdPrimaryColor, size: 10,),
                SizedBox(width: 5),
                Text(
                  'GPU Benchmarks',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Red Hat Display',
                      color: thirdPrimaryColor),
                ),
              ],
            ),
            trailing: const Icon(
              Icons.keyboard_arrow_right_rounded,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }

  _locationList() {
    return Container(
      margin: const EdgeInsets.only(left: 5),
      height: MediaQuery.of(context).size.height * 0.61,
      child: ListView(
        children: [
          ListTile(
            //    leading: Icon(BoxIcons.bx_edit),
            onTap: () {
              var locale = Locale('en', 'UK');
              Get.updateLocale(locale);
              Navigator.pushNamed(context, '/mydoc');
            },
            title: Row(
              children: [
                CountryFlag.fromCountryCode(
                  'gb',
                  height: MediaQuery.of(context).size.width * .07,
                  width: MediaQuery.of(context).size.width * .07,
                  borderRadius: 8,
                ),
                SizedBox(width: 5),
                Text(
                  'United Kingdom',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Red Hat Display',
                      color: thirdPrimaryColor),
                ),
              ],
            ),
              trailing: isSelected ? Icon(
                Boxicons.bx_circle,
                size: 20,
              ) : null
          ),
          ListTile(
            //    leading: Icon(BoxIcons.bx_edit),
            onTap: () {
              var locale = Locale('en', 'US');
              Get.updateLocale(locale);
              Navigator.pushNamed(context, '/mydoc');
            },
            title: Row(
              children: [
                CountryFlag.fromCountryCode(
                  'us',
                  height: MediaQuery.of(context).size.width * .07,
                  width: MediaQuery.of(context).size.width * .07,
                  borderRadius: 8,
                ),
                SizedBox(width: 5),
                Text(
                  'USA',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Red Hat Display',
                      color: thirdPrimaryColor),
                ),
              ],
            ),
              trailing: isSelected ? Icon(
                Boxicons.bx_circle,
                size: 20,
              ) : null
          ),
          ListTile(
            //    leading: Icon(BoxIcons.bx_edit),
            onTap: () {
              Navigator.pushNamed(context, '/mydoc');
            },
            title: Row(
              children: [
                CountryFlag.fromCountryCode(
                  'ca',
                  height: MediaQuery.of(context).size.width * .07,
                  width: MediaQuery.of(context).size.width * .07,
                  borderRadius: 8,
                ),
                SizedBox(width: 5),
                Text(
                  'Canada',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Red Hat Display',
                      color: thirdPrimaryColor),
                ),
              ],
            ),
              trailing: isSelected ? Icon(
                Boxicons.bx_circle,
                size: 20,
              ) : null
          ),
          ListTile(
            //    leading: Icon(BoxIcons.bx_edit),
            onTap: () {
              var locale = Locale('de', 'DE');
              Get.updateLocale(locale);
              Navigator.pushNamed(context, '/mydoc');
            },
            title: Row(
              children: [
                CountryFlag.fromCountryCode(
                  'de',
                  height: MediaQuery.of(context).size.width * .07,
                  width: MediaQuery.of(context).size.width * .07,
                  borderRadius: 8,
                ),
                SizedBox(width: 5),
                Text(
                  'Germany',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Red Hat Display',
                      color: thirdPrimaryColor),
                ),
              ],
            ),
              trailing: isSelected ? Icon(
                Boxicons.bx_circle,
                size: 20,
              ) : null
          ),
          ListTile(
            //    leading: Icon(BoxIcons.bx_edit),
            onTap: () {
              var locale = Locale('it', 'IT');
              Get.updateLocale(locale);
              Navigator.pushNamed(context, '/mydoc');
            },
            title: Row(
              children: [
                CountryFlag.fromCountryCode(
                  'it',
                  height: MediaQuery.of(context).size.width * .07,
                  width: MediaQuery.of(context).size.width * .07,
                  borderRadius: 8,
                ),
                SizedBox(width: 5),
                Text(
                  'Italy',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Red Hat Display',
                      color: thirdPrimaryColor),
                ),
              ],
            ),
              trailing: isSelected ? Icon(
                Boxicons.bx_circle,
                size: 20,
              ) : null
          ),
          ListTile(
            //    leading: Icon(BoxIcons.bx_edit),
            onTap: () {
              var locale = Locale('fr', 'FR');
              Get.updateLocale(locale);
              Navigator.pushNamed(context, '/mydoc');
            },
            title: Row(
              children: [
                CountryFlag.fromCountryCode(
                  'fr',
                  height: MediaQuery.of(context).size.width * .07,
                  width: MediaQuery.of(context).size.width * .07,
                  borderRadius: 8,
                ),
                SizedBox(width: 5),
                Text(
                  'France',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Red Hat Display',
                      color: thirdPrimaryColor),
                ),
              ],
            ),
              trailing: isSelected ? Icon(
                Boxicons.bx_circle,
                size: 20,
              ) : null
          ),
          ListTile(
            //    leading: Icon(BoxIcons.bx_edit),
            onTap: () {
              var locale = Locale('es', 'ES');
              Get.updateLocale(locale);
              Navigator.pushNamed(context, '/mydoc');
            },
            title: Row(
              children: [
                CountryFlag.fromCountryCode(
                  'es',
                  height: MediaQuery.of(context).size.width * .07,
                  width: MediaQuery.of(context).size.width * .07,
                  borderRadius: 8,
                ),
                SizedBox(width: 5),
                Text(
                  'Spain',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Red Hat Display',
                      color: thirdPrimaryColor),
                ),
              ],
            ),
            trailing: isSelected ? Icon(
              Boxicons.bx_circle,
              size: 20,
            ) : null
          ),
          ListTile(
            //    leading: Icon(BoxIcons.bx_edit),
            onTap: () {
              var locale = Locale('tr', 'TR');
              Get.updateLocale(locale);
              Navigator.pushNamed(context, '/mydoc');
            },
            title: Row(
              children: [
                CountryFlag.fromCountryCode(
                  'tr',
                  height: MediaQuery.of(context).size.width * .07,
                  width: MediaQuery.of(context).size.width * .07,
                  borderRadius: 8,
                ),
                SizedBox(width: 5),
                Text(
                  'Turkey',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Red Hat Display',
                      color: thirdPrimaryColor),
                ),
              ],
            ),
              trailing: isSelected ? Icon(
                Boxicons.bx_circle,
                size: 20,
              ) : null
          ),
          ListTile(
            //    leading: Icon(BoxIcons.bx_edit),
            onTap: () {
              var locale = Locale('HI');
              Get.updateLocale(locale);
              Navigator.pushNamed(context, '/mydoc');
            },
            title: Row(
              children: [
                CountryFlag.fromCountryCode(
                  'in',
                  height: MediaQuery.of(context).size.width * .07,
                  width: MediaQuery.of(context).size.width * .07,
                  borderRadius: 8,
                ),
                SizedBox(width: 5),
                Text(
                  'India',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Red Hat Display',
                      color: thirdPrimaryColor),
                ),
              ],
            ),
              trailing: isSelected ? Icon(
                Boxicons.bx_circle,
                size: 20,
              ) : null
          ),
          ListTile(
            //    leading: Icon(BoxIcons.bx_edit),
            onTap: () {
              var locale = Locale('ZH');
              Get.updateLocale(locale);
              Navigator.pushNamed(context, '/mydoc');
            },
            title: Row(
              children: [
                CountryFlag.fromCountryCode(
                  'cn',
                  height: MediaQuery.of(context).size.width * .07,
                  width: MediaQuery.of(context).size.width * .07,
                  borderRadius: 8,
                ),
                SizedBox(width: 5),
                Text(
                  'China',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Red Hat Display',
                      color: thirdPrimaryColor),
                ),
              ],
            ),
              trailing: isSelected ? Icon(
                Boxicons.bx_circle,
                size: 20,
              ) : null
          ),
        ],
      ),
    );
  }
}