import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
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
    required this.result,
    required this.name,
    required this.points,
    required this.classProd,
    required this.socket,
    required this.clockspeed,
    required this.turbospeed,
    required this.core,
    required this.threads,
    required this.cache,
    required this.avgmark,
  }) : super(key: key);

  final String result;
  final String name;
  final String classProd;
  final String socket;
  final String clockspeed;
  final String turbospeed;
  final String core;
  final String threads;
  final String cache;
  final double points;
  final double avgmark;

  @override
  State<BenchmarkDetailPage> createState() => _MyHomePageState();
}

class _SalesData extends State<BenchmarkDetailPage> {
  _SalesData(this.name, this.score);

  final String name;
  final double score;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

class _MyHomePageState extends State<BenchmarkDetailPage> {

  List<Product> productDetailList = [];


  @override
  initState() {
    super.initState();
    print("initState Called");
  }




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
                Navigator.pop(context);
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
                widget.result == '0' ? Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            padding: EdgeInsets.all(8),
                            child: Row(
                              children: [
                                Text('Class: ', style: CustomStyle.headlineTextStyle,),
                                Text(widget.classProd, style: CustomStyle.thirdTextStyle,),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(8),
                            child: Row(
                              children: [
                                Text('Socket: ', style: CustomStyle.headlineTextStyle,),
                                Text(widget.socket, style: CustomStyle.thirdTextStyle,),
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
                                Text(widget.clockspeed, style: CustomStyle.thirdTextStyle,),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(8),
                            child: Row(
                              children: [
                                Text('Turbo Speed: ', style: CustomStyle.headlineTextStyle,),
                                Text(widget.turbospeed, style: CustomStyle.thirdTextStyle,),
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
                                Text(widget.core, style: CustomStyle.thirdTextStyle,),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(8),
                            child: Row(
                              children: [
                                Text('Threads: ', style: CustomStyle.headlineTextStyle,),
                                Text(widget.threads, style: CustomStyle.thirdTextStyle,),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Text('Cache Size', style: CustomStyle.headlineTextStyle,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(8),
                              child: Text(widget.cache, style: CustomStyle.thirdTextStyle,
                                overflow: TextOverflow.fade,
                              ),
                            ),
                          ),
                        ],
                      ),

                      Divider(
                        color: Colors.grey,
                        thickness: 0,
                      ),
                    ],
                  ) : SizedBox.shrink(),

                  widget.result == '3' ?
                  Container(
                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance.collection('referenceGpu').snapshots(),
                      builder: (context,
                          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {

                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        List<_SalesData> GpuData = [
                          _SalesData(snapshot.data!.docs[0]['gpuName'], double.parse(snapshot.data!.docs[0]['gpuPoint'].toString())),
                          _SalesData(snapshot.data!.docs[1]['gpuName'], double.parse(snapshot.data!.docs[1]['gpuPoint'].toString())),
                          _SalesData(snapshot.data!.docs[2]['gpuName'], double.parse(snapshot.data!.docs[2]['gpuPoint'].toString())),
                          _SalesData(snapshot.data!.docs[3]['gpuName'], double.parse(snapshot.data!.docs[3]['gpuPoint'].toString())),
                          _SalesData(snapshot.data!.docs[4]['gpuName'], double.parse(snapshot.data!.docs[4]['gpuPoint'].toString())),
                          _SalesData(snapshot.data!.docs[5]['gpuName'], double.parse(snapshot.data!.docs[5]['gpuPoint'].toString())),
                          _SalesData(snapshot.data!.docs[6]['gpuName'], double.parse(snapshot.data!.docs[6]['gpuPoint'].toString())),
                          _SalesData(snapshot.data!.docs[7]['gpuName'], double.parse(snapshot.data!.docs[7]['gpuPoint'].toString())),
                          _SalesData(snapshot.data!.docs[8]['gpuName'], double.parse(snapshot.data!.docs[8]['gpuPoint'].toString())),
                          _SalesData('🟨'+widget.name.substring(0,16), widget.points),
                        ];

                        return SfCartesianChart(
                            primaryXAxis: CategoryAxis(),
                            // Chart title
                            title: ChartTitle(text: 'En iyi 10 Populer GPU', textStyle: CustomStyle.titleTextStyle),
                            // Enable legend
                            legend: Legend(isVisible: false, textStyle: CustomStyle.titleTextStyle),
                            // Enable tooltip
                            tooltipBehavior: TooltipBehavior(enable: true),
                            series: <ChartSeries<_SalesData, String>>[
                              BarSeries<_SalesData, String>(
                                  dataSource: GpuData,
                                  xValueMapper: (_SalesData sales, _) => sales.name, color: price,
                                  yValueMapper: (_SalesData sales, _) => sales.score, borderRadius: BorderRadius.only(topRight: Radius.circular(25)),
                                  name: 'Score',
                                  // Enable data label
                                  dataLabelSettings: DataLabelSettings(isVisible: true, textStyle: CustomStyle.titleTextStyle),
                              )
                            ]);
                      }
                    ),
                  ) :
                  widget.result == '0' ?
                  Container(
                    child: StreamBuilder(
                        stream: FirebaseFirestore.instance.collection('referenceCpu').snapshots(),
                        builder: (context,
                            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {

                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          List<_SalesData> CpuData = [
                            _SalesData(snapshot.data!.docs[0]['cpuName'], double.parse(snapshot.data!.docs[0]['cpuPoint'].toString())),
                            _SalesData(snapshot.data!.docs[1]['cpuName'], double.parse(snapshot.data!.docs[1]['cpuPoint'].toString())),
                            _SalesData(snapshot.data!.docs[2]['cpuName'], double.parse(snapshot.data!.docs[2]['cpuPoint'].toString())),
                            _SalesData(snapshot.data!.docs[3]['cpuName'], double.parse(snapshot.data!.docs[3]['cpuPoint'].toString())),
                            _SalesData(snapshot.data!.docs[4]['cpuName'], double.parse(snapshot.data!.docs[4]['cpuPoint'].toString())),
                            _SalesData(snapshot.data!.docs[5]['cpuName'], double.parse(snapshot.data!.docs[5]['cpuPoint'].toString())),
                            _SalesData(snapshot.data!.docs[6]['cpuName'], double.parse(snapshot.data!.docs[6]['cpuPoint'].toString())),
                            _SalesData(snapshot.data!.docs[7]['cpuName'], double.parse(snapshot.data!.docs[7]['cpuPoint'].toString())),
                            _SalesData(snapshot.data!.docs[8]['cpuName'], double.parse(snapshot.data!.docs[8]['cpuPoint'].toString())),
                            _SalesData('🟨'+widget.name.substring(0,16), widget.points),
                          ];

                          return SfCartesianChart(
                              primaryXAxis: CategoryAxis(),
                              // Chart title
                              title: ChartTitle(text: 'En iyi 10 Populer CPU', textStyle: CustomStyle.titleTextStyle),
                              // Enable legend
                              legend: Legend(isVisible: false, textStyle: CustomStyle.titleTextStyle),
                              // Enable tooltip
                              tooltipBehavior: TooltipBehavior(enable: true),
                              series: <ChartSeries<_SalesData, String>>[
                                BarSeries<_SalesData, String>(
                                  dataSource: CpuData,
                                  xValueMapper: (_SalesData sales, _) => sales.name, color: price,
                                  yValueMapper: (_SalesData sales, _) => sales.score, borderRadius: BorderRadius.only(topRight: Radius.circular(25)),
                                  name: 'Score',
                                  // Enable data label
                                  dataLabelSettings: DataLabelSettings(isVisible: true, textStyle: CustomStyle.titleTextStyle),
                                )
                              ]);
                        }
                    ),
                  ) : SizedBox.shrink(),

                  Divider(
                    color: Colors.grey,
                    thickness: 0,
                  ),

                  widget.result == '3' ?
                  Container(
                    child: StreamBuilder(
                        stream: FirebaseFirestore.instance.collection('referenceGPUcompare').snapshots(),
                        builder: (context,
                            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {

                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          List<_SalesData> GpuData = [
                            _SalesData(snapshot.data!.docs[0]['gpuName'], double.parse(snapshot.data!.docs[0]['gpuPoint'].toString())),
                            _SalesData(snapshot.data!.docs[1]['gpuName'], double.parse(snapshot.data!.docs[1]['gpuPoint'].toString())),
                            _SalesData(snapshot.data!.docs[2]['gpuName'], double.parse(snapshot.data!.docs[2]['gpuPoint'].toString())),
                            _SalesData(snapshot.data!.docs[3]['gpuName'], double.parse(snapshot.data!.docs[3]['gpuPoint'].toString())),
                            _SalesData(snapshot.data!.docs[4]['gpuName'], double.parse(snapshot.data!.docs[4]['gpuPoint'].toString())),
                            _SalesData('🟩'+widget.name.substring(0,16), widget.avgmark),
                          ];

                          return SfCartesianChart(
                              primaryXAxis: CategoryAxis(),
                              // Chart title
                              title: ChartTitle(text: 'GPU Value (Fiyat/Performans)', textStyle: CustomStyle.titleTextStyle),
                              // Enable legend
                              legend: Legend(isVisible: false, textStyle: CustomStyle.titleTextStyle),
                              // Enable tooltip
                              tooltipBehavior: TooltipBehavior(enable: true),
                              series: <ChartSeries<_SalesData, String>>[
                                BarSeries<_SalesData, String>(
                                  dataSource: GpuData,
                                  xValueMapper: (_SalesData sales, _) => sales.name, color: defaultStatus,
                                  yValueMapper: (_SalesData sales, _) => sales.score, borderRadius: BorderRadius.only(topRight: Radius.circular(25)),
                                  name: 'Score',
                                  // Enable data label
                                  dataLabelSettings: DataLabelSettings(isVisible: true, textStyle: CustomStyle.titleTextStyle),
                                )
                              ]);
                        }
                    ),
                  ) :
                  widget.result == '0' ?
                  Container(
                    child: StreamBuilder(
                        stream: FirebaseFirestore.instance.collection('referenceCPUcompare').snapshots(),
                        builder: (context,
                            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {

                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          List<_SalesData> CpuData = [
                            _SalesData(snapshot.data!.docs[0]['cpuName'], double.parse(snapshot.data!.docs[0]['cpuPoint'].toString())),
                            _SalesData(snapshot.data!.docs[1]['cpuName'], double.parse(snapshot.data!.docs[1]['cpuPoint'].toString())),
                            _SalesData(snapshot.data!.docs[2]['cpuName'], double.parse(snapshot.data!.docs[2]['cpuPoint'].toString())),
                            _SalesData(snapshot.data!.docs[3]['cpuName'], double.parse(snapshot.data!.docs[3]['cpuPoint'].toString())),
                            _SalesData(snapshot.data!.docs[4]['cpuName'], double.parse(snapshot.data!.docs[4]['cpuPoint'].toString())),
                            _SalesData('🟩'+widget.name.substring(0,16), widget.avgmark),
                          ];

                          return SfCartesianChart(
                              primaryXAxis: CategoryAxis(),
                              // Chart title
                              title: ChartTitle(text: 'CPU Value (Fiyat/Performans)', textStyle: CustomStyle.titleTextStyle),
                              // Enable legend
                              legend: Legend(isVisible: false, textStyle: CustomStyle.titleTextStyle),
                              // Enable tooltip
                              tooltipBehavior: TooltipBehavior(enable: true),
                              series: <ChartSeries<_SalesData, String>>[
                                BarSeries<_SalesData, String>(
                                  dataSource: CpuData,
                                  xValueMapper: (_SalesData sales, _) => sales.name, color: defaultStatus,
                                  yValueMapper: (_SalesData sales, _) => sales.score, borderRadius: BorderRadius.only(topRight: Radius.circular(25)),
                                  name: 'Score',
                                  // Enable data label
                                  dataLabelSettings: DataLabelSettings(isVisible: true, textStyle: CustomStyle.titleTextStyle),
                                )
                              ]);
                        }
                    ),
                  ) : SizedBox.shrink()
                  
                ],
              ),
            ),
          ),
        )
    );
  }
}

