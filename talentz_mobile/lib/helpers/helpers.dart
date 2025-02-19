import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:logger/logger.dart';

class CustomHelpers {
  static final Logger _logger = Logger();
  //static const String _key = 'current_id';

  // Get the path for the file inside the app's private documents directory
  static Future<String> get _filePath async {
    final directory = await getApplicationDocumentsDirectory();
    _logger.i(directory.path);
    return directory.path;
  }

  // Get the file reference inside the app's private directory
  static Future<File> get _file async {
    final path = await _filePath;
    final file = File("$path/files/base.txt");

    if (!await file.exists()) {
      // If the file doesn't exist, check if data is stored in flutter_secure_storage
      await file.create(recursive: true);
    }

    return file;
  }

  // Save the number to the file and flutter_secure_storage
  static Future<void> saveCurrentId(int number) async {
    final file = await _file;
    
    // Save data to the file
    await file.writeAsString(number.toString(), mode: FileMode.write);
  }

  // Retrieve the number from the file or flutter_secure_storage
  static Future<int?> getCurrentId() async {
    try {
      final file = await _file;
      final contents = await file.readAsString();
      return int.tryParse(contents);
    } catch (e) {
      _logger.e("Error reading Id: $e");
      return null;
    }
  }

  static Future<void> deleteFile() async {
    final file = await _file;
    await file.delete();
  }
}
