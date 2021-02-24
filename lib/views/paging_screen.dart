import 'package:flutter/material.dart';
import 'package:quality_app/packages/config_package.dart';
import 'package:quality_app/views/paging/page1.dart';

class PagingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Paging"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(screenWidth(20)),
          child: Column(
            children: [
              ListTile(
                title: Text("Get.to", style: h1),
                subtitle: Text("Navigation by class", style: bodyStyle5),
                onTap: () => Get.to(Page1()),
              ),
              ListTile(
                title: Text("Get.toNamed"),
                subtitle: Text("Navigation by class name"),
                onTap: () => Get.toNamed(AppRouter.page1),
              ),
              ListTile(
                title: Text("Get.off"),
                subtitle: Text("Navigation and remove current screen link"),
                onTap: () => Get.off(Page1()),
              ),
              ListTile(
                title: Text("Get.offAll"),
                subtitle: Text("Navigation and remove all screen link"),
                onTap: () => Get.offAll(Page1()),
              ),
              ListTile(
                title: Text("Get.offAllNamed"),
                subtitle: Text("Navigation by name and remove all screen link"),
                onTap: () => Get.offAllNamed(AppRouter.page1),
              ),
              ListTile(
                title: Text("pass & receive data"),
                subtitle: Text("Navigation with argument & result"),
                onTap: () async {
                  var data = {
                    'id': '1',
                    'name': 'page 1 data from previous screen',
                  };
                  var result = await Get.to(Page1(), arguments: data);
                  Get.snackbar("back result", result.toString(), snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.black);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
