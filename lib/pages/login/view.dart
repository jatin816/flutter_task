import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_task/widgets/custom_textform_field.dart';
import 'package:get/get.dart';

import '../../utils/app_colors.dart';
import '../../utils/app_images.dart';
import '../../utils/app_strings.dart';
import '../../widgets/custom_button_view.dart';
import '../../widgets/title_text_view.dart';
import 'logic.dart';
import 'package:flutter_test/flutter_test.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  final state = Get.find<LoginLogic>().state;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: ColorConst.loginBackground,
            body: LayoutBuilder(builder:
                (BuildContext context, BoxConstraints viewportConstraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: viewportConstraints.maxHeight,
                  ),
                  child: loginView(),
                ),
              );
            })));
  }

  Widget loginView() {
    return GetBuilder<LoginLogic>(
      assignId: true,
      builder: (logic) {
        return IntrinsicHeight(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 40.h,),
                    Image.asset(
                      AppImages.mainLogoIcon,
                      width: 100.w,
                      height: 100.h,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Center(
                      child: TitleTextView(
                        AppString.freshBits,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 5.h,),
                    Center(
                      child: TitleTextView(
                        AppString.since2014,
                        color: Colors.grey,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          top: 40.h, left: 15.w, right: 15.w),
                      padding: EdgeInsets.only(left: 10.w, right: 10.w),
                      decoration: BoxDecoration(
                          color: ColorConst.white,
                          borderRadius: BorderRadius.circular(8.0)),
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 25.h),
                            alignment: Alignment.center,
                            child: TitleTextView(
                              AppString.loginDetails,
                              color: ColorConst.yellowColor,
                              fontSize: 22.sp,
                            ),
                          ),
                          CommonTextField(
                              hintText: AppString.email,
                              maxLine: 1,
                              isAutoFocus: false,
                              isDivider: false,
                              controller: state.emailController,
                              onChanged: (String email) {},
                              textInputAction: TextInputAction.next,
                              textInputType: TextInputType.emailAddress),
                          CommonTextField(
                              hintText: AppString.password,
                              maxLine: 1,
                              isAutoFocus: false,
                              isDivider: false,
                              suffixIcon: state.passwordVisible
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              isObscure: state.passwordVisible,
                              controller: state.passwordController,
                              onSuffixIconTap: () => logic.managePasswordVisibility(),
                              onChanged: (String email) {},
                              textInputAction: TextInputAction.done,
                              textInputType: TextInputType.visiblePassword),
                          Container(
                            margin: EdgeInsets.only(left: 15.h , right: 15.h, top: 20.h, bottom: 30.h),
                            child: CustomButtonView(
                              AppString.loginDetails,
                              padding: 10.w,
                              buttonHeight: 40.h,
                              fontSize: 15.sp,
                              radius: 10.r,
                              onPressed: (value) async {
                                logic.loginUser();
                              },
                              backGroundColor: ColorConst.backgroundDark,
                              buttonTextColor: ColorConst.white,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
