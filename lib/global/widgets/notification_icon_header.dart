import 'package:flutter/material.dart';
import 'package:quality_app/controllers/notification_badge_controller.dart';
import 'package:quality_app/global/packages/config_package.dart';

class NotificationHeaderIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      onTap: () {
        Get.toNamed(routeName.notification);
      },
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Padding(
            padding: EdgeInsets.only(right: appScreenUtil.size(10)),
            child: Image.asset(
              imageAssets.notificationIcon,
              width: appScreenUtil.size(20),
            ),
          ),
          Positioned(
            right: appScreenUtil.size(4),
            top: appScreenUtil.size(-5),
            child: ClipOval(
              child: GetBuilder<NotificationBadgeController>(
                builder: (_) {
                  if (_.badgeCount == 0) return Container();
                  return Container(
                    child: Center(
                      child: Text('${_.badgeCount}', style: appCss.bodyStyle5.copyWith(color: appColor.whiteColor, fontWeight: FontWeight.w600, fontSize: 12)),
                    ),
                    color: appColor.dangerColor,
                    constraints: BoxConstraints(
                      minWidth: appScreenUtil.size(17),
                      minHeight: appScreenUtil.size(17),
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
