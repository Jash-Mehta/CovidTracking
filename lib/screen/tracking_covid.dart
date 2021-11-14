import 'package:covid_tracking/api/api_manager.dart';
import 'package:covid_tracking/model/apidata.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'chart.dart';

class TrackingCovid extends StatefulWidget {
  const TrackingCovid({Key? key}) : super(key: key);

  @override
  _TrackingCovidState createState() => _TrackingCovidState();
}

class _TrackingCovidState extends State<TrackingCovid> {
  Future<Tracking>? _covidmodel;
  // ignore: deprecated_member_use
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
      appBar: AppBar(
        title: const Text("Covid Tracking"),
        centerTitle: true,
        backgroundColor: Colors.blue[800],
        elevation: 0.0,
        leading: const Icon(
          Icons.clear_all,
          size: 35.0,
        ),
        actions: const [
          Icon(
            Icons.notifications_active_outlined,
            size: 30.0,
          )
        ],
      ),
      body: SafeArea(
          child: FutureBuilder(
        future: _covidmodel,
        builder: (BuildContext context, AsyncSnapshot<Tracking> snapshot) {
          if (snapshot.hasData) {
            return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(left: 15.0, top: 25.0),
                        child: Text(
                          "Covid-19",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 27.0,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 15.0, top: 25.0),
                        child: Text(
                          "USA",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 27.0,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 70.0,
                  ),
                  Row(children: [
                    Container(
                      margin: const EdgeInsets.only(left: 18.0),
                      height: 130.0,
                      width: MediaQuery.of(context).size.width * 0.45,
                      decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 15.0, top: 23.0),
                            child: Text(
                              "Pedding",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 23.0),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 15.0, bottom: 20.0),
                            child: Text(
                              snapshot.data!.pending.toString(),
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 10.0),
                      height: 130.0,
                      width: MediaQuery.of(context).size.width * 0.45,
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 15.0, top: 23.0),
                            child: Text(
                              "Death",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 23.0),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 15.0, bottom: 20.0),
                            child: Text(
                              snapshot.data!.death.toString(),
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    )
                  ]),
                  const SizedBox(
                    height: 50.0,
                  ),
                  Row(children: [
                    Container(
                      margin: const EdgeInsets.only(left: 15.0),
                      height: 130.0,
                      width: MediaQuery.of(context).size.width * 0.45,
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 15.0, top: 23.0),
                            child: Text(
                              "Recovered",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 23.0),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 15.0, bottom: 20.0),
                            child: Text(
                              snapshot.data!.negative.toString(),
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 10.0),
                      height: 130.0,
                      width: MediaQuery.of(context).size.width * 0.45,
                      decoration: BoxDecoration(
                          color: Colors.lightBlue,
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 15.0, top: 23.0),
                            child: Text(
                              "Active",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 23.0),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 15.0, bottom: 20.0),
                            child: Text(
                              snapshot.data!.positive.toString(),
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]),
                  const SizedBox(
                    height: 60.0,
                  ),
                  Center(
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) => Chart()));
                          },
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.green[700])),
                          child: const SizedBox(
                            height: 50.0,
                            width: 338.0,
                            child: Center(child: Text("NEXT")),
                          )))
                ]);
          } else {
            return const Center(
                child: CircularProgressIndicator(color: Colors.white));
          }
        },
      )),
    );
  }
}
