import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../utils/app_colors.dart';

SnackbarController snackBarView(String title, String mMessage) {
  return Get.snackbar(title, mMessage ,
      animationDuration: 500.milliseconds,
      snackPosition: SnackPosition.BOTTOM,
      colorText: ColorConst.white,
      margin: EdgeInsets.all(20.w),
      backgroundColor: ColorConst.snackBarBackgroundColor.withOpacity(0.6));
}
