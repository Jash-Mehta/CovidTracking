import 'package:covid_tracking/cubit/sendingdata_cubit.dart';
import 'package:covid_tracking/data/firebasedata.dart';
import 'package:covid_tracking/widget/maindrawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IntroductionScreen extends StatefulWidget {
  const IntroductionScreen({Key? key}) : super(key: key);

  @override
  _IntroductionScreenState createState() => _IntroductionScreenState();
}

  var intronames;
class _IntroductionScreenState extends State<IntroductionScreen> {
  TextEditingController _controllername = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.white,
            title: const Text(
              "INTRODUCTION",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            elevation: 0.0,
            centerTitle: true,
            leading: IconButton(
                onPressed: () {},
                icon: const Icon(
                  CupertinoIcons.back,
                  color: Colors.black,
                ))),
        body: SafeArea(
            child: SingleChildScrollView(
                child: BlocProvider<SendingdataCubit>(
                    create: (context) => SendingdataCubit(),
                    child: BlocBuilder<SendingdataCubit, SendingdataInitial>(
                        builder: (context, state) {
                      return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Container(
                                margin: const EdgeInsets.only(top: 20.0),
                                child: const Text(
                                  "WELCOME",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 34.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 50.0,
                            ),
                            const Center(
                                child: CircleAvatar(
                              radius: 60,
                              backgroundColor: Colors.grey,
                            )),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Container(
                                margin: const EdgeInsets.only(
                                    top: 30.0, left: 20.0),
                                child: const Text(
                                  "ENTER YOUR NAME",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0),
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(
                                  top: 15.0, left: 15.0, right: 15.0),
                              child: TextFormField(
                                keyboardType: TextInputType.name,
                                style: const TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                  counter: const Offstage(),
                                  hintText: "JASH MEHTA",
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.black, width: 2.0),
                                      borderRadius:
                                          BorderRadius.circular(10.0)),
                                  hintStyle: const TextStyle(
                                      color: Colors.black54, fontSize: 20.0),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: const BorderSide(
                                        color: Colors.black, width: 2.0),
                                  ),
                                ),
                                controller: _controllername,
                                onChanged: (value) {
                                  // _validate = true;
                                  intronames = value;
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 30.0,
                            ),
                            Center(
                                child: ElevatedButton(
                                    onPressed: () {
                                      BlocProvider.of<SendingdataCubit>(context)
                                          .userdata();
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => MainDrawer()));
                                    },
                                    style: ButtonStyle(
                                        elevation:
                                            MaterialStateProperty.all<double>(
                                                10.0),
                                        shadowColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.black87),
                                        side: MaterialStateProperty.all(
                                            const BorderSide(
                                                color: Colors.black,
                                                width: 1.5)),
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.white)),
                                    /**
                                                                             * ! Responsive is left......
                                                                             */
                                    child: const SizedBox(
                                      height: 50.0,
                                      width: 338.0,
                                      child: Center(
                                          child: Text(
                                        "NEXT",
                                        style: TextStyle(color: Colors.black),
                                      )),
                                    )))
                          ]);
                    })))));
  }
}
