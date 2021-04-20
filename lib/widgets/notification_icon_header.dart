import 'package:quality_app/packages/config_package.dart';
import 'package:flutter/material.dart';

class NotificationHeaderIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(AppRouter.notification);
      },
      child: Image.asset(
        notificationIcon,
        width: screenWidth(20),
      ),
    );
  }
}
