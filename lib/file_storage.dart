import 'dart:io';

import 'package:path_provider/path_provider.dart';

class FileStorage {
  Future<String> get _localPath async {
    // final directory = await getApplicationDocumentsDirectory();
    final directory = await getDownloadsDirectory();
    return directory!.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/result.txt');
  }

  Future<Object> readResult() async {
    try {
      final file = await _localFile;
      // Read the file
      final String contents = await file.readAsString();
      return contents;
    } catch (e) {
      // If encountering an error, return 0
      return 0;
    }
  }

  Future<File> writeResult(String result) async {
    final file = await _localFile;
    // Write the file
    return file.writeAsString('$result');
  }

  bool _checkFileExistsSync(String path) {
    return File(path).existsSync();
  }

  Future cekFile() async {
    final file = await _localFile;
    return _checkFileExistsSync(file.path);
  }
}
