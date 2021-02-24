import 'package:quality_app/packages/config_package.dart';
import 'package:flutter/material.dart';

class CustomDropDown extends StatelessWidget {
  final dynamic dropdownValue;
  final ValueChanged<dynamic> onChangedValue;
  final List dropDownOptions;
  final String displayKey;
  final Widget prefixIcon;
  final String hint;
  final String hintText;
  final double padding;
  final double radius;

  const CustomDropDown(
      {Key key,
      @required this.dropdownValue,
      this.onChangedValue,
      this.dropDownOptions,
      this.prefixIcon,
      this.displayKey,
      this.hint,
      this.hintText,
      this.padding = 10,
      this.radius = 10})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<dynamic>(
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius(radius)),
          borderSide: BorderSide(width: 0, style: BorderStyle.none),
        ),
        contentPadding: EdgeInsets.all(screenWidth(padding)),
        filled: true,
        hintText: hintText,
        fillColor: Color(0xFFF5F6FA),
        prefixIcon: prefixIcon != null
            ? Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth(10)),
                child: prefixIcon,
              )
            : null,
      ),
      value: dropdownValue,
      isExpanded: true,
      icon: Icon(MdiIcons.menuDown),
      iconSize: 24,
      elevation: 16,
      style: TextStyle(color: Colors.black),
      /*underline: Container(
        height: 0,
        color: Colors.deepPurpleAccent,
      ),*/
      onChanged: onChangedValue,
      items: dropDownOptions.map<DropdownMenuItem<dynamic>>((dynamic val) {
        return DropdownMenuItem<dynamic>(
          value: val,
          child: Text(val[displayKey], style: bodyStyle4, overflow: TextOverflow.ellipsis),
        );
      }).toList(),
    );
  }
}
