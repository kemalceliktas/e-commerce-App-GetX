import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:flutter_ecommerce_laravel/controllers/popular_product_controller.dart';
import 'package:flutter_ecommerce_laravel/controllers/recommended_product_controller.dart';

import 'package:flutter_ecommerce_laravel/routes/route_helper.dart';

import 'package:get/get.dart';
import 'helper/dependencies.dart' as dep;

Future<void> main() async {
  DartPluginRegistrant.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

   return GetBuilder<PopularProductController>(
      builder: (_) {
        return GetBuilder<RecommendedProductController>(builder: (_) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            /*  home: const SplashScreen(), */
            initialRoute: RouteHelper.getSplashPage(),
            getPages: RouteHelper.routes,
          );
        });
      },
    );
  }
}
