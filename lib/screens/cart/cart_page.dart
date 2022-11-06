import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_laravel/controllers/cart_controller.dart';
import 'package:flutter_ecommerce_laravel/controllers/popular_product_controller.dart';
import 'package:flutter_ecommerce_laravel/controllers/recommended_product_controller.dart';
import 'package:flutter_ecommerce_laravel/home/main_food_page.dart';
import 'package:flutter_ecommerce_laravel/routes/route_helper.dart';
import 'package:flutter_ecommerce_laravel/utils/app_const.dart';
import 'package:flutter_ecommerce_laravel/utils/utils.dart';
import 'package:flutter_ecommerce_laravel/widgets/app_icon.dart';
import 'package:flutter_ecommerce_laravel/widgets/big_text.dart';
import 'package:flutter_ecommerce_laravel/widgets/small_text.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            left: PageSize.width20,
            right: PageSize.width20,
            top: PageSize.height20 * 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: AppIcon(
                    icon: Icons.arrow_back_ios,
                    iconColor: Colors.white,
                    backgroundColor: Colors.blueAccent,
                    size: PageSize.iconSize16 * 2,
                  ),
                ),
                SizedBox(
                  width: PageSize.width20 * 5,
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(RouteHelper.getInitial());
                  },
                  child: AppIcon(
                    icon: Icons.home_sharp,
                    iconColor: Colors.white,
                    backgroundColor: Colors.blueAccent,
                    size: PageSize.iconSize16 * 2,
                  ),
                ),
                AppIcon(
                  icon: Icons.shopping_bag_outlined,
                  iconColor: Colors.white,
                  backgroundColor: Colors.blueAccent,
                  size: PageSize.iconSize16 * 2,
                ),
              ],
            ),
          ),
          Positioned(
            top: PageSize.height20 * 5,
            left: PageSize.width20,
            right: PageSize.width20,
            bottom: 0,
            child: Container(
              margin: EdgeInsets.only(
                top: PageSize.height15,
              ),
              child: MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: GetBuilder<CartController>(
                    builder: (controller) {
                      var _cartList = controller.getItems;

                      return ListView.builder(
                          itemCount: _cartList.length,
                          itemBuilder: (_, index) {
                            return Container(
                              height: PageSize.height20 * 5,
                              width: double.maxFinite,
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      var popularIndex =
                                          Get.find<PopularProductController>()
                                              .popularProductList
                                              .indexOf(
                                                  _cartList[index].product!);
                                      if (popularIndex>=0) {
                                        Get.toNamed(RouteHelper.getPopularFood(popularIndex,"cartpage"),);
                                      }else{
                                         var recommendedIndex =
                                          Get.find<RecommendedProductController>()
                                              .recommendedProductList
                                              .indexOf(
                                                  _cartList[index].product!);
                                        Get.toNamed(RouteHelper.getRecommendedFood(recommendedIndex,"cartpage"),);

                                      }
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(bottom: 10),
                                      width: PageSize.height20 * 5,
                                      height: PageSize.height20 * 5,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            PageSize.radius20),
                                        color: Colors.white,
                                        image: DecorationImage(
                                          image: NetworkImage(AppConst
                                                  .BASE_URL +
                                              AppConst.UPLOAD_URL +
                                              controller.getItems[index].img!),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: PageSize.width10,
                                  ),
                                  Expanded(
                                    child: Container(
                                      height: PageSize.height20 * 5,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          BigText(
                                            title: controller
                                                .getItems[index].name!,
                                            size: PageSize.font20,
                                            color: Colors.blueGrey[800],
                                          ),
                                          SmallText(title: "Alt başlık"),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              BigText(
                                                title: "\$ " +
                                                    _cartList[index]
                                                        .price!
                                                        .toString(),
                                                color: Colors.redAccent,
                                              ),
                                              Container(
                                                child: Row(
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        controller.addItem(
                                                            _cartList[index]
                                                                .product!,
                                                            -1);
                                                      },
                                                      child: Icon(
                                                        Icons.remove,
                                                        color: Colors.blueGrey,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width:
                                                          PageSize.width10 / 2,
                                                    ),
                                                    BigText(
                                                      title: _cartList[index]
                                                          .quantity
                                                          .toString(),
                                                      size: PageSize.font20,
                                                    ),
                                                    SizedBox(
                                                      width:
                                                          PageSize.width10 / 2,
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        controller.addItem(
                                                            _cartList[index]
                                                                .product!,
                                                            1);
                                                      },
                                                      child: Icon(
                                                        Icons.add,
                                                        color: Colors.blueGrey,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          });
                    },
                  )),
            ),
          ),
        ],
      ),
      bottomNavigationBar:
         GetBuilder<CartController>(
          builder: (cartController) {
            return Container(
              height: PageSize.bottomHeightBar,
              padding: EdgeInsets.only(
                top: PageSize.height15 * 2,
                bottom: PageSize.height15 * 2,
                right: PageSize.width20,
                left: PageSize.width20,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(PageSize.radius20),
                  topRight: Radius.circular(PageSize.radius20),
                ),
                color: Colors.black12.withOpacity(0.13),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: PageSize.width20,
                        vertical: PageSize.height20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(PageSize.radius20),
                    ),
                    child: Row(
                      children: [
                      
                        SizedBox(
                          width: PageSize.width10 / 2,
                        ),
                        BigText(
                          title:"\$ "+ cartController.totalAmount.toString(),

                          size: PageSize.font20,
                        ),
                        SizedBox(
                          width: PageSize.width10 / 2,
                        ),
                     
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: PageSize.width20,
                        vertical: PageSize.height20),
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(PageSize.radius20),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        
                      },
                      child: BigText(
                        title: "Check out",
                        color: Colors.white,
                        size: PageSize.font20,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
    );
  }
}
