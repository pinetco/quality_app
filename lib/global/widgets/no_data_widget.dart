import 'package:flutter/material.dart';
import 'package:quality_app/global/theme/index.dart';
import 'package:quality_app/global/utility/index.dart';

class NoDataWidget extends StatelessWidget {
  final String title;
  final String body;

  const NoDataWidget({Key key, this.title, this.body}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(appScreenUtil.size(20)),
      child: Column(
        children: [
          Text(title, style: appCss.h2),
          SizedBox(height: appScreenUtil.size(5)),
          Text(
            body,
            style: appCss.bodyStyle3,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
