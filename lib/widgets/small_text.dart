import 'package:flutter/material.dart';
import 'package:froozo/utils/dimensions.dart';

class SmallText extends StatelessWidget {
  Color? color;
  final String text;
  double size, height;
  int maxlines;
  TextOverflow overflow;
  
  SmallText(
      {Key? key,
      this.color = const Color(0xFFccc7c5),
      required this.text,
      this.size = 0,
      this.overflow = TextOverflow.ellipsis,
      this.height = 1.2,
      this.maxlines=1})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(
      maxLines: maxlines,
      text,
      overflow: overflow,
      style: TextStyle(
          color: color,
          fontWeight: FontWeight.w400,
          fontFamily: 'Roboto',
          fontSize: size == 0 ? Dimensions.font15 : size,
          height: height),
    );
  }
}
