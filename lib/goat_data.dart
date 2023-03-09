import 'dart:convert';
import 'dart:io';
import 'feed.dart';
import 'package:path_provider/path_provider.dart';
import 'medicine.dart';
import 'constants.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'goat.dart';

class GoatData {
  late File _localFile;
  static Future<List<Feed>> getFeeds() async {
    final jsonString = await rootBundle.loadString('assets/feeds.json');
    final jsonResponse = json.decode(jsonString);
    return (jsonResponse as List).map((data) => Feed.fromJson(data)).toList();
  }

  static Future<List<Medicine>> getMedicines() async {
    final jsonStr = await rootBundle.loadString('assets/data/medicines.json');
    final jsonList = json.decode(jsonStr) as List<dynamic>;
    final medicines = jsonList.map((e) => Medicine.fromJson(e)).toList();
    return medicines;
  }

  static Future<void> addFeed(Feed feed) async {
    final jsonString = await rootBundle.loadString('assets/feeds.json');
    final jsonResponse = json.decode(jsonString);
    final List<dynamic> feedsJson = jsonResponse as List<dynamic>;
    feedsJson.add(feed.toJson());
    final jsonStringToWrite = json.encode(feedsJson);
    final file = File('assets/feeds.json');
    await file.writeAsString(jsonStringToWrite);
  }

  static Future<void> addMedicine(Medicine medicine) async {
    final jsonString = await rootBundle.loadString('assets/medicines.json');
    final jsonResponse = json.decode(jsonString);
    final List<dynamic> medicinesJson = jsonResponse as List<dynamic>;
    medicinesJson.add(medicine.toJson());
    final jsonStringToWrite = json.encode(medicinesJson);
    final file = File('assets/medicines.json');
    await file.writeAsString(jsonStringToWrite);
  }

  void updateGoat(Goat goatToUpdate, Goat newGoatData) {
    final goatIndex = goats.indexWhere((goat) => goat.id == goatToUpdate.id);
    if (goatIndex >= 0) {
      goats[goatIndex] = newGoatData;
    }
  }

  GoatData() {
    _initLocalFile();
  }

  Future<void> _initLocalFile() async {
    final directory = await getApplicationDocumentsDirectory();
    _localFile = File('${directory.path}/goats.json');
  }

  List<Goat> _goats = [];

  List<Goat> get goats => _goats;

  set goats(List<Goat> goats) {
    _goats = goats;
    _saveGoatsToFile(_goats);
  }

  Future<List<Goat>> loadGoatsFromJson() async {
    final file = await _localFile;
    if (await file.exists()) {
      final String data = await file.readAsString();
      final List<dynamic> jsonData = jsonDecode(data);
      List<Goat> goats = [];
      for (var goatData in jsonData) {
        goats.add(Goat.fromJson(goatData));
      }
      return goats;
    } else {
      return [];
    }
  }

  Future<void> _saveGoatsToFile(List<Goat> goats) async {
    try {
      final jsonList = goats.map((goat) => goat.toJson()).toList();
      await _localFile.writeAsString(json.encode(jsonList));
    } catch (e) {
      print('Error saving goats to file: $e');
    }
  }
}
