import 'package:flutter/material.dart';
import 'package:froozo/utils/colors.dart';
import 'package:froozo/utils/dimensions.dart';
import 'package:froozo/widgets/app_icon.dart';
import 'package:froozo/widgets/big_text.dart';
import 'package:get/get.dart';

class AccountWidget extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color iconBackgroundColor;
  const AccountWidget(
      {super.key,
      required this.icon,
      required this.text,
      required this.iconBackgroundColor});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
            offset: Offset(0, 5),
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 1),
      ]),
      padding: EdgeInsets.only(
        left: Dimensions.width10,
        top: Dimensions.width10,
        bottom: Dimensions.width10,
      ),
      width: double.maxFinite,
      child: Row(children: [
        AppIcon(
          icon: icon,
          backgroundColor: iconBackgroundColor,
          iconColor: Colors.white,
          iconSize: Dimensions.icon18 * 2,
          size: Dimensions.icon24 * 2,
        ),
        SizedBox(
          width: Dimensions.width20,
        ),
        BigText(text: text)
      ]),
    );
  }
}
