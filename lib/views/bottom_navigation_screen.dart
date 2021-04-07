import 'package:quality_app/controllers/bottom_navigation_controller.dart';
import 'package:quality_app/packages/config_package.dart';
import 'package:quality_app/packages/screen_package.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:custom_navigation_bar/custom_navigation_bar.dart';

class BottomNavigation extends StatefulWidget {
  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  var bottomCtrl = Get.put(BottomNavigationController());

  List<Widget> _widgetOptions = <Widget>[Home(), Discount(), Profile()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0XFFF7F8FA),
        body: GetBuilder<BottomNavigationController>(builder: (controller) => _widgetOptions.elementAt(bottomCtrl.currentTab)),
        bottomNavigationBar: GetBuilder<BottomNavigationController>(
          builder: (controller) => CustomNavigationBar(
            borderRadius: Radius.circular(screenWidth(30)),
            items: [
              CustomNavigationBarItem(
                icon: Icon(MdiIcons.formatListBulleted),
              ),
              CustomNavigationBarItem(
                icon: Icon(MdiIcons.tagOutline),
              ),
              // CustomNavigationBarItem(
              //   icon: Stack(
              //     overflow: Overflow.visible,
              //     children: <Widget>[
              //       new Icon(MdiIcons.shoppingOutline),
              //       new Positioned(
              //         right: -5,
              //         top: -5,
              //         child: new Container(
              //           padding: EdgeInsets.all(1),
              //           decoration: new BoxDecoration(
              //             color: Colors.red,
              //             borderRadius: BorderRadius.circular(15),
              //           ),
              //           constraints: BoxConstraints(
              //             minWidth: screenWidth(15),
              //             minHeight: screenWidth(15),
              //           ),
              //           child: Center(
              //             child: Text(
              //               '10',
              //               style: bodyStyle7.copyWith(color: Colors.white),
              //             ),
              //           ),
              //         ),
              //       )
              //     ],
              //   ),
              // ),
              CustomNavigationBarItem(
                icon: Icon(MdiIcons.cogOutline),
              ),
            ],
            currentIndex: bottomCtrl.currentTab,
            selectedColor: primaryColor,
            unSelectedColor: Color(0XFFCCCCCC),
            strokeColor: primaryColor,
            onTap: (index) {
              bottomCtrl.updateCurrentTab(index);
            },
          ),
        ));
  }
}
