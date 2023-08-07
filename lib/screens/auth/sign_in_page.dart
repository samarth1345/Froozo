import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:froozo/screens/auth/sign_up_page.dart';
import 'package:froozo/screens/home/home_page.dart';
import 'package:froozo/utils/colors.dart';
import 'package:froozo/utils/dimensions.dart';
import 'package:froozo/widgets/app_text_field.dart';
import 'package:froozo/widgets/big_text.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});
  static List<String> logos = [
    "assets/Images/google.png",
    "assets/Images/twitter.png",
    "assets/Images/facebook.png",
  ];
  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    // var intl = Intl();
    void authorize() {
      if (emailController.text.isEmpty) {
        Get.snackbar("Error", "Please enter your email");
        return;
      }
      if (passwordController.text.isEmpty) {
        Get.snackbar("Error", "Please enter your password");
      }
      if (emailController.text == "bsamarth56@gmail.com" &&
          passwordController.text == "password") {
        Get.to(HomePage());
      } else {
        Get.snackbar("Error", "Email or password incorrect");
      }
    }

    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(children: [
          SizedBox(
            height: Dimensions.heigt40 * 2,
          ),
          Center(
            child: Container(
              height: Dimensions.heigt40 * 4,
              width: Dimensions.width20 * 8,
              child: Image(image: AssetImage("assets/Images/logo3.png")),
            ),
          ),
          SizedBox(
            height: Dimensions.heigt40,
          ),
          AppTextField(
              controller: emailController,
              hintText: "Email",
              icon: Icons.email,
              iconColor: AppColors.yellowColor),
          SizedBox(
            height: Dimensions.heigt20,
          ),
          AppTextField(
              controller: passwordController,
              hintText: "Password",
              icon: Icons.password_sharp,
              iconColor: AppColors.yellowColor),
          SizedBox(
            height: Dimensions.heigt20,
          ),
          GestureDetector(
            onTap: () => authorize(),
            child: Container(
              width: Dimensions.width45 * 6,
              height: Dimensions.heigt30 * 2,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius30),
                  color: AppColors.mainColor),
              child: Center(
                child: BigText(
                  text: "Sign in",
                  size: Dimensions.font20 + Dimensions.font20 / 2,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          // SizedBox(
          //   height: Dimensions.heigt20,
          // ),
          // RichText(
          //   text: TextSpan(
          //       text: "Don't have an account ?",
          //       style: TextStyle(
          //           color: Colors.grey[500], fontSize: Dimensions.font16),
          //       recognizer: TapGestureRecognizer()
          //         ..onTap = () => Get.to(SignUpPage())),
          //   // selectionColor: AppColors.mainBlackColor,
          // ),
        ]),
      ),
    );
  }
}
