import 'package:flutter/material.dart';
import 'package:quality_app/controllers/other_user_profile_controller.dart';
import 'package:quality_app/global/packages/config_package.dart';

class CareGiverProfile extends StatefulWidget {
  @override
  _CareGiverProfileState createState() => _CareGiverProfileState();
}

class _CareGiverProfileState extends State<CareGiverProfile> with TickerProviderStateMixin {
  var otherUserProfileCtrl = Get.put(OtherUserProfileController());

  Widget renderComponent(_dx, type, icon, disabled) {
    final value = helper.jsonGet(_dx.userDetails, type, ''); //helper.jsonGet(_dx, 'userDetails.name', '');
    print(value);
    return InkWell(
      onTap: disabled
          ? null
          : () {
              //_dx.userDetails[type].toString();
              otherUserProfileCtrl.openURLContactInfo(value, type);
            },
      child: Container(
        width: appScreenUtil.screenActualWidth(),
        padding: EdgeInsets.symmetric(vertical: appScreenUtil.size(15), horizontal: appScreenUtil.size(15)),
        decoration: BoxDecoration(border: Border.all(width: 1, color: appColor.deactivateColor), borderRadius: BorderRadius.circular(5)),
        child: Row(
          children: [
            Image.asset(
              icon,
              width: appScreenUtil.size(20),
              color: appColor.primaryDarkColor,
            ),
            SizedBox(width: appScreenUtil.size(10)),
            Expanded(
              child: Text(
                value.toString(),
                style: appCss.bodyStyle5.copyWith(color: appColor.black22Color),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFFF7F8FA),
      appBar: AppBar(
        backgroundColor: Color(0XFFF7F8FA),
        elevation: 0,
        leading: InkWell(
            child: Icon(MdiIcons.arrowLeft, color: appColor.black22Color),
            onTap: () {
              Navigator.pop(context);
            }),
      ),
      body: SafeArea(child: GetBuilder<OtherUserProfileController>(builder: (_dx) {
        return LoadingComponent(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: appScreenUtil.size(20)),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      'Profile',
                      style: appCss.h1,
                    ),
                  ],
                ),
                SizedBox(height: appScreenUtil.size(30)),
                if (_dx.userDetails != null && _dx.userDetails['profile_photo_url'] != null)
                  Container(
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
                            _dx.userDetails['profile_photo_url'],
                            width: appScreenUtil.size(90),
                            height: appScreenUtil.size(90),
                            fit: BoxFit.fill,
                          ),
                        ),
                      )),
                SizedBox(height: appScreenUtil.size(30)),
                if (_dx.userDetails != null) renderComponent(_dx, 'name', imageAssets.userIcon, true),
                SizedBox(height: appScreenUtil.size(10)),
                if (_dx.userDetails != null) renderComponent(_dx, 'email', imageAssets.emailIcon, false),
                SizedBox(height: appScreenUtil.size(10)),
                if (_dx.userDetails != null) renderComponent(_dx, 'phone', imageAssets.phoneIcon, false),
                SizedBox(height: appScreenUtil.size(10)),
                if (helper.jsonGet(_dx.userDetails, 'location.full_address', '') != '') renderComponent(_dx, 'location.full_address', imageAssets.locationIcon, false),
              ],
            ),
          ),
        );
      })),
    );
  }
}
