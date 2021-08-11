import 'package:flutter/material.dart';
import 'package:quality_app/controllers/notification_controller.dart';
import 'package:quality_app/global/packages/config_package.dart';
import 'package:quality_app/global/widgets/common/custom_button.dart';

class Notification extends StatelessWidget {
  var notificationsCtrl = Get.put(NotificationController());
  List notificationItem = [
    {
      'title': 'has started work just now',
      'name': 'Nitin Gadhiya',
      'duration': 'just now',
      'button': false,
      'rated': false,
      'status': 'Working',
    },
    {
      'title': 'has finished with work',
      'name': 'Pinal Patel',
      'duration': '2 mins ago',
      'button': true,
      'rated': false,
      'status': '',
    },
    {
      'title': 'has finished with work',
      'name': 'Vishal M.',
      'duration': '2 days ago',
      'button': true,
      'rated': false,
      'status': '',
    },
    {
      'title': 'has finished with work',
      'name': 'RaviRaj',
      'duration': '1 month ago',
      'button': true,
      'rated': true,
      'status': '',
    },
    {
      'title': 'has finished with work',
      'name': 'Pooja Pinetco',
      'duration': '8 months ago',
      'button': true,
      'rated': false,
      'status': '',
    }
  ];

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
                  child: ListView.builder(
                    itemCount: notificationItem.length,
                    itemBuilder: (context, index) {
                      final item = notificationItem[index];
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
                                      TextSpan(text: '${item['name']} ', style: appCss.h5.copyWith(color: appColor.black22Color)),
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
                                    Text(item['duration'], style: appCss.bodyStyle6.copyWith(color: appColor.grayColor)),
                                    if (item['status'] == 'Working')
                                      Container(
                                        padding: EdgeInsets.only(right: appScreenUtil.size(10.0)),
                                        child: Text(item['status'], style: appCss.bodyStyle6.copyWith(color: Colors.green)),
                                      ),
                                    if (item['button'] && !item['rated'])
                                      CustomButton(
                                          title: 'Rate',
                                          width: appScreenUtil.size(80),
                                          padding: appScreenUtil.size(5),
                                          radius: appScreenUtil.size(5),
                                          style: appCss.bodyStyle6.copyWith(color: Colors.white),
                                          onTap: () {
                                            //navigateReviewScreen(empId, name, email, phone, imageName);
                                          }),
                                    if (item['button'] && item['rated'])
                                      CustomButton(
                                        title: 'Rated',
                                        color: Colors.white,
                                        border: Border.all(width: 1, color: appColor.primaryDarkColor),
                                        width: appScreenUtil.size(80),
                                        padding: appScreenUtil.size(5),
                                        radius: appScreenUtil.size(5),
                                        style: appCss.bodyStyle6.copyWith(color: appColor.primaryDarkColor),
                                      ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
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
