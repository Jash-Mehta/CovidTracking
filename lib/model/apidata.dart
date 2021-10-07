// To parse this JSON data, do
//
//     final tracking = trackingFromJson(jsonString);
//     final album = albumFromJson(jsonString);
//     final track = trackFromJson(jsonString);

import 'dart:convert';

Tracking trackingFromJson(String str) => Tracking.fromJson(json.decode(str));

String trackingToJson(Tracking data) => json.encode(data.toJson());

class Tracking {
  Tracking({
    required this.death,
    required this.positive,
    required this.negative,
    required this.pending,
    // required this.members,
  });

  int death;
  int positive;
  int negative;
  int pending;
  // List<Tracking> members;

  factory Tracking.fromJson(Map<String, dynamic> json) => Tracking(
        death: json["death"],
        positive: json["positive"],
        negative: json["negative"],
        pending: json['pending'],
        // members: List<Tracking>.from(json["0"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "name": death,
        "founded": positive,
        // "members": List<dynamic>.from(members.map((x) => x)),
      };
}
