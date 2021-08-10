import 'package:quality_app/controllers/wish_controller.dart';
import 'package:quality_app/global/packages/config_package.dart';
import 'package:quality_app/global/widgets/common/custom_button.dart';
import 'package:quality_app/global/widgets/common/custom_textformfield.dart';
import 'package:quality_app/global/widgets/notification_icon_header.dart';
import 'package:flutter/material.dart';

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
        ));
  }

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
                        NotificationHeaderIcon()
                      ],
                    ),
                    SizedBox(
                      height: appScreenUtil.size(20),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: appColor.deactivateColor), borderRadius: BorderRadius.circular(appScreenUtil.size(5))),
                      child: CustomTextFormField(
                        maxLines: 3,
                        container: wishCtrl.txtwishComment,
                        hintText: "What is your wish for next visit?",
                        // prefixIcon: Icon(MdiIcons.commentOutline),
                        obscureText: false,
                        style: appCss.bodyStyle5.copyWith(color: appColor.black22Color),
                        keyboardType: TextInputType.multiline,
                        padding: appScreenUtil.size(20),
                      ),
                    ),
                    if (errorWishValidation != '') validationWidget(errorWishValidation),
                    Spacer(),
                    Padding(
                      padding: EdgeInsets.all(appScreenUtil.size(10)),
                      child: CustomButton(
                        title: "Send",
                        onTap: () {
                          wishCtrl.sendRequest();
                        },
                      ),
                    ),
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
