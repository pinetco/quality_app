import 'package:quality_app/global/packages/config_package.dart';
import 'package:flutter/material.dart';
import 'package:quality_app/global/theme/image_.dart';

class NotificationHeaderIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(routeName.notification);
      },
      child: Image.asset(
        notificationIcon,
        width: appScreenUtil.size(20),
      ),
    );
  }
}
