import 'package:flutter/material.dart';
import 'package:quality_app/controllers/notification_controller.dart';
import 'package:quality_app/global/packages/config_package.dart';
import 'package:quality_app/global/widgets/common/custom_button.dart';

class Notification extends StatelessWidget {
  var notificationsCtrl = Get.put(NotificationController());
  List notificationItem = [
    {
      "id": 34,
      "title": "has request",
      "body": "could you please bring me a cup of coffee??",
      "actor_name": "Joey Hoppe",
      "type": "clientRequest",
      "data": {
        "accepted_by": null,
        "accepted_by_name": null,
      },
      "redirect_to_id": "38",
      "redirect_to_type": "3",
      "created_at": "2021-08-18",
      "read_at": "2021-08-18"
    },
    {
      "id": 30,
      "title": "has request",
      "body": "could you please bring me a cup of coffee??",
      "actor_name": "Joey Hoppe",
      "type": "checkIn",
      "data": {
        "is_running": true,
      },
      "redirect_to_id": "38",
      "redirect_to_type": "3",
      "created_at": "2021-08-18",
      "read_at": "2021-08-18"
    },
    {
      "id": 31,
      "title": "has request",
      "body": "could you please bring me a cup of coffee??",
      "actor_name": "Joey Hoppe",
      "type": "checkOut",
      "data": {
        "is_rated": false,
      },
      "redirect_to_id": "38",
      "redirect_to_type": "3",
      "created_at": "2021-08-18",
      "read_at": "2021-08-18"
    },
    {
      "id": 31,
      "title": "has request",
      "body": "could you please bring me a cup of coffee??",
      "actor_name": "Joey Hoppe",
      "type": "checkOut",
      "data": {
        "is_rated": true,
      },
      "redirect_to_id": "38",
      "redirect_to_type": "3",
      "created_at": "2021-08-18",
      "read_at": "2021-08-18"
    },
    {
      "id": 34,
      "title": "has request",
      "body": "could you please bring me a cup of coffee??",
      "actor_name": "Joey Hoppe",
      "type": "clientRequest",
      "data": {
        "accepted_by": 1,
        "accepted_by_name": 'Nitin',
      },
      "redirect_to_id": "38",
      "redirect_to_type": "3",
      "created_at": "2021-08-18",
      "read_at": "2021-08-18"
    },
  ];
  // List notificationItem = [
  //   {
  //     'title': 'has started work just now',
  //     'name': 'Nitin Gadhiya',
  //     'duration': 'just now',
  //     'button': false,
  //     'rated': false,
  //     'status': 'Working',
  //   },
  //   {
  //     'title': 'has finished with work',
  //     'name': 'Pinal Patel',
  //     'duration': '2 mins ago',
  //     'button': true,
  //     'rated': false,
  //     'status': '',
  //   },
  //   {
  //     'title': 'has finished with work',
  //     'name': 'Vishal M.',
  //     'duration': '2 days ago',
  //     'button': true,
  //     'rated': false,
  //     'status': '',
  //   },
  //   {
  //     'title': 'has finished with work',
  //     'name': 'RaviRaj',
  //     'duration': '1 month ago',
  //     'button': true,
  //     'rated': true,
  //     'status': '',
  //   },
  //   {
  //     'title': 'has finished with work',
  //     'name': 'Pooja Pinetco',
  //     'duration': '8 months ago',
  //     'button': true,
  //     'rated': false,
  //     'status': '',
  //   },
  //   {
  //     "id": 34,
  //     "title": "has request",
  //     "body": "could you please bring me a cup of coffee??",
  //     "actor_name": "Joey Hoppe",
  //     "type": "clientRequest",
  //     "data": {"accepted_by": 38, "accepted_by_name": "Prof. Chadd Reynolds"},
  //     "redirect_to_id": "38",
  //     "redirect_to_type": "3",
  //     "created_at": "2021-08-18 05:28:28",
  //     "read_at": "2021-08-18 07:34:57"
  //   },
  //   {
  //     "id": 29,
  //     "title": "has request",
  //     "body": "could you please bring me a cup of coffee??",
  //     "actor_name": "Joey Hoppe",
  //     "type": "clientRequest",
  //     "data": {"accepted_by": null, "accepted_by_name": null},
  //     "redirect_to_id": "38",
  //     "redirect_to_type": "3",
  //     "created_at": "2021-08-18 05:25:48",
  //     "read_at": "2021-08-18 07:34:57"
  //   },
  // ];

