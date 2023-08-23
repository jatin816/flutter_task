import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_task/pages/splash/binding.dart';
import 'package:flutter_task/route/app_routes.dart';
import 'package:flutter_task/services/service_locator.dart';
import 'package:flutter_task/utils/app_colors.dart';
import 'package:get/get_core/src/smart_management.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:loader_overlay/loader_overlay.dart';

void main() async {
  // Setup app dependencies
  await setupDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(
    //   SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.black),
    // );

    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    return GlobalLoaderOverlay(
      useDefaultLoading: false,
      overlayWidget: Center(
          child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Wrap(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    borderRadius: const BorderRadius.all(Radius.circular(4.0))),
                padding: const EdgeInsets.all(20),
                child: const SpinKitCircle(
                  color: ColorConst.yellowColor,
                  size: 50.0,
                ),
              )
            ],
          )
        ],
      )),
      overlayColor: Colors.white,
      overlayOpacity: 0.1,
      child: ScreenUtilInit(
          minTextAdapt: true,
          splitScreenMode: false,
          builder: (context, child) {
            return GetMaterialApp(
                title: 'Flutter Task',
                smartManagement: SmartManagement.onlyBuilder,
                debugShowCheckedModeBanner: false,
                color: Colors.white,
                initialRoute: '/',
                initialBinding: SplashBinding(),
                getPages: AppPages.routes);
          }),
    );
  }
}
