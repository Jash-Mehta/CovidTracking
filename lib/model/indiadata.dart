// To parse this JSON data, do
//
//     final india = indiaFromJson(jsonString);

import 'dart:convert';

India indiaFromJson(String str) => India.fromJson(json.decode(str));

String indiaToJson(India data) => json.encode(data.toJson());

class India {
    India({
        required this.statewise,
    });

    List<Statewise> statewise;

    factory India.fromJson(Map<String, dynamic> json) => India(
       
        statewise: List<Statewise>.from(json["statewise"].map((x) => Statewise.fromJson(x))),
        
    );

    Map<String, dynamic> toJson() => {
        "statewise": List<dynamic>.from(statewise.map((x) => x.toJson())),
    };
}


class Statewise {
    Statewise({
        required this.active,
        required this.confirmed,
        required this.deaths,
        required this.deltaconfirmed,
        required this.deltadeaths,
        required this.deltarecovered,
        required this.migratedother,
        required this.recovered,
        required this.state,
        required this.statecode,
        required this.statenotes,
    });

    String active;
    String confirmed;
    String deaths;
    String deltaconfirmed;
    String deltadeaths;
    String deltarecovered;
    String migratedother;
    String recovered;
    String state;
    String statecode;
    String statenotes;

    factory Statewise.fromJson(Map<String, dynamic> json) => Statewise(
        active: json["active"],
        confirmed: json["confirmed"],
        deaths: json["deaths"],
        deltaconfirmed: json["deltaconfirmed"],
        deltadeaths: json["deltadeaths"],
        deltarecovered: json["deltarecovered"],
       
        migratedother: json["migratedother"],
        recovered: json["recovered"],
        state: json["state"],
        statecode: json["statecode"],
        statenotes: json["statenotes"],
    );

    Map<String, dynamic> toJson() => {
        "active": active,
        "confirmed": confirmed,
        "deaths": deaths,
        "deltaconfirmed": deltaconfirmed,
        "deltadeaths": deltadeaths,
        "deltarecovered": deltarecovered,
       
        "migratedother": migratedother,
        "recovered": recovered,
        "state": state,
        "statecode": statecode,
        "statenotes": statenotes,
    };
}

