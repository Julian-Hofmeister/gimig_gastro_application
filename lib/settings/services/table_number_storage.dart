import 'dart:io';
import 'package:path_provider/path_provider.dart';

class TableNumberStorageService {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    print("Path $path");
    return File("$path/tableNumber.txt");
  }

  Future<int> readTableNumber() async {
    try {
      final file = await _localFile;

      String contents = await file.readAsString();

      return int.parse(contents);
    } catch (e) {
      return 0;
    }
  }

  Future<File> writeTableNumber(int tableNumber) async {
    final file = await _localFile;

    return file.writeAsString('$tableNumber');
  }
}
