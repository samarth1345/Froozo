import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:froozo/screens/auth/sign_in_page.dart';
import 'package:froozo/utils/colors.dart';
import 'package:froozo/utils/dimensions.dart';
import 'package:froozo/widgets/app_text_field.dart';
import 'package:froozo/widgets/big_text.dart';
import 'package:get/get.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});
  static List<String> logos = [
    "assets/Images/google.png",
    "assets/Images/twitter.png",
    "assets/Images/facebook.png",
  ];
  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();
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
          AppTextField(
              controller: nameController,
              hintText: "Name",
              icon: Icons.person,
              iconColor: AppColors.yellowColor),
          SizedBox(
            height: Dimensions.heigt20,
          ),
          AppTextField(
              controller: phoneController,
              hintText: "Phone",
              icon: Icons.phone,
              iconColor: AppColors.yellowColor),
          SizedBox(
            height: Dimensions.heigt20,
          ),
          Container(
            width: Dimensions.width45 * 6,
            height: Dimensions.heigt30 * 2,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius30),
                color: AppColors.mainColor),
            child: Center(
              child: BigText(
                text: "Sign up",
                size: Dimensions.font20 + Dimensions.font20 / 2,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(
            height: Dimensions.heigt20,
          ),
          RichText(
            text: TextSpan(
                text: "Have an account already?",
                style: TextStyle(
                    color: Colors.grey[500], fontSize: Dimensions.font20),
                recognizer: TapGestureRecognizer()
                  ..onTap = () => Get.to(SignInPage())),
            // selectionColor: AppColors.mainBlackColor,
          ),
          SizedBox(
            height: Dimensions.heigt20,
          ),
          RichText(
            text: TextSpan(
                text: "Sign up using one of the methods",
                style: TextStyle(
                    color: Colors.grey[500], fontSize: Dimensions.font16),
                recognizer: TapGestureRecognizer()..onTap = () => Get.back()),
            // selectionColor: AppColors.mainBlackColor,
          ),
          Wrap(
            children: List.generate(
                3,
                (index) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: Dimensions.heigt30 * 2,
                        width: Dimensions.width30 * 2,
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius30)),
                        child: Image(image: AssetImage(logos[index])),
                      ),
                    )),
          )
        ]),
      ),
    );
  }
}
