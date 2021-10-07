import 'dart:async';

import 'package:covid_tracking/model/apidata.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class API_Manager {
  Future<Tracking> getcovid() async {
    var client = http.Client();
    var response = await client
        .get(Uri.parse('https://api.covidtracking.com/v1/us/current.json'));
    if (response.statusCode == 200) {
      var jsonString = response.body;
      var jsonMap = json.decode(jsonString);
      return Tracking.fromJson(jsonMap[0]);
    } else {
      throw Exception('Failed to load data');
    }
  }
}
