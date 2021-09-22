import 'package:flutter/material.dart';
import 'package:quality_app/controllers/wish_controller.dart';
import 'package:quality_app/global/packages/config_package.dart';
import 'package:quality_app/global/widgets/common/custom_button.dart';
import 'package:quality_app/global/widgets/common/custom_textformfield.dart';
import 'package:quality_app/global/widgets/notification_icon_header.dart';

// ignore: must_be_immutable
class WishMessage extends StatelessWidget {
  var wishCtrl = Get.put(WishController());

  Widget validationWidget(errorValidation) {
    return Container(
      padding: EdgeInsets.only(top: appScreenUtil.size(8)),
      child: Align(
        alignment: Alignment.topLeft,
        child: Text(
          errorValidation,
          style: appCss.validationTextStyle,
        ),
      ),
    );
  }

  // Widget requestListViewWidget() {
  //   return InkWell(
  //     highlightColor: Colors.transparent,
  //     onTap: () {
  //       Get.toNamed(routeName.requestList);
  //     },
  //     child: Padding(
  //       padding: EdgeInsets.only(right: appScreenUtil.size(10)),
  //       child: Icon(Icons.view_list_outlined, size: appScreenUtil.size(25), color: Colors.black),
  //       // child: Image.asset(
  //       //   notificationIcon,
  //       //   width: appScreenUtil.size(20),
  //       // ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WishController>(builder: (_) {
      dynamic errorWishValidation = wishCtrl.wishFieldError ?? '';
      print(errorWishValidation);

      return Scaffold(
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: LoadingComponent(
            child: Container(
              height: double.infinity,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: appScreenUtil.size(20)),
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Text(
                          'Request',
                          style: appCss.h1,
                        ),
                        Spacer(),
                        NotificationHeaderIcon(),
                        // requestListViewWidget()
                      ],
                    ),
                    SizedBox(
                      height: appScreenUtil.size(20),
                    ),
                    Container(
                      decoration: BoxDecoration(border: Border.all(width: 1, color: appColor.deactivateColor), borderRadius: BorderRadius.circular(appScreenUtil.size(10))),
                      child: CustomTextFormField(
                        maxLines: 3,
                        container: wishCtrl.txtwishComment,
                        hintText: "What is your wish for next visit?",
                        cursorColor: appColor.primaryColor,
                        // prefixIcon: Icon(MdiIcons.commentOutline),
                        obscureText: false,
                        style: appCss.bodyStyle5.copyWith(color: appColor.black22Color),
                        keyboardType: TextInputType.multiline,
                        padding: appScreenUtil.size(20),
                      ),
                    ),
                    if (errorWishValidation != '') validationWidget(errorWishValidation),
                    Spacer(),
                    CustomButton(
                      title: "Your All Request",
                      color: appColor.whiteColor,
                      border: Border.all(color: appColor.primaryColor),
                      style: appCss.bodyStyle4.copyWith(color: appColor.primaryColor),
                      onTap: () {
                        Get.toNamed(routeName.requestList);
                      },
                    ),
                    SizedBox(height: appScreenUtil.size(15)),
                    CustomButton(
                      title: "Send",
                      onTap: () {
                        wishCtrl.sendRequest();
                      },
                    ),
                    SizedBox(height: appScreenUtil.size(15)),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
