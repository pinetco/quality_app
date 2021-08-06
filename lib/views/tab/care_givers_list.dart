import 'package:flutter/material.dart';
import 'package:quality_app/controllers/bottom_navigation_controller.dart';
import 'package:quality_app/controllers/care_giver_controller.dart';
import 'package:quality_app/packages/config_package.dart';
import 'package:quality_app/packages/input_package.dart';

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
        navigateReviewScreen(empId, name, email, phone, imageName);
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: screenWidth(8), horizontal: screenWidth(20)),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: screenWidth(5.0)),
          decoration: BoxDecoration(border: Border.all(width: 1, color: deactivateColor), borderRadius: BorderRadius.circular(screenWidth(10))),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(vertical: screenWidth(8), horizontal: screenWidth(10)),
                child: Container(width: screenWidth(60.0), height: screenWidth(60.0), decoration: new BoxDecoration(shape: BoxShape.circle, image: new DecorationImage(fit: BoxFit.cover, image: NetworkImage(imageName)))),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Text(
                      name,
                      style: bodyStyle5.copyWith(color: black22Color),
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
    Get.toNamed(AppRouter.careGiverProfile, arguments: {'id': empId, 'name': name, 'email': email, 'phone': phone, 'userImage': userImage});
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
                      padding: EdgeInsets.only(left: screenWidth(20), right: screenWidth(10)),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                'Care Givers',
                                style: h1,
                              ),
                              Spacer(),
                              NotificationHeaderIcon(),
                              SizedBox(
                                width: screenWidth(15),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: screenWidth(0), horizontal: screenWidth(20)),
                      child: Container(
                        decoration: BoxDecoration(border: Border.all(width: 1, color: deactivateColor), borderRadius: BorderRadius.circular(screenWidth(5))),
                        child: CustomTextFormField(
                          container: careGiverCtrl.searchCareGiver,
                          hintText: "What do you like to search care giver",
                          prefixIcon: Icon(MdiIcons.magnify),
                          style: bodyStyle5.copyWith(color: black22Color),
                          keyboardType: TextInputType.multiline,
                          padding: screenWidth(13),
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
                                      Text('No Care Givers Found.', style: bodyStyle5),
                                      TextButton(
                                          onPressed: () {
                                            careGiverCtrl.getCareGivers();
                                          },
                                          child: Text(
                                            'Refresh',
                                            style: bodyStyle5,
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
