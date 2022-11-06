import 'package:flutter_ecommerce_laravel/data/repository/cart_repo.dart';
import 'package:flutter_ecommerce_laravel/models/popular_products_modal.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../models/cart_model.dart';

class CartController extends GetxController {
  final CartRepo cartRepo;
  CartController({required this.cartRepo});
  Map<int, CartModel> _items = {};

  Map<int, CartModel> get items =>_items;

  void addItem(ProductModel product, int quantity) {
    var totalQuantity=0;
    if (_items.containsKey(product.id!)) {
      _items.update(product.id!, (value) {
        totalQuantity=value.quantity!+quantity;
        return CartModel(
          id: value.id,
          name: value.name,
          price: value.price,
          img: value.img,
          isExist: true,
          quantity: value.quantity!+quantity,
          time: DateTime.now().toString(),
          product: product,
          
        );
      });

      if (totalQuantity<=0) {
        _items.remove(product.id);
      }
    } else {
      _items.putIfAbsent(
        product.id!,
        () {
          return CartModel(
            id: product.id,
            name: product.name,
            price: product.price,
            img: product.img,
            isExist: true,
            quantity: quantity,
            time: DateTime.now().toString(),
            product: product,
          );
        },
      );
    }
    cartRepo.addToCartList(getItems);
    update();
  }

  bool existInCart(ProductModel product){
    if(_items.containsKey(product.id)){
      return true;
    }
    return false;
  }

  getQuantity(ProductModel product){
    var quantity=0;
    if (_items.containsKey(product.id)) {
      _items.forEach((key, value) { 
        if (key==product.id) {
          quantity = value.quantity!;
        }
      });
    }
    return quantity;
  }

  int get totalItems{
    var totalQuantity =0;
    
    _items.forEach((key, value) { 
      totalQuantity +=value.quantity!;
    });

    return totalQuantity;
  }


  List<CartModel> get getItems{
    return _items.entries.map((e){
     return e.value;
    }).toList();
  }

  int get totalAmount{
    var total=0;

      _items.forEach((key, value) {
        total+= value.quantity!*value.price!;
       });

    return total;
  }
}
