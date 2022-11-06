import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_laravel/home/food_page_body.dart';
import 'package:flutter_ecommerce_laravel/utils/utils.dart';
import 'package:flutter_ecommerce_laravel/widgets/big_text.dart';
import 'package:flutter_ecommerce_laravel/widgets/small_text.dart';

class MainFoodPage extends StatefulWidget {
  const MainFoodPage({super.key});

  @override
  State<MainFoodPage> createState() => _MainFoodPageState();
}

class _MainFoodPageState extends State<MainFoodPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Column(
        children: [
          // showing the header

          Container(
            child: Container(
              margin: EdgeInsets.only(
                top: PageSize.height45,
                bottom: PageSize.height15,
              ),
              padding: EdgeInsets.only(
                left: PageSize.width20,
                right: PageSize.width20,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      BigText(
                        title: "Turkey",
                        color: Colors.blue[900],
                      ),
                      Row(
                        children: [
                          SmallText(title: "Bursa"),
                          Icon(
                            Icons.arrow_drop_down,
                            color: Colors.blueGrey,
                          ),
                        ],
                      ),
                    ],
                  ),
                  Center(
                    child: Container(
                      width: PageSize.height45,
                      height: PageSize.height45,
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(PageSize.radius30 / 2),
                        color: Colors.blueAccent,
                      ),
                      child: Icon(
                        Icons.search,
                        color: Colors.white,
                        size: PageSize.iconSize24,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          //showing the body
          Expanded(
            child: SingleChildScrollView(
              child: FoodPageBody(),
            ),
          ),
        ],
      ),
    );
  }
}
