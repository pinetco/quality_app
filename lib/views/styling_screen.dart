import 'package:flutter/material.dart';
import 'package:quality_app/packages/config_package.dart';

class StylingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Styling"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(screenWidth(20)),
          child: Column(
            children: [
              Text("Header", style: h1),
              Divider(),
              Text("H1", style: h1),
              Text("H2", style: h2),
              Text("H3", style: h3),
              Text("H4", style: h4),
              Text("H5", style: h5),
              Divider(),
              Text("Body", style: h1),
              Divider(),
              Text("Body Style 1", style: bodyStyle1),
              Text("Body Style 2", style: bodyStyle2),
              Text("Body Style 3", style: bodyStyle3),
              Text("Body Style 4", style: bodyStyle4),
              Text("Body Style5", style: bodyStyle5),
              Divider(),
              Text("Merge Style", style: h1.merge(ls5)),
              Divider(),
              Text("H1", style: h1.merge(ls5)),
              Text("Body Style 1", style: bodyStyle1.merge(ls5)),
              Divider(),
              Text("Copy With Style", style: h1.copyWith(color: Colors.red)),
              Divider(),
              Text("H1", style: h1.copyWith(color: Colors.green)),
              Text("Body Style 1", style: bodyStyle1.copyWith(color: Colors.blue)),
              Divider(),
              Text("Merge & Copy With Style", style: h1.merge(ls1).copyWith(color: Colors.red)),
              Divider(),
              Text("H1", style: h1.merge(ls5).copyWith(color: Colors.green)),
              Text("Body Style 1", style: bodyStyle1.merge(ls5).copyWith(color: Colors.blue)),
            ],
          ),
        ),
      ),
    );
  }
}
