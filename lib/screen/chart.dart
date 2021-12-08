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
      appBar: AppBar(
          title: const Text(
            "Covid Tracking",
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0.0,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                CupertinoIcons.back,
                color: Colors.black,
              ))),
      backgroundColor: Colors.white,
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
                      Container(
                          height: 300.0,
                          width: 383.0,
                          margin: EdgeInsets.only(
                              left: 10.0, right: 10.0, top: 10.0),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0xDD000000),
                                  offset: Offset(
                                    5.0,
                                    5.0,
                                  ),
                                  blurRadius: 10.0,
                                  spreadRadius: 2.0,
                                ), //BoxShadow
                                BoxShadow(
                                  color: Colors.white,
                                  offset: Offset(0.0, 0.0),
                                  blurRadius: 0.0,
                                  spreadRadius: 0.0,
                                ), //BoxShadow
                              ],
                              borderRadius: BorderRadius.circular(15.0)),
                          child: Stack(
                            children: [
                              Container(
                                height: 350.0,
                                width: 350.0,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                  fit: BoxFit.cover,
                                  colorFilter: ColorFilter.mode(
                                      Colors.white.withOpacity(0.7),
                                      BlendMode.dstATop),
                                  image: AssetImage('assets/d2.png'),
                                )),
                              ),
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
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
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
            height: 20.0,
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => MapScreen()));
              },
              style: ButtonStyle(
                  elevation: MaterialStateProperty.all<double>(10.0),
                  shadowColor: MaterialStateProperty.all<Color>(Colors.black87),
                  side: MaterialStateProperty.all(
                      BorderSide(color: Colors.black, width: 1.5)),
                  backgroundColor: MaterialStateProperty.all(Colors.white)),
              child: Container(
                height: 50.0,
                width: 338.0,
                child: Center(
                    child: Text(
                  "NEXT",
                  style: TextStyle(color: Colors.black),
                )),
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
