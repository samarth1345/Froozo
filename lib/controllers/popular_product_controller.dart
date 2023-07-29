import 'package:flutter/material.dart';
import 'package:froozo/controllers/cart_controller.dart';
import 'package:froozo/data/repository/popular_product_repo.dart';
import 'package:froozo/models/cart_model.dart';
import 'package:froozo/models/popular_product.dart';
import 'package:get/get.dart';

class PopularProductController extends GetxController {
  final PopularProductRepo popularProductRepo;
  PopularProductController({required this.popularProductRepo});
  List<dynamic> _popularProductList = [];
  List<dynamic> get popularProductList => _popularProductList;

  late CartController _cart;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  int _quantity = 0;
  int get quantity => _quantity;

  int _inCartItems = 0;
  int get inCartItems => _inCartItems + _quantity;

  Future<void> getPopularProductList() async {
    Response response = await popularProductRepo.getPopularProductList();
    if (response.statusCode == 200) {
      // debugPrint("output: this is working");
      _popularProductList = [];
      _popularProductList.addAll(Product.fromJson(response.body).products);
      update();
      _isLoaded = true;
    } else {
      // debugPrint("output" + response.body.toString());
    }
  }

  void setValue(bool increment) {
    if (increment) {
      _quantity++;
    } else if ((_quantity + _inCartItems) > 0) {
      _quantity--;
    }
    debugPrint(_inCartItems.toString() + " " + _quantity.toString());
    update();
  }

  void initProduct(PopularProducts product, CartController cart) {
    _quantity = 0;
    _inCartItems = 0;
    _cart = cart;
    var exist = false;
    exist = cart.existInCart(product);
    if (exist) {
      _inCartItems = cart.getQuantity(product);
    }
  }

  void addItem(PopularProducts product) {
    _cart.addItem(product, _quantity, _inCartItems);
    _quantity = 0;
    _inCartItems = _cart.getQuantity(product);
    update();
  }

  int get getTotalItems {
    return _cart.totalQuantity;
  }

  List<CartModel> get getItems {
    return _cart.getItems;
  }
}
