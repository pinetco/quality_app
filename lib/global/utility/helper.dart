import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:quality_app/controllers/common/loading_controller.dart';
import 'package:quality_app/global/networking/server_config.dart';
import 'package:quality_app/global/packages/config_package.dart';

ServerConfig _serverConfig = ServerConfig();

final _storage = GetStorage();
var loadingCtrl = Get.find<LoadingController>();

class Helper {
  dynamic getStorage(String name) {
    dynamic info = _storage.read(name) ?? '';
    return info != '' ? json.decode(info) : info;
  }

  dynamic writeStorage(String key, dynamic value) {
    dynamic object = value != null ? json.encode(value) : value;
    return _storage.write(key, object);
  }

  dynamic removeSpecificKeyStorage(String key) {
    _storage.remove(key);
  }

  clearStorage() {
    _storage.erase();
  }

  String getImagePath(dynamic url) {
    if (url != null && url is String) {
      if (url.contains('http') || url.contains('https'))
        return url;
      else {
        return _serverConfig.baseUrl + url;
      }
    } else
      return '';
  }

  Widget imageNetwork({
    String? url,
    double? height,
    double? width,
    BoxFit? fit,
    Widget? placeholder,
    String? errorImageAsset,
  }) {
    return CachedNetworkImage(
      imageUrl: url!,
      width: width,
      height: height,
      fit: fit ?? BoxFit.cover,
      placeholder: (context, url) => placeholder ?? Center(child: CircularProgressIndicator()),
      errorWidget: (context, url, error) => Image.asset(
        errorImageAsset ?? imageAssets.noImageBanner,
        width: width,
        height: height,
        fit: BoxFit.cover,
      ),
    );
  }

  //#region Dialog & Alert
  dialogMessage(String message, {String title = "App Name", onConfirm, onCancel}) {
    return Get.defaultDialog(
      title: title,
      middleText: "$message",
      onConfirm: onConfirm,
      titleStyle: appCss.h3,
      middleTextStyle: appCss.bodyStyle4,
      confirmTextColor: Colors.white,
      buttonColor: appColor.primaryColor,
      onCancel: onCancel,
    );
  }

