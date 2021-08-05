import 'package:quality_app/global/packages/config_package.dart';
import 'package:flutter/material.dart';

class RowIconText extends StatelessWidget {
  final Widget icon;
  final double spacing;
  final String text;
  final TextStyle textStyle;
  final bool textFirst;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisAlignment mainAxisAlignment;

  const RowIconText({
    Key key,
    this.icon,
    this.spacing = 5,
    this.text,
    this.textStyle,
    this.textFirst = false,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return textFirst
        ? Row(
            crossAxisAlignment: crossAxisAlignment,
            mainAxisAlignment: mainAxisAlignment,
            children: [
              Expanded(
                child: Text(text, style: textStyle),
              ),
              SizedBox(width: appScreenUtil.size(spacing)),
              icon,
            ],
          )
        : Row(
            crossAxisAlignment: crossAxisAlignment,
            mainAxisAlignment: mainAxisAlignment,
            children: [
              icon,
              SizedBox(width: appScreenUtil.size(spacing)),
              Expanded(
                child: Text(text, style: textStyle),
              ),
            ],
          );
  }
}
