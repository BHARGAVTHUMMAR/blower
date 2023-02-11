import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:yodo1mas/Yodo1MAS.dart';

import 'app/routes/app_pages.dart';
import 'constants/app_module.dart';
final getIt = GetIt.instance;
void main() {
  WidgetsFlutterBinding.ensureInitialized();

  Yodo1MAS.instance.init("zMgkRAQQnF", true,(successful) {});
  setUp();
  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute: AppPages.INITIAL,
      debugShowCheckedModeBanner: false,
      getPages: AppPages.routes,
    ),
  );
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
}
