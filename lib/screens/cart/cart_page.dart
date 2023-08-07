import 'package:flutter/material.dart';
import 'package:froozo/screens/address/add_address_page.dart';
import 'package:froozo/screens/home/home_page.dart';
import 'package:froozo/screens/home/main_food_page.dart';
import 'package:froozo/utils/app_constants.dart';
import 'package:froozo/utils/colors.dart';
import 'package:froozo/utils/dimensions.dart';
import 'package:froozo/widgets/app_icon.dart';
import 'package:froozo/widgets/big_text.dart';
import 'package:froozo/widgets/small_text.dart';
import 'package:froozo/controllers/cart_controller.dart';
import 'package:get/get.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
          //App Bar
          Positioned(
              top: Dimensions.heigt30 * 2,
              left: Dimensions.width20,
              right: Dimensions.width20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: AppIcon(
                      icon: Icons.arrow_back_rounded,
                      iconSize: Dimensions.icon24,
                      backgroundColor: AppColors.mainColor,
                      iconColor: Colors.white,
                    ),
                  ),
                  SizedBox(
                    width: Dimensions.width45 * 2,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(HomePage());
                    },
                    child: AppIcon(
                      icon: Icons.home_filled,
                      iconSize: Dimensions.icon24,
                      backgroundColor: AppColors.mainColor,
                      iconColor: Colors.white,
                    ),
                  ),
                  AppIcon(
                    icon: Icons.shopping_cart,
                    iconSize: Dimensions.icon24,
                    backgroundColor: AppColors.mainColor,
                    iconColor: Colors.white,
                  ),
                ],
              )),
          Positioned(
            top: Dimensions.heigt45 * (2.5),
            left: Dimensions.width20,
            right: Dimensions.width20,
            bottom: 0,
            child: Container(
              // color: Colors.red,
              child: MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: GetBuilder<CartController>(builder: (Controller) {
                  return ListView.builder(
                      itemCount: Controller.getItems.length,
                      itemBuilder: (_, index) {
                        var Curr_item = Controller.getItems[index];
                        // var Curr_item = Curr_item;
                        return Container(
                          width: double.maxFinite,
                          height: Dimensions.heigt20 * 5,
                          margin: EdgeInsets.only(bottom: Dimensions.heigt10),
                          color: Colors.white,
                          child: Row(children: [
                            Container(
                              height: Dimensions.heigt20 * 5,
                              width: Dimensions.heigt20 * 5,
                              margin: EdgeInsets.only(left: Dimensions.width10),
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          AppConstants.BASE_URL +
                                              "/uploads/" +
                                              Curr_item.img!),
                                      fit: BoxFit.cover),
                                  borderRadius: BorderRadius.circular(
                                      Dimensions.radius20),
                                  color: Colors.blue),
                            ),
                            SizedBox(
                              width: Dimensions.width10,
                            ),
                            Expanded(
                                child: Container(
                              height: Dimensions.heigt20 * 5,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  BigText(text: Curr_item.name!),
                                  SmallText(text: "Nothing"),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      BigText(
                                        text:
                                            "\$ " + Curr_item.price.toString(),
                                        color: Colors.redAccent,
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(
                                            top: Dimensions.heigt10,
                                            bottom: Dimensions.heigt10,
                                            left: Dimensions.width10,
                                            right: Dimensions.width10),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                                Dimensions.radius20),
                                            color: Colors.white),
                                        child: Row(children: [
                                          GestureDetector(
                                            onTap: () {
                                              Controller.addItem(
                                                  Curr_item.product!,
                                                  -1,
                                                  Curr_item.quantity!);
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
                                            text: Controller
                                                .getItems[index].quantity
                                                .toString(),
                                          ),
                                          SizedBox(
                                            width: Dimensions.width10,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              Controller.addItem(
                                                  Curr_item.product!,
                                                  1,
                                                  Curr_item.quantity!);
                                            },
                                            child: Icon(
                                              Icons.add,
                                              color: AppColors.signColor,
                                            ),
                                          )
                                        ]),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ))
                          ]),
                        );
                      });
                }),
              ),
            ),
          )
        ]),
        bottomNavigationBar: GetBuilder<CartController>(builder: (Controller) {
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
                    child: Row(children: [
                      SizedBox(
                        width: Dimensions.width10,
                      ),
                      BigText(
                        text: '\$ ' + Controller.getTotalAmount().toString(),
                      ),
                      SizedBox(
                        width: Dimensions.width10,
                      ),
                    ]),
                  ),
                  GestureDetector(
                    onTap: () {
                      Controller.addToHistory();
                      Get.to(AddAddressPage());
                    },
                    child: Container(
                      padding: EdgeInsets.only(
                          top: Dimensions.heigt20,
                          bottom: Dimensions.heigt20,
                          left: Dimensions.width20,
                          right: Dimensions.width20),
                      child: BigText(
                        text: "Check Out",
                        color: Colors.white,
                      ),
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(Dimensions.radius20),
                          color: AppColors.mainColor),
                    ),
                  )
                ]),
          );
        }));
  }
}
