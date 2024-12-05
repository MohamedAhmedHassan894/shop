import 'package:flutter/services.dart';

class FileHelper {
  static Future<String> loadJsonFromFile(String path) async {
    return await rootBundle.loadString(path);
  }
}
