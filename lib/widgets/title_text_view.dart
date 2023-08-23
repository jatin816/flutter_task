import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class TitleTextView extends StatelessWidget {
  TitleTextView(this.text,
      {Key? key,
      this.textAlign,
      this.color,
      this.fontSize,
      this.softWrap,
      this.maxLines,
      this.textOverflow,
      this.fontWeight,
      this.fontStyle,
      this.isGradiant,
      this.textDecoration})
      : super(key: key);

  final String text;
  TextAlign? textAlign = TextAlign.start;
  Color? color = Colors.black;

  double? fontSize = 13;
  bool? softWrap = true;
  bool? isGradiant = false;
  int? maxLines;
  TextOverflow? textOverflow = TextOverflow.clip;
  FontWeight? fontWeight;
  FontStyle? fontStyle;
  TextDecoration? textDecoration;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      overflow: textOverflow,
      softWrap: softWrap,
      maxLines: maxLines,
      style: GoogleFonts.roboto(
              color: (color == null) ? Colors.black : color,
              fontSize: (fontSize == null) ? 14.sp : fontSize,
              fontStyle: (fontStyle == null) ? FontStyle.normal : fontStyle,
              fontWeight: (fontWeight == null) ? FontWeight.normal : fontWeight,
              decoration: (textDecoration == null) ? TextDecoration.none : textDecoration),
    );
  }
}
