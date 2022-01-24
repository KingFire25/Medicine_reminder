<<<<<<< HEAD


import 'package:flutter/material.dart';

final String tablenotes = 'notes';

class Notesfield {
  static final List<String> values = [id, name, medicinename, medicineduration, medtype, medicineamount, settime];
  static final String id = '_id';
  static final String name = 'name';
  static final String medicinename = 'medicinename';
  static final String medicineduration = 'medicineduration';
  static final String medtype = 'medtype';
  static final String medicineamount = 'medicineamount';
  static final String settime ='settime';
  
}

class Notes {
  final int? id;
  final String name;
  final String medicinename;
  final int medicineduration;
  final int medtype;
  final int medicineamount;
  final TimeOfDay settime;
  

  const Notes({
    this.id,
    required this.name,
    required this.medicinename,
    required this.medicineduration,
    required this.medtype,
    required this.medicineamount,
    required this.settime,
    
  });

  Notes copy({
    int? id,
    String? name,
    String? medicinename,
    int? medicineduration,
    int? medtype,
    int? medicineamount,
    TimeOfDay? settime, 
    
  }) =>
       Notes(
        id: id ?? this.id,
        name: name ?? this.name,
        medicinename: medicinename ?? this.medicinename,
        medicineduration: medicineduration ?? this.medicineduration,
        medtype: medtype ?? this.medtype,
        medicineamount: medicineamount ?? this.medicineamount,
        settime: settime ?? this.settime,
        
      );

  static Notes fromJson(Map<String, Object?> json) => Notes(
        id: json[Notesfield.id] as int?,
        name: json[Notesfield.name] as String,
        medicinename: json[Notesfield.medicinename] as String,
        medicineduration: json[Notesfield.medicineduration] as int,
        medtype: json[Notesfield.medtype] as int,
        medicineamount: json[Notesfield.medicineamount] as int,
        settime: TimeOfDay(
        hour: int.parse(
          json[Notesfield.settime].toString().substring(10, 12),
        ),
        minute: int.parse(
          json[Notesfield.settime].toString().substring(13, 15),
        ),
      ),
        
      );

  Map<String, Object?> toJson() => {
        Notesfield.id: id,
        Notesfield.name: name,
        Notesfield.medicinename: medicinename,
        Notesfield.medicineduration: medicineduration,
        Notesfield.medtype: medtype,
        Notesfield.medicineamount:medicineamount,
        Notesfield.settime: settime.toString(),
      };
}
=======
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
>>>>>>> cd34dfa4b5462ac855fdc3a8b5f5875d962bd051
