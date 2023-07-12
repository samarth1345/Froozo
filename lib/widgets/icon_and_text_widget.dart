import 'package:flutter/material.dart';
import 'package:froozo/utils/dimensions.dart';
import 'package:froozo/widgets/small_text.dart';

class IconAndTextWidget extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color iconColor;
  final double IconSize;
  final double TextSize;
  const IconAndTextWidget(
      {Key? key,
      required this.icon,
      required this.text,
      required this.iconColor,
      this.IconSize = 0,
      this.TextSize = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: iconColor,
          size: IconSize == 0 ? Dimensions.icon24 : IconSize,
        ),
        SizedBox(
          width: 5,
        ),
        SmallText(
          text: text,
          size: TextSize,
        )
      ],
    );
  }
}
