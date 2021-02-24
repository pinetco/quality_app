import 'package:quality_app/packages/config_package.dart';
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
        color: isSelected ? primaryColor : whiteColor,
        borderRadius: BorderRadius.circular(borderRadius(10)),
        border: Border.all(width: 1, color: primaryColor),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Text("$text", style: isSelected ? h4.copyWith(color: whiteColor) : h4),
          ),
        ),
      ),
    );
  }
}
