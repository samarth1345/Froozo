import 'package:flutter/material.dart';
import 'package:froozo/utils/colors.dart';
import 'package:froozo/utils/dimensions.dart';
import 'package:froozo/widgets/big_text.dart';
import 'package:froozo/widgets/icon_and_text_widget.dart';
import 'package:froozo/widgets/small_text.dart';

class FoodAppColumn extends StatelessWidget {
  final String Maintext;
  const FoodAppColumn({super.key, required this.Maintext});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      BigText(
        text: Maintext,
        size: Dimensions.font26,
      ),
      SizedBox(height: Dimensions.heigt10),
      Row(
        children: [
          Wrap(
            children: List.generate(
                5,
                (index) => Icon(
                      Icons.star,
                      size: Dimensions.heigt15,
                      color: AppColors.mainColor,
                    )),
          ),
          SizedBox(
            width: Dimensions.width10,
          ),
          SmallText(text: "4.5"),
          SizedBox(
            width: Dimensions.width10,
          ),
          SmallText(text: "1287"),
          SizedBox(
            width: Dimensions.width3,
          ),
          SmallText(text: "Comments")
        ],
      ),
      SizedBox(height: Dimensions.heigt20),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconAndTextWidget(
              icon: Icons.circle,
              text: "Normal",
              iconColor: AppColors.iconColor1),
          IconAndTextWidget(
              icon: Icons.location_pin,
              text: "1.7km",
              iconColor: AppColors.mainColor),
          IconAndTextWidget(
              icon: Icons.timer,
              text: "32min",
              iconColor: AppColors.iconColor2),
        ],
      )
    ]);
  }
}
