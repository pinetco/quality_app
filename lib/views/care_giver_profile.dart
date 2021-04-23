import 'package:quality_app/controllers/other_user_profile_controller.dart';
import 'package:quality_app/controllers/store_controller.dart';
import 'package:flutter/material.dart';
import 'package:quality_app/packages/config_package.dart';

class CareGiverProfile extends StatefulWidget {
  @override
  _CareGiverProfileState createState() => _CareGiverProfileState();
}

class _CareGiverProfileState extends State<CareGiverProfile> with TickerProviderStateMixin {
  var OtherUserProfileCtrl = Get.put(OtherUserProfileController());

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFFF7F8FA),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: InkWell(
            child: Icon(MdiIcons.arrowLeft, color: black22Color),
            onTap: () {
              Navigator.pop(context);
            }),
      ),
      body: SafeArea(
        child: LoadingComponent(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: screenWidth(20)),
            child: Column(
              children: [
                // Align(alignment: Alignment.topLeft, child: Text('Profile', style: h1)),
                Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          'Profile',
                          style: h1,
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: screenHeight(30)),
                GetBuilder<OtherUserProfileController>(
                  builder: (_dx) => _dx.userDetails != null && _dx.userDetails['userImage'] != null
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
                                _dx.userDetails['userImage'],
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
                GetBuilder<OtherUserProfileController>(
                    builder: (_dx) => _dx.userDetails != null
                        ? Container(
                            width: screenActualWidth(),
                            padding: EdgeInsets.symmetric(vertical: screenHeight(15), horizontal: screenWidth(15)),
                            decoration: BoxDecoration(border: Border.all(width: 1, color: deactivateColor), borderRadius: BorderRadius.circular(5)),
                            child: Row(
                              children: [
                                Image.asset(userIcon, width: screenWidth(20), color: primaryDarkColor),
                                SizedBox(width: screenWidth(10)),
                                Text(
                                  _dx.userDetails['name'].toString(),
                                  style: bodyStyle5.copyWith(color: black22Color),
                                )
                              ],
                            ),
                          )
                        : Container()),
                SizedBox(
                  height: screenHeight(10),
                ),
                GetBuilder<OtherUserProfileController>(
                    builder: (_dx) => _dx.userDetails != null
                        ? InkWell(
                            onTap: () {
                              final email = _dx.userDetails['email'].toString();
                              //   settingCtrl.openURL(email, 'email');
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
                                    _dx.userDetails['email'].toString(),
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
                GetBuilder<OtherUserProfileController>(
                    builder: (_dx) => _dx.userDetails != null
                        ? InkWell(
                            onTap: () {
                              final phone = _dx.userDetails['phone'].toString();
                              // settingCtrl.openURL(phone, 'phone');
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
                                    _dx.userDetails['phone'].toString(),
                                    style: bodyStyle5.copyWith(color: black22Color),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : Container()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
