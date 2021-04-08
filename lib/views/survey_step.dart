import 'package:flutter/material.dart';
import 'package:quality_app/packages/config_package.dart';
import 'package:quality_app/packages/input_package.dart';

enum SingingCharacter { lafayette, jefferson }

class SurveyStep extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SingingCharacter _character = SingingCharacter.lafayette;

    return Scaffold(
      backgroundColor: Color(0XFFF7F8FA),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        title: Text(
          'Survey',
          style: h1,
        ),
        automaticallyImplyLeading: false,
        actions: [
          Center(
            child: InkWell(
              highlightColor: Colors.white,
              splashColor: Colors.transparent,
              onTap: () {
                Get.back();
                //bottomCtrl.updateCurrentTab(2);
              },
              child: Padding(
                  padding: EdgeInsets.only(right: screenWidth(20.0)),
                  child: Image.asset(
                    closeIcon,
                    width: screenWidth(16),
                  )),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: LoadingComponent(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: screenWidth(20)),
            child: Column(
              children: [
                // Align(alignment: Alignment.topLeft, child: Text('Survey', style: h1)),
                Container(
                  decoration: BoxDecoration(border: Border.all(width: 1, color: deactivateColor), borderRadius: BorderRadius.circular(screenWidth(10))),
                  height: screenHeight(16),
                  width: screenActualWidth(),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(screenWidth(3)),
                        child: Container(
                          width: (screenActualWidth() - screenWidth(48)),
                          decoration: BoxDecoration(color: primaryDarkColor, borderRadius: BorderRadius.circular(screenWidth(10))),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: screenHeight(20),
                ),
                Column(
                  children: [
                    Container(
                        child: Text(
                      'The service I receive from FirstLight Home Care meets my expectations.',
                      style: h5.copyWith(fontWeight: FontWeight.w500),
                    )),
                    ListTile(
                      visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                      title: const Text('Lafayette'),
                      contentPadding: EdgeInsets.all(0),
                      leading: Radio<SingingCharacter>(
                        activeColor: primaryDarkColor,
                        value: SingingCharacter.lafayette,
                        groupValue: _character,
                        onChanged: (value) {},
                      ),
                    ),
                    ListTile(
                      title: const Text('Thomas Jefferson'),
                      contentPadding: EdgeInsets.all(0),
                      visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                      leading: Radio<SingingCharacter>(
                        value: SingingCharacter.jefferson,
                        groupValue: _character,
                        onChanged: (value) {},
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.all(screenWidth(10)),
                  child: CustomButton(
                    title: "Start",
                    onTap: () {},
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
