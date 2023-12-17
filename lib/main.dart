import 'package:diet_app/core/app_bindings.dart';
import 'package:diet_app/core/utils/App-router.dart';
import 'package:diet_app/screens/auth/login.screen.dart';
import 'package:diet_app/screens/auth/landing.screen.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  AppBindings.dependencies();
  runApp(MaterialApp.router(
    routerConfig: AppRouter.router,
    debugShowCheckedModeBanner: false,
  ));
}
