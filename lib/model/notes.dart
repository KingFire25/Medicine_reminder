import 'package:flutter/material.dart';

final String tablenotes = 'notes';

class Notesfield {
  static final List<String> values = [id, name, medtype, settime, days];
  static final String id = '_id';
  static final String name = 'name';
  static final String medtype = 'medtype';
  static final String settime ='settime';
  static final String days ='days';
}

class Notes {
  final int? id;
  final String name;
  final int medtype;
  final TimeOfDay settime;
  final String days;

  const Notes({
    this.id,
    required this.name,
    required this.medtype,
    required this.settime,
    required this.days,
  });

  Notes copy({
    int? id,
    String? name,
    int? medtype,
    TimeOfDay? settime, 
    String? days,
  }) =>
       Notes(
        id: id ?? this.id,
        name: name ?? this.name,
        medtype: medtype ?? this.medtype,
        settime: settime ?? this.settime,
        days: days ?? this.days,
      );

  static Notes fromJson(Map<String, Object?> json) => Notes(
        id: json[Notesfield.id] as int?,
        name: json[Notesfield.name] as String,
        medtype: json[Notesfield.medtype] as int,
        settime: TimeOfDay(
        hour: int.parse(
          json[Notesfield.settime].toString().substring(10, 12),
        ),
        minute: int.parse(
          json[Notesfield.settime].toString().substring(13, 15),
        ),
      ),
        days: json[Notesfield.days] as String,
      );

  Map<String, Object?> toJson() => {
        Notesfield.id: id,
        Notesfield.name: name,
        Notesfield.medtype: medtype,
        Notesfield.settime: settime.toString(),
        Notesfield.days: days,
      };
}
