import 'package:flutter/material.dart';
import 'package:froozo/controllers/popular_product_controller.dart';
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

class PopularFoodPage extends StatelessWidget {
  int pageId;
  PopularFoodPage({super.key, required this.pageId});
  @override
  Widget build(BuildContext context) {
    var product =
        Get.find<PopularProductController>().popularProductList[pageId];
    Get.find<PopularProductController>().initProduct();
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
                        Navigator.of(context).pop();
                      },
                      child: AppIcon(icon: Icons.arrow_back)),
                  AppIcon(icon: Icons.shopping_cart_checkout_outlined),
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
                  text: popularProduct.quantity.toString(),
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
            Container(
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
            )
          ]),
        );
      }),
    );
  }
}
