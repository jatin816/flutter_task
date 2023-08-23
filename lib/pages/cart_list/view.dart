import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../model/product_model.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_strings.dart';
import '../../widgets/common_app_bar.dart';
import '../../widgets/title_text_view.dart';
import 'logic.dart';

class CartListPage extends StatelessWidget {
  CartListPage({super.key});

  final logic = Get.find<CartListLogic>();
  final state = Get.find<CartListLogic>().state;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartListLogic>(
      assignId: true,
      builder: (logic) {
        return Scaffold(
            backgroundColor: ColorConst.backgroundGrey,
            appBar: homeAppBar(
              context: context,
              cartCount: 0,
              hasBackButton: true,
              navTitle: AppString.orderDetail,
            ),
            body: Container(
              margin: EdgeInsets.only(top: 10.h, left: 10.w , right: 10.w),
              height: MediaQuery.sizeOf(context).height,
              child: Column(
                children: [
                  ListView.builder(
                      itemCount: logic.cartItemList.length,
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final item = logic.cartItemList[index];
                        return productContent(item, index, context);
                      }),
                  const Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TitleTextView(
                        'Order Info',
                        fontSize: 20.sp,
                        maxLines: 2,
                        color: ColorConst.darkBackgroundColor,
                        fontWeight: FontWeight.w700,
                      ),
                      SizedBox(height: 10.h,),
                      orderContent('Sub Total', '\$ ${logic.itemTotalAmount.toStringAsFixed(2)}'),
                      SizedBox(height: 10.h,),
                      orderContent('Shipping  Code', '\$ 00.00'),
                      SizedBox(height: 10.h,),
                      orderContent('Total', '\$ ${logic.itemTotalAmount.toStringAsFixed(2)}'),
                      SizedBox(height: 15.h,),
                    ],
                  )
                ],
              ),
            ));
      },
    );
  }

  Widget productContent(ProductModel item, int index, BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8.h),
      decoration: BoxDecoration(
          color: ColorConst.white,
          borderRadius: BorderRadius.all(Radius.circular(10.r)),
          boxShadow: [
            BoxShadow(color: Colors.black12, blurRadius: 0.1.r),
          ]),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            flex: 1,
            child: Container(
              margin: EdgeInsets.only(left: 10.w, top: 5.h, bottom: 2.h),
              height: 100.h,
              child: CachedNetworkImage(
                imageUrl: item.image ?? '',
                fit: BoxFit.contain,
                errorWidget: (context, url, error) {
                  return const Icon(Icons.error);
                },
              ),
            ),
          ),
          Flexible(
            flex: 3,
            child: Container(
              margin: EdgeInsets.all(10.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TitleTextView(
                    item.title ?? '',
                    fontSize: 14.sp,
                    maxLines: 2,
                    color: ColorConst.darkBackgroundColor,
                    fontWeight: FontWeight.w700,
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  TitleTextView(
                    '\$ ${item.price ?? 0}',
                    fontSize: 12.sp,
                    color: ColorConst.lightGray,
                    fontWeight: FontWeight.w400,
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              if (item.cartCount == 1) {
                                logic.cartItemList.removeAt(index);
                                logic.removeFromCart(item.id ?? 0);
                              } else {
                                item.setCartCount = item.cartCount! - 1;
                                logic.calculateTotalAmount();
                              }
                            },
                            child: Container(
                              margin: EdgeInsets.only(right: 10.w),
                              padding: EdgeInsets.all(5.w),
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.r)),
                                border: Border.all(
                                    color: ColorConst.darkBackgroundColor),
                              ),
                              child: Icon(
                                Icons.remove,
                                size: 18.w,
                              ),
                            ),
                          ),
                          Center(
                            child: TitleTextView(
                              item.cartCount.toString(),
                              fontSize: 14.sp,
                              maxLines: 2,
                              color: ColorConst.darkBackgroundColor,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              item.setCartCount = item.cartCount! + 1;
                              logic.updateCartQty(item.id, item.cartCount);
                            },
                            child: Container(
                              margin: EdgeInsets.only(left: 10.w),
                              padding: EdgeInsets.all(5.w),
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.r)),
                                border: Border.all(
                                    color: ColorConst.darkBackgroundColor),
                              ),
                              child: Icon(
                                Icons.add,
                                size: 18.w,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget orderContent(String key, String value){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TitleTextView(
          key,
          fontSize: 13.sp,
          maxLines: 2,
          color: ColorConst.lightGray,
          fontWeight: FontWeight.w400,
        ),
        TitleTextView(
          value,
          fontSize: key == 'Total' ? 18.sp : 13.sp,
          maxLines: 2,
          color: ColorConst.darkBackgroundColor,
          fontWeight: FontWeight.w400,
        ),
      ],
    );
  }
}
