import 'package:flutter/material.dart';
import 'package:quality_app/packages/config_package.dart';

class Page1 extends StatefulWidget {
  @override
  _Page1State createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  String data;

  @override
  void initState() {
    // TODO: implement initState
    getArgumentData();
    super.initState();
  }

  getArgumentData() {
    var _data = Get.arguments;
    if (_data != null) {
      setState(() {
        data = _data.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Page 1"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(screenWidth(20)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Body", style: h1),
              RaisedButton(
                child: Text("Go to home"),
                onPressed: () {
                  Get.offAllNamed(AppRouter.home);
                },
              ),
              if (data != null)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: screenWidth(50)),
                    Text("Argument Data", style: h3),
                    Text("$data", style: bodyStyle4),
                    SizedBox(height: screenWidth(10)),
                    RaisedButton(
                      child: Text("Pass Data Back"),
                      onPressed: () {
                        var resultData = {"val": 1};
                        Get.back(result: resultData);
                      },
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
