import 'package:quality_app/controllers/setting_controller.dart';
import 'package:flutter/material.dart';
import 'package:quality_app/packages/config_package.dart';
import 'package:quality_app/theme/theme_service.dart';
import 'package:lottie/lottie.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> with TickerProviderStateMixin {
  AnimationController _animationController;
  bool isPlaying = false;
  var settingCtrl = Get.put(SettingController());

  @override
  void initState() {
    // TODO: implement initState
    _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 450));
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFFF7F8FA),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text("Settings", style: header.copyWith(color: primaryColor)),
        centerTitle: false,
        automaticallyImplyLeading: false,
        actions: [
          Center(
            child: InkWell(
              highlightColor: Colors.white,
              splashColor: Colors.transparent,
              onTap: () {
                //bottomCtrl.updateCurrentTab(2);
              },
              child: Padding(
                padding: EdgeInsets.only(right: screenWidth(20.0)),
                child: Icon(
                  MdiIcons.logout,
                  size: screenWidth(26.0),
                  color: primaryColor,
                ),
              ),
            ),
          )
        ],
      ),
      body: LoadingComponent(
        child: Container(
          padding: EdgeInsets.all(screenWidth(20)),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    height: screenWidth(70),
                    width: screenWidth(70),
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(screenWidth(70)),
                    ),
                    child: Center(
                      child: Text(
                        'N',
                        style: h1.copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: screenWidth(10),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Nitin Gadhiya 1992',
                          style: h3.copyWith(color: primaryColor),
                        ),
                        Text('SUDTR . 26 42103 WUPPERTAL', style: bodyStyle5),
                        Text('info@tarmiona.de', style: bodyStyle5),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: screenWidth(30),
              ),
              Row(
                children: [
                  Icon(
                    MdiIcons.accountQuestion,
                    color: text444Color,
                  ),
                  SizedBox(width: screenWidth(20)),
                  Text(
                    'Any questions? Contact Us',
                    style: h2.copyWith(color: text444Color),
                  ),
                ],
              ),
              SizedBox(height: screenWidth(20)),
              Align(
                alignment: Alignment.topLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('quality_app DEUTSCHLAND GMBH', style: bodyStyle5),
                    SizedBox(height: screenWidth(10)),
                    Text('STERKENHOFWEG 5B,', style: bodyStyle5),
                    SizedBox(height: screenWidth(10)),
                    Text('47807 KREFLD,', style: bodyStyle5),
                    SizedBox(height: screenWidth(10)),
                    Text('TEL:- +49 2151565760,', style: bodyStyle5),
                    SizedBox(height: screenWidth(10)),
                    Text('Email:- info@quality_app.de,', style: bodyStyle5),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
