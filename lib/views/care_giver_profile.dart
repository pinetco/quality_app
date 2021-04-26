import 'package:quality_app/controllers/other_user_profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:quality_app/packages/config_package.dart';

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
        width: screenActualWidth(),
        padding: EdgeInsets.symmetric(vertical: screenHeight(15), horizontal: screenWidth(15)),
        decoration: BoxDecoration(border: Border.all(width: 1, color: deactivateColor), borderRadius: BorderRadius.circular(5)),
        child: Row(
          children: [
            Image.asset(
              icon,
              width: screenWidth(20),
              color: primaryDarkColor,
            ),
            SizedBox(width: screenWidth(10)),
            Expanded(
              child: Text(
                value.toString(),
                style: bodyStyle5.copyWith(color: black22Color),
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
                  builder: (_dx) => _dx.userDetails != null && _dx.userDetails['profile_photo_url'] != null
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
                                _dx.userDetails['profile_photo_url'],
                                width: screenWidth(90),
                                height: screenWidth(90),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ))
                      : Container(),
                ),
                SizedBox(height: screenHeight(30)),
                GetBuilder<OtherUserProfileController>(builder: (_dx) => _dx.userDetails != null ? renderComponent(_dx, 'name', userIcon, true) : Container()),
                SizedBox(height: screenHeight(10)),
                GetBuilder<OtherUserProfileController>(
                    builder: (_dx) => _dx.userDetails != null ? renderComponent(_dx, 'email', emailIcon, false) : Container()),
                SizedBox(height: screenHeight(10)),
                GetBuilder<OtherUserProfileController>(
                    builder: (_dx) => _dx.userDetails != null ? renderComponent(_dx, 'phone', phoneIcon, false) : Container()),
                SizedBox(height: screenHeight(10)),
                GetBuilder<OtherUserProfileController>(
                    builder: (_dx) => _dx.userDetails != null ? renderComponent(_dx, 'location.full_address', locationIcon, false) : Container()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
