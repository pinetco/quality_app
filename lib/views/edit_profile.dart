import 'package:flutter/material.dart';
import 'package:quality_app/controllers/bottom_navigation_controller.dart';
import 'package:quality_app/controllers/edit_profile_controller.dart';
import 'package:quality_app/global/packages/config_package.dart';
import 'package:quality_app/global/widgets/common/custom_button.dart';
import 'package:quality_app/global/widgets/common/custom_textformfield.dart';
import 'package:quality_app/global/widgets/notification_icon_header.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  var editProfileCtrl = Get.put(EditProfileController());
  var bottomCtrl = Get.find<BottomNavigationController>();

  Widget showPicker(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Wrap(
                children: <Widget>[
                  ListTile(
                      leading: Icon(Icons.photo_camera, color: appColor.primaryColor),
                      title: Text('Camera', style: appCss.bodyStyle5.copyWith(color: appColor.black22Color)),
                      onTap: () {
                        editProfileCtrl.cameraImageUpload();
                        Navigator.of(context).pop();
                      }),
                  ListTile(
                      leading: Icon(Icons.photo_library, color: appColor.primaryColor),
                      title: Text('Gallery', style: appCss.bodyStyle5.copyWith(color: appColor.black22Color)),
                      onTap: () {
                        editProfileCtrl.galleryImageUpload();
                        Navigator.of(context).pop();
                      }),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget renderImage(profileImageFile) {
    print("++++++++++Image+++++++++  $profileImageFile");
    if (profileImageFile['profile_image'] != null && profileImageFile['profile_image'] is String) {
      return Container(
        child: Image.network(profileImageFile['profile_image'], errorBuilder: (BuildContext context, Object exception, StackTrace stackTrace) {
          return Image.asset(imageAssets.noImageBanner);
        }),
      );
    } else
      return Image.file(editProfileCtrl.selectedFile);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFFF7F8FA),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        automaticallyImplyLeading: false,
        leading: Center(
          child: InkWell(
            highlightColor: Colors.white,
            splashColor: Colors.transparent,
            onTap: () {
              Get.back();
              //bottomCtrl.updateCurrentTab(2);
            },
            child: Image.asset(
              imageAssets.backIcon,
              width: appScreenUtil.size(20),
            ),
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: appScreenUtil.size(10)),
            child: Center(
              child: NotificationHeaderIcon(),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: LoadingComponent(
            child: GetBuilder<EditProfileController>(
                builder: (_) => Container(
                      padding: EdgeInsets.symmetric(horizontal: appScreenUtil.size(20)),
                      child: Column(
                        children: [
                          Column(
                            children: [
                              // SizedBox(height: 10),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'Edit Profile',
                                  style: appCss.h1,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: appScreenUtil.size(30)),
                          GetBuilder<EditProfileController>(
                            builder: (_) {
                              return Container(
                                height: appScreenUtil.size(90),
                                width: appScreenUtil.size(90),
                                decoration: BoxDecoration(
                                  color: appColor.primaryColor,
                                  borderRadius: BorderRadius.circular(appScreenUtil.size(90)),
                                ),
                                child: Center(
                                  child: Stack(
                                    fit: StackFit.expand,
                                    overflow: Overflow.visible,
                                    clipBehavior: Clip.none,
                                    children: [
                                      ClipOval(
                                        // borderRadius: BorderRadius.circular(appScreenUtil.size(90)),
                                        child: Container(
                                          color: appColor.deactivateColor,
                                          padding: EdgeInsets.all(appScreenUtil.size(1)),
                                          child: ClipOval(
                                            child: editProfileCtrl.selectedFile != null
                                                ? Image.file(editProfileCtrl.selectedFile, fit: BoxFit.cover)
                                                : Container(
                                                    child: helper.imageNetwork(
                                                      url: bottomCtrl.userInfo['profile_photo_url'],
                                                      width: appScreenUtil.size(90),
                                                      height: appScreenUtil.size(90),
                                                    ),
                                                  ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: appScreenUtil.size(0),
                                        right: appScreenUtil.size(-5),
                                        // right: -10,
                                        // bottom: 0,
                                        child: InkWell(
                                          onTap: () => showPicker(context),
                                          child: ClipOval(
                                            child: Container(
                                              padding: EdgeInsets.all(appScreenUtil.size(8)),
                                              decoration: BoxDecoration(
                                                color: appColor.whiteColor,
                                                border: Border.all(color: appColor.deactivateColor, width: appScreenUtil.size(1)),
                                                borderRadius: BorderRadius.circular(appScreenUtil.size(90)),
                                              ),
                                              child: Icon(
                                                Icons.edit,
                                                size: appScreenUtil.size(15),
                                                color: appColor.primaryDarkColor,
                                              ),
                                            ),
                                          ),
                                          // child: FlatButton(
                                          //   shape: RoundedRectangleBorder(
                                          //     borderRadius: BorderRadius.circular(50),
                                          //     side: BorderSide(color: appColor.bgColor),
                                          //   ),
                                          //   color: appColor.primaryColor,
                                          //   onPressed: () {
                                          //     showPicker(context);
                                          //   },
                                          //   child: Icon(
                                          //     MdiIcons.pencil,
                                          //     size: appScreenUtil.size(15),
                                          //     color: appColor.bgColor,
                                          //   ),
                                          // ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                          SizedBox(height: appScreenUtil.size(30)),
                          Container(
                            width: appScreenUtil.screenActualWidth(),
                            decoration: BoxDecoration(border: Border.all(width: 1, color: appColor.deactivateColor), borderRadius: BorderRadius.circular(10)),
                            child: GetBuilder<EditProfileController>(
                              builder: (_) => CustomTextFormField(
                                container: editProfileCtrl.txtEditUserName,
                                cursorColor: appColor.primaryColor,
                                hintText: "User names",
                                prefixIcon: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(imageAssets.userIcon, width: appScreenUtil.size(20), height: appScreenUtil.size(20), color: appColor.primaryDarkColor),
                                  ],
                                ),
                                style: appCss.bodyStyle5.copyWith(color: appColor.black22Color),
                                keyboardType: TextInputType.multiline,
                                padding: 15,
                              ),
                            ),
                          ),
                          SizedBox(height: appScreenUtil.size(20)),
                          Container(
                            width: appScreenUtil.screenActualWidth(),
                            decoration: BoxDecoration(border: Border.all(width: 1, color: appColor.deactivateColor), borderRadius: BorderRadius.circular(10)),
                            child: GetBuilder<EditProfileController>(
                              builder: (_) => CustomTextFormField(
                                container: editProfileCtrl.txtEditEmail,
                                cursorColor: appColor.primaryColor,
                                hintText: "Email",
                                prefixIcon: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(imageAssets.emailIcon, width: appScreenUtil.size(20), height: appScreenUtil.size(20), color: appColor.primaryDarkColor),
                                  ],
                                ),
                                style: appCss.bodyStyle5.copyWith(color: appColor.black22Color),
                                keyboardType: TextInputType.multiline,
                                padding: 15,
                              ),
                            ),
                          ),
                          SizedBox(height: appScreenUtil.size(20)),
                          Container(
                            width: appScreenUtil.screenActualWidth(),
                            decoration: BoxDecoration(border: Border.all(width: 1, color: appColor.deactivateColor), borderRadius: BorderRadius.circular(10)),
                            child: GetBuilder<EditProfileController>(
                              builder: (_) => CustomTextFormField(
                                container: editProfileCtrl.txtEditPhoneNumber,
                                cursorColor: appColor.primaryColor,
                                hintText: "Phone number",
                                prefixIcon: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(imageAssets.phoneIcon, width: appScreenUtil.size(20), height: appScreenUtil.size(20), color: appColor.primaryDarkColor),
                                  ],
                                ),
                                style: appCss.bodyStyle5.copyWith(color: appColor.black22Color),
                                keyboardType: TextInputType.number,
                                padding: 15,
                              ),
                            ),
                          ),
                          Spacer(),
                          CustomButton(
                              title: "Save",
                              onTap: () {
                                editProfileCtrl.updateProfileData();
                              }),
                          SizedBox(height: appScreenUtil.size(15)),
                          // Row(
                          //   children: [
                          //     Expanded(
                          //       child: CustomButton(
                          //         title: "Cancel",
                          //         style: appCss.bodyStyle4.copyWith(color: appColor.primaryColor),
                          //         border: Border.all(width: 1, color: appColor.primaryColor),
                          //         onTap: () {
                          //           Get.back();
                          //         },
                          //         color: Colors.transparent,
                          //       ),
                          //     ),
                          //     SizedBox(width: appScreenUtil.size(10)),
                          //     Expanded(
                          //       child: CustomButton(
                          //         title: "Save",
                          //         onTap: () {
                          //           editProfileCtrl.updateProfileData();
                          //         },
                          //       ),
                          //     ),
                          //   ],
                          // ),
                        ],
                      ),
                    ))),
      ),
    );
  }
}