  // dynamic notificationItem = {
  //   "data": [
  //     {
  //       "id": 34,
  //       "title": "has request",
  //       "body": "could you please bring me a cup of coffee??",
  //       "actor_name": "Joey Hoppe",
  //       "type": "clientRequest",
  //       "data": {
  //         "accepted_by": 38,
  //         "accepted_by_name": "Prof. Chadd Reynolds",
  //       },
  //       "redirect_to_id": "38",
  //       "redirect_to_type": "3",
  //       "created_at": "2021-08-18 05:28:28",
  //       "read_at": "2021-08-18 07:34:57"
  //     },
  //     {
  //       "id": 29,
  //       "title": "has request",
  //       "body": "could you please bring me a cup of coffee??",
  //       "actor_name": "Joey Hoppe",
  //       "type": "clientRequest",
  //       "data": {"accepted_by": null, "accepted_by_name": null},
  //       "redirect_to_id": "38",
  //       "redirect_to_type": "3",
  //       "created_at": "2021-08-18 05:25:48",
  //       "read_at": "2021-08-18 07:34:57"
  //     }
  //   ],
  //   "links": {
  //     "first": "http://quality-control-web.test/api/notifications?page=1",
  //     "last": "http://quality-control-web.test/api/notifications?page=1",
  //     "prev": null,
  //     "next": null,
  //   },
  //   "meta": {
  //     "current_page": 1,
  //     "from": 1,
  //     "last_page": 1,
  //     "links": [
  //       {
  //         "url": null,
  //         "label": "&laquo; Previous",
  //         "active": false,
  //       },
  //       {
  //         "url": "http://quality-control-web.test/api/notifications?page=1",
  //         "label": "1",
  //         "active": true,
  //       },
  //       {
  //         "url": null,
  //         "label": "Next &raquo;",
  //         "active": false,
  //       }
  //     ],
  //     "path": "http://quality-control-web.test/api/notifications",
  //     "per_page": 10,
  //     "to": 2,
  //     "total": 2
  //   }
  // };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFFF7F8FA),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        // automaticallyImplyLeading: false,
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
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: appScreenUtil.size(10)),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(appScreenUtil.size(5)),
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
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(item['created_at'], style: appCss.bodyStyle6.copyWith(color: appColor.grayColor)),
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
                                              //navigateReviewScreen(empId, name, email, phone, imageName);
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
                                        if (item['type'] == "clientRequest" && item['data']['accepted_by'] == null && item['data']['accepted_by_name'] == null)
                                          Row(
                                            children: [
                                              CustomButton(
                                                title: 'Accepted',
                                                color: Colors.white,
                                                border: Border.all(width: 1, color: appColor.primaryDarkColor),
                                                width: appScreenUtil.size(80),
                                                padding: appScreenUtil.size(5),
                                                radius: appScreenUtil.size(5),
                                                style: appCss.bodyStyle6.copyWith(color: appColor.primaryDarkColor),
                                              ),
                                              SizedBox(width: appScreenUtil.size(10)),
                                              CustomButton(
                                                title: 'Rejected',
                                                width: appScreenUtil.size(80),
                                                padding: appScreenUtil.size(5),
                                                radius: appScreenUtil.size(5),
                                                style: appCss.bodyStyle6.copyWith(color: Colors.white),
                                                onTap: () {
                                                  //navigateReviewScreen(empId, name, email, phone, imageName);
                                                },
                                              ),
                                            ],
                                          ),
                                        if (item['type'] == "clientRequest" && item['data']['accepted_by'] != null && item['data']['accepted_by_name'] != null)
                                          CustomButton(
                                            title: 'Request accepted',
                                            width: appScreenUtil.size(150),
                                            padding: appScreenUtil.size(5),
                                            radius: appScreenUtil.size(5),
                                            style: appCss.bodyStyle6.copyWith(color: Colors.white),
                                            onTap: () {
                                              //navigateReviewScreen(empId, name, email, phone, imageName);
                                            },
                                          ),
                                        // if (item['type'] == "checkOut" && item['data']['is_rated'] == true)
                                        //   CustomButton(
                                        //     title: 'Rejected',
                                        //     color: Colors.white,
                                        //     border: Border.all(width: 1, color: appColor.primaryDarkColor),
                                        //     width: appScreenUtil.size(80),
                                        //     padding: appScreenUtil.size(5),
                                        //     radius: appScreenUtil.size(5),
                                        //     style: appCss.bodyStyle6.copyWith(color: appColor.primaryDarkColor),
                                        //   ),
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
