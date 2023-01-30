import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:serenity/common/color.dart';
import 'package:serenity/repository/report_repository.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'dart:io';

import '../bloc/blocReport/bloc/report_bloc.dart';
import '../bloc/bloc_exports.dart';
import '../routes/Routes.dart';

class DashBoardPage extends StatefulWidget {
  const DashBoardPage({super.key});

  @override
  State<DashBoardPage> createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  TooltipBehavior? _tooltipBehavior;
  @override
  void initState() {
    _tooltipBehavior =
        TooltipBehavior(enable: true, header: '', canShowMarker: false);
    super.initState();
  }
  // final List<ChartData> chartData = [
  //           ChartData('David', 25, Colors.red),
  //           ChartData('Steve', 38,Colors.yellow),
  //           ChartData('Jack', 34,Colors.green),
  //           ChartData('Others', 52,Colors.pink)
  //       ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<ReportBloc, ReportState>(
          builder: (context, state) {
            if(state is ReportLoading){
              return const Center(child: CircularProgressIndicator());
            }
            else if(state is ReportLoaded){
              return Container(
              color: const Color(0xFFDDF9E8),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 30),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Analysis", style: TextStyle(color: CustomColor.second,fontSize: 30, fontWeight: FontWeight.bold),)),
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Container(
                            height: 160,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20)
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.shopping_cart,color: CustomColor.second,size: 40,),
                                Text(state.orders, style: TextStyle(fontSize: 36,color: CustomColor.second,fontWeight: FontWeight.bold),),
                                Text("Orders",style: TextStyle(fontSize: 18,color: CustomColor.second,fontWeight: FontWeight.w500))
                              ],
                            ),),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Container(
                            height: 160,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20)
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.person,color: CustomColor.second,size: 40,),
                                Text(state.customer, style: TextStyle(fontSize: 36,color: CustomColor.second,fontWeight: FontWeight.bold),),
                                Text("Customers",style: TextStyle(fontSize: 18,color: CustomColor.second,fontWeight: FontWeight.w500))
                              ],
                            ),),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Container(
                            height: 160,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20)
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.payments,color: CustomColor.second,size: 40,),
                                Text(state.revenue, style: TextStyle(fontSize: 36,color: CustomColor.second,fontWeight: FontWeight.bold),),
                                Text("Revenue",style: TextStyle(fontSize: 18,color: CustomColor.second,fontWeight: FontWeight.w500))
                              ],
                            ),),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Container(
                            height: 160,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20)
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.stacked_line_chart,color: CustomColor.second,size: 40,),
                                Text(state.profit, style: TextStyle(fontSize: 36,color: CustomColor.second,fontWeight: FontWeight.bold),),
                                Text("Profit",style: TextStyle(fontSize: 18,color: CustomColor.second,fontWeight: FontWeight.w500))
                              ],
                            ),),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 60,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      children: [
                        // ElevatedButton(onPressed: ()async{
                        //   final products=FirebaseFirestore.instance.collection("Product");
                        //   final String response = await rootBundle.loadString('assets/data.json');
                        //   final data = await json.decode(response);
                        //   data['product'].forEach((e){
                        //     products.add({
                        //       "name":e['name'],
                        //       "price":e['price'].toString(),
                        //       "content":e['content'],
                        //       "image":e['image'],
                        //       "category":e['category'],
                        //       "amount":e['amount'].toString(),
                        //       "historicalCost":e['historicalCost'].toString(),
                        //     }).then((value) {
                        //       products.doc(value.id).update({"idProduct":value.id});
                        //     });
                        //   });
                        // }, child: Text("Push data")),
                        Expanded(
                          flex: 2,
                          child: Container(
                            decoration: BoxDecoration(color: Colors.white,
                            borderRadius: BorderRadius.circular(15)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 50),
                              child: _buildDefaultColumnChart(state.dataColumn),
                            ))),
                            const SizedBox(width:20),
                        Expanded(
                          flex: 1,
                          child: Container(
                            decoration: BoxDecoration(color: Colors.white,
                            borderRadius: BorderRadius.circular(15)
                            ),
                            child: state.dataPie.length>4?Padding(
                              padding: const EdgeInsets.symmetric(vertical: 50),
                              child: _buildDefaultPieChart(state.dataPie),
                            ):const Center(child:Text("no data"))))
                        // Container(
                        //   child: SfCircularChart(
                            
                        //       series: <CircularSeries>[

                        //           // Render pie chart
                        //           PieSeries<ChartData, String>(
                        //               dataSource: chartData,
                        //               pointColorMapper:(ChartData data, _) => data.color,
                        //               xValueMapper: (ChartData data, _) => data.x,
                        //               yValueMapper: (ChartData data, _) => data.y
                        //           )
                        //       ]
                        //   ))
                      ],
                    ),
                  ),
                ],
              ),
            );
            }
            else{
              return Container();
            }
          },
        ),
      ),
    );
  }

  SfCartesianChart _buildDefaultColumnChart(List<ChartSampleData> data) {
    return SfCartesianChart(
      // backgroundColor: Colors.white,
      plotAreaBorderWidth: 0,
      title: ChartTitle(
          text: true ? 'Revenue Chart' : 'Population growth of various countries'),
      primaryXAxis: CategoryAxis(
        majorGridLines: const MajorGridLines(width: 0),
      ),
      primaryYAxis: NumericAxis(
          axisLine: const AxisLine(width: 0),
          labelFormat: '{value}đ',
          majorTickLines: const MajorTickLines(size: 0)),
      series: _getDefaultColumnSeries(data),
      tooltipBehavior: _tooltipBehavior,
    );
  }

  /// Get default column series
  List<ColumnSeries<ChartSampleData, String>> _getDefaultColumnSeries(List<ChartSampleData> data) {
    return <ColumnSeries<ChartSampleData, String>>[
      ColumnSeries<ChartSampleData, String>(
        // dataSource: <ChartSampleData>[
        //   ChartSampleData(x: 'China', y: 0.541),
        //   ChartSampleData(x: 'Brazil', y: 0.818),
        //   ChartSampleData(x: 'Bolivia', y: 1.51),
        //   ChartSampleData(x: 'Mexico', y: 1.302),
        //   ChartSampleData(x: 'Egypt', y: 2.017),
        //   ChartSampleData(x: 'Mongolia', y: 1.683),
        // ],
        dataSource: data,
        xValueMapper: (ChartSampleData sales, _) => sales.x,
        yValueMapper: (ChartSampleData sales, _) => sales.y,
        pointColorMapper: (ChartSampleData sales, _) => CustomColor.second,
        dataLabelSettings: const DataLabelSettings(
            isVisible: true, textStyle: TextStyle(fontSize: 10)),
      )
    ];
  }
  // SfCircularChart _buildRadiusPieChart() {
  //   return SfCircularChart(
  //     title: ChartTitle(
  //         text: true
  //             ? ''
  //             : 'Various countries population density and area'),
  //     legend: Legend(
  //         isVisible: !true, overflowMode: LegendItemOverflowMode.wrap),
  //     series: _getRadiusPieSeries(),
  //     onTooltipRender: (TooltipArgs args) {
  //       final NumberFormat format = NumberFormat.decimalPattern();
  //       args.text = args.dataPoints![args.pointIndex!.toInt()].x.toString() +
  //           ' : ' +
  //           format.format(args.dataPoints![args.pointIndex!.toInt()].y);
  //     },
  //     tooltipBehavior: TooltipBehavior(enable: true),
  //   );
  // }

  // /// Returns the pie series.
  // List<PieSeries<ChartSampleData1, String>> _getRadiusPieSeries() {
  //   return <PieSeries<ChartSampleData1, String>>[
  //     PieSeries<ChartSampleData1, String>(
  //         dataSource: <ChartSampleData1>[
  //           ChartSampleData1(x: 'Argentina', y: 8, text: '45%'),
  //           ChartSampleData1(x: 'Belgium', y: 2, text: '53.7%'),
  //           ChartSampleData1(x: 'Cuba', y: 2, text: '59.6%'),
  //           ChartSampleData1(x: 'Dominican Republic', y: 3, text: '72.5%'),
  //           ChartSampleData1(x: 'Egypt', y: 4, text: '85.8%'),
  //           ChartSampleData1(x: 'Kazakhstan', y: 5, text: '90.5%'),
  //           ChartSampleData1(x: 'Somalia', y: 3, text: '95.6%')
  //         ],
  //         xValueMapper: (ChartSampleData1 data, _) => data.x as String,
  //         yValueMapper: (ChartSampleData1 data, _) => data.y,
  //         dataLabelMapper: (ChartSampleData1 data, _) => data.x as String,
  //         startAngle: 100,
  //         endAngle: 100,
  //         pointRadiusMapper: (ChartSampleData1 data, _) => data.text,
  //         dataLabelSettings: const DataLabelSettings(
  //             isVisible: true, labelPosition: ChartDataLabelPosition.outside))
  //   ];
  // }
  SfCircularChart _buildDefaultPieChart(List<ChartSampleData1> data) {
    return SfCircularChart(
      title: ChartTitle(text: true ? 'Top 3 Customer' : 'Sales by sales person'),
      legend: Legend(isVisible: !true),
      series: _getDefaultPieSeries(data),
    );
  }

  /// Returns the pie series.
  List<PieSeries<ChartSampleData1, String>> _getDefaultPieSeries(List<ChartSampleData1> data) {
    return <PieSeries<ChartSampleData1, String>>[
      PieSeries<ChartSampleData1, String>(
          explode: true,
          explodeIndex: 0,
          explodeOffset: '10%',
          dataSource: data,
          xValueMapper: (ChartSampleData1 data, _) => data.x,
          yValueMapper: (ChartSampleData1 data, _) => data.y,
          dataLabelMapper: (ChartSampleData1 data, _) => data.text,
          startAngle: 90,
          endAngle: 90,
          dataLabelSettings: const DataLabelSettings(isVisible: true)),
    ];
  }
}

// class ChartSampleData1 {
//         ChartSampleData1({required this.x, required this.y, required this.text});
//         final String x;
//         final double y;  
//         final String text;
//     }
// class ChartSampleData {
//   ChartSampleData({required this.x, required this.y});
//   final String x;
//   final double y;
// }
