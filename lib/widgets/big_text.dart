import 'package:flutter/material.dart';
import 'package:froozo/utils/dimensions.dart';

class BigText extends StatelessWidget {
  Color? color;
  String text;
  double size;
  TextOverflow overflow;
  BigText(
      {Key? key,
      this.color = const Color(0xFF332d2b),
      required this.text,
      this.overflow = TextOverflow.ellipsis,
      this.size = 0})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    if (text.length > 27) {
      text = text.substring(0, 27) + "..";
    }
    return Text(
      maxLines: 1,
      text,
      overflow: overflow,
      style: TextStyle(
          color: color,
          fontWeight: FontWeight.w400,
          fontFamily: 'Roboto',
          fontSize: size == 0 ? Dimensions.font20 : size),
    );
  }
}
