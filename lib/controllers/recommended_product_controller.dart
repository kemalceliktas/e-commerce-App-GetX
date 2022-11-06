
import 'package:flutter_ecommerce_laravel/models/popular_products_modal.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../data/repository/recommended_product_repo.dart';

class RecommendedProductController extends GetxController{
  final RecommendedProductRepo recommendedProductRepo;

  RecommendedProductController({required this.recommendedProductRepo});

  List<dynamic> _recommendedProductList=[

  ];
  List<dynamic> get recommendedProductList =>_recommendedProductList;


  bool _isLoaded=false;

  bool get isLoaded => _isLoaded;

  Future<void> getRecommendedProductList()async{
   Response response= await recommendedProductRepo.getRecommendedProductList();
   if(response.statusCode==200){
    
    
    _recommendedProductList=[];
    _recommendedProductList.addAll(Product.fromJson(response.body).products);
  /*   print(_popularProductList); */
    _isLoaded=true;
    update();
   }else{
    print("Something went wrong");
   }
  }
}