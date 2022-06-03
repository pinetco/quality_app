import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:quality_app/global/packages/config_package.dart';

class PhoneNumberWithCountry extends StatelessWidget {
  final TextEditingController? txtMobile;

  final Function(PhoneNumber)? onInputChanged;
  final String? isoCode;

  const PhoneNumberWithCountry({Key? key, this.onInputChanged, this.txtMobile, this.isoCode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: appColor.deactivateColor),
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: appScreenUtil.size(10)),
        child: InternationalPhoneNumberInput(
          onInputChanged: onInputChanged,
          onInputValidated: (bool value) {
            print(value);
          },
          selectorConfig: SelectorConfig(
            selectorType: PhoneInputSelectorType.DIALOG,
          ),
          locale: 'en',
          ignoreBlank: true,
          autoValidateMode: AutovalidateMode.disabled,
          selectorTextStyle: TextStyle(color: Colors.black),
          initialValue: PhoneNumber(isoCode: isoCode ?? 'en'), //PhoneNumber(isoCode: Platform.localeName.split('_').last)
          textFieldController: txtMobile,
          formatInput: false,
          spaceBetweenSelectorAndTextField: 0.01,
          textStyle: appCss.bodyStyle5.copyWith(color: appColor.black22Color),
          onSaved: (PhoneNumber number) {
            print('On Saved: $number');
          },
          inputDecoration: InputDecoration(
            border: OutlineInputBorder(borderSide: BorderSide.none),
            hintText: helper.trans('phone_number'),
            hintStyle: appCss.bodyStyle5.copyWith(color: appColor.deactivateColor),
          ),
        ),
      ),
    );
  }

  void getPhoneNumber(String phoneNumber) async {
    String originalPhoneNumber = '+499162255887';
    PhoneNumber numberRegionInfo = await PhoneNumber.getRegionInfoFromPhoneNumber(originalPhoneNumber);
    print(numberRegionInfo.isoCode); //Get country code
    print(numberRegionInfo.dialCode); //Get Country digital code
    print(txtMobile!.text); // Text input value;
  }
}
