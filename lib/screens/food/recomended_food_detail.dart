import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_laravel/controllers/popular_product_controller.dart';
import 'package:flutter_ecommerce_laravel/controllers/recommended_product_controller.dart';
import 'package:flutter_ecommerce_laravel/routes/route_helper.dart';

import 'package:flutter_ecommerce_laravel/utils/app_const.dart';
import 'package:flutter_ecommerce_laravel/utils/utils.dart';
import 'package:flutter_ecommerce_laravel/widgets/app_icon.dart';
import 'package:flutter_ecommerce_laravel/widgets/big_text.dart';
import 'package:flutter_ecommerce_laravel/widgets/exandble_text_widget.dart';
import 'package:get/get.dart';

import '../../controllers/cart_controller.dart';

class RecomendedFoodDetail extends StatelessWidget {
  int pageId;
  String page;
  RecomendedFoodDetail({super.key, required this.pageId,required this.page});

  @override
  Widget build(BuildContext context) {
    var product =
        Get.find<RecommendedProductController>().recommendedProductList[pageId];
    Get.find<PopularProductController>()
        .initProduct(product, Get.find<CartController>());
    return Scaffold(
        backgroundColor: Colors.white,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
              toolbarHeight: 70,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () {
                        if (page=="cartpage") {
                          Get.toNamed(RouteHelper.getCartPage());
                        }else{
                          Get.toNamed(RouteHelper.initial);
                        }
                        
                      },
                      child: AppIcon(icon: Icons.clear)),
                  GetBuilder<PopularProductController>(builder: (controller) {
                    return GestureDetector(
                      onTap: () {
                        Get.toNamed(RouteHelper.getCartPage());
                      },
                      child: Stack(
                        children: [
                          AppIcon(icon: Icons.shopping_bag_outlined),
                          Get.find<PopularProductController>().totalItems >= 1
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
                      ),
                    );
                  }),
                ],
              ),
              bottom: PreferredSize(
                child: Container(
                  padding: EdgeInsets.only(top: 5, bottom: 10),
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(PageSize.radius20),
                        topRight: Radius.circular(PageSize.radius20),
                      )),
                  child: Center(
                      child: BigText(
                    title: product.name!,
                    size: PageSize.font20,
                  )),
                ),
                preferredSize: Size.fromHeight(20),
              ),
              pinned: true,
              backgroundColor: Colors.blueAccent,
              expandedHeight: 300,
              flexibleSpace: FlexibleSpaceBar(
                background: Image.network(
                  AppConst.BASE_URL + AppConst.UPLOAD_URL + product.img!,
                  fit: BoxFit.cover,
                  width: double.maxFinite,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      left: PageSize.width20,
                      right: PageSize.width20,
                    ),
                    child: ExandbleTextWidget(
                      text: product.description!,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: GetBuilder<PopularProductController>(
          builder: (controller) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: EdgeInsets.only(
                    left: PageSize.width20 * 2.5,
                    right: PageSize.width20 * 2.5,
                    top: PageSize.height10,
                    bottom: PageSize.height10,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          controller.setQuantity(false);
                        },
                        child: AppIcon(
                          icon: Icons.remove,
                          backgroundColor: Colors.blueAccent,
                          iconColor: Colors.white,
                        ),
                      ),
                      BigText(
                        title: "\$ " +
                            product.price!.toString() +
                            " X " +
                            controller.inCartItems.toString(),
                        size: PageSize.font26,
                      ),
                      GestureDetector(
                          onTap: () {
                            controller.setQuantity(true);
                          },
                          child: AppIcon(
                              icon: Icons.add,
                              backgroundColor: Colors.blueAccent,
                              iconColor: Colors.white)),
                    ],
                  ),
                ),
                Container(
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
                          borderRadius:
                              BorderRadius.circular(PageSize.radius20),
                        ),
                        child: Icon(
                          Icons.favorite,
                          color: Colors.blueAccent,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          controller.addItem(product);
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: PageSize.width20,
                              vertical: PageSize.height20),
                          decoration: BoxDecoration(
                            color: Colors.blueAccent,
                            borderRadius:
                                BorderRadius.circular(PageSize.radius20),
                          ),
                          child: BigText(
                            title: "\$ " +
                                product.price!.toString() +
                                " | Add to cart",
                            color: Colors.white,
                            size: PageSize.font20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ));
  }
}
