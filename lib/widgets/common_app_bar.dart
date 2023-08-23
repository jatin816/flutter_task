import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_task/widgets/title_text_view.dart';
import 'package:get/get.dart';
import 'package:badges/badges.dart' as badges;

import '../utils/app_colors.dart';

AppBar homeAppBar(
    {GlobalKey<ScaffoldState>? scaffoldKey,
    required BuildContext context,
    GlobalKey? notificationKey,
    bool hasBackButton = false,
      int cartCount = 4,
    String navTitle = '',
    Function? cartListAction}) {
  // var notificationProvider = Provider.of<NotificationProvider>(context);
  // print(notificationProvider.unreadNotificationCount);
  return AppBar(
    backgroundColor: ColorConst.backgroundDark,
    elevation: 0.5,
    leading: GestureDetector(
      onTap: () {
        if(hasBackButton) {
          Get.back();
        }
      },
      child: Center(
          child: Icon(hasBackButton ? Icons.arrow_back : Icons.menu,
              color: hasBackButton ? ColorConst.white : ColorConst.transparent, size: 25.w)),
    ),
    actions: [
      if(cartCount != 0)
      GestureDetector(
        onTap: () {
          if(hasBackButton) {
            Get.back();
          }
        },
        child: Center(
          child: badges.Badge(
            position: badges.BadgePosition.topEnd(top: 0, end: 3),
            badgeAnimation: const badges.BadgeAnimation.slide(
              disappearanceFadeAnimationDuration: Duration(milliseconds: 200),
              curve: Curves.easeInCubic,
            ),
            showBadge: cartCount != 0,
            badgeStyle: badges.BadgeStyle(
              badgeColor: Colors.white,
            ),
            badgeContent: Text(
              cartCount.toString(),
              style: TextStyle(color: Colors.black),
            ),
            child: IconButton(icon: const Icon(Icons.shopping_cart , color: ColorConst.white,), onPressed: () {
              cartListAction?.call();
            }),
          ),
        ),
      ),
      SizedBox(width: 10.w,)
    ],
    centerTitle: true,
    titleSpacing: 2,
    title: TitleTextView(
      navTitle,
      color: Colors.white,
      maxLines: 1,
      textAlign: TextAlign.start,
      fontSize: 18.sp,
    ),
  );
}
