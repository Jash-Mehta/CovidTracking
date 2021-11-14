// ignore_for_file: curly_braces_in_flow_control_structures, prefer_const_constructors

import 'package:covid_tracking/api/api_manager.dart';
import 'package:covid_tracking/maps/maps.dart';
import 'package:covid_tracking/model/apidata.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Chart extends StatefulWidget {
  const Chart({Key? key}) : super(key: key);

  @override
  _ChartState createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  Future<Tracking>? _covidmodel;
  int touchedIndex = -1;
  //  final isTouched  = touchedIndex;
  //     final fontSize = isTouched ? 25.0 : 16.0;
  //     final radius = isTouched ? 60.0 : 50.0;
  @override
  void initState() {
    // TODO: implement initState
    _covidmodel = API_Manager().getcovid();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[800],
      body: SafeArea(
        child: Column(children: [
          FutureBuilder(
              future: _covidmodel,
              builder:
                  (BuildContext context, AsyncSnapshot<Tracking> snapshot) {
                // int positives = snapshot.data!.positive % 10;
                try {
                  return Column(
                    children: <Widget>[
                      const SizedBox(
                        height: 18,
                      ),
                      Container(
                          height: 300.0,
                          width: 383.0,
                          margin: EdgeInsets.only(
                              left: 10.0, right: 10.0, top: 10.0),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15.0)),
                          child: Stack(
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 30.0),
                                child: PieChart(
                                  PieChartData(
                                    pieTouchData: PieTouchData(touchCallback:
                                        (FlTouchEvent event, pieTouchResponse) {
                                      setState(() {
                                        if (!event
                                                .isInterestedForInteractions ||
                                            pieTouchResponse == null ||
                                            pieTouchResponse.touchedSection ==
                                                null) {
                                          touchedIndex = -1;
                                          return;
                                        }
                                        touchedIndex = pieTouchResponse
                                            .touchedSection!
                                            .touchedSectionIndex;
                                      });
                                    }),
                                    borderData: FlBorderData(
                                      show: false,
                                    ),
                                    sectionsSpace: 2,
                                    centerSpaceRadius: 40,
                                    sections: showingSections(snapshot),
                                  ),
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Row(
                                    children: const [
                                      Icon(
                                        CupertinoIcons.circle_filled,
                                        color: Colors.green,
                                      ),
                                      Text(
                                        "Recovered",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w500),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Row(
                                    children: const [
                                      Icon(
                                        CupertinoIcons.circle_filled,
                                        color: Colors.red,
                                      ),
                                      Text(
                                        "Death",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w500),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Row(
                                    children: const [
                                      Icon(
                                        CupertinoIcons.circle_filled,
                                        color: Colors.blueAccent,
                                      ),
                                      Text(
                                        "Active",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w500),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Row(
                                    children: const [
                                      Icon(
                                        CupertinoIcons.circle_filled,
                                        color: Colors.yellow,
                                      ),
                                      Text(
                                        "Pendding",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  )
                                ],
                              )
                            ],
                          ))
                    ],
                  );
                } catch (e) {
                  return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        CircularProgressIndicator(color: Colors.white),
                        SizedBox(height: 20.0),
                        Center(
                          child: Text(
                            "Having some trouble to load the data.....",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ]);
                }
              }),
          SizedBox(
            height: 30.0,
          ),
          Container(
            margin: EdgeInsets.only(left: 10.0, right: 10.0),
            height: 300.0,
            width: 383.0,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                CircularProgressIndicator(color: Colors.black),
                Center(
                  child: Text(
                    "Coming Soon",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          ElevatedButton(
              onPressed: (){
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => MapScreen()));
              },
              
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Colors.green[700])),
              child: Container(
                height: 50.0,
                width: 338.0,
                child: const Center(child: Text("NEXT")),
              ))
        ]),
      ),
    );
  }

  List<PieChartSectionData> showingSections(AsyncSnapshot<Tracking> snapshots) {
    return List.generate(4, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      int positives = snapshots.data!.positive % 100;
      int negatives = snapshots.data!.negative % 100;
      int deaths = snapshots.data!.death % 100;
      int pendings = snapshots.data!.pending % 100;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: Colors.green,
            value: positives.toDouble(),
            title: '${positives.toString()}%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 1:
          return PieChartSectionData(
            color: Colors.lightBlue,
            value: negatives.toDouble(),
            title: '${negatives.toString()}%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 2:
          return PieChartSectionData(
            color: Colors.red,
            value: deaths.toDouble(),
            title: '${deaths.toString()}%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 3:
          return PieChartSectionData(
            color: Colors.orange,
            value: pendings.toDouble(),
            title: '${pendings.toString()}%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        default:
          throw Error();
      }
    });
  }
}
