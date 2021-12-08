// To parse this JSON data, do
//
//     final geoLocator = geoLocatorFromJson(jsonString);

import 'dart:convert';

Map<String, List<GeoLocator>> geoLocatorFromJson(String str) => Map.from(json.decode(str)).map((k, v) => MapEntry<String, List<GeoLocator>>(k, List<GeoLocator>.from(v.map((x) => GeoLocator.fromJson(x)))));

String geoLocatorToJson(Map<String, List<GeoLocator>> data) => json.encode(Map.from(data).map((k, v) => MapEntry<String, dynamic>(k, List<dynamic>.from(v.map((x) => x.toJson())))));



class GeoLocator {

 Gujarat  gujarat;
  Gujarat maharashtra;
  Gujarat ?westBengal;
  Gujarat ?assam;
  Gujarat ?goa;
  Gujarat ?haryana;
  Gujarat ?punjab;
  Gujarat ?rajasthan;
  Gujarat ? delhi;
  GeoLocator({
    required this.gujarat,
    required this.maharashtra,
    required this.westBengal,
    required this.assam,
    required this.goa,
    required this.punjab,
    required this.delhi,
    required this.haryana,
    required this.rajasthan,
  });

  factory GeoLocator.fromJson(Map<String, dynamic> json) => GeoLocator(
        gujarat: json["Gujarat"],
        maharashtra: json["Maharashtra"],
        westBengal: json["WestBengal"],
        assam: json["Assam"],
        goa: json["Goa"],
        haryana: json["Haryana"],
        punjab: json["Punjab"],
        delhi: json["Delhi"],
        rajasthan: json["Rajasthan"]
      );

  Map<String, dynamic> toJson() => {
        "Gujarat": gujarat,
        "Maharashtra": maharashtra,
        "WestBengal" : westBengal,
        "Assam" : assam,
        "Goa" : goa,
        "Haryana" : haryana
      };
}

class Gujarat {
  String ? latitude;
  String  ?longitude;

  Gujarat({required this.latitude, required this.longitude});

  Gujarat.fromJson(Map<String, dynamic> json) {
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    return data;
  }
}
// class Maharashtra {
//   String ? latitude;
//   String ? longitude;

//   Maharashtra({required this.latitude, required this.longitude});

//   Maharashtra.fromJson(Map<String, dynamic> json) {
//     latitude = json['latitude'];
//     longitude = json['longitude'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data =  Map<String, dynamic>();
//     data['latitude'] = this.latitude;
//     data['longitude'] = this.longitude;
//     return data;
//   }
// }
// class AndhraPrades {
//   String ? latitude;
//   String ? longitude;

//   AndhraPrades({required this.latitude, required this.longitude});

//   AndhraPrades.fromJson(Map<String, dynamic> json) {
//     latitude = json['latitude'];
//     longitude = json['longitude'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data =  Map<String, dynamic>();
//     data['latitude'] = this.latitude;
//     data['longitude'] = this.longitude;
//     return data;
//   }
// }
// class WestBengal {
//   String ? latitude;
//   String ? longitude;

//   WestBengal({required this.latitude, required this.longitude});

//   WestBengal.fromJson(Map<String, dynamic> json) {
//     latitude = json['latitude'];
//     longitude = json['longitude'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data =  Map<String, dynamic>();
//     data['latitude'] = this.latitude;
//     data['longitude'] = this.longitude;
//     return data;
//   }
// }
// class Assam {
//   String ? latitude;
//   String ? longitude;

//   Assam({required this.latitude, required this.longitude});

//   Assam.fromJson(Map<String, dynamic> json) {
//     latitude = json['latitude'];
//     longitude = json['longitude'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data =  Map<String, dynamic>();
//     data['latitude'] = this.latitude;
//     data['longitude'] = this.longitude;
//     return data;
//   }
// }
// class Goa {
//   String ? latitude;
//   String ? longitude;

//   Goa({required this.latitude, required this.longitude});

//   Goa.fromJson(Map<String, dynamic> json) {
//     latitude = json['latitude'];
//     longitude = json['longitude'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data =  Map<String, dynamic>();
//     data['latitude'] = this.latitude;
//     data['longitude'] = this.longitude;
//     return data;
//   }
// }
// class Haryana {
//   String ? latitude;
//   String ? longitude;

//   Haryana({required this.latitude, required this.longitude});

//   Haryana.fromJson(Map<String, dynamic> json) {
//     latitude = json['latitude'];
//     longitude = json['longitude'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data =  Map<String, dynamic>();
//     data['latitude'] = this.latitude;
//     data['longitude'] = this.longitude;
//     return data;
//   }
// }

