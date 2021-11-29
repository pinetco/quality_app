import 'package:flutter/material.dart';
import 'package:quality_app/controllers/request_list_controller.dart';
import 'package:quality_app/global/packages/config_package.dart';

// ignore: must_be_immutable
class RequestList extends StatelessWidget {
  var requestCtrl = Get.put(RequestListController());

  Widget requestListCard(item, index) {
    int id = item['id'];
    dynamic description = helper.jsonGet(item, 'description', '');
    // String description = item['description'].toString();
    String date = item['date'];
    return Padding(
      padding: EdgeInsets.symmetric(vertical: appScreenUtil.size(8), horizontal: appScreenUtil.size(0)),
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: appScreenUtil.size(5.0),
        ),
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: appColor.deactivateColor),
          borderRadius: BorderRadius.circular(
            appScreenUtil.size(10),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              // if (description != '')
              SizedBox(height: 10),
              if (!helper.isNullOrBlank(description))
                Text(
                  description,
                  style: appCss.bodyStyle5.copyWith(color: appColor.black22Color),
                ),
              if (date != '')
                Text(
                  date,
                  style: appCss.bodyStyle6.copyWith(color: appColor.grayColor),
                ),
              SizedBox(height: 10),
              // if (date != '')
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RequestListController>(builder: (_) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: false,
          automaticallyImplyLeading: false,
          // title: Text('Notifications', style: appCss.h1.copyWith(color: appColor.blackColor)),
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
                    padding: EdgeInsets.only(left: appScreenUtil.size(20.0)),
                    child: Image.asset(
                      imageAssets.backIcon,
                      width: appScreenUtil.size(20),
                    )),
              ),
            ),
            Spacer(),
          ],
        ),
        body: SafeArea(
          child: LoadingComponent(
            child: Container(
              height: double.infinity,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: appScreenUtil.size(20)),
                child: Column(
                  children: [
                    SizedBox(height: 0),
                    Row(
                      children: [
                        Text(
                          'Request List',
                          style: appCss.h1,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: appScreenUtil.size(15),
                    ),
                    Expanded(
                      child: SizedBox(
                        child: SingleChildScrollView(
                          physics: AlwaysScrollableScrollPhysics(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GetBuilder<RequestListController>(
                                builder: (_) {
                                  return ListView.builder(
                                    shrinkWrap: true,
                                    // physics: NeverScrollableScrollPhysics(),
                                    itemCount: requestCtrl.requestList.length,
                                    itemBuilder: (context, index) {
                                      return requestListCard(requestCtrl.requestList[index], index);
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
