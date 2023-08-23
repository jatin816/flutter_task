import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/app_colors.dart';

class CommonTextField extends StatelessWidget {
  String hintText;
  int maxLine;
  FocusNode? focusNode;
  TextInputType? textInputType;
  TextInputAction textInputAction;
  TextEditingController? controller;
  ValueChanged<String>? onChanged;
  ValueChanged<String>? onSaved;
  IconData? suffixIcon;
  bool isObscure = false;
  Function()? onTap;
  Function()? onSuffixIconTap;
  bool isDivider = true;
  bool isAutoFocus = true;
  bool isShowCursor = true;
  bool isTablet = false;
  double? height;
  List<TextInputFormatter>? inputFormatters;

  CommonTextField(
      {super.key,
        String? initialValue,
        required this.hintText,
        required this.maxLine,
        this.inputFormatters,
        this.controller,
        this.onChanged,
        this.focusNode,
        this.suffixIcon,
        this.onSuffixIconTap,
        this.onTap,
        this.textInputType,
        required this.textInputAction,
        this.onSaved,
        this.isDivider = true,
        this.isAutoFocus = true,
        this.isObscure = false,
        this.isShowCursor = true,
        this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 42.h,
      margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 15.h),
      child: TextFormField(
        style:
        TextStyle(fontSize: 14.sp, color: Colors.black),
        maxLines: 1,
        autofocus: isAutoFocus ? true : false,
        onTap: onTap,
        obscureText: isObscure == true ? true : false,
        textInputAction: textInputAction,
        keyboardType: textInputType,
        onChanged: onChanged,
        focusNode: focusNode,
        showCursor: isShowCursor,
        inputFormatters: inputFormatters,
        decoration: InputDecoration(
            fillColor: ColorConst.white,
            filled: true,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade400),
              borderRadius: BorderRadius.circular(10),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade400),
              borderRadius: BorderRadius.circular(10),
            ),
            hintText: hintText,
            isDense: true,
            suffixIcon: Container(
              child: Padding(
                padding: EdgeInsets.only(right: 15.0.w),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    isDivider
                        ? Container(
                      height: 20.h,
                      width: 1.h,
                      color: Colors.grey.shade400,
                    )
                        : Container(),
                    SizedBox(width: 10.w),
                    GestureDetector(
                      onTap: onSuffixIconTap,
                      child: Icon(
                        suffixIcon,
                        color: Colors.black,
                        size: 20.h,
                      ),
                    )
                  ],
                ),
              ),
            ),
            hintStyle: TextStyle(
                color: Colors.grey.shade500,
                fontSize: 14.sp,
                fontWeight: FontWeight.normal),
            contentPadding: EdgeInsets.only(left: 15.w)),
        controller: controller,
      ),
    );
  }
}
