import 'dart:async';

import 'package:flutter/material.dart';
import 'package:froozo/controllers/cart_controller.dart';
import 'package:froozo/controllers/popular_product_controller.dart';
import 'package:froozo/screens/cart/cart_page.dart';
import 'package:froozo/screens/home/home_page.dart';
import 'package:froozo/screens/home/main_food_page.dart';
import 'package:froozo/utils/app_constants.dart';
import 'package:froozo/utils/colors.dart';
import 'package:froozo/utils/dimensions.dart';
import 'package:froozo/widgets/app_icon.dart';
import 'package:froozo/widgets/big_text.dart';
import 'package:froozo/widgets/expandable_text_widget.dart';
import 'package:froozo/widgets/food_app_column.dart';
import 'package:froozo/widgets/icon_and_text_widget.dart';
import 'package:froozo/widgets/small_text.dart';
import 'package:get/get.dart';

class PopularFoodPage extends StatefulWidget {
  int pageId;
  PopularFoodPage({super.key, required this.pageId});

  @override
  State<PopularFoodPage> createState() => _PopularFoodPageState();
}
class _PopularFoodPageState extends State<PopularFoodPage> {
  @override
  Widget build(BuildContext context) {
    var product =
        Get.find<PopularProductController>().popularProductList[widget.pageId];
    Get.find<PopularProductController>()
        .initProduct(product, Get.find<CartController>());
    void refresh(){
      product = Get.find<PopularProductController>()
          .popularProductList[widget.pageId];
      Get
          .find<PopularProductController>()
          .initProduct(product, Get.find<CartController>());
    }
    FutureOr onGoBack(dynamic value) {
      refresh();
      setState(() {});
    }
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          //Background image
          Positioned(
              left: 0,
              right: 0,
              child: Container(
                width: double.maxFinite,
                height: Dimensions.popularFoodImgSize,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(AppConstants.BASE_URL +
                            "/uploads/" +
                            product.img))),
              )),
          //Icon Widgets
          Positioned(
              top: Dimensions.heigt45,
              left: Dimensions.width20,
              right: Dimensions.width20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                      onTap: () {
                        Get.to(HomePage());
                      },
                      child: AppIcon(
                        icon: Icons.arrow_back,
                        iconSize: Dimensions.icon24,
                      )),
                  GetBuilder<PopularProductController>(builder: (controller) {
                    return GestureDetector(
                      onTap: () {
                        Get.to(() => CartPage())!.then(onGoBack);
                      },
                      child: Stack(
                        children: [
                          AppIcon(
                            icon: Icons.shopping_cart_outlined,
                            iconSize: Dimensions.icon24,
                          ),
                          Get.find<PopularProductController>().getTotalItems > 0
                              ? Positioned(
                                  right: 0,
                                  top: 0,
                                  child: AppIcon(
                                    icon: Icons.circle,
                                    size: Dimensions.icon24,
                                    iconColor: Colors.transparent,
                                    backgroundColor: AppColors.mainColor,
                                  ),
                                )
                              : Container(),
                          Get.find<PopularProductController>().getTotalItems > 0
                              ? Positioned(
                                  right: 5,
                                  top: 5,
                                  child: SmallText(
                                    text: Get.find<PopularProductController>()
                                        .getTotalItems
                                        .toString(),
                                    color: Colors.white,
                                    size: Dimensions.font12,
                                  ))
                              : Container()
                        ],
                      ),
                    );
                  }),
                ],
              )),
          //Details
          Positioned(
            left: 0,
            right: 0,
            top: Dimensions.popularFoodImgSize - 20,
            bottom: 0,
            child: Container(
              padding: EdgeInsets.only(
                  left: Dimensions.width20,
                  right: Dimensions.width20,
                  top: Dimensions.heigt20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(Dimensions.radius20),
                      topRight: Radius.circular(Dimensions.radius20)),
                  color: Colors.white),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FoodAppColumn(
                    Maintext: product.name,
                  ),
                  SizedBox(
                    height: Dimensions.heigt15,
                  ),
                  BigText(text: "Introduction"),
                  SizedBox(
                    height: Dimensions.heigt20,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                        child: ExpandableTextWidget(text: product.description)),
                  )
                ],
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar:
          GetBuilder<PopularProductController>(builder: (popularProduct) {
        return Container(
          height: Dimensions.bottomHeightBar,
          padding: EdgeInsets.only(
              top: Dimensions.heigt20,
              bottom: Dimensions.heigt20,
              left: Dimensions.width20,
              right: Dimensions.width20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(Dimensions.radius20 * 2),
                topRight: Radius.circular(Dimensions.radius20 * 2),
              ),
              color: AppColors.buttonBackgroundColor),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Container(
              padding: EdgeInsets.only(
                  top: Dimensions.heigt20,
                  bottom: Dimensions.heigt20,
                  left: Dimensions.width20,
                  right: Dimensions.width20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                  color: Colors.white),
              child: Row(children: [
                GestureDetector(
                  onTap: () {
                    popularProduct.setValue(false);
                  },
                  child: Icon(
                    Icons.remove,
                    color: AppColors.signColor,
                  ),
                ),
                SizedBox(
                  width: Dimensions.width10,
                ),
                BigText(
                  text: popularProduct.inCartItems.toString(),
                ),
                SizedBox(
                  width: Dimensions.width10,
                ),
                GestureDetector(
                  onTap: () {
                    popularProduct.setValue(true);
                  },
                  child: Icon(
                    Icons.add,
                    color: AppColors.signColor,
                  ),
                )
              ]),
            ),
            GestureDetector(
              onTap: () {
                popularProduct.addItem(product);
              },
              child: Container(
                padding: EdgeInsets.only(
                    top: Dimensions.heigt20,
                    bottom: Dimensions.heigt20,
                    left: Dimensions.width20,
                    right: Dimensions.width20),
                child: BigText(
                  text: "\$ ${product.price} | Add to cart",
                  color: Colors.white,
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                    color: AppColors.mainColor),
              ),
            )
          ]),
        );
      }),
    );
  }
}
