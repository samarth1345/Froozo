import 'package:flutter/material.dart';
import 'package:froozo/controllers/cart_controller.dart';
import 'package:froozo/controllers/location_controller.dart';
import 'package:froozo/controllers/popular_product_controller.dart';
import 'package:froozo/controllers/recommended_product_controller.dart';
import 'package:froozo/screens/address/add_address_page.dart';
import 'package:froozo/screens/auth/sign_up_page.dart';
import 'package:froozo/screens/cart/cart_page.dart';
import 'package:froozo/screens/food/popular_food_detail.dart';
import 'package:froozo/screens/food/recommended_food_detail.dart';
import 'package:froozo/screens/home/home_page.dart';
import 'package:froozo/screens/home/main_food_page.dart';
import 'package:froozo/screens/splash/splash_screen.dart';
import 'package:get/get.dart';
import 'helper/dependencies.dart' as dep;
import 'dart:developer' as logger;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    Get.find<PopularProductController>().getPopularProductList();
    Get.find<RecommendedProductController>().getRecommendedProductList();
    Get.find<CartController>().getCartData();
    Get.find<LocationController>().setPermissions();
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Froozo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: SplashScreen(),
      // home: AddAddressPage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
//7:28:35
