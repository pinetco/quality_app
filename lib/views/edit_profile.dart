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

  // Widget renderImage(file) {
  //   if (file['0']['image_url'] != null) {
  //     return Image.network(file, errorBuilder: (BuildContext context, Object exception, StackTrace stackTrace) {
  //       print("Krushant");
  //       return Image.file(file);
  //     });
  //   }
  //   // return Image.file(file['file']);
  // }

  @override
  Widget build(BuildContext context) {
    // dynamic file = editProfileCtrl.fileList;
    return Scaffold(
      backgroundColor: Color(0XFFF7F8FA),
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
                          'Edit Profile',
                          style: appCss.h1,
                        ),
                        Spacer(),
                        SizedBox(width: 15),
                        NotificationHeaderIcon(),
                      ],
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
                            ClipRRect(
                              borderRadius: BorderRadius.circular(appScreenUtil.size(90)),
                              // child: renderImage(file),

                              child: helper.imageNetwork(
                                url: helper.getImagePath(editProfileCtrl.profileImage),
                                height: appScreenUtil.size(100),
                                width: appScreenUtil.size(100),
                                fit: BoxFit.cover,
                              ),
                              // child: Image.network(
                              //   _.userInfo['profile_photo_url'],
                              //   width: appScreenUtil.size(90),
                              //   height: appScreenUtil.size(90),
                              //   fit: BoxFit.fill,
                              //   errorBuilder: (BuildContext context, Object exception, StackTrace stackTrace) {
                              //     return Image.asset(imageAssets.userIcon);
                              //   },
                              // ),
                            ),
                            Positioned(
                              right: -10,
                              bottom: 0,
                              child: SizedBox(
                                height: 40,
                                width: 40,
                                child: FlatButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                    side: BorderSide(color: appColor.bgColor),
                                  ),
                                  color: appColor.primaryColor,
                                  onPressed: () {
                                    showPicker(context);
                                  },
                                  child: Icon(
                                    MdiIcons.pencil,
                                    size: appScreenUtil.size(15),
                                    color: appColor.bgColor,
                                  ),
                                ),
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
                  decoration: BoxDecoration(border: Border.all(width: 1, color: appColor.deactivateColor), borderRadius: BorderRadius.circular(5)),
                  child: GetBuilder<EditProfileController>(
                    builder: (_) => CustomTextFormField(
                      container: editProfileCtrl.txtEditUserName,
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
                  decoration: BoxDecoration(border: Border.all(width: 1, color: appColor.deactivateColor), borderRadius: BorderRadius.circular(5)),
                  child: GetBuilder<EditProfileController>(
                    builder: (_) => CustomTextFormField(
                      container: editProfileCtrl.txtEditEmail,
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
                  decoration: BoxDecoration(border: Border.all(width: 1, color: appColor.deactivateColor), borderRadius: BorderRadius.circular(5)),
                  child: GetBuilder<EditProfileController>(
                    builder: (_) => CustomTextFormField(
                      container: editProfileCtrl.txtEditPhoneNumber,
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
                Padding(
                  padding: EdgeInsets.all(appScreenUtil.size(10)),
                  child: CustomButton(
                    title: "Save",
                    onTap: () {
                      editProfileCtrl.updateProfileData();
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
