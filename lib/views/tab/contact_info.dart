import 'package:quality_app/controllers/setting_controller.dart';
import 'package:flutter/material.dart';
import 'package:quality_app/controllers/home_client_controller.dart';
import 'package:quality_app/packages/config_package.dart';
import 'package:quality_app/packages/input_package.dart';
import 'package:quality_app/theme/theme_service.dart';
import 'package:lottie/lottie.dart';

class ContactInfo extends StatefulWidget {
  @override
  _ContactInfoState createState() => _ContactInfoState();
}

class _ContactInfoState extends State<ContactInfo> with TickerProviderStateMixin {
  var settingCtrl = Get.put(SettingController());
  var storeCtrl = Get.find<HomeClientController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFFF7F8FA),
      body: SafeArea(
        child: LoadingComponent(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: screenWidth(20)),
            child: GetBuilder<HomeClientController>(builder: (_dx) {
              final phone = helper.jsonGet(_dx.userInfo, 'franchisee.phone', '');
              final contactName = helper.jsonGet(_dx.userInfo, 'franchisee.name', '');
              final email = helper.jsonGet(_dx.userInfo, 'franchisee.email', '');
              final websiteLink = helper.jsonGet(_dx.userInfo, 'franchisee.website', '');
              final fbLink = helper.jsonGet(_dx.userInfo, 'franchisee.fb_link', '');
              final twitterLink = helper.jsonGet(_dx.userInfo, 'franchisee.twitter_link', '');
              final linkedinLink = helper.jsonGet(_dx.userInfo, 'franchisee.linkedin_link', '');
              final logoUrl = helper.jsonGet(_dx.userInfo, 'franchisee.logo_url', '');
              return Column(
                children: [
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Text(
                        'Contact Info',
                        style: h1,
                      ),
                      Spacer(),
                      NotificationHeaderIcon(),
                    ],
                  ),
                  SizedBox(
                    height: screenWidth(30),
                  ),
                  Container(
                      padding: EdgeInsets.all(8),
                      height: screenHeight(150),
                      width: screenActualHeight(),
                      decoration: BoxDecoration(
                        border: Border.all(color: deactivateColor, width: 1),
                        borderRadius: BorderRadius.circular(screenWidth(10)),
                      ),
                      child: Center(
                        child: Image.network(logoUrl, height: screenHeight(150)),
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
                        if (contactName != null)
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: screenHeight(10)),
                            child: Row(
                              children: [
                                Icon(MdiIcons.officeBuildingOutline, size: screenWidth(20), color: primaryDarkColor),
                                SizedBox(width: screenWidth(10)),
                                Expanded(
                                  child: Text(contactName, style: bodyStyle5.copyWith(color: black22Color)),
                                ),
                              ],
                            ),
                          ),
                        if (email != null)
                          InkWell(
                            onTap: () {
                              settingCtrl.openURLContactInfo(email, 'email');
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: screenHeight(10)),
                              child: Row(
                                children: [
                                  Image.asset(emailIcon, width: screenWidth(20), color: primaryDarkColor),
                                  SizedBox(width: screenWidth(10)),
                                  Expanded(
                                    child: Text(_dx.userInfo['franchisee']['email'] ?? '', style: bodyStyle5.copyWith(color: black22Color)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        if (phone != '')
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: screenHeight(10)),
                            child: InkWell(
                              onTap: () {
                                settingCtrl.openURLContactInfo(phone, 'phone');
                              },
                              child: Row(
                                children: [
                                  Image.asset(phoneIcon, width: screenWidth(20), color: primaryDarkColor),
                                  SizedBox(width: screenWidth(10)),
                                  Expanded(
                                    child: Text(phone ?? '', style: bodyStyle5.copyWith(color: black22Color)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        if (websiteLink != '')
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: screenHeight(10)),
                            child: InkWell(
                              onTap: () {
                                settingCtrl.openURLContactInfo(websiteLink, 'website');
                              },
                              child: Row(
                                children: [
                                  Icon(MdiIcons.web, size: screenWidth(20), color: primaryDarkColor),
                                  SizedBox(width: screenWidth(10)),
                                  Expanded(
                                    child: Text(websiteLink, style: bodyStyle5.copyWith(color: primaryDarkColor)),
                                  ),
                                ],
                              ),
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
                            if (fbLink != '')
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: screenHeight(5)),
                                child: InkWell(
                                  onTap: () {
                                    settingCtrl.openURLContactInfo(fbLink, 'website');
                                  },
                                  child: Row(
                                    children: [
                                      Icon(MdiIcons.facebook, size: screenWidth(30), color: Color(0XFF4267B2)),
                                    ],
                                  ),
                                ),
                              ),
                            SizedBox(width: screenWidth(10)),
                            if (twitterLink != '')
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: screenHeight(5)),
                                child: InkWell(
                                  onTap: () {
                                    settingCtrl.openURLContactInfo(twitterLink, 'website');
                                  },
                                  child: Row(
                                    children: [
                                      Icon(MdiIcons.twitter, size: screenWidth(30), color: Color(0XFF00ACEE)),
                                    ],
                                  ),
                                ),
                              ),
                            SizedBox(width: screenWidth(10)),
                            if (linkedinLink != '')
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: screenHeight(5)),
                                child: InkWell(
                                  onTap: () {
                                    settingCtrl.openURLContactInfo(linkedinLink, 'website');
                                  },
                                  child: Row(
                                    children: [
                                      Icon(MdiIcons.linkedin, size: screenWidth(30), color: Color(0XFF0077b5)),
                                    ],
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
