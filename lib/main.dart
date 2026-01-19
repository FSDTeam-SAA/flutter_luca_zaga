import 'package:flutter/material.dart';
import 'package:flutter_luca_zaga30/app/app_manager.dart';
import 'package:flutter_luca_zaga30/core/di/external_service_di.dart';
import 'package:flutter_luca_zaga30/core/di/internal_service_di.dart';
import 'package:flutter_luca_zaga30/core/theme/app_theme.dart';
import 'package:flutter_luca_zaga30/modules/onbording/onboarding1.dart';
import 'package:get/get.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  externalServiceDI();
  initServices();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final AppManager appManager;

  @override
  void initState() {
    super.initState();
    appManager = Get.put(AppManager());
    appManager.onInit();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme.light,
      home: Onboarding1Screen(),
    );
  }
}
