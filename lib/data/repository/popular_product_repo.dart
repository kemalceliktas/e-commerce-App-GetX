

import 'package:flutter_ecommerce_laravel/data/api/api_client.dart';
import 'package:flutter_ecommerce_laravel/utils/app_const.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class PopularProductRepo extends GetxService {
  final ApiClient apiClient;
  PopularProductRepo({required this.apiClient});

  Future<Response> getPopularProductList()async{
    return await apiClient.getData(AppConst.POPULAR_PRODUCT_URI);
  }

  
}