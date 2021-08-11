import 'package:quality_app/controllers/bottom_navigation_controller.dart';
import 'package:quality_app/controllers/setting_controller.dart';
import 'package:flutter/material.dart';
import 'package:quality_app/controllers/home_client_controller.dart';
import 'package:quality_app/global/packages/config_package.dart';
import 'package:quality_app/global/widgets/common/custom_button.dart';
import 'package:quality_app/global/widgets/notification_icon_header.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> with TickerProviderStateMixin {
  AnimationController _animationController;
  bool isPlaying = false;
  var settingCtrl = Get.put(SettingController());
  var bottomCtrl = Get.find<BottomNavigationController>();

  Widget profileEditIcon() {
    return InkWell(
      onTap: () {
        //Get.toNamed(routeName.editProfile);
      },
      child: Container(
        height: appScreenUtil.size(20),
        width: appScreenUtil.size(20),
        decoration: BoxDecoration(
          // color: primaryColor,
          border: Border.all(
            color: appColor.black22Color,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(appScreenUtil.size(30)),
        ),
        child: Center(
          child: Icon(
            MdiIcons.accountEditOutline,
            size: appScreenUtil.size(20),
            color: appColor.black22Color,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFFF7F8FA),
      body: SafeArea(
        child: LoadingComponent(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: appScreenUtil.size(20)),
            child: Column(
              children: [
                // Align(alignment: Alignment.topLeft, child: Text('Profile', style: h1)),
                Column(
                  children: [
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Text(
                          'Profile',
                          style: appCss.h1,
                        ),
                        Spacer(),
                        profileEditIcon(),
                        SizedBox(width: 15),
                        NotificationHeaderIcon(),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: appScreenUtil.size(30)),
                GetBuilder<BottomNavigationController>(
                  builder: (_dx) => _dx.userInfo != null && _dx.userInfo['profile_photo_url'] != null
                      ? Container(
                          height: appScreenUtil.size(90),
                          width: appScreenUtil.size(90),
                          decoration: BoxDecoration(
                            color: appColor.primaryColor,
                            borderRadius: BorderRadius.circular(appScreenUtil.size(90)),
                          ),
                          child: Center(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(appScreenUtil.size(90)),
                              child: Image.network(
                                _dx.userInfo['profile_photo_url'],
                                width: appScreenUtil.size(90),
                                height: appScreenUtil.size(90),
                                fit: BoxFit.fill,
                                errorBuilder: (BuildContext context, Object exception, StackTrace stackTrace) {
                                  return Image.asset(imageAssets.userIcon);
                                },
                              ),
                            ),
                          ))
                      : Container(),
                ),
                SizedBox(
                  height: appScreenUtil.size(30),
                ),
                GetBuilder<BottomNavigationController>(
                    builder: (_dx) => _dx.userInfo != null
                        ? Container(
                            width: appScreenUtil.screenActualWidth(),
                            padding: EdgeInsets.symmetric(vertical: appScreenUtil.size(15), horizontal: appScreenUtil.size(15)),
                            decoration: BoxDecoration(border: Border.all(width: 1, color: appColor.deactivateColor), borderRadius: BorderRadius.circular(5)),
                            child: Row(
                              children: [
                                Image.asset(imageAssets.userIcon, width: appScreenUtil.size(20), color: appColor.primaryDarkColor),
                                SizedBox(width: appScreenUtil.size(10)),
                                Text(
                                  _dx.userInfo['name'].toString(),
                                  style: appCss.bodyStyle5.copyWith(color: appColor.black22Color),
                                )
                              ],
                            ),
                          )
                        : Container()),
                SizedBox(
                  height: appScreenUtil.size(10),
                ),
                GetBuilder<BottomNavigationController>(
                    builder: (_dx) => _dx.userInfo != null
                        ? InkWell(
                            onTap: () {
                              final email = _dx.userInfo['email'].toString();
                              settingCtrl.openURL(email, 'email');
                            },
                            child: Container(
                              width: appScreenUtil.screenActualWidth(),
                              padding: EdgeInsets.symmetric(vertical: appScreenUtil.size(15), horizontal: appScreenUtil.size(15)),
                              decoration: BoxDecoration(border: Border.all(width: 1, color: appColor.deactivateColor), borderRadius: BorderRadius.circular(5)),
                              child: Row(
                                children: [
                                  Image.asset(
                                    imageAssets.emailIcon,
                                    width: appScreenUtil.size(20),
                                  ),
                                  SizedBox(width: appScreenUtil.size(10)),
                                  Expanded(
                                    child: Text(
                                      _dx.userInfo['email'].toString(),
                                      style: appCss.bodyStyle5.copyWith(color: appColor.black22Color),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        : Container()),
                SizedBox(
                  height: appScreenUtil.size(10),
                ),
                GetBuilder<BottomNavigationController>(
                    builder: (_dx) => _dx.userInfo != null
                        ? InkWell(
                            onTap: () {
                              final phone = _dx.userInfo['phone'].toString();
                              settingCtrl.openURL(phone, 'phone');
                            },
                            child: Container(
                              width: appScreenUtil.screenActualWidth(),
                              padding: EdgeInsets.symmetric(vertical: appScreenUtil.size(15), horizontal: appScreenUtil.size(15)),
                              decoration: BoxDecoration(border: Border.all(width: 1, color: appColor.deactivateColor), borderRadius: BorderRadius.circular(5)),
                              child: Row(
                                children: [
                                  Image.asset(
                                    imageAssets.phoneIcon,
                                    width: appScreenUtil.size(20),
                                  ),
                                  SizedBox(width: appScreenUtil.size(10)),
                                  Text(
                                    _dx.userInfo['phone'].toString(),
                                    style: appCss.bodyStyle5.copyWith(color: appColor.black22Color),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : Container()),
                Spacer(),
                Padding(
                  padding: EdgeInsets.all(appScreenUtil.size(10)),
                  child: CustomButton(
                    title: "Change Password",
                    style: appCss.bodyStyle4.copyWith(color: appColor.primaryColor),
                    border: Border.all(width: 1, color: appColor.primaryColor),
                    onTap: () {
                      settingCtrl.changePassword();
                    },
                    color: Colors.transparent,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(appScreenUtil.size(10)),
                  child: CustomButton(
                    title: "Logout",
                    onTap: () {
                      settingCtrl.logout();
                    },
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
