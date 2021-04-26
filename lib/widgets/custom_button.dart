import 'package:quality_app/packages/config_package.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
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
  final Widget suffixIcon;
  final bool disabled;

  const CustomButton(
      {Key key,
      @required this.title,
      this.disabled = false,
      this.padding = 15,
      this.radius = 10,
      this.onTap,
      this.style,
      this.color = primaryColor,
      this.icon,
      this.iconColor,
      this.iconSize = 25,
      this.width,
      this.suffixIcon,
      this.border})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(disabled);
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius(radius)),
      child: Container(
        color: disabled ? color.withOpacity(0.2) : color,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: disabled ? null : onTap,
            child: Container(
              padding: EdgeInsets.all(screenWidth(padding)),
              width: width != null ? screenWidth(width) : MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                border: border,
                borderRadius: BorderRadius.circular(borderRadius(radius)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (icon != null)
                    Row(
                      children: [
                        Icon(icon, color: iconColor, size: screenWidth(iconSize)),
                        SizedBox(width: screenWidth(10)),
                      ],
                    ),
                  Text(
                    title,
                    style: style ?? bodyStyle4.copyWith(color: whiteColor),
                    textAlign: TextAlign.center,
                  ),
                  if (suffixIcon != null)
                    Expanded(
                      child: Row(
                        children: [
                          Spacer(),
                          suffixIcon,
                        ],
                      ),
                    )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
