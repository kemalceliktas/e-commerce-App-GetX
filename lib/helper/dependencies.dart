import 'package:flutter_ecommerce_laravel/controllers/cart_controller.dart';
import 'package:flutter_ecommerce_laravel/controllers/popular_product_controller.dart';
import 'package:flutter_ecommerce_laravel/controllers/recommended_product_controller.dart';
import 'package:flutter_ecommerce_laravel/data/api/api_client.dart';
import 'package:flutter_ecommerce_laravel/data/repository/cart_repo.dart';
import 'package:flutter_ecommerce_laravel/data/repository/popular_product_repo.dart';
import 'package:flutter_ecommerce_laravel/data/repository/recommended_product_repo.dart';
import 'package:flutter_ecommerce_laravel/utils/app_const.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> init() async {

  final sharedPreferences =await SharedPreferences.getInstance();

  Get.lazyPut(() => sharedPreferences);


  //client
  Get.lazyPut(
    () => ApiClient(appBaseUrl: AppConst.BASE_URL),
  );

  //repo
  Get.lazyPut(
    () => PopularProductRepo(
      apiClient: Get.find(),
    ),
  );
  Get.lazyPut(
    () => RecommendedProductRepo(
      apiClient: Get.find(),
    ),
  );

  Get.lazyPut(
    () => CartRepo(sharedPreferences:Get.find()),
  );

  //controllers
  Get.lazyPut(
    () => PopularProductController(
      popularProductRepo: Get.find(),
    ),
  );

  Get.lazyPut(
    () => RecommendedProductController(
      recommendedProductRepo: Get.find(),
    ),
  );

  Get.lazyPut(
    () => CartController(
      cartRepo: Get.find(),
    ),
  );
}
