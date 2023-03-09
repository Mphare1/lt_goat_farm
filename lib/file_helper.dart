import 'dart:io';
import 'dart:convert';

import 'package:path_provider/path_provider.dart';

class FileHelper {
  static Future<File> getFile(String fileName) async {
    final directory = await getApplicationDocumentsDirectory();
    final path = directory.path;
    return File('$path/$fileName');
  }

  static Future<String> readData(String fileName) async {
    try {
      final file = await getFile(fileName);
      // Read the file
      final data = await file.readAsString();
      return data;
    } catch (e) {
      return '';
    }
  }

  static Future<File> writeData(String fileName, String data) async {
    final file = await getFile(fileName);
    // Write the file
    return file.writeAsString(data);
  }
}
