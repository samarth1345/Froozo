import 'package:flutter/material.dart';
import 'package:froozo/utils/colors.dart';
import 'package:froozo/utils/dimensions.dart';
import 'package:froozo/widgets/small_text.dart';

class ExpandableTextWidget extends StatefulWidget {
  final String text;
  final double textHeightfact;
  const ExpandableTextWidget(
      {super.key, required this.text, this.textHeightfact = 1});

  @override
  State<ExpandableTextWidget> createState() => _ExpandableTextWidgetState();
}

class _ExpandableTextWidgetState extends State<ExpandableTextWidget> {
  late String firstHalf;
  late String secondHalf;

  bool hiddenText = true;

  double textHeight = Dimensions.screenHeight / 5.63;
  double textSize = Dimensions.font16;
  @override
  void initState() {
    super.initState();
    if (widget.text.length > (textHeight * widget.textHeightfact)) {
      firstHalf = widget.text
          .substring(0, (textHeight.toInt()) * (widget.textHeightfact.toInt()));
      secondHalf = widget.text.substring(
          (textHeight.toInt()) * (widget.textHeightfact.toInt()) + 1,
          widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: secondHalf.isEmpty
          ? SmallText(
              text: firstHalf,
              size: textSize,
              color: AppColors.paraColor,
              height: 1.8,
            )
          : Column(
              children: [
                SmallText(
                  text: hiddenText
                      ? (firstHalf + "...")
                      : (firstHalf + secondHalf + firstHalf),
                  size: textSize,
                  color: AppColors.paraColor,
                  height: 1.8,
                  maxlines: 30,
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      hiddenText = !hiddenText;
                    });
                  },
                  child: Row(children: [
                    SmallText(
                      text: "Show more",
                      color: AppColors.mainColor,
                    ),
                    Icon(
                      hiddenText ? Icons.arrow_drop_down : Icons.arrow_drop_up,
                      color: AppColors.mainColor,
                    )
                  ]),
                )
              ],
            ),
    );
  }
}
