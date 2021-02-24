import 'package:flutter/material.dart';
import 'package:quality_app/packages/config_package.dart';

class Language extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Language"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(screenWidth(20)),
          child: Column(
            children: [
              Text("hello".tr, style: bodyStyle1),
              SizedBox(height: screenWidth(20)),
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      var locale = Locale('en', 'US');
                      Get.updateLocale(locale);
                    },
                    child: Card(
                      elevation: 5,
                      child: Padding(
                        padding: EdgeInsets.all(screenWidth(15)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("English", style: h2),
                          ],
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      var locale = Locale('de', 'DE');
                      Get.updateLocale(locale);
                    },
                    child: Card(
                      elevation: 5,
                      child: Padding(
                        padding: EdgeInsets.all(screenWidth(15)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("German", style: h2),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
