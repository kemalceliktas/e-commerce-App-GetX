import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_laravel/controllers/cart_controller.dart';
import 'package:flutter_ecommerce_laravel/data/repository/popular_product_repo.dart';
import 'package:flutter_ecommerce_laravel/models/popular_products_modal.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../models/cart_model.dart';

class PopularProductController extends GetxController {
  final PopularProductRepo popularProductRepo;

  PopularProductController({required this.popularProductRepo});

  List<dynamic> _popularProductList = [];
  List<dynamic> get popularProductList => _popularProductList;
  late CartController _cart;

  bool _isLoaded = false;

  bool get isLoaded => _isLoaded;

  int _quantity = 0;
  int get quatity => _quantity;

  int _inCartItems=0;
  int get inCartItems=>_inCartItems+_quantity;

  Future<void> getPopularProductList() async {
    Response response = await popularProductRepo.getPopularProductList();
    if (response.statusCode == 200) {
   
      _popularProductList = [];
      _popularProductList.addAll(Product.fromJson(response.body).products);
      /*   print(_popularProductList); */
      _isLoaded = true;
      update();
    } else {
      print("Something went wrong");
    }
  }

  void setQuantity(bool isIncrement) {
    if (isIncrement) {
      _quantity = _quantity + 1;
    } else {
      if (_quantity+_inCartItems > 0) {
        _quantity = _quantity - 1;
        update();
      } else {
        Get.snackbar(
          "Item count",
          "You cant reduce more!",
          backgroundColor: Colors.blueAccent,
          colorText: Colors.white,
        );
        _quantity = 0;
      }
    }
    update();
  }


  void initProduct(ProductModel product,CartController cart){
    _quantity=0;
    _inCartItems=0;
    _cart=cart;
    var exist=false;
    exist=_cart.existInCart(product);

    if (exist) {
      _inCartItems=_cart.getQuantity(product);
    }
    print("the quantity is: "+_inCartItems.toString());
  
    // if exist
    // get from storage _inCartitems

    
  }


  void addItem(ProductModel product){
    
     if (_quantity>0) {
       _cart.addItem(product, _quantity);

       _quantity=0;
       _inCartItems=_cart.getQuantity(product);

       _cart.items.forEach((key, value) {
        print("The id is: " +value.id.toString()+" The quantity is  "+value.quantity.toString());
       },);
    }
    
    else if(_quantity==0){
       Get.snackbar("Error", "You need to add item",
      backgroundColor: Colors.blueAccent,
      colorText: Colors.white,);
    }
    
    else{ 
      _cart.addItem(product, _quantity);

       _quantity=0;
       _inCartItems=_cart.getQuantity(product);

       _cart.items.forEach((key, value) {
        print("The id is: " +value.id.toString()+" The quantity is  "+value.quantity.toString());
       },);

    } 

    update();
   
  }

  int get totalItems{
    return _cart.totalItems;
  }


  List<CartModel> get getItems{
    return _cart.getItems;
  }

  
}
