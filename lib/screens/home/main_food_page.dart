import 'package:flutter/material.dart';
import 'package:froozo/controllers/cart_controller.dart';
import 'package:froozo/controllers/popular_product_controller.dart';
import 'package:froozo/controllers/recommended_product_controller.dart';
import 'package:froozo/screens/home/food_page_body.dart';
import 'package:froozo/utils/dimensions.dart';
import 'package:froozo/widgets/big_text.dart';
import 'package:froozo/widgets/small_text.dart';
import 'package:get/get.dart';
import '../../utils/colors.dart';

class MainFoodPage extends StatefulWidget {
  const MainFoodPage({super.key});

  @override
  State<MainFoodPage> createState() => _MainFoodPageState();
}

class _MainFoodPageState extends State<MainFoodPage> {
  Future<void> _loadResource() async {
    await Get.find<PopularProductController>().getPopularProductList();
    await Get.find<RecommendedProductController>().getRecommendedProductList();
    Get.find<CartController>().getCartData();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _loadResource,
      child: Column(
        children: [
          Container(
              margin: EdgeInsets.only(
                  top: Dimensions.heigt45, bottom: Dimensions.heigt15),
              padding: EdgeInsets.only(
                  left: Dimensions.heigt20, right: Dimensions.heigt20),
              child: Container(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      BigText(
                        text: "INDIA",
                        color: AppColors.mainColor,
                      ),
                      Row(
                        children: [
                          SmallText(
                            text: "City",
                            color: Colors.black54,
                          ),
                          Icon(Icons.arrow_drop_down_rounded)
                        ],
                      )
                    ],
                  ),
                  Center(
                    child: Container(
                      width: Dimensions.heigt45,
                      height: Dimensions.heigt45,
                      child: Icon(Icons.search,
                          color: Colors.white, size: Dimensions.icon24),
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius15),
                        color: AppColors.mainColor,
                      ),
                    ),
                  )
                ],
              ))),
          Expanded(
              child: SingleChildScrollView(
            child: FoodPageBody(),
          )),
        ],
      ),
    );
  }
}
