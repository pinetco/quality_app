import 'package:flutter/material.dart';
import 'package:quality_app/packages/config_package.dart';

class ControllerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Getx Controllers"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(screenWidth(20)),
          child: Column(
            children: [
              ListTile(
                title: Text("GetBuilder"),
                subtitle: Text("Manual State Management"),
                onTap: () => Get.toNamed(AppRouter.getBuilderScreen),
              ),
              ListTile(
                title: Text("Obx & Getx"),
                subtitle: Text("Auto State Management"),
                onTap: () => Get.toNamed(AppRouter.obxGtxScreen),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
