import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:froozo/models/cart_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartRepo {
  final SharedPreferences sharedPreferences;
  CartRepo({required this.sharedPreferences});
  List<String> cart = [];
  List<String> cartHistory = [];
  void addToCartList(List<CartModel> cartList) {
    var time = DateTime.now().toString();
    cart = [];
    cartList.forEach((element) {
      //change the time to latest time for all the items in the current cart
      element.time = time;
      return cart.add(jsonEncode(element.toJson()));
    });
    sharedPreferences.setStringList("Cart-List", cart);
  }

  List<CartModel> getCartList() {
    // sharedPreferences.remove('cart-history-list');
    // sharedPreferences.remove('Cart-List');
    List<CartModel> list = [];
    if (sharedPreferences.containsKey("Cart-List")) {
      cart = sharedPreferences.getStringList("Cart-List")!;
      sharedPreferences.getStringList("Cart-List")!.forEach((element) {
        list.add(CartModel.fromJson(jsonDecode(element)));
      });
    }
    return list;
  }

  void addToCartHistoryList() {
    if (sharedPreferences.containsKey('cart-history-list')) {
      cartHistory = sharedPreferences.getStringList('cart-history-list')!;
    }
    cart.forEach((element) {
      cartHistory.add(element);
    });
    removeCart();
    sharedPreferences.setStringList('cart-history-list', cartHistory);
    // print(cartHistory.length);
    // cartHistory.forEach((element) {
    //   print(element);
    // });
  }

  void removeCart() {
    cart = [];
    sharedPreferences.remove('Cart-List');
  }

  List<CartModel> getCartHistoryList() {
    List<CartModel> list = [];
    if (sharedPreferences.containsKey('cart-history-list')) {
      cartHistory = [];
      cartHistory = sharedPreferences.getStringList('cart-history-list')!;
    }
    cartHistory.forEach((element) {
      list.add(CartModel.fromJson(jsonDecode(element)));
    });
    return list;
  }
}
