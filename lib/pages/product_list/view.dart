import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_task/model/product_model.dart';
import 'package:flutter_task/route/app_routes.dart';
import 'package:flutter_task/utils/app_constant.dart';
import 'package:get/get.dart';

import '../../utils/app_colors.dart';
import '../../utils/app_strings.dart';
import '../../widgets/common_app_bar.dart';
import '../../widgets/title_text_view.dart';
import 'logic.dart';

class ProductListPage extends StatelessWidget {
  ProductListPage({super.key});

  final state = Get.find<ProductListLogic>().state;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductListLogic>(
      assignId: false,
      builder: (logic) {
        return Scaffold(
            key: state.scaffoldKey,
            backgroundColor: ColorConst.backgroundGrey,
            appBar: homeAppBar(
              scaffoldKey: state.scaffoldKey,
              context: context,
              cartCount: logic.cartItemList.length,
              navTitle: AppString.productList,
              cartListAction:() async{
                await Get.toNamed(AppPages.cartDetail);
                logic.manageCartItemCount();
              }
            ),
            body: Container(
              margin: EdgeInsets.only(top: 10.h),
              height: MediaQuery.sizeOf(context).height,
              child: ListView.builder(
                  itemCount: state.productList.length,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final item = state.productList[index];
                    return productContent(item, index, context, logic);
                  }),
            ));
      },
    );
  }

  Widget productContent(ProductModel item, int index, BuildContext context, ProductListLogic logic) {
    return Container(
      margin: EdgeInsets.all(8.h),
      // height: 100.h,
      // padding: EdgeInsets.all(15.w),
      decoration: BoxDecoration(
          color: ColorConst.white,
          borderRadius: BorderRadius.all(Radius.circular(10.r)),
          boxShadow: [
            BoxShadow(color: Colors.black12, blurRadius: 0.1.r),
          ]),
      child: GestureDetector(
        onTap: () async {
          await Get.toNamed(AppPages.productDetails,
               arguments: {AppConstant.productIndex: index});
          logic.manageCartItemCount();
        },
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
                  children: [
                    TitleTextView(
                      item.title ?? '',
                      fontSize: 14.sp,
                      maxLines: 2,
                      color: ColorConst.darkBackgroundColor,
                      fontWeight: FontWeight.w700,
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    TitleTextView(
                      item.category ?? '',
                      fontSize: 12.sp,
                      color: ColorConst.lightGray,
                      fontWeight: FontWeight.w400,
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    Row(
                      children: [
                        RatingBar.builder(
                          initialRating: item.rating?.rate?.toDouble() ?? 0,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemSize: 18,
                          itemPadding:
                              const EdgeInsets.symmetric(horizontal: 1.0),
                          itemBuilder: (context, _) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (rating) {
                            print(rating);
                          },
                        ),
                        SizedBox(width: 3.w),
                        TitleTextView(
                          '(${item.rating?.count?.toString()})',
                          fontSize: 12.sp,
                          color: ColorConst.lightGray,
                          fontWeight: FontWeight.w400,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    TitleTextView(
                      '${item.price ?? 0} \$',
                      fontSize: 15.sp,
                      color: ColorConst.black,
                      fontWeight: FontWeight.w400,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
