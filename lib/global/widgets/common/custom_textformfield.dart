import 'package:flutter/material.dart';
import 'package:quality_app/global/packages/config_package.dart';
import 'package:quality_app/global/theme/index.dart';
import 'package:quality_app/global/utility/index.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController? container;
  final String? hint;
  final String? hintText;
  final String? labelText;
  final double radius;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextStyle? style;
  final bool obscureText;
  final FormFieldValidator<String>? validator;
  final TextInputType? keyboardType;
  final double padding;
  final double? width;
  final Color? fillColor;
  final Color? cursorColor;
  final bool enabled;
  final int maxLines;
  final ValueChanged? onChanged;

  const CustomTextFormField({
    Key? key,
    this.container,
    this.hint,
    this.hintText,
    this.labelText,
    this.radius = 10.0,
    this.prefixIcon,
    this.style,
    this.obscureText = false,
    this.validator,
    this.padding = 10,
    this.width,
    this.fillColor,
    this.cursorColor,
    this.keyboardType,
    this.enabled = true,
    this.maxLines = 1,
    this.suffixIcon,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: container,
      textAlignVertical: TextAlignVertical.top,
      decoration: InputDecoration(
        prefixIcon: prefixIcon != null
            ? Padding(
                padding: EdgeInsets.symmetric(horizontal: appScreenUtil.size(10)),
                child: prefixIcon,
              )
            : null,
        suffixIcon: suffixIcon != null
            ? Padding(
                padding: EdgeInsets.symmetric(horizontal: appScreenUtil.size(10)),
                child: suffixIcon,
              )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(appScreenUtil.borderRadius(radius)),
          borderSide: BorderSide(width: 0, style: BorderStyle.none),
        ),
        filled: true,
        fillColor: fillColor ?? Colors.white,
        contentPadding: EdgeInsets.all(appScreenUtil.size(padding)),
        hintText: hintText,
        hintStyle: appCss.bodyStyle5.copyWith(color: appColor.deactivateColor),
        labelText: labelText,
      ),
      style: style,
      cursorColor: cursorColor,
      obscureText: obscureText,
      validator: validator,
      enabled: enabled,
      keyboardType: keyboardType,
      maxLines: maxLines,
      onChanged: onChanged,
    );
  }
}
