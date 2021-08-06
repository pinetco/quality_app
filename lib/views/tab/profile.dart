import 'package:flutter/material.dart';
import 'package:quality_app/controllers/home_client_controller.dart';
import 'package:quality_app/controllers/setting_controller.dart';
import 'package:quality_app/packages/config_package.dart';
import 'package:quality_app/packages/input_package.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> with TickerProviderStateMixin {
  AnimationController _animationController;
  bool isPlaying = false;
  var settingCtrl = Get.put(SettingController());
  var storeCtrl = Get.find<HomeClientController>();

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
      body: SafeArea(
        child: LoadingComponent(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: screenWidth(20)),
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
                          style: h1,
                        ),
                        Spacer(),
                        ProfileEditIcon(),
                        SizedBox(width: 15),
                        NotificationHeaderIcon(),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: screenHeight(30)),
                GetBuilder<HomeClientController>(
                  builder: (_dx) => _dx.userInfo != null && _dx.userInfo['profile_photo_url'] != null
                      ? Container(
                          height: screenWidth(90),
                          width: screenWidth(90),
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(screenWidth(90)),
                          ),
                          child: Center(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(screenWidth(90)),
                              child: Image.network(
                                _dx.userInfo['profile_photo_url'],
                                width: screenWidth(90),
                                height: screenWidth(90),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ))
                      : Container(),
                ),
                SizedBox(
                  height: screenHeight(30),
                ),
                GetBuilder<HomeClientController>(
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
                GetBuilder<HomeClientController>(
                    builder: (_dx) => _dx.userInfo != null
                        ? InkWell(
                            onTap: () {
                              final email = _dx.userInfo['email'].toString();
                              settingCtrl.openURL(email, 'email');
                            },
                            child: Container(
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
                            ),
                          )
                        : Container()),
                SizedBox(
                  height: screenHeight(10),
                ),
                GetBuilder<HomeClientController>(
                    builder: (_dx) => _dx.userInfo != null
                        ? InkWell(
                            onTap: () {
                              final phone = _dx.userInfo['phone'].toString();
                              settingCtrl.openURL(phone, 'phone');
                            },
                            child: Container(
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
                            ),
                          )
                        : Container()),
                Spacer(),
                Padding(
                  padding: EdgeInsets.all(screenWidth(10)),
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

class ProfileEditIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(AppRouter.notification);
      },
      child: Container(
        height: screenWidth(20),
        width: screenWidth(20),
        decoration: BoxDecoration(
          // color: primaryColor,
          border: Border.all(
            color: black22Color,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(screenWidth(30)),
        ),
        child: Center(
          child: Icon(
            MdiIcons.accountEditOutline,
            size: screenWidth(20),
            color: black22Color,
          ),
        ),
      ),
    );
  }
}
