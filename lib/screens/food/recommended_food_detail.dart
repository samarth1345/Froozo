import 'package:flutter/material.dart';
import 'package:froozo/controllers/recommended_product_controller.dart';
import 'package:froozo/utils/app_constants.dart';
import 'package:froozo/utils/colors.dart';
import 'package:froozo/utils/dimensions.dart';
import 'package:froozo/widgets/app_icon.dart';
import 'package:froozo/widgets/big_text.dart';
import 'package:froozo/widgets/expandable_text_widget.dart';
import 'package:froozo/widgets/small_text.dart';
import 'package:get/get.dart';

class RecommendedFoodDetail extends StatelessWidget {
  int pageId;
  RecommendedFoodDetail({super.key, required this.pageId});
  @override
  Widget build(BuildContext context) {
    var product =
        Get.find<RecommendedProductController>().recommendedProductList[pageId];
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: Dimensions.heigt70,
            title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    child: AppIcon(icon: Icons.clear),
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  AppIcon(
                    icon: Icons.shopping_cart_checkout_outlined,
                  )
                ]),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(30),
              child: Container(
                child: Center(
                  child: BigText(
                    text: product.name,
                    size: Dimensions.font26,
                  ),
                ),
                width: double.maxFinite,
                padding: EdgeInsets.only(
                    top: Dimensions.height5, bottom: Dimensions.heigt10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(Dimensions.radius20),
                      topRight: Radius.circular(Dimensions.radius20),
                    )),
              ),
            ),
            pinned: true,
            backgroundColor: AppColors.yellowColor,
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
                background: Image.network(
              AppConstants.BASE_URL + "/uploads/" + product.img,
              width: double.maxFinite,
              fit: BoxFit.cover,
            )),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                    margin: EdgeInsets.only(
                        left: Dimensions.width20,
                        right: Dimensions.width20,
                        bottom: Dimensions.heigt20),
                    child: ExpandableTextWidget(
                        textHeightfact: 3, text: product.description))
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.only(
              left: Dimensions.width45,
              right: Dimensions.width45,
              top: Dimensions.heigt10,
              bottom: Dimensions.heigt10,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppIcon(
                  icon: Icons.remove,
                  backgroundColor: AppColors.mainColor,
                  iconColor: Colors.white,
                  iconSize: Dimensions.icon24,
                ),
                BigText(
                  text: "\$ ${product.price} " + "X" + " 0",
                  color: AppColors.mainBlackColor,
                  size: Dimensions.font26,
                ),
                AppIcon(
                  icon: Icons.add,
                  backgroundColor: AppColors.mainColor,
                  iconColor: Colors.white,
                  iconSize: Dimensions.icon24,
                ),
              ],
            ),
          ),
          Container(
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
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      padding: EdgeInsets.only(
                          top: Dimensions.heigt20,
                          bottom: Dimensions.heigt20,
                          left: Dimensions.width20,
                          right: Dimensions.width20),
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(Dimensions.radius20),
                          color: Colors.white),
                      child: Icon(
                        Icons.favorite,
                        color: AppColors.mainColor,
                        size: Dimensions.icon24,
                      )),
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
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius20),
                        color: AppColors.mainColor),
                  )
                ]),
          ),
        ],
      ),
    );
  }
}
