import 'package:froozo/controllers/cart_controller.dart';
import 'package:froozo/controllers/location_controller.dart';
import 'package:froozo/controllers/popular_product_controller.dart';
import 'package:froozo/controllers/recommended_product_controller.dart';
import 'package:froozo/data/api/api_client.dart';
import 'package:froozo/data/repository/cart_repo.dart';
import 'package:froozo/data/repository/location_repo.dart';
import 'package:froozo/data/repository/popular_product_repo.dart';
import 'package:froozo/data/repository/recommended_product_repo.dart';
import 'package:froozo/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

Future<void> init() async {
  //local storage
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences);

  //api client
  Get.lazyPut(() => ApiClient(appBaseUrl: AppConstants.BASE_URL));

  //repos
  Get.lazyPut(() => PopularProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => RecommendedProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => CartRepo(sharedPreferences: Get.find()));
  Get.lazyPut(
      () => LocationRepo(apiClient: Get.find(), sharedPreferences: Get.find()));

  //controllers
  Get..lazyPut(() => PopularProductController(popularProductRepo: Get.find()));
  Get.lazyPut(
      () => RecommendedProductController(recommendedProductRepo: Get.find()));
  Get.lazyPut(() => CartController(cartRepo: Get.find()));
  Get.lazyPut(() => LocationController(locationRepo: Get.find()));
}
