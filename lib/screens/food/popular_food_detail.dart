import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_laravel/controllers/cart_controller.dart';
import 'package:flutter_ecommerce_laravel/controllers/popular_product_controller.dart';

import 'package:flutter_ecommerce_laravel/home/main_food_page.dart';
import 'package:flutter_ecommerce_laravel/routes/route_helper.dart';
import 'package:flutter_ecommerce_laravel/screens/cart/cart_page.dart';
import 'package:flutter_ecommerce_laravel/utils/app_const.dart';
import 'package:flutter_ecommerce_laravel/utils/utils.dart';
import 'package:flutter_ecommerce_laravel/widgets/app_column.dart';
import 'package:flutter_ecommerce_laravel/widgets/app_icon.dart';
import 'package:flutter_ecommerce_laravel/widgets/exandble_text_widget.dart';
import 'package:get/get.dart';

import '../../widgets/big_text.dart';

class PopularFoodDetail extends StatelessWidget {
  int pageId;
  String page;
  PopularFoodDetail({super.key, required this.pageId, required this.page});

  @override
  Widget build(BuildContext context) {
    var product =
        Get.find<PopularProductController>().popularProductList[pageId];
    Get.find<PopularProductController>()
        .initProduct(product, Get.find<CartController>());
    return Scaffold(
        body: Stack(
          children: [
            //BACKGROUND
            Positioned(
              left: 0,
              right: 0,
              child: Container(
                width: double.maxFinite,
                height: PageSize.popularFoodImgSize,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                        AppConst.BASE_URL + AppConst.UPLOAD_URL + product.img!),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            //ICON BAR TOP
            Positioned(
              top: PageSize.height45,
              left: PageSize.width20,
              right: PageSize.width20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                      onTap: () {
                        if (page == "cartpage") {
                          Get.toNamed(
                            RouteHelper.getCartPage(),
                          );
                        } else {
                          Get.toNamed(RouteHelper.getInitial());
                        }
                      },
                      child: AppIcon(icon: Icons.arrow_back_ios)),
                  GetBuilder<PopularProductController>(builder: (controller) {
                    return Stack(
                      children: [
                        GestureDetector(
                            onTap: () {
                              Get.toNamed(
                                RouteHelper.getCartPage(),
                              );
                            },
                            child: AppIcon(icon: Icons.shopping_bag_outlined)),
                        controller.totalItems >= 1
                            ? Positioned(
                                right: 5,
                                top: 5,
                                child: AppIcon(
                                  icon: Icons.circle,
                                  size: 17,
                                  backgroundColor: Colors.blueAccent,
                                  iconColor: Colors.transparent,
                                ),
                              )
                            : Container(),
                        Get.find<PopularProductController>().totalItems >= 1
                            ? Positioned(
                                right: 9,
                                top: 7,
                                child: BigText(
                                  title: Get.find<PopularProductController>()
                                      .totalItems
                                      .toString(),
                                  size: 10,
                                  color: Colors.white,
                                ),
                              )
                            : Container(),
                      ],
                    );
                  }),
                ],
              ),
            ),
            //DESCRİPTİON
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              top: PageSize.popularFoodImgSize - 20,
              child: Container(
                padding: EdgeInsets.only(
                  left: PageSize.width20,
                  right: PageSize.width20,
                  top: PageSize.height20,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(PageSize.radius20),
                    topRight: Radius.circular(PageSize.radius20),
                  ),
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppColumn(
                      stars: product.stars,
                      text: product.name!,
                    ),
                    SizedBox(
                      height: PageSize.height20,
                    ),
                    BigText(
                      title: "Introduce",
                      size: PageSize.font20,
                    ),
                    SizedBox(
                      height: PageSize.height20,
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: ExandbleTextWidget(
                          text: product.description!,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            //Expandble text widget
          ],
        ),
        bottomNavigationBar:
         GetBuilder<PopularProductController>(
          builder: (popularProduct) {
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
                        GestureDetector(
                          onTap: () {
                            popularProduct.setQuantity(false);
                          },
                          child: Icon(
                            Icons.remove,
                            color: Colors.blueGrey,
                          ),
                        ),
                        SizedBox(
                          width: PageSize.width10 / 2,
                        ),
                        BigText(
                          title: popularProduct.inCartItems.toString(),
                          size: PageSize.font20,
                        ),
                        SizedBox(
                          width: PageSize.width10 / 2,
                        ),
                        GestureDetector(
                          onTap: () {
                            popularProduct.setQuantity(true);
                          },
                          child: Icon(
                            Icons.add,
                            color: Colors.blueGrey,
                          ),
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
                        popularProduct.addItem(product);
                      },
                      child: BigText(
                        title: "\$" +
                            (product.price! * popularProduct.inCartItems)
                                .toString() +
                            " | Add to cart",
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
