import 'package:flutter/cupertino.dart';
import 'package:get_storage/get_storage.dart';

class StorageService {
  static final _storage = GetStorage();

  static Future<void> saveData(String key, dynamic data) async {
    await _storage.write(key, data);
    debugPrint("saved------>$key==>$data");
  }

  static dynamic fetchData(String key) {
    return _storage.read(key);
  }

  static Future<void> clearData() async {
    await _storage.erase();
  }
}
