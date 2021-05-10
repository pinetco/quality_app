import 'package:quality_app/controllers/bottom_navigation_controller.dart';
import 'package:quality_app/packages/input_package.dart';
import 'package:flutter/material.dart';
import 'package:quality_app/packages/config_package.dart';
import 'package:quality_app/controllers/home_employee_controller.dart';

class EmployeeHome extends StatefulWidget {
  @override
  _EmployeeHomeState createState() => _EmployeeHomeState();
}

class _EmployeeHomeState extends State<EmployeeHome> with TickerProviderStateMixin {
  var bottomCtrl = Get.put(BottomNavigationController());
  var homeEmpCtrl = Get.put(HomeEmpController());

  Widget rateYourDay() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: screenWidth(20), horizontal: screenWidth(20)),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: screenWidth(5.0)),
        decoration: BoxDecoration(border: Border.all(width: 1, color: deactivateColor), borderRadius: BorderRadius.circular(screenWidth(5))),
        child: Padding(
          padding: EdgeInsets.all(screenWidth(10)),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Text(
                      'Rate your day',
                      style: bodyStyle5.copyWith(color: black22Color),
                    ),
                  ],
                ),
              ),
              CustomButton(
                  title: 'Rate',
                  width: screenWidth(80),
                  padding: screenWidth(5),
                  radius: screenWidth(5),
                  style: bodyStyle6.copyWith(color: Colors.white),
                  onTap: () {
                    homeEmpCtrl.navigateRateYourDay();
                  }),
            ],
          ),
        ),
      ),
    );
  }

  Widget personDetailCard(item, index, status) {
    dynamic imageName = item['profile_photo_url'];
    String name = item['name'].toString();
    int id = item['id'];
    dynamic isRunning = helper.jsonGet(item, 'client_visit.is_running', false);
    dynamic clientVisitId = helper.jsonGet(item, 'client_visit.id', false);
    String date = helper.jsonGet(item, 'client_visit.date', '');

    return Padding(
      padding: EdgeInsets.symmetric(vertical: screenWidth(8), horizontal: screenWidth(20)),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: screenWidth(5.0)),
        decoration: BoxDecoration(border: Border.all(width: 1, color: deactivateColor), borderRadius: BorderRadius.circular(screenWidth(10))),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(vertical: screenWidth(8), horizontal: screenWidth(10)),
              child: Container(
                  width: screenWidth(60.0),
                  height: screenWidth(60.0),
                  decoration: new BoxDecoration(shape: BoxShape.circle, image: new DecorationImage(fit: BoxFit.cover, image: NetworkImage(imageName)))),
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
                  if (date != '')
                    Text(
                      date,
                      style: bodyStyle6.copyWith(color: grayColor),
                    ),
                ],
              ),
            ),
            if (status == 'pending' && !isRunning)
              Container(
                padding: EdgeInsets.only(right: screenWidth(10.0)),
                child: CustomButton(
                    title: 'Check in',
                    disabled: homeEmpCtrl.checkInDisabled,
                    width: screenWidth(80),
                    padding: screenWidth(5),
                    radius: screenWidth(5),
                    style: bodyStyle6.copyWith(color: Colors.white),
                    onTap: () {
                      homeEmpCtrl.checkIn(id);
                    }),
              ),
            if (status == 'pending' && isRunning)
              Container(
                padding: EdgeInsets.only(right: screenWidth(10.0)),
                child: CustomButton(
                    title: 'Check out',
                    width: screenWidth(80),
                    padding: screenWidth(5),
                    radius: screenWidth(5),
                    style: bodyStyle6.copyWith(color: Colors.white),
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
    Get.toNamed(AppRouter.reviewSubmission, arguments: {'id': empId, 'name': name, 'email': email, 'phone': phone, 'userImage': userImage});
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
                      padding: EdgeInsets.only(left: screenWidth(20), right: screenWidth(10), top: screenWidth(10)),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              GetBuilder<HomeEmpController>(builder: (_dx) {
                                if (homeEmpCtrl.userInfo != null &&
                                    homeEmpCtrl.userInfo['franchisee'] != null &&
                                    homeEmpCtrl.userInfo['franchisee']['logo_url'] != null)
                                  return Image.network(
                                    homeEmpCtrl.userInfo['franchisee']['logo_url'],
                                    height: screenHeight(50),
                                  );
                                return Text(
                                  'Quality Control',
                                  style: h1,
                                );
                              }),
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
                    Expanded(
                      child: SizedBox(
                        child: RefreshIndicator(
                          onRefresh: homeEmpCtrl.refreshList,
                          child: SingleChildScrollView(
                            physics: AlwaysScrollableScrollPhysics(),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                rateYourDay(),
                                GetBuilder<HomeEmpController>(builder: (_dx) {
                                  if (_dx.pendingList.length > 0)
                                    return Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: screenHeight(25)),
                                        Padding(
                                          padding: EdgeInsets.symmetric(horizontal: screenWidth(20)),
                                          child: Text(
                                            'Care Patient',
                                            style: h5,
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
                                        SizedBox(height: screenHeight(25)),
                                        Divider(
                                          height: screenHeight(5),
                                          color: dividerColor,
                                          thickness: 5,
                                        ),
                                        SizedBox(height: screenHeight(25)),
                                        GetBuilder<HomeEmpController>(builder: (_dx) {
                                          if (_dx.finishedList.length > 0)
                                            return Padding(
                                              padding: EdgeInsets.symmetric(horizontal: screenWidth(20)),
                                              child: Text(
                                                'Finished Visit',
                                                style: h5,
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
