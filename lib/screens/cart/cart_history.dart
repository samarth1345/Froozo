import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:froozo/controllers/cart_controller.dart';
import 'package:froozo/models/cart_model.dart';
import 'package:froozo/screens/cart/cart_page.dart';
import 'package:froozo/utils/app_constants.dart';
import 'package:froozo/utils/colors.dart';
import 'package:froozo/utils/dimensions.dart';
import 'package:froozo/widgets/app_icon.dart';
import 'package:froozo/widgets/big_text.dart';
import 'package:froozo/widgets/small_text.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CartHistory extends StatefulWidget {
  const CartHistory({super.key});
  @override
  State<CartHistory> createState() => _CartHistoryState();
}

class _CartHistoryState extends State<CartHistory> {
  @override
  Widget build(BuildContext context) {
    var getCartHistoryList =
        Get.find<CartController>().getCartHistoryList().reversed.toList();
    Map<String, int> cartItemsPerOrder = Map();
    for (int i = 0; i < getCartHistoryList.length; i++) {
      if (cartItemsPerOrder.containsKey(getCartHistoryList[i].time)) {
        cartItemsPerOrder.update(
            getCartHistoryList[i].time!, (value) => ++value);
      } else {
        cartItemsPerOrder.putIfAbsent(getCartHistoryList[i].time!, () => 1);
      }
    }
    List<int> cartOrderCountToList() {
      return cartItemsPerOrder.entries.map((e) => e.value).toList();
    }

    List<String> cartOrderTimeToList() {
      return cartItemsPerOrder.entries.map((e) => e.key).toList();
    }

    List<int> itemsPerOrder = cartOrderCountToList();
    var listCounter = 0;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: AppColors.mainColor,
          title: Center(
              child: Text(
            "Cart History",
            style: TextStyle(color: Colors.white, fontSize: Dimensions.font26),
          )),
          actions: [
            AppIcon(
              icon: Icons.shopping_cart,
              iconSize: Dimensions.icon24,
              iconColor: AppColors.mainColor,
            ),
          ],
        ),
        body: getCartHistoryList.length > 0
            ? Column(children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(
                      top: Dimensions.heigt20,
                      left: Dimensions.width20,
                      right: Dimensions.width20,
                    ),
                    child: MediaQuery.removePadding(
                      removeTop: true,
                      context: context,
                      child: ListView(
                        children: [
                          for (int i = 0; i < cartItemsPerOrder.length; i++)
                            Container(
                              height: Dimensions.heigt40 * 3,
                              margin:
                                  EdgeInsets.only(bottom: Dimensions.heigt20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  (() {
                                    DateTime parseDate =
                                        DateFormat("yyyy-MM-dd HH:mm:ss").parse(
                                            getCartHistoryList[listCounter]
                                                .time!);
                                    var inputDate =
                                        DateTime.parse(parseDate.toString());
                                    var outputFormat =
                                        DateFormat("MM/dd/yyyy hh:mm a");
                                    var outputDate =
                                        outputFormat.format(inputDate);
                                    return BigText(text: outputDate);
                                  }()),
                                  SizedBox(
                                    height: Dimensions.heigt10,
                                  ),
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Wrap(
                                          direction: Axis.horizontal,
                                          children: List.generate(
                                              itemsPerOrder[i], (index) {
                                            if (listCounter <
                                                getCartHistoryList.length)
                                              listCounter++;
                                            return index <= 2
                                                ? Container(
                                                    margin: EdgeInsets.only(
                                                        right:
                                                            Dimensions.width5),
                                                    height: 80,
                                                    width: 80,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                Dimensions
                                                                    .radius20),
                                                        image: DecorationImage(
                                                            fit: BoxFit.cover,
                                                            image: NetworkImage(AppConstants
                                                                    .BASE_URL +
                                                                '/uploads/' +
                                                                getCartHistoryList[
                                                                        listCounter -
                                                                            1]
                                                                    .img!))),
                                                  )
                                                : Container();
                                          }),
                                        ),
                                        Container(
                                          height: Dimensions.heigt40 * 2,
                                          child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SmallText(
                                                  text: "Total",
                                                  color: AppColors.titleColor,
                                                ),
                                                BigText(
                                                    text: itemsPerOrder[i]
                                                            .toString() +
                                                        " Items"),
                                                GestureDetector(
                                                  onTap: () {
                                                    var orderTime =
                                                        cartOrderTimeToList();
                                                    print(orderTime[i]);
                                                    Map<int, CartModel>
                                                        moreorder = {};
                                                    for (int j = 0;
                                                        j <
                                                            getCartHistoryList
                                                                .length;
                                                        j++) {
                                                      print(
                                                          getCartHistoryList[j]
                                                              .time);
                                                      if (getCartHistoryList[j]
                                                              .time ==
                                                          orderTime[i]) {
                                                        moreorder.putIfAbsent(
                                                            getCartHistoryList[j]
                                                                .id!,
                                                            () => CartModel.fromJson(
                                                                jsonDecode(jsonEncode(
                                                                    getCartHistoryList[
                                                                        j]))));
                                                      }
                                                    }
                                                    Get.find<CartController>()
                                                        .setItems = moreorder;
                                                    Get.to(CartPage());
                                                  },
                                                  child: Container(
                                                    padding: EdgeInsets.all(
                                                        Dimensions.height3),
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                Dimensions
                                                                    .radius5),
                                                        border: Border.all(
                                                            width: 2,
                                                            color: AppColors
                                                                .mainColor)),
                                                    child: SmallText(
                                                      text: "Add More",
                                                      color:
                                                          AppColors.mainColor,
                                                    ),
                                                  ),
                                                )
                                              ]),
                                        )
                                      ])
                                ],
                              ),
                            )
                        ],
                      ),
                    ),
                  ),
                )
              ])
            : Center(
                child:
                    Image(image: AssetImage("assets/Images/empty_cart.jpg"))));
  }
}
