import 'package:flutter/material.dart';
import 'package:watad/core/cache/cache_helper.dart';
import 'package:watad/core/di/service_locator.dart';
import 'package:watad/watad_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  await setupServiceLocator();

  runApp(const WatadApp());

}