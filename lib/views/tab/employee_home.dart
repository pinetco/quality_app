import 'package:flutter/material.dart';
import 'package:quality_app/controllers/bottom_navigation_controller.dart';
import 'package:quality_app/controllers/home_employee_controller.dart';
import 'package:quality_app/global/packages/config_package.dart';
import 'package:quality_app/global/widgets/common/custom_button.dart';
import 'package:quality_app/global/widgets/notification_icon_header.dart';

class EmployeeHome extends StatefulWidget {
  @override
  _EmployeeHomeState createState() => _EmployeeHomeState();
}

class _EmployeeHomeState extends State<EmployeeHome> with TickerProviderStateMixin {
  var bottomCtrl = Get.put(BottomNavigationController());
  var homeEmpCtrl = Get.put(HomeEmpController());

  Widget rateYourDay() {
    // if (bottomCtrl.appSettings != null && !bottomCtrl.appSettings['is_today_rated'])
    return Padding(
      padding: EdgeInsets.symmetric(vertical: appScreenUtil.size(20), horizontal: appScreenUtil.size(20)),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: appScreenUtil.size(5.0)),
        decoration: BoxDecoration(border: Border.all(width: 1, color: appColor.deactivateColor), borderRadius: BorderRadius.circular(appScreenUtil.size(5))),
        child: Padding(
          padding: EdgeInsets.all(0),
          child: Column(
            children: [
              if (bottomCtrl.appSettings != null && !bottomCtrl.appSettings['is_today_rated'])
                Padding(
                  padding: EdgeInsets.all(appScreenUtil.size(10)),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Text(
                              helper.trans('rate_your_day'),
                              style: appCss.bodyStyle5.copyWith(color: appColor.black22Color),
                            ),
                          ],
                        ),
                      ),
                      CustomButton(
                        title: helper.trans('rate'),
                        width: appScreenUtil.size(100),
                        padding: appScreenUtil.size(5),
                        radius: appScreenUtil.size(5),
                        style: appCss.bodyStyle6.copyWith(color: Colors.white),
                        onTap: () {
                          homeEmpCtrl.navigateRateYourDay();
                        },
                      ),
                    ],
                    // Column(),
                  ),
                ),
              if (bottomCtrl.appSettings != null && !bottomCtrl.appSettings['is_today_rated'])
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: appScreenUtil.size(20), vertical: appScreenUtil.size(5)),
                  child: Divider(thickness: 0.7, color: appColor.darkGreyColor),
                ),
              Padding(
                padding: EdgeInsets.all(0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      style: TextButton.styleFrom(padding: EdgeInsets.all(0)),
                      onPressed: () {
                        Get.toNamed(routeName.ratingList);
                      },
                      child: Text(
                        helper.trans('your_all_ratings'),
                        style: appCss.bodyStyle5.copyWith(color: appColor.primaryColor),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
    return Container();
  }

  Widget personDetailCard(item, index, status) {
    dynamic imageName = item['profile_photo_url'];
    String name = item['name'].toString();
    int id = item['id'];
    dynamic isRunning = helper.jsonGet(item, 'client_visit.is_running', false);
    dynamic clientVisitId = helper.jsonGet(item, 'client_visit.id', false);
    String date = helper.jsonGet(item, 'client_visit.date', '');
    return Padding(
      padding: EdgeInsets.symmetric(vertical: appScreenUtil.size(8), horizontal: appScreenUtil.size(20)),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: appScreenUtil.size(5.0)),
        decoration: BoxDecoration(border: Border.all(width: 1, color: appColor.deactivateColor), borderRadius: BorderRadius.circular(appScreenUtil.size(10))),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(vertical: appScreenUtil.size(8), horizontal: appScreenUtil.size(10)),
              child: InkWell(
                onTap: () {
                  homeEmpCtrl.navigateOtherProfile(item);
                },
                child: Container(width: appScreenUtil.size(60.0), height: appScreenUtil.size(60.0), decoration: new BoxDecoration(shape: BoxShape.circle, image: new DecorationImage(fit: BoxFit.cover, image: NetworkImage(imageName)))),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      homeEmpCtrl.navigateOtherProfile(item);
                    },
                    child: Text(
                      name,
                      style: appCss.bodyStyle5.copyWith(color: appColor.black22Color),
                    ),
                  ),
                  if (date != '')
                    Text(
                      date,
                      style: appCss.bodyStyle6.copyWith(color: appColor.grayColor),
                    ),
                ],
              ),
            ),
            if (status == 'pending' && !isRunning)
              Container(
                padding: EdgeInsets.only(right: appScreenUtil.size(10.0)),
                child: CustomButton(
                    title: helper.trans('check_in'),
                    enable: !homeEmpCtrl.checkInDisabled,
                    width: appScreenUtil.size(100),
                    padding: appScreenUtil.size(5),
                    radius: appScreenUtil.size(5),
                    style: appCss.bodyStyle6.copyWith(color: Colors.white),
                    onTap: () {
                      print('checK ');
                      homeEmpCtrl.checkIn(id);
                    }),
              ),
            if (status == 'pending' && isRunning)
              Container(
                padding: EdgeInsets.only(right: appScreenUtil.size(10.0)),
                child: CustomButton(
                    title: helper.trans('check_out'),
                    width: appScreenUtil.size(100),
                    padding: appScreenUtil.size(5),
                    radius: appScreenUtil.size(5),
                    style: appCss.bodyStyle6.copyWith(color: Colors.white),
                    onTap: () {
                      homeEmpCtrl.checkOut(clientVisitId);
                    }),
              ),
          ],
        ),
      ),
    );
  }

  void navigateReviewScreen(empId, name, email, phone, userImage) {
    Get.toNamed(routeName.reviewSubmission, arguments: {'id': empId, 'name': name, 'email': email, 'phone': phone, 'userImage': userImage});
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
                    Padding(
                      padding: EdgeInsets.only(left: appScreenUtil.size(20), right: appScreenUtil.size(20), top: appScreenUtil.size(10)),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              GetBuilder<HomeEmpController>(builder: (_dx) {
                                if (homeEmpCtrl.userInfo != null && homeEmpCtrl.userInfo['franchisee'] != null && homeEmpCtrl.userInfo['franchisee']['logo_url'] != null)
                                  return Image.network(
                                    homeEmpCtrl.userInfo['franchisee']['logo_url'],
                                    height: appScreenUtil.size(50),
                                  );
                                return Text(
                                  helper.trans('quality_control'),
                                  style: appCss.h1,
                                );
                              }),
                              Spacer(),
                              NotificationHeaderIcon(),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: SizedBox(
                        child: RefreshIndicator(
                          onRefresh: homeEmpCtrl.refreshList,
                          child: SingleChildScrollView(
                            physics: AlwaysScrollableScrollPhysics(),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GetBuilder<BottomNavigationController>(builder: (_dx) => rateYourDay()),
                                GetBuilder<HomeEmpController>(builder: (_dx) {
                                  if (_dx.pendingList.length > 0)
                                    return Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: appScreenUtil.size(25)),
                                        Padding(
                                          padding: EdgeInsets.symmetric(horizontal: appScreenUtil.size(20)),
                                          child: Text(
                                            helper.trans('care_patient'),
                                            style: appCss.h5,
                                          ),
                                        ),
                                        ListView.builder(
                                          shrinkWrap: true,
                                          physics: NeverScrollableScrollPhysics(),
                                          itemCount: _dx.pendingList.length,
                                          itemBuilder: (context, index) {
                                            return personDetailCard(_dx.pendingList[index], index, 'pending');
                                          },
                                        ),
                                      ],
                                    );
                                  return Container();
                                }),
                                GetBuilder<HomeEmpController>(builder: (_dx) {
                                  if (_dx.finishedList.length > 0)
                                    return Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: appScreenUtil.size(25)),
                                        Divider(
                                          height: appScreenUtil.size(5),
                                          color: appColor.dividerColor,
                                          thickness: 5,
                                        ),
                                        SizedBox(height: appScreenUtil.size(25)),
                                        GetBuilder<HomeEmpController>(builder: (_dx) {
                                          if (_dx.finishedList.length > 0)
                                            return Padding(
                                              padding: EdgeInsets.symmetric(horizontal: appScreenUtil.size(20)),
                                              child: Text(
                                                helper.trans('finished_visit'),
                                                style: appCss.h5,
                                              ),
                                            );
                                          return Container();
                                        }),
                                      ],
                                    );
                                  return Container();
                                }),
                                GetBuilder<HomeEmpController>(
                                  builder: (_dx) => ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: _dx.finishedList.length,
                                    itemBuilder: (context, index) {
                                      if (index == 0 || index == 1 || index == 2) return personDetailCard(_dx.finishedList[index], index, '');
                                      return Container();
                                    },
                                  ),
                                ),
                              ],
                            ),
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
