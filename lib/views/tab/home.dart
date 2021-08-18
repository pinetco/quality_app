import 'package:flutter/material.dart';
import 'package:quality_app/controllers/bottom_navigation_controller.dart';
import 'package:quality_app/controllers/home_client_controller.dart';
import 'package:quality_app/global/packages/config_package.dart';
import 'package:quality_app/global/widgets/common/custom_button.dart';
import 'package:quality_app/global/widgets/notification_icon_header.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  var bottomCtrl = Get.put(BottomNavigationController());
  var homeClientCtrl = Get.put(HomeClientController());

  AnimationController _animationController;
  bool isPlaying = false;

  @override
  void initState() {
    // TODO: implement initState
    _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 450));
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Widget personDetailCard(item, index, status) {
    dynamic employee = item['employee'];
    dynamic email = employee['email'];
    dynamic imageName = employee['profile_photo_url'];
    String name = employee['name'].toString();
    String phone = employee['phone'].toString();
    dynamic visitId = helper.jsonGet(item, 'id', '');
    String date = helper.jsonGet(item, 'date', '');
    int empId = employee['id'];
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
                  homeClientCtrl.navigateOtherProfile(item);
                  // homeClientCtrl.navigateReviewScreen(empId, name, email, phone, imageName);
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
                      homeClientCtrl.navigateReviewScreen(empId, name, email, phone, imageName);
                    },
                    child: Text(
                      name,
                      style: appCss.bodyStyle5.copyWith(color: appColor.black22Color),
                    ),
                  ),
                  Text(
                    date,
                    style: appCss.bodyStyle6.copyWith(color: appColor.grayColor),
                  ),
                ],
              ),
            ),
            if (status == '')
              Container(
                padding: EdgeInsets.only(right: appScreenUtil.size(10.0)),
                child: CustomButton(
                    title: 'Rate',
                    width: appScreenUtil.size(80),
                    padding: appScreenUtil.size(5),
                    radius: appScreenUtil.size(5),
                    style: appCss.bodyStyle6.copyWith(color: Colors.white),
                    onTap: () {
                      navigateReviewScreen(empId, name, email, phone, imageName, visitId, date);
                    }),
              ),
            if (status == 'working')
              Container(
                padding: EdgeInsets.only(right: appScreenUtil.size(10.0)),
                child: Text('Working', style: appCss.bodyStyle6.copyWith(color: Colors.green)),
              ),
          ],
        ),
      ),
    );
  }

  void navigateReviewScreen(empId, name, email, phone, userImage, visitId, date) {
    Get.toNamed(routeName.reviewSubmission, arguments: {'id': empId, 'name': name, 'email': email, 'phone': phone, 'userImage': userImage, 'visitId': visitId, "date": date});
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
                      padding: EdgeInsets.only(left: appScreenUtil.size(20), right: appScreenUtil.size(10), top: appScreenUtil.size(10)),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              GetBuilder<HomeClientController>(builder: (_dx) {
                                if (homeClientCtrl.userInfo != null && homeClientCtrl.userInfo['franchisee'] != null && homeClientCtrl.userInfo['franchisee']['logo_url'] != null)
                                  return Image.network(
                                    homeClientCtrl.userInfo['franchisee']['logo_url'],
                                    height: appScreenUtil.size(50),
                                  );
                                return Text(
                                  'Quality Control',
                                  style: appCss.h1,
                                );
                              }),
                              Spacer(),
                              NotificationHeaderIcon(),
                              SizedBox(
                                width: appScreenUtil.size(15),
                              ),
                              // InkWell(
                              //   onTap: () {
                              //     Get.toNamed(AppRouter.profile);
                              //   },
                              //   child: Image.asset(
                              //     userIcon,
                              //     width: appScreenUtil.size(20),
                              //   ),
                              // ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: SizedBox(
                        child: RefreshIndicator(
                          onRefresh: homeClientCtrl.refreshList,
                          child: SingleChildScrollView(
                            physics: AlwaysScrollableScrollPhysics(),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: appScreenUtil.size(20)),
                                  child: Column(
                                    children: [
                                      SizedBox(height: appScreenUtil.size(20)),
                                      Align(alignment: Alignment.topLeft, child: Text('Survey', style: appCss.h4)),
                                      SizedBox(height: appScreenUtil.size(4)),
                                      Text(
                                        'Thank you for being our loyal customer. As you know quality and customer satisfaction is our top priority. It would be awesome if you could fill out our quarterly survey.',
                                        style: appCss.bodyStyle6.copyWith(color: appColor.grayColor),
                                      ),
                                      SizedBox(height: appScreenUtil.size(15)),
                                    ],
                                  ),
                                ),
                                GetBuilder<HomeClientController>(builder: (_dx) {
                                  print(_dx.surveysList.length);
                                  return ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: _dx.surveysList.length,
                                    itemBuilder: (context, index) {
                                      final data = _dx.surveysList[index];
                                      return Padding(
                                        padding: EdgeInsets.symmetric(horizontal: appScreenUtil.size(20), vertical: appScreenUtil.size(5)),
                                        child: CustomButton(
                                          title: data['name'],
                                          suffixIcon: Image.asset(
                                            imageAssets.rightArrowIcon,
                                            width: appScreenUtil.size(20),
                                          ),
                                          onTap: () {
                                            Get.toNamed(routeName.surveyInfo, arguments: {'id': data['id']});
                                          },
                                        ),
                                      );
                                    },
                                  );
                                }),
                                GetBuilder<HomeClientController>(builder: (_dx) {
                                  if (_dx.workingList.length > 0)
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
                                        Padding(
                                          padding: EdgeInsets.symmetric(horizontal: appScreenUtil.size(20)),
                                          child: Text(
                                            'Working Care Giver',
                                            style: appCss.h5,
                                          ),
                                        ),
                                        ListView.builder(
                                          shrinkWrap: true,
                                          physics: NeverScrollableScrollPhysics(),
                                          itemCount: _dx.workingList.length,
                                          itemBuilder: (context, index) {
                                            return personDetailCard(_dx.workingList[index], index, 'working');
                                          },
                                        ),
                                      ],
                                    );
                                  return Container();
                                }),
                                GetBuilder<HomeClientController>(builder: (_dx) {
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
                                        Padding(
                                          padding: EdgeInsets.symmetric(horizontal: appScreenUtil.size(20)),
                                          child: Text(
                                            'Finished Visit',
                                            style: appCss.h5,
                                          ),
                                        ),
                                        ListView.builder(
                                          shrinkWrap: true,
                                          physics: NeverScrollableScrollPhysics(),
                                          itemCount: _dx.finishedList.length,
                                          itemBuilder: (context, index) {
                                            return personDetailCard(_dx.finishedList[index], index, '');
                                          },
                                        ),
                                      ],
                                    );
                                  return Container();
                                }),
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
