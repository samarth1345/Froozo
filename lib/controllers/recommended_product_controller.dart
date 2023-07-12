import 'package:flutter/material.dart';
import 'package:froozo/controllers/recommended_product_controller.dart';
import 'package:froozo/data/repository/recommended_product_repo.dart';
import 'package:froozo/models/popular_product.dart';
import 'package:get/get.dart';

class RecommendedProductController extends GetxController {
  final RecommendedProductRepo recommendedProductRepo;
  RecommendedProductController({required this.recommendedProductRepo});
  List<dynamic> _recommendedProductList = [];
  List<dynamic> get recommendedProductList => _recommendedProductList;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  Future<void> getRecommendedProductList() async {
    Response response =
        await recommendedProductRepo.getRecommendedProductList();
    if (response.statusCode == 200) {
      // debugPrint("output:Okay we are getting recommended");
      _recommendedProductList = [];
      _recommendedProductList.addAll(Product.fromJson(response.body).products);
      update();
      _isLoaded = true;
    } else {}
  }
}
