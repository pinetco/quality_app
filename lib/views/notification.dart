import 'package:flutter/material.dart';
import 'package:quality_app/controllers/home_client_controller.dart';
import 'package:quality_app/controllers/notification_controller.dart';
import 'package:quality_app/global/packages/config_package.dart';
import 'package:quality_app/global/widgets/common/custom_button.dart';
import 'package:timeago/timeago.dart' as timeago;

class Notification extends StatelessWidget {
  var notificationsCtrl = Get.put(NotificationController());
  var homeClientCtrl = Get.put(HomeClientController());

  void navigateReviewScreenPage(item) {
    dynamic employee = item['data']['employee'];
    int empId = employee['id'];
    String name = employee['name'];
    String phone = employee['phone'];
    dynamic userImage = employee['profile_photo_url'];
    String date = item['data']['date'];
    dynamic visitId = item['id'];
    Get.toNamed(routeName.reviewSubmission, arguments: {'id': empId, 'name': name, 'phone': phone, 'userImage': userImage, 'visitId': visitId, "date": date});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFFF7F8FA),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        automaticallyImplyLeading: false,
        // leading: Center(
        //   child: InkWell(
        //     highlightColor: Colors.white,
        //     splashColor: Colors.transparent,
        //     onTap: () {
        //       Get.back();
        //       //bottomCtrl.updateCurrentTab(2);
        //     },
        //     child: Padding(
        //         padding: EdgeInsets.only(left: appScreenUtil.size(20.0)),
        //         child: Image.asset(
        //           imageAssets.backIcon,
        //           width: appScreenUtil.size(20),
        //         )),
        //   ),
        // ),
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
            padding: EdgeInsets.symmetric(horizontal: appScreenUtil.size(20)),
            child: Column(
              children: [
                Align(alignment: Alignment.topLeft, child: Text('Notifications', style: appCss.h1)),
                /*  Expanded(
                  child: Center(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: appScreenUtil.size(size)(10)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            notificationBellIcon,
                            width: appScreenUtil.size(size)(40),
                          ),
                          SizedBox(
                            height: appScreenUtil.size(size)(10),
                          ),
                          Text(
                            'No notifications yet!',
                            style: bodyStyle5.copyWith(color: black22Color),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),*/
                Expanded(
                  child: GetBuilder<NotificationController>(
                    builder: (_) {
                      return ListView.builder(
                        itemCount: notificationsCtrl.notificationList.length,
                        itemBuilder: (context, index) {
                          final item = notificationsCtrl.notificationList[index];
                          final acceptedId = helper.getFromJson(item, 'data.id', null);
                          // final acceptedId = item['data']['id'];
                          final rejectedId = item['id'];
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: appScreenUtil.size(10)),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(appScreenUtil.size(10)),
                                border: Border.all(width: 1, color: appColor.deactivateColor),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(appScreenUtil.size(10)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        children: <TextSpan>[
                                          TextSpan(text: '${item['actor_name']} ', style: appCss.h5.copyWith(color: appColor.black22Color)),
                                          TextSpan(text: item['title'], style: appCss.bodyStyle5.copyWith(color: appColor.black22Color)),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: appScreenUtil.size(5),
                                    ),
                                    Text("${item['body']}", style: appCss.bodyStyle6.copyWith(color: appColor.black22Color)),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(timeago.format(DateTime.parse(item['created_at'])), style: appCss.bodyStyle8.copyWith(color: appColor.grayColor)),
                                        if (item['type'] == "checkIn" && item['data']['is_running'] == true)
                                          Container(
                                            padding: EdgeInsets.only(right: appScreenUtil.size(10.0)),
                                            child: Text("Working", style: appCss.bodyStyle6.copyWith(color: Colors.green)),
                                          ),
                                        if (item['type'] == "checkOut" && item['data']['is_rated'] == false)
                                          CustomButton(
                                            title: 'Rate',
                                            width: appScreenUtil.size(80),
                                            padding: appScreenUtil.size(5),
                                            radius: appScreenUtil.size(5),
                                            style: appCss.bodyStyle6.copyWith(color: Colors.white),
                                            onTap: () {
                                              navigateReviewScreenPage(item);
                                            },
                                          ),
                                        if (item['type'] == "checkOut" && item['data']['is_rated'] == true)
                                          CustomButton(
                                            title: 'Rated',
                                            color: Colors.white,
                                            border: Border.all(width: 1, color: appColor.primaryDarkColor),
                                            width: appScreenUtil.size(80),
                                            padding: appScreenUtil.size(5),
                                            radius: appScreenUtil.size(5),
                                            style: appCss.bodyStyle6.copyWith(color: appColor.primaryDarkColor),
                                          ),
                                        if (item['type'] == "clientRequest" && item['data']['accepted_by'] == null && item['data']['accepted_by_name'] == null && !helper.isNullOrBlank(acceptedId))
                                          Row(
                                            children: [
                                              CustomButton(
                                                  title: 'Accept',
                                                  color: Colors.white,
                                                  border: Border.all(width: 1, color: appColor.primaryDarkColor),
                                                  width: appScreenUtil.size(80),
                                                  padding: appScreenUtil.size(5),
                                                  radius: appScreenUtil.size(5),
                                                  style: appCss.bodyStyle6.copyWith(color: appColor.primaryDarkColor),
                                                  onTap: () {
                                                    print('Accepted data ');
                                                    notificationsCtrl.acceptedRequest(acceptedId);
                                                  }),
                                              SizedBox(width: appScreenUtil.size(10)),
                                              CustomButton(
                                                title: 'Reject',
                                                width: appScreenUtil.size(80),
                                                padding: appScreenUtil.size(5),
                                                radius: appScreenUtil.size(5),
                                                style: appCss.bodyStyle6.copyWith(color: Colors.white),
                                                onTap: () {
                                                  notificationsCtrl.rejectRequest(rejectedId);
                                                },
                                              ),
                                            ],
                                          ),
                                        if (item['type'] == "clientRequest" && item['data']['accepted_by'] != null && item['data']['accepted_by_name'] != null)
                                          Container(
                                            padding: EdgeInsets.only(right: appScreenUtil.size(10.0)),
                                            child: Text(
                                              "Accept by ${item['data']['accepted_by_name']}",
                                              style: appCss.bodyStyle6.copyWith(color: appColor.primaryColor),
                                            ),
                                          ),
                                        if (item['type'] == "acceptedRequest")
                                          Container(
                                            padding: EdgeInsets.only(right: appScreenUtil.size(10.0)),
                                            child: Text(
                                              "${item['title']}",
                                              style: appCss.bodyStyle6.copyWith(color: appColor.primaryDarkColor),
                                            ),
                                          ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                    // child: ListView.builder(
                    //   itemCount: notificationsCtrl.notificationList.length,
                    //   itemBuilder: (context, index) {
                    //     final item = notificationsCtrl.notificationList[index];
                    //     return Padding(
                    //       padding: EdgeInsets.symmetric(vertical: appScreenUtil.size(10)),
                    //       child: Container(
                    //         decoration: BoxDecoration(
                    //           borderRadius: BorderRadius.circular(appScreenUtil.size(5)),
                    //           border: Border.all(width: 1, color: appColor.deactivateColor),
                    //         ),
                    //         child: Padding(
                    //           padding: EdgeInsets.all(appScreenUtil.size(10)),
                    //           child: Column(
                    //             crossAxisAlignment: CrossAxisAlignment.start,
                    //             children: [
                    //               RichText(
                    //                 text: TextSpan(
                    //                   children: <TextSpan>[
                    //                     TextSpan(text: '${item['actor_name']} ', style: appCss.h5.copyWith(color: appColor.black22Color)),
                    //                     TextSpan(text: item['title'], style: appCss.bodyStyle5.copyWith(color: appColor.black22Color)),
                    //                   ],
                    //                 ),
                    //               ),
                    //               SizedBox(
                    //                 height: appScreenUtil.size(5),
                    //               ),
                    //               Row(
                    //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //                 children: [
                    //                   Text(item['created_at'], style: appCss.bodyStyle6.copyWith(color: appColor.grayColor)),
                    //                   if (item['type'] == "checkIn" && item['data']['is_running'] == true)
                    //                     Container(
                    //                       padding: EdgeInsets.only(right: appScreenUtil.size(10.0)),
                    //                       child: Text("Working", style: appCss.bodyStyle6.copyWith(color: Colors.green)),
                    //                     ),
                    //                   if (item['type'] == "checkOut" && item['data']['is_rated'] == false)
                    //                     CustomButton(
                    //                       title: 'Rate',
                    //                       width: appScreenUtil.size(80),
                    //                       padding: appScreenUtil.size(5),
                    //                       radius: appScreenUtil.size(5),
                    //                       style: appCss.bodyStyle6.copyWith(color: Colors.white),
                    //                       onTap: () {
                    //                         //navigateReviewScreen(empId, name, email, phone, imageName);
                    //                       },
                    //                     ),
                    //                   if (item['type'] == "checkOut" && item['data']['is_rated'] == true)
                    //                     CustomButton(
                    //                       title: 'Rated',
                    //                       color: Colors.white,
                    //                       border: Border.all(width: 1, color: appColor.primaryDarkColor),
                    //                       width: appScreenUtil.size(80),
                    //                       padding: appScreenUtil.size(5),
                    //                       radius: appScreenUtil.size(5),
                    //                       style: appCss.bodyStyle6.copyWith(color: appColor.primaryDarkColor),
                    //                     ),
                    //                   if (item['type'] == "clientRequest" && item['data']['accepted_by'] == null && item['data']['accepted_by_name'] == null)
                    //                     Row(
                    //                       children: [
                    //                         CustomButton(
                    //                           title: 'Accepted',
                    //                           color: Colors.white,
                    //                           border: Border.all(width: 1, color: appColor.primaryDarkColor),
                    //                           width: appScreenUtil.size(80),
                    //                           padding: appScreenUtil.size(5),
                    //                           radius: appScreenUtil.size(5),
                    //                           style: appCss.bodyStyle6.copyWith(color: appColor.primaryDarkColor),
                    //                         ),
                    //                         SizedBox(width: appScreenUtil.size(10)),
                    //                         CustomButton(
                    //                           title: 'Rejected',
                    //                           width: appScreenUtil.size(80),
                    //                           padding: appScreenUtil.size(5),
                    //                           radius: appScreenUtil.size(5),
                    //                           style: appCss.bodyStyle6.copyWith(color: Colors.white),
                    //                           onTap: () {
                    //                             //navigateReviewScreen(empId, name, email, phone, imageName);
                    //                           },
                    //                         ),
                    //                       ],
                    //                     ),
                    //                   if (item['type'] == "clientRequest" && item['data']['accepted_by'] != null && item['data']['accepted_by_name'] != null)
                    //                     CustomButton(
                    //                       title: 'Request accepted',
                    //                       width: appScreenUtil.size(150),
                    //                       padding: appScreenUtil.size(5),
                    //                       radius: appScreenUtil.size(5),
                    //                       style: appCss.bodyStyle6.copyWith(color: Colors.white),
                    //                       onTap: () {
                    //                         //navigateReviewScreen(empId, name, email, phone, imageName);
                    //                       },
                    //                     ),
                    //                   // if (item['type'] == "checkOut" && item['data']['is_rated'] == true)
                    //                   //   CustomButton(
                    //                   //     title: 'Rejected',
                    //                   //     color: Colors.white,
                    //                   //     border: Border.all(width: 1, color: appColor.primaryDarkColor),
                    //                   //     width: appScreenUtil.size(80),
                    //                   //     padding: appScreenUtil.size(5),
                    //                   //     radius: appScreenUtil.size(5),
                    //                   //     style: appCss.bodyStyle6.copyWith(color: appColor.primaryDarkColor),
                    //                   //   ),
                    //                 ],
                    //               )
                    //             ],
                    //           ),
                    //         ),
                    //       ),
                    //     );
                    //   },
                    // ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
