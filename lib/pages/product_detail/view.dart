import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_task/model/product_model.dart';
import 'package:flutter_task/pages/product_list/logic.dart';
import 'package:flutter_task/route/app_routes.dart';
import 'package:flutter_task/utils/app_constant.dart';
import 'package:flutter_task/widgets/title_text_view.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../utils/app_colors.dart';
import '../../utils/app_strings.dart';
import '../../widgets/common_app_bar.dart';
import '../../widgets/custom_button_view.dart';
import 'logic.dart';

class ProductDetailPage extends StatelessWidget {
  final logic = Get.find<ProductDetailLogic>();
  final productLogic = Get.find<ProductListLogic>();
  final state = Get.find<ProductDetailLogic>().state;

  ProductDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductDetailLogic>(
      assignId: true,
      builder: (logic) {
        return Scaffold(
            backgroundColor: ColorConst.backgroundGrey,
            appBar: homeAppBar(
              context: context,
              hasBackButton: true,
              cartCount: logic.cartCount,
              navTitle: AppString.productList,
            ),
            body: SizedBox(
              height: MediaQuery.sizeOf(context).height,
              child: productDetailView(context),
            ));
      },
    );
  }

  Widget productDetailView(BuildContext context) {
    return Column(
      children: [
        Flexible(
          child: ListView(
            children: [
              Container(
                padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
                height: 300.h,
                color: ColorConst.white,
                width: MediaQuery.sizeOf(context).width,
                child: CachedNetworkImage(
                  imageUrl:
                  productLogic.state.productList[logic.selectedIndex].image ?? '',
                  fit: BoxFit.fill,
                  errorWidget: (context, url, error) {
                    return const Icon(Icons.error);
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10.w, top: 10.h),
                child: Row(
                  children: [
                    Icon(Icons.shopping_bag,
                        color: ColorConst.darkBackgroundColor, size: 20.w),
                    SizedBox(width: 8.w),
                    TitleTextView(
                      AppString.shopping,
                      color: ColorConst.darkBackgroundColor,
                      fontSize: 15.sp,
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10.w, top: 20.h),
                child: TitleTextView(
                  productLogic.state.productList[logic.selectedIndex].title ?? 'N/A',
                  color: ColorConst.darkBackgroundColor,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10.w, top: 10.h),
                child: TitleTextView(
                  productLogic.state.productList[logic.selectedIndex].description ?? 'N/A',
                  color: ColorConst.lightGray,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10.w, top: 20.h),
                child: Row(
                  children: [
                    Container(
                      width: 40.h,
                      height: 40.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          color: ColorConst.snackBarBackgroundColor.withOpacity(0.6)),
                      child: const Icon(Icons.pin_drop_outlined , color: Colors.white),
                    ),
                    SizedBox(width: 12.w),
                    Column(
                      children: [
                        TitleTextView(
                          'B-111 D M Ave 75, Gota\n 130012, Nava Jadaj',
                          color: ColorConst.lightGray,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ],
                    ),
                    const Spacer(),
                    Icon(Icons.keyboard_arrow_right, color: ColorConst.darkBackgroundColor,size: 30.w,),
                    SizedBox(width: 1.w,)
                  ],
                ),
              ),
              Container(
                  margin: EdgeInsets.only(left: 10.w, top: 10.h, right: 10.h),
                  child: const Divider(color: ColorConst.gray,)),
              Container(
                alignment: Alignment.topLeft,
                margin: EdgeInsets.only(left: 10.w, top: 10.h),
                child: TitleTextView(
                  '\$ ${productLogic.state.productList[logic.selectedIndex].price}',
                  color: ColorConst.darkBackgroundColor,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Container(
                alignment: Alignment.topLeft,
                margin: EdgeInsets.only(left: 10.w, top: 5.h, bottom: 10.h),
                child: TitleTextView(
                  'Tax Rate 5% - 7% (-\$190.00)',
                  color: ColorConst.darkBackgroundColor,
                  fontSize: 12.sp,
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 15.h , right: 15.h, top: 5.h, bottom: 10.h),
          child: CustomButtonView(
            productLogic.state.productList[logic.selectedIndex].cartCount == 0 ?AppString.addToCart : AppString.removeToCart,
            padding: 10.w,
            buttonHeight: 40.h,
            fontSize: 15.sp,
            radius: 10.r,
            onPressed: (value) async {
              if(productLogic.state.productList[logic.selectedIndex].cartCount == 0) {
                productLogic.state.productList[logic.selectedIndex].setCartCount = 1;
                List<ProductModel> result = productLogic.state.productList.where((element) => element.cartCount != 0).toList();
                GetStorage().write(AppConstant.cartItemCountKey, result);
              } else {
                productLogic.state.productList[logic.selectedIndex].setCartCount = 0;
              }

              logic.cartCount = productLogic.state.productList.where((element) => element.cartCount != 0).length;
              logic.update();
            },
            backGroundColor: ColorConst.backgroundDark,
            buttonTextColor: ColorConst.white,
          ),
        )
      ],
    );
  }
}