  void deleteConfirmation({context, title, message, onConfirm}) {
    // set up the buttons
    Widget cancelButton = TextButton(
        child: Text(helper.trans('cancel'), style: appCss.bodyStyle5),
        onPressed: () {
          Get.back();
        });
    Widget continueButton = TextButton(child: Text(helper.trans('continue')), onPressed: onConfirm);
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title ?? helper.trans('delete_confirmation'), style: appCss.h3),
      content: Text(message ?? helper.trans("confirm_delete"), style: appCss.bodyStyle4),
      actions: [cancelButton, continueButton],
    );
    // show the dialog
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        });
  }
  //#endregion

  //#region ForJson
  getFromJson(json, String path, defaultValue) {
    try {
      List pathSplitter = path.split(".");

      /// <String,dynamic> || String
      var returnValue;

      json.forEach((key, value) {
        var currentPatten = pathSplitter[0];
        int index = 0;

        if (currentPatten.contains('[') && currentPatten.contains(']')) {
          int index1 = currentPatten.indexOf('[');
          int index2 = currentPatten.indexOf(']');

          index = int.parse(currentPatten.substring(index1 + 1, index2));
          currentPatten = currentPatten.substring(0, index1);
        }

        if (key == currentPatten) {
          if (pathSplitter.length == 1) {
            returnValue = value;
            return;
          }

          pathSplitter.remove(pathSplitter[0]);

          if (value == null) {
            returnValue = defaultValue;
            return;
          }
          try {
            try {
              value = value.toJson();
            } catch (error) {
              // handle error
            }

            try {
              if (value is List) {
                value = value[index];
              }
            } catch (error) {
              // handle error
            }

            returnValue = getFromJson(value, pathSplitter.join("."), defaultValue);
          } catch (error) {
            returnValue = defaultValue;
          }
          return;
        }
      });

      return returnValue != null ? returnValue : defaultValue;
    } on Exception catch (e) {
      // TODO
      return defaultValue;
    }
  }

  dynamic filter(dynamic items, dynamic key, value) {
    return items.where((u) => (u['$key'].toString() != null ? u['$key'].toString().toLowerCase().contains(value.toLowerCase()) : false)).toList();
  }
  //#endregion

  //#region Loading
  void showLoading() {
    return loadingCtrl.showLoading();
  }

  void hideLoading() {
    return loadingCtrl.hideLoading();
  }

  //#endregion

  double toDouble(dynamic val) {
    if (val != null)
      return double.parse(val.toString());
    else
      return 0;
  }

  //#region Success, Alert, Error Message

  messageContainer(message, icon) => Row(children: [
        Icon(
          icon,
          color: Colors.white,
          size: appScreenUtil.size(22),
        ),
        SizedBox(width: appScreenUtil.size(10)),
        Text(
          message,
          style: TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.w400,
          ),
        ),
      ]);

  actionButton() => TextButton(
        child: Icon(
          Icons.close_outlined,
          color: Colors.white,
          size: appScreenUtil.size(22),
        ),
        onPressed: () {},
      );

  flashMessage({
    String? message,
    Color? bgColor,
    SnackPosition? position,
    IconData? icon,
  }) =>
      Get.snackbar(
        '',
        '',
        snackPosition: position ?? SnackPosition.TOP,
        snackStyle: SnackStyle.FLOATING,
        messageText: messageContainer(message, icon),
        titleText: Container(),
        margin: EdgeInsets.only(bottom: kBottomNavigationBarHeight, left: appScreenUtil.size(8), right: appScreenUtil.size(8)),
        padding: EdgeInsets.only(bottom: appScreenUtil.size(4), left: appScreenUtil.size(16), right: appScreenUtil.size(16)),
        borderRadius: appScreenUtil.borderRadius(4),
        backgroundColor: bgColor,
        colorText: Colors.white,
        mainButton: actionButton(),
      );

  successMessage(message, {position}) => flashMessage(message: message, bgColor: Colors.green, position: position, icon: Icons.check_circle);
  errorMessage(message, {position}) => flashMessage(message: message, bgColor: Colors.red, position: position, icon: Icons.cancel);
  alertMessage(message, {position}) => flashMessage(message: message, bgColor: Colors.orange, position: position, icon: Icons.info);

  //#endregion

  jsonGet(json, String path, defaultValue) {
    try {
      List pathSplitter = path.split(".");

      /// <String,dynamic> || String
      var returnValue;
      json.forEach((key, value) {
        var currentPatten = pathSplitter[0];
        int index = 0;
        if (currentPatten.contains('[') && currentPatten.contains(']')) {
          int index1 = currentPatten.indexOf('[');
          int index2 = currentPatten.indexOf(']');
          index = int.parse(currentPatten.substring(index1 + 1, index2));
          currentPatten = currentPatten.substring(0, index1);
        }
        if (key == currentPatten) {
          if (pathSplitter.length == 1) {
            returnValue = value;
            return;
          }
          pathSplitter.remove(pathSplitter[0]);
          if (value == null) {
            returnValue = defaultValue;
            return;
          }
          try {
            try {
              value = value.toJson();
            } catch (error) {
              // handle error
            }
            try {
              if (value is List) {
                value = value[index];
              }
            } catch (error) {
              // handle error
            }
            returnValue = jsonGet(value, pathSplitter.join("."), defaultValue);
          } catch (error) {
            returnValue = defaultValue;
          }
          return;
        }
      });
      return returnValue != null ? returnValue : defaultValue;
    } on Exception catch (e) {
      print(e);
      // TODO
      return defaultValue;
    }
  }

  bool isNullOrBlank(dynamic val) {
    if (val is List) {
      if (val == null || val.isEmpty || val.length == 0)
        return true;
      else
        return false;
    } else {
      if (val == null || val == '' || val.toString().isEmpty || val.toString().isBlank!)
        return true;
      else
        return false;
    }
  }

  Future<bool> isConnected() async {
    var connectivityResult = await Connectivity().checkConnectivity(); //Check For Wifi or Mobile data is ON/OFF
    if (connectivityResult == ConnectivityResult.none) {
      return false;
    }
    return true;
  }

  getErrorKey(array, path, index, key) {
    if (array['$path.$index.$key'] != null) {
      return array['$path.$index.$key'][0] ?? '';
    }
    return '';
  }

  snackBar(message, {context, duration}) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: appCss.h5.copyWith(color: Colors.white),
      ),
      duration: Duration(
        milliseconds: duration == 'short' ? 1000 : (duration == 'long' ? 4000 : 2000),
      ),
    );

    ScaffoldMessenger.of(context ?? Get.context).clearSnackBars();
    ScaffoldMessenger.of(context ?? Get.context).showSnackBar(snackBar);
  }

  checkApiValidationError(data) {
    print(data);
    dynamic error = data['errors'];
    if (!isNullOrBlank(error)) {
      List keys = error.keys.toList();
      if (keys != null && keys.length > 0) {
        var msg = '';
        for (int i = 0; i < keys.length; i++) {
          String key = keys[i].toString();
          print('key : $key');
          if (i > 0) msg += '\n';
          msg += error[key][0].toString();
        }
        snackBar(msg, duration: 'long');
      } else
        snackBar(data['message'], duration: 'long');
    } else
      snackBar(data['message'], duration: 'long');
  }

  apiExceptionMethod(controllerName, e) {
    hideLoading();
    snackBar(helper.trans('something_wrong_error_msg'));
    print("Exception : on $controllerName");
    print(e.toString());
  }

  // add the widget and used getx defaultDialog box // by krushant //
  appUpdateDialog(String message, {VoidCallback? onConfirm, VoidCallback? onCancel, bool forceUpdate = false}) {
    print("forceUpdate, $forceUpdate");
    return Get.defaultDialog(
      title: 'App Update',
      middleText: "Welcome to Quality Control",
      titleStyle: appCss.h4.copyWith(fontSize: appScreenUtil.size(19), fontWeight: FontWeight.w500),
      // titleStyle: h3,
      barrierDismissible: false,
      middleTextStyle: appCss.bodyStyle1,
      contentPadding: EdgeInsets.only(top: appScreenUtil.size(30), bottom: appScreenUtil.size(0), left: appScreenUtil.size(5), right: appScreenUtil.size(5)),
      titlePadding: EdgeInsets.only(top: appScreenUtil.size(15)),
      onWillPop: forceUpdate == true ? () async => false : null,
      actions: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (!forceUpdate)
              ElevatedButton(
                onPressed: onCancel,
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                  elevation: MaterialStateProperty.resolveWith<double>(
                    // As you said you dont need elevation. I'm returning 0 in both case
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.disabled)) {
                        return 0;
                      }
                      return 0; // Defer to the widget's default.
                    },
                  ),
                ),
                child: Text(
                  'Abbrechen',
                  style: appCss.bodyStyle4.copyWith(color: Colors.red.withOpacity(0.7)),
                ),
              ),
            ElevatedButton(
              onPressed: onConfirm,
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                elevation: MaterialStateProperty.resolveWith<double>(
                  // As you said you dont need elevation. I'm returning 0 in both case
                  (Set<MaterialState> states) {
                    if (states.contains(MaterialState.disabled)) {
                      return 0;
                    }
                    return 0; // Defer to the widget's default.
                  },
                ),
              ),
              child: Text(
                'Aktualisieren',
                style: appCss.bodyStyle4.copyWith(color: appColor.primaryColor),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Future<bool> isNetworkConnection() async {
    var connectivityResult = await Connectivity().checkConnectivity(); //Check For Wifi or Mobile data is ON/OFF
    if (connectivityResult == ConnectivityResult.none) {
      return false;
    } else {
      final result = await InternetAddress.lookup('google.com'); //Check For Internet Connection
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty)
        return true;
      else
        return false;
    }
  }

  String trans(String val) {
    if (!isNullOrBlank(val)) {
      return val.tr;
    }
    return val;
  }

  goToNoInternetScreen() {
    String currentRoute = Get.currentRoute;
    if (currentRoute != routeName.noInternet) {
      Get.toNamed(routeName.noInternet);
    }
  }
}
