import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_task/widgets/title_text_view.dart';

import '../utils/app_colors.dart';

class CustomButtonView extends StatelessWidget {
  CustomButtonView(
    this.text, {
    Key? key,
    this.onPressed,
    this.borderColor,
    this.backGroundColor,
    this.textcolor,
    this.buttonHeight,
    this.fontSize,
    this.buttonTextColor,
    this.radius,
    required this.padding,
    this.isRightArrowVisible = false,
    this.setBoarderRadius = false,
    this.buttonBorderWidth,
    this.buttonBorderColor,
    this.isBorderVisible = true,
  }) : super(key: key);

  String? text;

  // bool isDisable = false;
  bool? isRightArrowVisible = false;
  bool? setBoarderRadius = false;
  Function(String)? onPressed;

  // String? fontFamily = FontName.NunitoSansBold;
  Color? backGroundColor = ColorConst.yellowColor;
  Color? buttonBorderColor = Colors.transparent;
  Color? borderColor = ColorConst.darkBackgroundColor;
  Color? textcolor = ColorConst.darkBackgroundColor;

  // Color disabledColor = Color(redColor);
  double padding = 16;
  double? buttonHeight = 50.h;
  Color? buttonTextColor = ColorConst.white;
  double? fontSize = 16.sp;
  double? radius = 5;
  double? buttonBorderWidth = 0;
  bool isBorderVisible = true;

  double? elevation;

  double borderRadius = 8.r;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 5.h, top: 10.h),
      height: buttonHeight,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(radius!)),
          border: Border.all(
              color: buttonBorderColor ?? Colors.transparent,
              width: buttonBorderWidth ?? 0),
          boxShadow: [
            BoxShadow(color: Colors.black12, blurRadius: 0.1.r),
          ]),
      alignment: Alignment.center,
      child: CupertinoButton(
        borderRadius: BorderRadius.circular(radius!),
        padding: const EdgeInsets.all(5),
        color: backGroundColor,
        alignment: Alignment.center,
        onPressed: onPressed == null ? null : () => onPressed!.call(''),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: TitleTextView(text ?? '',
              textAlign: TextAlign.center,
              color: buttonTextColor,
              fontWeight: FontWeight.w700,
              fontStyle: FontStyle.normal,
              fontSize: fontSize),
        ),
      ),
    );
  }
}
