import 'package:quality_app/global/packages/config_package.dart';
import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final String title;
  final double padding;
  final double radius;
  final Function onTap;
  final TextStyle style;
  final Color color;
  final Color iconColor;
  final double iconSize;
  final IconData icon;
  final double width;
  final Border border;

  const CustomIconButton({
    Key key,
    @required this.title,
    this.padding = 15,
    this.radius = 10,
    this.onTap,
    this.style,
    this.color,
    this.icon,
    this.iconColor,
    this.iconSize = 25,
    this.width,
    this.border,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(appScreenUtil.borderRadius(radius)),
      child: Container(
        color: color ?? appColor.primaryColor,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            child: Container(
              padding: EdgeInsets.all(appScreenUtil.size(padding)),
              width: width != null ? appScreenUtil.size(width) : MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                border: border,
                borderRadius: BorderRadius.circular(appScreenUtil.borderRadius(radius)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (icon != null)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(icon, color: iconColor, size: appScreenUtil.size(iconSize)),
                        SizedBox(width: appScreenUtil.size(10)),
                      ],
                    ),
                  Text(
                    title,
                    style: style ?? appCss.h4.copyWith(color: appColor.whiteColor),
                    textAlign: TextAlign.center,
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
