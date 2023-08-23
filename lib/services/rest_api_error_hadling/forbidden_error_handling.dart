import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../model/rest_error.dart';
import '../../utils/app_colors.dart';

class ForbiddenErrorHandling {
  static bool canHandle(RestError error) {
    var statusCode = error.statusCode;

    return (statusCode != null && statusCode == HttpStatus.accepted);
  }

  static handle(RestError error, BuildContext context) {
    _sessionLogoutDialog(context);
  }

  static _sessionLogoutDialog(BuildContext context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            insetPadding: EdgeInsets.all(20.h),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.r))),
            child: Container(
              margin: EdgeInsets.only(
                  top: 15.h, left: 20.w, right: 20.w, bottom: 15.h),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: ColorConst.backgroundDark.withOpacity(0.4),
                    child: const Icon(
                      Icons.error_outline_sharp,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 15.h),
                  Text(
                    'Your session has expired\n You will redirected to the Login Page.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.roboto(
                        color: ColorConst.black,
                        fontSize: 16.sp,),
                    maxLines: 5,
                  ),
                  SizedBox(height: 20.h),
                  Container(
                    margin: EdgeInsets.only(
                        top: 10.h, left: 10.w, right: 10.w, bottom: 10.h),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        color: ColorConst.backgroundDark),
                    height: 40.h,
                    width: MediaQuery.of(context).size.width,
                    child: TextButton(
                        onPressed: () {
                          Get.back();
                          // _logoutApiCall(context);
                        },
                        child: Center(
                          child: Text(
                            'OK',
                            style: GoogleFonts.roboto(
                                color: ColorConst.white,
                                fontSize: 15.h,
                            ),
                          ),
                        )),
                  )
                ],
              ),
            ),
          );
        });
  }
}
