import 'package:flutter/material.dart';
import 'package:froozo/data/repository/cart_repo.dart';
import 'package:froozo/models/cart_model.dart';
import 'package:froozo/models/popular_product.dart';
import 'package:froozo/screens/cart/cart_history.dart';
import 'package:froozo/utils/colors.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  final CartRepo cartRepo;
  CartController({required this.cartRepo});
  Map<int, CartModel> _items = {};
  Map<int, CartModel> get items => _items;
  List<CartModel> storageItems = [];
  void addItem(PopularProducts product, int quantity, int prev) {
    debugPrint("called " + quantity.toString() + " " + prev.toString());
    if (prev + quantity > 0) {
      if (_items.containsKey(product.id!)) {
        _items.update(product.id!, (value) {
          return CartModel(
              id: product.id,
              name: product.name,
              price: product.price,
              img: product.img,
              quantity: value.quantity! + quantity,
              isExist: true,
              product: product,
              time: DateTime.now().toString());
        });
      } else {
        _items.putIfAbsent(product.id!, () {
          return CartModel(
              id: product.id,
              name: product.name,
              price: product.price,
              img: product.img,
              quantity: quantity,
              isExist: true,
              product: product,
              time: DateTime.now().toString());
        });
      }
    } else if (prev + quantity == 0) {
      _items.remove(product.id);
    } else {
      Get.snackbar("No Items Added", "Please add atleast one item!",
          backgroundColor: AppColors.mainColor, colorText: Colors.white);
    }
    cartRepo.addToCartList(getItems);
    update();
  }

  bool existInCart(PopularProducts product) {
    if (_items.containsKey(product.id)) return true;
    return false;
  }

  int getQuantity(PopularProducts product) {
    var quantity = 0;
    _items.forEach((key, value) {
      if (key == product.id) quantity = value.quantity!;
    });
    return quantity;
  }

  int get totalQuantity {
    var quantity = 0;
    _items.forEach((key, value) {
      quantity += value.quantity!;
    });
    return quantity;
  }

  List<CartModel> get getItems {
    return _items.entries.map((e) {
      return e.value;
    }).toList();
  }

  int getTotalAmount() {
    var total = 0;
    _items.forEach((key, value) {
      total += ((value.quantity!) * (value.price!));
    });
    return total;
  }

  List<CartModel> getCartData() {
    setCart = cartRepo.getCartList();
    return storageItems;
  }

  set setCart(List<CartModel> items) {
    storageItems = items;
    for (int i = 0; i < storageItems.length; i++) {
      _items.putIfAbsent(storageItems[i].product!.id!, () => storageItems[i]);
    }
  }

  void addToHistory() {
    cartRepo.addToCartHistoryList();
    clear();
  }

  void clear() {
    _items = {};
    update();
  }

  List<CartModel> getCartHistoryList() {
    return cartRepo.getCartHistoryList();
  }

  set setItems(Map<int, CartModel> setItems) {
    _items = {};
    _items = setItems;
    cartRepo.addToCartList(getItems);
    update(); 
  }
}
