

import 'package:flutter_ecommerce_laravel/data/api/api_client.dart';
import 'package:flutter_ecommerce_laravel/utils/app_const.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class RecommendedProductRepo extends GetxService {
  final ApiClient apiClient;
  RecommendedProductRepo({required this.apiClient});

  Future<Response> getRecommendedProductList()async{
    return await apiClient.getData(AppConst.RECOMMENDED_PRODUCT_URI);
  }
}