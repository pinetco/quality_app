import 'package:quality_app/controllers/setting_controller.dart';
import 'package:flutter/material.dart';
import 'package:quality_app/controllers/store_controller.dart';
import 'package:quality_app/packages/config_package.dart';
import 'package:quality_app/packages/input_package.dart';
import 'package:quality_app/theme/theme_service.dart';
import 'package:lottie/lottie.dart';

class FrenchiserInfo extends StatefulWidget {
  @override
  _FrenchiserInfoState createState() => _FrenchiserInfoState();
}

class _FrenchiserInfoState extends State<FrenchiserInfo> with TickerProviderStateMixin {
  AnimationController _animationController;
  bool isPlaying = false;
  var settingCtrl = Get.put(SettingController());
  var storeCtrl = Get.find<StoreController>();

  @override
  void initState() {
    // TODO: implement initState
    _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 450));
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFFF7F8FA),
      body: SafeArea(
        child: LoadingComponent(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: screenWidth(20)),
            child: Column(
              children: [
                SizedBox(height: 10),
                Row(
                  children: [
                    Text(
                      'Contact Info',
                      style: h1,
                    ),
                    Spacer(),
                    Align(
                      alignment: Alignment.topRight,
                      child: Image.asset(
                        notificationIcon,
                        width: screenWidth(20),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: screenWidth(30),
                ),
                // Align(alignment: Alignment.topLeft, child: Text('Profile', style: h1)),
                Container(
                    padding: EdgeInsets.all(8),
                    height: screenHeight(150),
                    width: screenActualHeight(),
                    decoration: BoxDecoration(
                      border: Border.all(color: deactivateColor, width: 1),
                      borderRadius: BorderRadius.circular(screenWidth(10)),
                    ),
                    child: Center(
                      child: Image.asset(logoCont),
                    )),

                SizedBox(
                  height: screenHeight(30),
                ),

                Container(
                  padding: EdgeInsets.all(screenWidth(15)),
                  width: screenActualHeight(),
                  decoration: BoxDecoration(
                    border: Border.all(color: deactivateColor, width: 1),
                    borderRadius: BorderRadius.circular(screenWidth(10)),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(MdiIcons.officeBuildingOutline, size: screenWidth(20), color: primaryDarkColor),
                          SizedBox(width: screenWidth(10)),
                          Text(
                            "First Light Home Care",
                            style: bodyStyle5.copyWith(color: black22Color),
                          )
                        ],
                      ),
                      SizedBox(
                        height: screenHeight(20),
                      ),
                      InkWell(
                        onTap: () {
                          settingCtrl.openURLContactInfo('info@firstlighthomecare.com', 'email');
                        },
                        child: Row(
                          children: [
                            Image.asset(emailIcon, width: screenWidth(20), color: primaryDarkColor),
                            SizedBox(width: screenWidth(10)),
                            Text(
                              'info@firstlighthomecare.com',
                              style: bodyStyle5.copyWith(color: black22Color),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: screenHeight(20),
                      ),
                      InkWell(
                        onTap: () {
                          settingCtrl.openURLContactInfo('8669855348', 'phone');
                        },
                        child: Row(
                          children: [
                            Image.asset(phoneIcon, width: screenWidth(20), color: primaryDarkColor),
                            SizedBox(width: screenWidth(10)),
                            Text(
                              "(866) 985-4031",
                              style: bodyStyle5.copyWith(color: black22Color),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: screenHeight(20),
                      ),
                      InkWell(
                        onTap: () {
                          settingCtrl.openURLContactInfo('https://www.firstlighthomecare.com/', 'website');
                        },
                        child: Row(
                          children: [
                            Icon(MdiIcons.web, size: screenWidth(20), color: primaryDarkColor),
                            SizedBox(width: screenWidth(10)),
                            Text(
                              'https://www.firstlighthomecare.com/',
                              style: bodyStyle6.copyWith(
                                color: black22Color,
                                decoration: TextDecoration.underline,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(
                  height: screenHeight(30),
                ),

                Container(
                  padding: EdgeInsets.all(screenWidth(15)),
                  width: screenActualHeight(),
                  decoration: BoxDecoration(
                    border: Border.all(color: deactivateColor, width: 1),
                    borderRadius: BorderRadius.circular(screenWidth(10)),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(MdiIcons.facebook, size: screenWidth(30), color: Color(0XFF4267B2)),
                          SizedBox(width: screenWidth(10)),
                          Icon(MdiIcons.google, size: screenWidth(20), color: Colors.red),
                          SizedBox(width: screenWidth(10)),
                          Icon(MdiIcons.twitter, size: screenWidth(20), color: Color(0XFF00ACEE)),
                          SizedBox(width: screenWidth(10)),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
