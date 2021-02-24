import 'package:quality_app/packages/config_package.dart';
import 'package:flutter/material.dart';

class CustomCheckboxListTile extends StatelessWidget {
  final ValueChanged<bool> onChanged;
  final Widget title;
  final double height;
  final double contentPadding;
  final bool value;

  const CustomCheckboxListTile({Key key, this.onChanged, this.value, this.title, this.height = 25, this.contentPadding = 0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: screenWidth(height),
      child: ListTileTheme(
        contentPadding: EdgeInsets.all(screenWidth(contentPadding)),
        child: CheckboxListTile(
          value: value,
          onChanged: onChanged,
          title: title,
          controlAffinity: ListTileControlAffinity.leading,
          //contentPadding: EdgeInsets.all(0),
        ),
      ),
    );
  }
}
