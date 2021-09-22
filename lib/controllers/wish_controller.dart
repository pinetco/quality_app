import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quality_app/controllers/bottom_navigation_controller.dart';
import 'package:quality_app/global/packages/config_package.dart';

class WishController extends GetxController with SingleGetTickerProviderMixin {
  TextEditingController txtwishComment = TextEditingController();
  String wishFieldError;

  @override
  void onInit() async {
    // TODO: implement onInit

    update();
    // getPhoneNumber();
    super.onInit();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: Get.context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          insetPadding: EdgeInsets.symmetric(horizontal: 20),
          contentPadding: EdgeInsets.all(15),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                InkWell(
                  onTap: () {
                    Navigator.pop(Get.context);
                  },
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Icon(
                      MdiIcons.close,
                      size: appScreenUtil.size(30),
                      color: Colors.black54,
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      imageAssets.checkMark,
                      width: 50,
                      height: 50,
                    ),
                    SizedBox(height: appScreenUtil.size(10)),
                    Text('Thank You', style: appCss.bodyStyle3.copyWith(color: appColor.black22Color)),
                    Container(
                      width: appScreenUtil.screenActualWidth() - appScreenUtil.size(50),
                      padding: EdgeInsets.symmetric(horizontal: appScreenUtil.size(10)),
                      child: Text(
                        'Your request has been send successfully',
                        style: appCss.bodyStyle6.copyWith(color: appColor.grayColor),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  sendRequest() {
    wishFieldError = '';
    update();

    final formData = {'description': txtwishComment.text};
    helper.showLoading();
    apis.call(apiMethods.createRequestAPI, formData, apiType.post).then((res) async {
      helper.hideLoading();
      if (res.data != null && res.validation == false) {
        final message = res.data['message'];
        txtwishComment.clear();
        // helper.successMessage(message.toUpperCase());
        // Get.toNamed();
        _showMyDialog();
        var bottomCtrl = Get.find<BottomNavigationController>();
        bottomCtrl.updateCurrentTab(0);
        update();
      } else if (res.validation == true) {
        final data = res.data;
        final errors = data['errors'];
        wishFieldError = errors['description'] != null ? errors['description'][0] : '';

        update();
      }
    }, onError: (e) {
      print('e');
    });
  }
}
