import 'dart:async';
import 'dart:convert';

import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:get/get.dart';
import 'package:pc_building_simulator/Model/product.dart';
import 'package:pc_building_simulator/Network/Api/ApiService.dart';
import 'package:pc_building_simulator/Screens/SystemBenchmarkScreen.dart';
import 'package:pc_building_simulator/Utils/Globals.dart';
import 'package:pc_building_simulator/Utils/colors.dart';
import 'package:pc_building_simulator/Utils/common.dart';
import 'package:pc_building_simulator/Utils/images.dart';
import 'package:pc_building_simulator/Widgets/CategoryCard.dart';
import 'package:pc_building_simulator/Widgets/DeviceCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';


class BenchmarkDetailPage extends StatefulWidget {
  BenchmarkDetailPage({
    Key? key,
    this.result,
    required this.name,
    required this.points,
  }) : super(key: key);

  final result;
  String name;
  double points;

  @override
  State<BenchmarkDetailPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<BenchmarkDetailPage> {

  List<Product> productDetailList = [];


  @override
  initState() {
    super.initState();
    print("initState Called");
  }


  List<_SalesData> data = [
    _SalesData('Ryzen 9 7900X3D', 9205),
    _SalesData('Ryzen 9 7800X3D', 9085),
    _SalesData('i9 14900KF', 8829),
    _SalesData('Ryzen 9 7950X3D', 8430),
    _SalesData('Ryzen 5 5600X3D', 7831),
    _SalesData('i9 13900KF', 7529),
    _SalesData('Ryzen 5 5800X3D', 7248),
    _SalesData('e', 4143),
  ];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: primaryColor,
        appBar: AppBar(
          title: Text(widget.name, style: CustomStyle.boldTitleTextStyle,),
          elevation: 1,
          leading: IconButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const BenchmarkPage()));
              },
              icon:Icon(Boxicons.bxs_chevron_left, color: secondaryPrimaryColor,)
          ),
          centerTitle: true,
          backgroundColor: primaryColor,
        ),
        body: Container(
          width: double.infinity,
          child: SingleChildScrollView(
            child: SizedBox(
              height: size.height,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        padding: EdgeInsets.all(8),
                        child: Row(
                          children: [
                            Text('Class: ', style: CustomStyle.headlineTextStyle,),
                            Text('Desktop', style: CustomStyle.thirdTextStyle,),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(8),
                        child: Row(
                          children: [
                            Text('Socket: ', style: CustomStyle.headlineTextStyle,),
                            Text('AM4', style: CustomStyle.thirdTextStyle,),
                          ],
                        ),
                      ),
                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        padding: EdgeInsets.all(8),
                        child: Row(
                          children: [
                            Text('Clockspeed: ', style: CustomStyle.headlineTextStyle,),
                            Text('3.4 GHz', style: CustomStyle.thirdTextStyle,),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(8),
                        child: Row(
                          children: [
                            Text('Turbo Speed: ', style: CustomStyle.headlineTextStyle,),
                            Text('4.9 GHz', style: CustomStyle.thirdTextStyle,),
                          ],
                        ),
                      ),
                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        padding: EdgeInsets.all(8),
                        child: Row(
                          children: [
                            Text('Cores: ', style: CustomStyle.headlineTextStyle,),
                            Text('16', style: CustomStyle.thirdTextStyle,),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(8),
                        child: Row(
                          children: [
                            Text('Threads: ', style: CustomStyle.headlineTextStyle,),
                            Text('32', style: CustomStyle.thirdTextStyle,),
                          ],
                        ),
                      ),
                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        padding: EdgeInsets.all(8),
                        child: Row(
                          children: [
                            Text('Cache Size: ', style: CustomStyle.headlineTextStyle,),
                            Text('L1: 1024 KB, L2: 8.0 MB, L3: 64 MB', style: CustomStyle.thirdTextStyle,),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    color: Colors.grey,
                    thickness: 0,
                  ),
                  Container(
                    child: SfCartesianChart(
                        primaryXAxis: CategoryAxis(),
                        // Chart title
                        title: ChartTitle(text: 'gamingscore'.tr, textStyle: CustomStyle.titleTextStyle),
                        // Enable legend
                        legend: Legend(isVisible: false, textStyle: CustomStyle.titleTextStyle),
                        // Enable tooltip
                        tooltipBehavior: TooltipBehavior(enable: true),
                        series: <ChartSeries<_SalesData, String>>[
                          BarSeries<_SalesData, String>(
                              dataSource: data,
                              xValueMapper: (_SalesData sales, _) => sales.name, color: price,
                              yValueMapper: (_SalesData sales, _) => sales.score, borderRadius: BorderRadius.only(topRight: Radius.circular(25)),
                              name: 'Score',
                              // Enable data label
                              dataLabelSettings: DataLabelSettings(isVisible: true, textStyle: CustomStyle.titleTextStyle),
                          )
                        ]),
                  ),
                  Divider(
                    color: Colors.grey,
                    thickness: 0,
                  ),
                  Container(
                    child: SfCartesianChart(
                        primaryXAxis: CategoryAxis(),
                        // Chart title
                        title: ChartTitle(text: 'singlethread'.tr, textStyle: CustomStyle.titleTextStyle),
                        // Enable legend
                        legend: Legend(isVisible: false, textStyle: CustomStyle.titleTextStyle),
                        // Enable tooltip
                        tooltipBehavior: TooltipBehavior(enable: true),
                        series: <ChartSeries<_SalesData, String>>[
                          BarSeries<_SalesData, String>(
                            dataSource: data,
                            xValueMapper: (_SalesData sales, _) => sales.name, color: defaultStatus,
                            yValueMapper: (_SalesData sales, _) => sales.score, borderRadius: BorderRadius.only(topRight: Radius.circular(25)),
                            name: 'Score',
                            // Enable data label
                            dataLabelSettings: DataLabelSettings(isVisible: true, textStyle: CustomStyle.titleTextStyle),
                          )
                        ]),
                  ),

                ],
              ),
            ),
          ),
        )
    );
  }
}

class _SalesData {
  _SalesData(this.name, this.score);

  final String name;
  final double score;
}