import 'package:quality_app/global/packages/config_package.dart';
import 'package:flutter/material.dart';

class CustomChoosableListCard extends StatelessWidget {
  final bool isSelected;
  final String text;
  final Function onTap;

  const CustomChoosableListCard({Key key, this.isSelected, this.text, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isSelected ? appColor.primaryColor : appColor.whiteColor,
        borderRadius: BorderRadius.circular(appScreenUtil.borderRadius(10)),
        border: Border.all(width: 1, color: appColor.primaryColor),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Text("$text", style: isSelected ? appCss.h4.copyWith(color: appColor.whiteColor) : appCss.h4),
          ),
        ),
      ),
    );
  }
}
