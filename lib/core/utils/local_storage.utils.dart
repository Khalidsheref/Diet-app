import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageUtils{
  static final box = Hive.box("appBox");
  static const String _token = "token";
  static const String myDocId = "myDocId";

  static setToken(String? token) {
    box.put(_token, token ??"");
  }

  static setMyDocId(String? docId) {
    box.put(myDocId, docId ??"");
  }

  static getMyDocId() {
    String? stringDocId = box.get(myDocId);
    return stringDocId;
  }

  static getToken() {
    String? stringToken = box.get(_token);
    return stringToken;
  }
}