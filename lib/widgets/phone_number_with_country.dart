import 'package:quality_app/packages/config_package.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class PhoneNumberWithCountry extends StatelessWidget {
  final TextEditingController txtMobile;

  final Function onInputChanged;
  final String isoCode;

  const PhoneNumberWithCountry({Key key, this.onInputChanged, this.txtMobile, this.isoCode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color(0xFFF5F6FA),
      ),
      child: InternationalPhoneNumberInput(
        onInputChanged: onInputChanged,
        //     (PhoneNumber number) {
        //   print(number.phoneNumber);
        // },
        onInputValidated: (bool value) {
          print(value);
        },
        selectorConfig: SelectorConfig(
          selectorType: PhoneInputSelectorType.DIALOG,
        ),
        inputBorder: OutlineInputBorder(borderSide: BorderSide.none),
        locale: 'en',
        ignoreBlank: true,
        autoValidateMode: AutovalidateMode.disabled,
        selectorTextStyle: TextStyle(color: Colors.black),
        initialValue: PhoneNumber(isoCode: isoCode ?? 'en'), //PhoneNumber(isoCode: Platform.localeName.split('_').last)
        textFieldController: txtMobile,
        formatInput: false,
        // keyboardType: TextInputType.numberWithOptions(signed: true, decimal: true),
        spaceBetweenSelectorAndTextField: 0.01,
        textStyle: bodyStyle5.copyWith(color: black22Color),
        // inputBorder: OutlineInputBorder(),
        onSaved: (PhoneNumber number) {
          print('On Saved: $number');
        },
      ),
    );
  }

  void getPhoneNumber(String phoneNumber) async {
    // PhoneNumber number = await PhoneNumber.getRegionInfoFromPhoneNumber(phoneNumber, 'DE');
    // print(number);
    //
    // String phoneNumber1 = '+234 500 500 5005';
    // PhoneNumber number1 = await PhoneNumber.getRegionInfoFromPhoneNumber(phoneNumber1);
    // print(number1);
    // String parsableNumber = number1.parseNumber();
    // print(parsableNumber);

    String originalPhoneNumber = '+499162255887';
    PhoneNumber numberRegionInfo = await PhoneNumber.getRegionInfoFromPhoneNumber(originalPhoneNumber);
    print(numberRegionInfo.isoCode); //Get country code
    print(numberRegionInfo.dialCode); //Get Country digital code
    print(txtMobile.text); // Text input value;
  }
}
