import 'package:diet_app/core/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';

class AppBindings {
  static void dependencies() async{
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    await Hive.initFlutter();
    await Hive.openBox("appBox");
    // FireBaseUtils.initializefirebase();
  }
}