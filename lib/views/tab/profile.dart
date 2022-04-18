import 'package:flutter/material.dart';
import 'package:quality_app/controllers/bottom_navigation_controller.dart';
import 'package:quality_app/controllers/setting_controller.dart';
import 'package:quality_app/controllers/splash_controller.dart';
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
  var splashCtrl = Get.find<SplashController>();
  var bottomCtrl = Get.find<BottomNavigationController>();

  Widget profileEditIcon(item) {
    dynamic imageName = item['profile_photo_url'];
    int id = item['id'];
    print("Item Id @@@@@@@@@@@ $id");
    print("Image Name ############# $imageName");
    return InkWell(
      onTap: () {
        bottomCtrl.navigateEditProfile(item);
      },
      child: Container(
        // height: appScreenUtil.size(25),
        // width: appScreenUtil.size(25),
        // decoration: BoxDecoration(
        //   // color: primaryColor,
        //   border: Border.all(
        //     color: appColor.black22Color,
        //     width: 1,
        //   ),
        //   borderRadius: BorderRadius.circular(appScreenUtil.size(30)),
        // ),
        child: Center(
          child: Icon(
            MdiIcons.squareEditOutline,
            size: appScreenUtil.size(21),
            // color: appColor.black22Color,
          ),
        ),
      ),
    );
  }

  Widget languageCode() {
    return InkWell(
      onTap: () {
        languageOption(context);
      },
      child: Container(
        child: Center(
          // child: Image.asset(imageAssets.germanFlag),
          child: Icon(
            MdiIcons.web,
            size: appScreenUtil.size(21),
            // color: appColor.black22Color,
          ),
        ),
      ),
    );
  }

  Widget languageOption(context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return GetBuilder<SplashController>(
          builder: (_) => ClipRRect(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(12),
              topLeft: Radius.circular(12),
            ),
            child: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(appScreenUtil.size(15)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          helper.trans('change_language'),
                          style: appCss.h2,
                        ),
                        IconButton(
                          icon: Icon(
                            MdiIcons.close,
                            color: appColor.textPrimaryColor,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ),
                  ListTile(
                    title: Text(helper.trans('english'), style: appCss.bodyStyle3),
                    leading: Image.asset(imageAssets.englishFlag),
                    onTap: () => splashCtrl.changeLanguage('en', 'US'),
                    tileColor: splashCtrl.languageCode == 'en' ? Colors.grey.withOpacity(0.1) : Colors.white,
                  ),
                  ListTile(
                    title: Text(helper.trans('german'), style: appCss.bodyStyle3),
                    leading: Image.asset(imageAssets.germanFlag),
                    onTap: () => splashCtrl.changeLanguage('de', 'DE'),
                    tileColor: splashCtrl.languageCode == 'de' ? Colors.grey.withOpacity(0.1) : Colors.white,
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: LoadingComponent(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: appScreenUtil.size(20)),
            child: Column(
              children: [
                Column(
                  children: [
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Text(
                          helper.trans('profile'),
                          style: appCss.h1,
                        ),
                        Spacer(),
                        languageCode(),
                        SizedBox(width: 15),
                        profileEditIcon(bottomCtrl.userInfo),
                        SizedBox(width: 15),
                        NotificationHeaderIcon(),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: appScreenUtil.size(20)),
                GetBuilder<BottomNavigationController>(
                  builder: (_dx) => _dx.userInfo != null && _dx.userInfo['profile_photo_url'] != null
                      ? Container(
                          height: appScreenUtil.size(90),
                          width: appScreenUtil.size(90),
                          decoration: BoxDecoration(
                            color: appColor.lightGreyColor.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(appScreenUtil.size(90)),
                          ),
                          child: Center(
                            child: ClipOval(
                              child: Container(
                                color: appColor.deactivateColor,
                                padding: EdgeInsets.all(appScreenUtil.size(1)),
                                child: ClipOval(
                                  // borderRadius: BorderRadius.circular(appScreenUtil.size(90)),
                                  child: helper.imageNetwork(
                                    url: _dx.userInfo['profile_photo_url'],
                                    width: appScreenUtil.size(90),
                                    height: appScreenUtil.size(90),
                                  ),
                                ),
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
                            decoration: BoxDecoration(border: Border.all(width: 1, color: appColor.deactivateColor), borderRadius: BorderRadius.circular(10)),
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
                              decoration: BoxDecoration(border: Border.all(width: 1, color: appColor.deactivateColor), borderRadius: BorderRadius.circular(10)),
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
                              decoration: BoxDecoration(border: Border.all(width: 1, color: appColor.deactivateColor), borderRadius: BorderRadius.circular(10)),
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
                CustomButton(
                  title: helper.trans('change_password'),
                  style: appCss.bodyStyle4.copyWith(color: appColor.primaryColor),
                  border: Border.all(width: 1, color: appColor.primaryColor),
                  onTap: () {
                    settingCtrl.changePassword();
                  },
                  color: Colors.transparent,
                ),
                SizedBox(height: appScreenUtil.size(15)),
                CustomButton(
                  title: helper.trans('logout'),
                  onTap: () {
                    settingCtrl.logout();
                  },
                ),
                SizedBox(height: appScreenUtil.size(15)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
