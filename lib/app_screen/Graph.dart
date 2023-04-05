import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

import 'package:fl_chart/fl_chart.dart';

class IndividualBar {
  final int x;
  final double y;

  IndividualBar({
    required this.x,
    required this.y,
  });
}

class BarData {
  final double sunAmount;
  final double monAmount;
  final double tueAmount;
  final double wedAmount;
  final double thuAmount;

  BarData({
    required this.sunAmount,
    required this.monAmount,
    required this.tueAmount,
    required this.wedAmount,
    required this.thuAmount,
  });

  List<IndividualBar> barData = [];

  void initializeBarData() {
    barData = [
      IndividualBar(x: 1, y: sunAmount),
      IndividualBar(x: 2, y: monAmount),
      IndividualBar(x: 3, y: tueAmount),
      IndividualBar(x: 4, y: wedAmount),
      IndividualBar(x: 5, y: thuAmount),
    ];
  }
}

class MyBarGraph extends StatelessWidget {
  final List weeklySummary;
  MyBarGraph({Key? key, required this.weeklySummary}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BarData myBarData = BarData(
      sunAmount: weeklySummary[0],
      monAmount: weeklySummary[1],
      tueAmount: weeklySummary[2],
      wedAmount: weeklySummary[3],
      thuAmount: weeklySummary[4],
    );
    myBarData.initializeBarData();

    return BarChart(BarChartData(
        maxY: 30,
        minY: 0,
        barGroups: myBarData.barData
            .map((data) => BarChartGroupData(
                x: data.x, barRods: [BarChartRodData(toY: data.y)]))
            .toList()));
  }
}

class Graph extends StatefulWidget {
  final ShowGraph;
  final incrementSunAmount;
  const Graph({
    Key? key,
    required this.ShowGraph,
    required this.incrementSunAmount,
  }) : super(key: key);

  @override
  _GraphState createState() => _GraphState();
}

class _GraphState extends State<Graph> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context); // Add this line
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(243, 222, 186, 1),
        centerTitle: true,
        title: Text(
          "Your Mood",
          style: const TextStyle(
            color: Color.fromRGBO(71, 60, 51, 1),
          ),
        ),
        iconTheme: IconThemeData(
          color: Color.fromRGBO(71, 60, 51, 1),
        ),
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Container(
        color: Color.fromRGBO(169, 144, 126, 1),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.only(top: 50),
          child: Column(
            children: [
              SizedBox(
                height: 600,
                child: MyBarGraph(
                  weeklySummary: widget.ShowGraph,
                ),
              ),
              Container(
                  margin: EdgeInsets.only(
                    left: 65,
                    right: 65,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        child: Text(
                          '😄',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      Container(
                        child: Text(
                          '😢',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      Container(
                        child: Text(
                          '😭',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      Container(
                        child: Text(
                          '😍',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      Container(
                          child: Text(
                        '😡',
                        style: TextStyle(fontSize: 20),
                      )),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
//'😄''😢''😭''😍''😡'
