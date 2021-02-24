import 'package:flutter/material.dart';
import 'package:quality_app/controllers/obx_getx_controller.dart';
import 'package:quality_app/packages/config_package.dart';

class ObxGtxScreen extends StatelessWidget {
  var obxGetxController = Get.put(ObxGetxController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Obx & Getx"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(screenWidth(20)),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      GetX<ObxGetxController>(
                        builder: (controller) {
                          return Text("${obxGetxController.counterValue}", style: h1);
                        },
                      ),
                      Text("GetX Counter", style: bodyStyle1),
                    ],
                  ),
                  Column(
                    children: [
                      Obx(() {
                        return Text("${obxGetxController.counterValue}", style: h1);
                      }),
                      Text("Obx Counter", style: bodyStyle1),
                    ],
                  ),
                ],
              ),
              SizedBox(height: screenWidth(20)),
              RaisedButton(
                child: Text("Update Counter"),
                onPressed: () => obxGetxController.increment(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
