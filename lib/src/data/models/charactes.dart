// To parse this JSON data, do
//
//     final characters = charactersFromJson(jsonString);

import 'dart:convert';

import 'package:urbetrack_sw/src/data/models/people.dart';

Characters charactersFromJson(String str) =>
    Characters.fromJson(json.decode(str));

String charactersToJson(Characters data) => json.encode(data.toJson());

class Characters {
  Characters({
    required this.count,
    required this.next,
    required this.previous,
    required this.results,
  });

  final int count;
  final String? next;
  final String? previous;
  final List<People> results;

  factory Characters.fromJson(Map<String, dynamic> json) => Characters(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results:
            List<People>.from(json["results"].map((x) => People.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "next": next,
        "previous": previous,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

// ignore: constant_identifier_names
enum Gender { MALE, N_A, FEMALE }

final genderValues = EnumValues(
    {"female": Gender.FEMALE, "male": Gender.MALE, "n/a": Gender.N_A});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String>? get reverse {
    reverseMap ??= map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
