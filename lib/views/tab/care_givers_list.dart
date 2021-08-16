import 'package:quality_app/controllers/bottom_navigation_controller.dart';
import 'package:quality_app/controllers/care_giver_controller.dart';
import 'package:quality_app/global/packages/config_package.dart';
import 'package:quality_app/global/widgets/common/custom_textformfield.dart';
import 'package:quality_app/global/widgets/notification_icon_header.dart';
import 'package:flutter/material.dart';

class CareGiversList extends StatefulWidget {
  @override
  _CareGiversListState createState() => _CareGiversListState();
}

class _CareGiversListState extends State<CareGiversList> with TickerProviderStateMixin {
  var bottomCtrl = Get.put(BottomNavigationController());
  var careGiverCtrl = Get.put(CareGiverController());

  Widget personDetailCard(item, index, status) {
    dynamic email = item['email'];
    dynamic imageName = item['profile_photo_url'];
    String name = item['name'].toString();
    String phone = item['phone'].toString();
    int empId = item['id'];
    return InkWell(
      onTap: () {
        careGiverCtrl.navigateOtherProfile(item);
        // navigateReviewScreen(empId, name, email, phone, imageName);
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: appScreenUtil.size(8), horizontal: appScreenUtil.size(20)),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: appScreenUtil.size(5.0)),
          decoration: BoxDecoration(border: Border.all(width: 1, color: appColor.deactivateColor), borderRadius: BorderRadius.circular(appScreenUtil.size(10))),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(vertical: appScreenUtil.size(8), horizontal: appScreenUtil.size(10)),
                child: Container(
                    width: appScreenUtil.size(60.0),
                    height: appScreenUtil.size(60.0),
                    decoration: new BoxDecoration(shape: BoxShape.circle, image: new DecorationImage(fit: BoxFit.cover, image: NetworkImage(imageName)))),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Text(
                      name,
                      style: appCss.bodyStyle5.copyWith(color: appColor.black22Color),
                    ),
                    // Text(
                    //   phone,
                    //   style: bodyStyle6.copyWith(color: grayColor),
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void navigateReviewScreen(empId, name, email, phone, userImage) {
    Get.toNamed(routeName.careGiverProfile, arguments: {'id': empId, 'name': name, 'email': email, 'phone': phone, 'userImage': userImage});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: LoadingComponent(
          child: Container(
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Padding(
                      padding: EdgeInsets.only(left: appScreenUtil.size(20), right: appScreenUtil.size(10)),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                'Care Givers',
                                style: appCss.h1,
                              ),
                              Spacer(),
                              NotificationHeaderIcon(),
                              SizedBox(
                                width: appScreenUtil.size(15),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: appScreenUtil.size(20)),
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(width: 1, color: appColor.deactivateColor), borderRadius: BorderRadius.circular(appScreenUtil.size(5))),
                        child: CustomTextFormField(
                          container: careGiverCtrl.searchCareGiver,
                          hintText: "What do you like to search care giver",
                          prefixIcon: Icon(MdiIcons.magnify),
                          style: appCss.bodyStyle5.copyWith(color: appColor.black22Color),
                          keyboardType: TextInputType.multiline,
                          padding: appScreenUtil.size(13),
                          onChanged: (text) {
                            careGiverCtrl.onChangeText(text);
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Expanded(
                      child: SizedBox(
                        child: GetBuilder<CareGiverController>(
                          builder: (_dx) => RefreshIndicator(
                            key: careGiverCtrl.refreshKey,
                            onRefresh: careGiverCtrl.refreshList,
                            child: _dx.careGiverList.length > 0
                                ? ListView.builder(
                                    itemCount: _dx.careGiverList.length,
                                    itemBuilder: (context, index) {
                                      return personDetailCard(_dx.careGiverList[index], index, 'working');
                                    },
                                  )
                                : Center(
                                    child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('No Care Givers Found.', style: appCss.bodyStyle5),
                                      TextButton(
                                          onPressed: () {
                                            careGiverCtrl.getCareGivers('');
                                          },
                                          child: Text(
                                            'Refresh',
                                            style: appCss.bodyStyle5,
                                          ))
                                    ],
                                  )),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
