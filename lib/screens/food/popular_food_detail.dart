import 'package:flutter/material.dart';
import 'package:froozo/utils/colors.dart';
import 'package:froozo/utils/dimensions.dart';
import 'package:froozo/widgets/app_icon.dart';
import 'package:froozo/widgets/big_text.dart';
import 'package:froozo/widgets/expandable_text_widget.dart';
import 'package:froozo/widgets/food_app_column.dart';
import 'package:froozo/widgets/icon_and_text_widget.dart';
import 'package:froozo/widgets/small_text.dart';

class PopularFoodPage extends StatelessWidget {
  const PopularFoodPage({super.key});

  @override
  Widget build(BuildContext context) {
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
                        image: AssetImage("assets/Images/Temp.jpg"))),
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
                    Maintext: "This is Froozo",
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
                        child: ExpandableTextWidget(
                            text:
                                "You will be offered 8 problems, dedicated to the adventures of a restless mathematician, a programmer and just a funny character named Rudolf, and 2 hours 15 minutes to solve them. Problems have expected difficulties to compose an interesting competition for participants with ratings up to 1600. However, all of you who wish to take part and have a rating of 1600 or higher, can register for the round unofficially")),
                  )
                ],
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: Container(
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
              Icon(
                Icons.remove,
                color: AppColors.signColor,
              ),
              SizedBox(
                width: Dimensions.width10,
              ),
              BigText(
                text: "0",
              ),
              SizedBox(
                width: Dimensions.width10,
              ),
              Icon(
                Icons.add,
                color: AppColors.signColor,
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
              text: "\$100 | Add to cart",
              color: Colors.white,
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius20),
                color: AppColors.mainColor),
          )
        ]),
      ),
    );
  }
}
