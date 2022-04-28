import 'dart:io';

import 'package:package_info_plus/package_info_plus.dart';
import 'package:quality_app/global/networking/server_config.dart';
import 'package:version/version.dart';

import '../packages/config_package.dart';

class AppUpdateService {
  init() {
    updateAlert();
  }

  updateAlert() async {
    print("::::::::::: updateAlert :::::::::::");
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version1 = packageInfo.version;

    await apis.call(apiMethods.appUpdate, null, apiType.get).then((res) async {
      if (res?.isSuccess == true) {
        dynamic resData = res?.data;
        String version2 = resData['data']['application_version_code'];
        String version3 = resData['data']['application_minimum_version_code'];
        bool forceUpdate = resData['data']['force_update'];
        String description = resData['data']['description'];
        print('version2, $version2');
        Version currentVersion = Version.parse(version1); //new Version(1, 0, 3);
        print('currentVersion, $currentVersion');
        Version latestVersion = Version.parse(version2);
        Version minimumVersion = Version.parse(version3);
        if (minimumVersion > currentVersion) {
          print("MINIMUMVERSION, $minimumVersion");
          helper.appUpdateDialog('$description', forceUpdate: true, onCancel: cancelAppUpdateDialog, onConfirm: confirmAppUpdate);
        } else if (latestVersion > currentVersion) {
          helper.appUpdateDialog('$description', forceUpdate: forceUpdate, onCancel: cancelAppUpdateDialog, onConfirm: confirmAppUpdate);
        }
      }
    });
  }

  cancelAppUpdateDialog() {
    Get.back();
  }

  confirmAppUpdate() async {
    if (Platform.isAndroid) {
      await launch(ServerConfig().playStoreUrl);
    } else {
      await launch(ServerConfig().appStoreUrl);
    }
  }
}
