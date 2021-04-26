import 'package:quality_app/controllers/review_submission_controller.dart';
import 'package:quality_app/controllers/home_client_controller.dart';
import 'package:quality_app/controllers/wish_controller.dart';
import 'package:quality_app/packages/input_package.dart';
import 'package:flutter/material.dart';
import 'package:quality_app/packages/config_package.dart';

class WishMessage extends StatelessWidget {
  var wishCtrl = Get.put(WishController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: LoadingComponent(
          child: Container(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth(20)),
              child: Column(
                children: [
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Text(
                        'Request',
                        style: h1,
                      ),
                      Spacer(),
                      NotificationHeaderIcon()
                    ],
                  ),
                  SizedBox(
                    height: screenHeight(20),
                  ),
                  Container(
                    decoration: BoxDecoration(border: Border.all(width: 1, color: deactivateColor), borderRadius: BorderRadius.circular(screenWidth(5))),
                    child: CustomTextFormField(
                      maxLines: 3,
                      container: wishCtrl.txtwishComment,
                      hintText: "What is your wish for next visit?",
                      // prefixIcon: Icon(MdiIcons.commentOutline),
                      obscureText: false,
                      style: bodyStyle5.copyWith(color: black22Color),
                      keyboardType: TextInputType.multiline,
                      padding: screenWidth(20),
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: EdgeInsets.all(screenWidth(10)),
                    child: CustomButton(
                      title: "Send",
                      onTap: () {},
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
