import 'package:flutter/material.dart';
import 'package:quality_app/packages/config_package.dart';
import 'package:quality_app/packages/input_package.dart';

class Notification extends StatelessWidget {
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
                  padding: EdgeInsets.only(left: screenWidth(20.0)),
                  child: Image.asset(
                    backIcon,
                    width: screenWidth(20),
                  )),
            ),
          ),
          Spacer(),
        ],
      ),
      body: SafeArea(
        child: LoadingComponent(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: screenWidth(20)),
            child: Column(
              children: [
                Align(alignment: Alignment.topLeft, child: Text('Notifications', style: h1)),
                /*  Expanded(
                  child: Center(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: screenWidth(10)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            notificationBellIcon,
                            width: screenWidth(40),
                          ),
                          SizedBox(
                            height: screenHeight(10),
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
                        padding: EdgeInsets.symmetric(vertical: screenHeight(10)),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(screenWidth(5)),
                            border: Border.all(width: 1, color: deactivateColor),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(screenHeight(10)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RichText(
                                  text: TextSpan(
                                    children: <TextSpan>[
                                      TextSpan(text: '${item['name']} ', style: h5.copyWith(color: black22Color)),
                                      TextSpan(text: item['title'], style: bodyStyle5.copyWith(color: black22Color)),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: screenHeight(5),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(item['duration'], style: bodyStyle6.copyWith(color: grayColor)),
                                    if (item['status'] == 'Working')
                                      Container(
                                        padding: EdgeInsets.only(right: screenWidth(10.0)),
                                        child: Text(item['status'], style: bodyStyle6.copyWith(color: Colors.green)),
                                      ),
                                    if (item['button'] && !item['rated'])
                                      CustomButton(
                                          title: 'Rate',
                                          width: screenWidth(80),
                                          padding: screenWidth(5),
                                          radius: screenWidth(5),
                                          style: bodyStyle6.copyWith(color: Colors.white),
                                          onTap: () {
                                            //navigateReviewScreen(empId, name, email, phone, imageName);
                                          }),
                                    if (item['button'] && item['rated'])
                                      CustomButton(
                                        title: 'Rated',
                                        color: Colors.white,
                                        border: Border.all(width: 1, color: primaryDarkColor),
                                        width: screenWidth(80),
                                        padding: screenWidth(5),
                                        radius: screenWidth(5),
                                        style: bodyStyle6.copyWith(color: primaryDarkColor),
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
