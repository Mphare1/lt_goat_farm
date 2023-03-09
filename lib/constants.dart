import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

import 'goat.dart';

const kMetricTitleTextStyle = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.bold,
);

const kMetricValueTextStyle = TextStyle(
  fontSize: 24,
  fontWeight: FontWeight.bold,
);

class Constants {
  static const List<String> weightUnits = ['kg', 'lbs'];
  static const List<String> breeds = [
    'Alpine',
    'Boer',
    'LaMancha',
    'Nubian',
    'Oberhasli',
    'Saanen',
    'Sable'
  ];
  static const List<String> genders = ['Male', 'Female'];
  static const kAppName = 'Goat Farm';
  static const Color kPrimaryColor = Color(0xFF00ADEF);
  static const kBackgroundColor = Color(0xFFF3F3F3);
  static Color get lightGrey => Color(0xFFE0E0E0);
  static const String defaultGoatImage = 'assets/images/default_goat_image.jpg';

  static Future<void> saveGoatsToFile(List<Goat> goats) async {
    try {
      final file = await getLocalFile('goats.json');
      final jsonList = goats.map((goat) => goat.toJson()).toList();
      await file.writeAsString(json.encode(jsonList));
    } catch (e) {
      print('Error saving goats to file: $e');
    }
  }

  static const kDefaultPadding = 20.0;
  static const kSmallPadding = 10.0;
  static DateFormat get dateFormat => DateFormat('MMM dd, yyyy');
  static const kCardShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(15),
    ),
  );

  static Future<String> get localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  static Future<File> getLocalFile(String fileName) async {
    final path = await localFilePath;
    return File('$path/$fileName');
  }

  static Future<File> get _localFile async {
    final path = await localFilePath;
    return File('$path/goats.json');
  }

  static Future<String> get localFilePath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  static const kInputDecoration = InputDecoration(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(15),
      ),
      borderSide: BorderSide.none,
    ),
    fillColor: kBackgroundColor,
    filled: true,
    contentPadding: EdgeInsets.symmetric(
      horizontal: kDefaultPadding,
      vertical: kSmallPadding,
    ),
  );

  static const kBoxDecoration = BoxDecoration(
    color: kBackgroundColor,
    borderRadius: BorderRadius.all(
      Radius.circular(15),
    ),
    boxShadow: [
      BoxShadow(
        color: Colors.black26,
        blurRadius: 3,
        offset: Offset(0, 2),
      ),
    ],
  );

  static Future<List<Goat>> loadGoatsFromJson() async {
    try {
      final file = await getLocalFile('goats.json');
      // Read the file
      String contents = await file.readAsString();
      // Decode the JSON data
      List<dynamic> jsonList = json.decode(contents);
      // Convert the JSON data to a list of Goat objects
      List<Goat> goats = [];
      for (var jsonGoat in jsonList) {
        goats.add(Goat.fromJson(jsonGoat));
      }
      return goats;
    } catch (e) {
      // If encountering an error, return an empty list
      return [];
    }
  }

  Future<void> _saveGoatsToFile(List<Goat> goats) async {
    try {
      final file = await _localFile;
      final jsonList = goats.map((goat) => goat.toJson()).toList();
      await file.writeAsString(json.encode(jsonList));
    } catch (e) {
      print('Error saving goats to file: $e');
    }
  }
}
