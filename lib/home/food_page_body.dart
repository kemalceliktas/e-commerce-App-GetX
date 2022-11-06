import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_laravel/controllers/popular_product_controller.dart';
import 'package:flutter_ecommerce_laravel/controllers/recommended_product_controller.dart';
import 'package:flutter_ecommerce_laravel/models/popular_products_modal.dart';
import 'package:flutter_ecommerce_laravel/routes/route_helper.dart';

import 'package:flutter_ecommerce_laravel/utils/app_const.dart';
import 'package:flutter_ecommerce_laravel/utils/utils.dart';
import 'package:flutter_ecommerce_laravel/widgets/app_column.dart';
import 'package:flutter_ecommerce_laravel/widgets/big_text.dart';

import 'package:flutter_ecommerce_laravel/widgets/icon_and_text.dart';
import 'package:flutter_ecommerce_laravel/widgets/small_text.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:get/get.dart';



class FoodPageBody extends StatefulWidget {
  const FoodPageBody({super.key});

  @override
  State<FoodPageBody> createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  PageController pageController = PageController(
    viewportFraction: 0.85,
  );

  var _currPageValue = 0.0;
  double _scaleFactor = 0.8;
  double _height = PageSize.pageViewContainer;
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currPageValue = pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //SLİDER
        GetBuilder<PopularProductController>(builder: (popularProducts) {
          return popularProducts.isLoaded==false ? Container(child: Center(child: CircularProgressIndicator(),)) :Container(
            height: PageSize.pageView,
            child: PageView.builder(
                controller: pageController,
                itemCount: popularProducts.popularProductList.length,
                itemBuilder: (context, index) {
                  return _buildPageItem(index,popularProducts.popularProductList[index]);
                }),
          );
        }),
          //DOTS
        GetBuilder<PopularProductController>(builder: (popularProducts) {
          return DotsIndicator(
          dotsCount: popularProducts.popularProductList.length>0? popularProducts.popularProductList.length:6 ,
          position: _currPageValue,
          decorator: DotsDecorator(
            activeColor: Colors.blueAccent,
            size: const Size.square(9.0),
            activeSize: const Size(18.0, 9.0),
            activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
          ),
        );
        }),

      
       
        //POPULAR TEXT
        SizedBox(
          height: PageSize.height15 * 2,
        ),
        Container(
          margin: EdgeInsets.only(
            left: PageSize.width15 * 2,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              BigText(
                title: "Recommended",
              ),
              SizedBox(
                width: PageSize.width10,
              ),
              Container(
                margin: const EdgeInsets.only(
                  bottom: 3,
                ),
                child: BigText(
                  title: ".",
                  color: Colors.blueGrey,
                ),
              ),
              SizedBox(
                width: PageSize.width10,
              ),
              Container(
                margin: const EdgeInsets.only(
                  bottom: 2,
                ),
                child: SmallText(title: "Food pairing"),
              ),
            ],
          ),
        ),
        //LİST OF FOOD AND İMAGES
        GetBuilder<RecommendedProductController>(builder: (recommendedProduct){
          return recommendedProduct.isLoaded? ListView.builder(
            padding: EdgeInsets.only(top: 20),
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: recommendedProduct.recommendedProductList.length,
            itemBuilder: (context, index) {
              final recommendedItems = recommendedProduct.recommendedProductList[index];
              return GestureDetector(
                onTap: (){
                  Get.toNamed(RouteHelper.getRecommendedFood(index,"home"));
                },
                child: Container(
                  margin: EdgeInsets.only(
                      left: PageSize.width20,
                      right: PageSize.width20,
                      bottom: PageSize.width10),
                  child: Row(
                    children: [
                      //IMAGE SEC.
                      Container(
                        width: PageSize.listViewImgSize,
                        height: PageSize.listViewImgSize,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(PageSize.radius20),
                          color: Colors.amberAccent,
                          image: DecorationImage(
                              image: NetworkImage(AppConst.BASE_URL+AppConst.UPLOAD_URL+recommendedItems.img!),
                              fit: BoxFit.cover),
                        ),
                      ),
                      // TEXT CONTAINER
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(),
                          height: PageSize.listViewTextSize,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(PageSize.radius20),
                              bottomRight: Radius.circular(PageSize.radius20),
                            ),
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: PageSize.width10,
                              right: PageSize.width10,
                              
                              
                            ),
              
                            ///SCROOL VAR
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: PageSize.height10,
                                  ),
                                  BigText(title: recommendedItems.name!),
                                  SizedBox(
                                    height: PageSize.height10,
                                  ),
                                  
                                SmallText(title:recommendedItems.description!,overFlow:TextOverflow.visible,),
                                  SizedBox(
                                    height: PageSize.height10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      IconAndText(
                                        icon: Icons.circle_sharp,
                                        text: "Normal",
                                        iconColor: Colors.amber,
                                      ),
                                      IconAndText(
                                        icon: Icons.location_on,
                                        text: "1.7km",
                                        iconColor: Colors.lightGreen,
                                      ),
                                      IconAndText(
                                        icon: Icons.access_time_rounded,
                                        text: "32min",
                                        iconColor: Colors.redAccent,
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: PageSize.height10,),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }):Container(child: Center(child: CircularProgressIndicator(),),);
        }),
        
      ],
    );
  }

  Widget _buildPageItem(int index,ProductModel popularProduct) {
    // Banner Animation
    Matrix4 matrix = new Matrix4.identity();
    if (index == _currPageValue.floor()) {
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor() + 1) {
      var currScale =
          _scaleFactor + (_currPageValue - index + 1) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor() - 1) {
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else {
      var currScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, _height * (1 - _scaleFactor) / 2, 0);
    }

    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          GestureDetector(
            onTap:() {
                Get.toNamed(RouteHelper.getPopularFood(index,"home"));
              },
            child: Container(
              height: _height,
              margin: EdgeInsets.only(
                left: PageSize.width10,
                right: PageSize.width10,
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(PageSize.radius30),
                  color: index.isEven ? Colors.amber : Colors.cyanAccent,
                  image: DecorationImage(
                    image: NetworkImage(
                     AppConst.BASE_URL+"/uploads/"+popularProduct.img!,
                    ),
                    fit: BoxFit.cover,
                  )),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: PageSize.pageViewTextContainer,
              margin: EdgeInsets.only(
                left: PageSize.width10 * 3,
                right: PageSize.width10 * 3,
                bottom: PageSize.height10 * 3,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(PageSize.radius20),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 5,
                    offset: Offset(0, 5),
                  ),
                  BoxShadow(
                    color: Colors.white,
                    offset: Offset(-5, 0),
                  ),
                  BoxShadow(
                    color: Colors.white,
                    offset: Offset(5, 0),
                  ),
                ],
              ),
              child: Container(
                padding: EdgeInsets.only(
                  top: PageSize.height20,
                  left: PageSize.height15,
                  right: PageSize.height15,
                ),
                child: AppColumn(
                  text: popularProduct.name!,
                  size: PageSize.font20,
                  stars: popularProduct.stars!,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
