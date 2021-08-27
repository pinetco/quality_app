import 'package:flutter/material.dart';
import 'package:quality_app/controllers/notification_badge_controller.dart';
import 'package:quality_app/global/packages/config_package.dart';
import 'package:quality_app/global/theme/image_.dart';

class NotificationHeaderIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(routeName.notification);
      },
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(0),
            child: Image.asset(
              notificationIcon,
              width: appScreenUtil.size(20),
            ),
          ),
          Positioned(
            right: appScreenUtil.size(2),
            top: appScreenUtil.size(-5),
            child: ClipOval(
              child: GetBuilder<NotificationBadgeController>(
                builder: (_) {
                  // if (_.badgeCount == 0) return Container();
                  return Container(
                    child: Center(
                      child: Text('${_.badgeCount}', style: appCss.bodyStyle5.copyWith(color: appColor.whiteColor, fontWeight: FontWeight.w600)),
                    ),
                    color: appColor.dangerColor,
                    constraints: BoxConstraints(
                      minWidth: appScreenUtil.size(15),
                      minHeight: appScreenUtil.size(15),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
