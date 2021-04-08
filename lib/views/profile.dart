import 'package:quality_app/controllers/setting_controller.dart';
import 'package:flutter/material.dart';
import 'package:quality_app/controllers/store_controller.dart';
import 'package:quality_app/packages/config_package.dart';
import 'package:quality_app/packages/input_package.dart';
import 'package:quality_app/theme/theme_service.dart';
import 'package:lottie/lottie.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> with TickerProviderStateMixin {
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
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        // automaticallyImplyLeading: false,
        actions: [
          Center(
            child: InkWell(
              highlightColor: Colors.white,
              splashColor: Colors.transparent,
              onTap: () {
                settingCtrl.navigationBack();
                //bottomCtrl.updateCurrentTab(2);
              },
              child: Padding(
                  padding: EdgeInsets.only(left: screenWidth(20.0)),
                  child: Image.asset(
                    backIcon,
                    width: screenWidth(20),
                  )),
            ),
          ),
          Spacer(),
          Center(
            child: InkWell(
              highlightColor: Colors.white,
              splashColor: Colors.transparent,
              onTap: () {
                Get.offAndToNamed(AppRouter.login);
                //bottomCtrl.updateCurrentTab(2);
              },
              child: Padding(
                  padding: EdgeInsets.only(right: screenWidth(20.0)),
                  child: Image.asset(
                    logoutIcon,
                    width: screenWidth(16),
                  )),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: LoadingComponent(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: screenWidth(20)),
            child: Column(
              children: [
                Align(alignment: Alignment.topLeft, child: Text('Profile', style: h1)),
                GetBuilder<StoreController>(
                  builder: (_dx) => _dx.userInfo != null && _dx.userInfo['profile_photo_url'] != null
                      ? Container(
                          height: screenWidth(90),
                          width: screenWidth(90),
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(screenWidth(90)),
                          ),
                          child: Center(
                            child: Image.network(
                              _dx.userInfo['profile_photo_url'],
                              width: screenWidth(90),
                              height: screenWidth(90),
                            ),
                          ))
                      : Container(),
                ),
                SizedBox(
                  height: screenHeight(30),
                ),
                GetBuilder<StoreController>(
                    builder: (_dx) => _dx.userInfo != null
                        ? Container(
                            width: screenActualWidth(),
                            padding: EdgeInsets.symmetric(vertical: screenHeight(15), horizontal: screenWidth(15)),
                            decoration: BoxDecoration(border: Border.all(width: 1, color: deactivateColor), borderRadius: BorderRadius.circular(5)),
                            child: Row(
                              children: [
                                Image.asset(userIcon, width: screenWidth(20), color: primaryDarkColor),
                                SizedBox(width: screenWidth(10)),
                                Text(
                                  _dx.userInfo['name'].toString(),
                                  style: bodyStyle5.copyWith(color: black22Color),
                                )
                              ],
                            ),
                          )
                        : Container()),
                SizedBox(
                  height: screenHeight(10),
                ),
                GetBuilder<StoreController>(
                    builder: (_dx) => _dx.userInfo != null
                        ? Container(
                            width: screenActualWidth(),
                            padding: EdgeInsets.symmetric(vertical: screenHeight(15), horizontal: screenWidth(15)),
                            decoration: BoxDecoration(border: Border.all(width: 1, color: deactivateColor), borderRadius: BorderRadius.circular(5)),
                            child: Row(
                              children: [
                                Image.asset(
                                  emailIcon,
                                  width: screenWidth(20),
                                ),
                                SizedBox(width: screenWidth(10)),
                                Text(
                                  _dx.userInfo['email'].toString(),
                                  style: bodyStyle5.copyWith(color: black22Color),
                                )
                              ],
                            ),
                          )
                        : Container()),
                SizedBox(
                  height: screenHeight(10),
                ),
                GetBuilder<StoreController>(
                    builder: (_dx) => _dx.userInfo != null
                        ? Container(
                            width: screenActualWidth(),
                            padding: EdgeInsets.symmetric(vertical: screenHeight(15), horizontal: screenWidth(15)),
                            decoration: BoxDecoration(border: Border.all(width: 1, color: deactivateColor), borderRadius: BorderRadius.circular(5)),
                            child: Row(
                              children: [
                                Image.asset(
                                  phoneIcon,
                                  width: screenWidth(20),
                                ),
                                SizedBox(width: screenWidth(10)),
                                Text(
                                  _dx.userInfo['phone'].toString(),
                                  style: bodyStyle5.copyWith(color: black22Color),
                                ),
                              ],
                            ),
                          )
                        : Container()),
                Spacer(),
                CustomButton(
                  title: "Quarterly Survey",
                  suffixIcon: Image.asset(
                    rightArrowIcon,
                    width: screenWidth(20),
                  ),
                  onTap: () {
                    Get.toNamed(AppRouter.surveyInfo);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
