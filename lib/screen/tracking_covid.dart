import 'package:covid_tracking/api/api_manager.dart';
import 'package:covid_tracking/model/apidata.dart';
import 'package:covid_tracking/widget/maindrawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

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
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Covid Tracking",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () => ZoomDrawer.of(context)!.toggle(),
          icon: const Icon(
            Icons.clear_all,
            size: 35.0,
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.call,
              color: Colors.black,
              size: 30.0,
            ),
            onPressed: () {
              _launchCaller();
            },
          )
        ],
      ),
      body: SafeArea(
          child: FutureBuilder(
        future: _covidmodel,
        builder: (BuildContext context, AsyncSnapshot<Tracking> snapshot) {
          if (snapshot.hasData) {
            return Stack(children: [
              Center(
                  child: Container(
                height: 350.0,
                width: 350.0,
                decoration: BoxDecoration(
                    image: DecorationImage(
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                      Colors.white.withOpacity(0.7), BlendMode.dstATop),
                  image: AssetImage('assets/coronavirus.png'),
                )),
              )),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 30.0, top: 25.0),
                      child: Text("Covid",
                          style: GoogleFonts.redHatDisplay(
                              color: const Color(0xDD000000),
                              fontSize: 27.0,
                              fontWeight: FontWeight.bold)),
                    ),
                    Container(
                      height: 28.0,
                      width: 28.0,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(
                            Colors.white.withOpacity(0.7), BlendMode.dstATop),
                        image: AssetImage('assets/virus.png'),
                      )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 30.0, top: 25.0),
                      child: Row(children: [
                        Image.asset(
                          'assets/usaflag.png',
                          height: 28.0,
                          width: 28.0,
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Text("USA",
                            style: GoogleFonts.redHatDisplay(
                                color: Color(0xDD000000),
                                fontSize: 27.0,
                                fontWeight: FontWeight.bold)),
                      ]),
                    )
                  ],
                ),
                const SizedBox(
                  height: 40.0,
                ),
                Row(children: [
                  Container(
                    margin: const EdgeInsets.only(left: 18.0),
                    height: 200.0,
                    width: MediaQuery.of(context).size.width * 0.45,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xFFFF7043),
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
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 45.0, left: 35.0),
                          child: Text(
                            "Pending",
                            style: TextStyle(
                                color: Colors.orange,
                                fontSize: 27.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(bottom: 60.0, left: 45.0),
                          child: Text(
                            snapshot.data!.pending.toString(),
                            style: const TextStyle(
                                color: Colors.orange,
                                fontSize: 25.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 10.0),
                    height: 200.0,
                    width: MediaQuery.of(context).size.width * 0.45,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xFFEF5350),
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
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 45.0, left: 50.0),
                          child: Text(
                            "Death",
                            style: TextStyle(
                                color: Color(0xFFE53935),
                                fontSize: 27.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(bottom: 60.0, left: 45.0),
                          child: Text(
                            snapshot.data!.death.toString(),
                            style: const TextStyle(
                                color: Color(0xFFE53935),
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
                    height: 200.0,
                    width: MediaQuery.of(context).size.width * 0.45,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xFF43A047),
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
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 50.0, left: 26.0),
                          child: Text(
                            "Recovered",
                            style: TextStyle(
                                color: Colors.green,
                                fontSize: 27.0,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(bottom: 65.0, left: 30.0),
                          child: Text(
                            snapshot.data!.negative.toString(),
                            style: const TextStyle(
                                color: Colors.green,
                                fontSize: 25.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 10.0),
                    height: 200.0,
                    width: MediaQuery.of(context).size.width * 0.45,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xFF1E88E5),
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
                          blurRadius: 12.0,
                          spreadRadius: -12.0,
                        ), //BoxShadow
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 45.0, left: 50.0),
                          child: Text(
                            "Active",
                            style: TextStyle(
                                color: Colors.blue,
                                fontSize: 27.0,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(bottom: 70.0, left: 30.0),
                          child: Text(
                            snapshot.data!.positive.toString(),
                            style: const TextStyle(
                                color: Colors.blue,
                                fontSize: 25.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ]),
                const SizedBox(
                  height: 50.0,
                ),
                Center(
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) => Chart()));
                        },
                        style: ButtonStyle(
                            elevation: MaterialStateProperty.all<double>(10.0),
                            shadowColor: MaterialStateProperty.all<Color>(
                                Colors.black87),
                            side: MaterialStateProperty.all(
                                BorderSide(color: Colors.black, width: 1.5)),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.white)),
                        child: Container(
                          height: 50.0,
                          width: 338.0,
                          child: const Center(
                              child: Text(
                            "NEXT",
                            style: TextStyle(color: Colors.black),
                          )),
                        )))
              ]),
            ]);
          } else {
            return const Center(
                child: CircularProgressIndicator(color: Colors.white));
          }
        },
      )),
    );
  }

  _launchCaller() async {
    const url = "tel:7096747394";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
