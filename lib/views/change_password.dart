import 'package:flutter/material.dart';
import 'package:quality_app/controllers/change_password_controller.dart';
import 'package:quality_app/global/packages/config_package.dart';
import 'package:quality_app/global/widgets/common/custom_button.dart';
import 'package:quality_app/global/widgets/common/custom_textformfield.dart';

// ignore: must_be_immutable
class ChangePassword extends StatelessWidget {
  var changePasswordCtrl = Get.put(ChangePasswordController());

  Widget passwordCustomWidget() {
    dynamic errorPasswordValidation = changePasswordCtrl.passwordFieldError ?? '';
    dynamic errorCPasswordValidation = changePasswordCtrl.cPasswordFieldError ?? '';
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(border: Border.all(width: 1, color: appColor.deactivateColor), borderRadius: BorderRadius.circular(appScreenUtil.size(10))),
          child: CustomTextFormField(
            container: changePasswordCtrl.txtPassword,
            hintText: "Password",
            prefixIcon: Icon(MdiIcons.lock),
            // suffixIcon: IconButton(
            //   icon: Icon(changePasswordCtrl.isObscureText == true ? MdiIcons.eye : MdiIcons.eyeOff, color: appColor.deactivateColor),
            //   onPressed: () {
            //     changePasswordCtrl.togglePassword();
            //   },
            // ),
            obscureText: true, //changePasswordCtrl.isObscureText,
            style: appCss.bodyStyle5.copyWith(color: appColor.black22Color),
            keyboardType: TextInputType.text,
            padding: 18,
          ),
        ),
        if (errorPasswordValidation != '') validationWidget(errorPasswordValidation),
        SizedBox(height: appScreenUtil.size(15)),
        Container(
          decoration: BoxDecoration(border: Border.all(width: 1, color: appColor.deactivateColor), borderRadius: BorderRadius.circular(appScreenUtil.size(10))),
          child: CustomTextFormField(
            container: changePasswordCtrl.txtConfirmPassword,
            hintText: "Confirm Password",
            prefixIcon: Icon(MdiIcons.lock),
            // suffixIcon: IconButton(
            //   icon: Icon(changePasswordCtrl.isObscureText == true ? MdiIcons.eye : MdiIcons.eyeOff, color: appColor.deactivateColor),
            //   onPressed: () {
            //     changePasswordCtrl.togglePassword();
            //   },
            // ),
            obscureText: false, //changePasswordCtrl.isObscureText,
            style: appCss.bodyStyle5.copyWith(color: appColor.black22Color),
            keyboardType: TextInputType.text,
            padding: 18,
          ),
        ),
        if (errorCPasswordValidation != '') validationWidget(errorCPasswordValidation),
        SizedBox(height: appScreenUtil.size(5)),
      ],
    );
  }

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
    AppBar appBar = AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: InkWell(
          child: Icon(MdiIcons.arrowLeft, color: appColor.black22Color),
          onTap: () {
            Navigator.pop(context);
          }),
    );

    var _pageSize = MediaQuery.of(context).size.height;
    var _notifySize = MediaQuery.of(context).padding.top;
    var _notifySize1 = MediaQuery.of(context).padding.bottom;
    var _appBarSize = appBar.preferredSize.height;

    return GetBuilder<ChangePasswordController>(
      builder: (_) => Scaffold(
        appBar: appBar,
        backgroundColor: appColor.bgColor,
        body: LoadingComponent(
          child: SingleChildScrollView(
            padding: EdgeInsets.only(bottom: appScreenUtil.size(20)),
            child: Container(
              height: _pageSize - (_appBarSize + _notifySize + _notifySize1),
              padding: EdgeInsets.symmetric(horizontal: appScreenUtil.size(20)),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Change Password',
                          style: appCss.h1,
                        ),
                      ),
                      SizedBox(width: 5),
                    ],
                  ),
                  SizedBox(height: appScreenUtil.size(15)),
                  passwordCustomWidget(),
                  SizedBox(height: appScreenUtil.size(20)),
                  Spacer(),
                  CustomButton(
                    title: "Update",
                    onTap: () {
                      changePasswordCtrl.changePassword();
                    },
                  ),
                  SizedBox(height: appScreenUtil.size(15)),
                  /*Container(
                    padding: EdgeInsets.symmetric(vertical: appScreenUtil.size(10)),
                    // decoration: BoxDecoration(border: Border(bottom: BorderSide(color: borderLineColor, width: 0.2))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        passwordCustomWidget(),
                        SizedBox(height: appScreenUtil.size(20)),
                        Spacer(),
                        Padding(
                          padding: EdgeInsets.all(appScreenUtil.size(10)),
                          child: CustomButton(
                            title: "Update",
                            onTap: () {
                              changePasswordCtrl.changePassword();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),*/
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
