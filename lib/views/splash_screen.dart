import 'package:quality_app/controllers/splash_controller.dart';
import 'package:quality_app/global/packages/config_package.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  //this will call Splash Controller
  var splashController = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColor.bgColor,
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    imageAssets.appLogoGIF,
                    width: appScreenUtil.size(150),
                  ),
                  SizedBox(height: 20),
                  Text('Health Sector', style: appCss.bodyStyle2.merge(appCss.ls5)),
                  SizedBox(height: 10),
                  Text('Quality Control', style: appCss.h1),
                ],
              ),
            ),
            SizedBox(
              child: CircularProgressIndicator(),
              height: 20,
              width: 20,
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
