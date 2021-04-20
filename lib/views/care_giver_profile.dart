import 'package:quality_app/controllers/review_submission_controller.dart';
import 'package:quality_app/controllers/setting_controller.dart';
import 'package:quality_app/controllers/store_controller.dart';
import 'package:quality_app/packages/input_package.dart';
import 'package:flutter/material.dart';
import 'package:quality_app/packages/config_package.dart';

class CareGiverProfile extends StatefulWidget {
  @override
  _CareGiverProfileState createState() => _CareGiverProfileState();
}

class _CareGiverProfileState extends State<CareGiverProfile> with TickerProviderStateMixin {
  var reviewSubmissionCtrl = Get.put(ReviewSubmissionController());
  var storeCtrl = Get.find<StoreController>();
  var settingCtrl = Get.find<SettingController>();

  AnimationController _animationController;
  bool isPlaying = false;

  final emojiWidth = 40;

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

  // manageColor(id, color, count) {
  //   dynamic rating = reviewSubmissionCtrl.getReviewEmoji(id, count);
  //   if (rating >= count) {
  //     return color;
  //   }
  //   return color.withOpacity(0.4);
  // }

  mangeImage(count, bool) {
    if (count == 1) return bool ? badY : bad;
    if (count == 2) return bool ? sadY : sad;
    if (count == 3) return bool ? okY : ok;
    if (count == 4) return bool ? smileY : smile;
    if (count == 5) return bool ? happyY : happy;
  }

  manageReview(id, color, count) {
    dynamic rating = reviewSubmissionCtrl.getReviewEmoji(id, count);
    if (rating >= count) {
      return Image.asset(
        mangeImage(count, true),
        width: screenHeight(28),
      );
    }
    return Image.asset(
      mangeImage(count, false),
      width: screenHeight(28),
    );
  }

  Widget ratingWidget(icon, id, ratingCount, color) {
    return Padding(
      padding: EdgeInsets.only(right: screenWidth(13)),
      child: InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () {
          if (reviewSubmissionCtrl.existingReview == null) reviewSubmissionCtrl.selectedReview(ratingCount, 'Good', id);
        },
        child: manageReview(id, color, ratingCount),

        // Icon(
        //   icon,
        //   size: screenWidth(40),
        //   color: manageColor(id, color, ratingCount),
        // ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFFF7F8FA),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: InkWell(
            child: Icon(MdiIcons.arrowLeft, color: black22Color),
            onTap: () {
              Navigator.pop(context);
            }),
      ),
      body: SafeArea(
        child: LoadingComponent(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: screenWidth(20)),
            child: Column(
              children: [
                // Align(alignment: Alignment.topLeft, child: Text('Profile', style: h1)),
                Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          'Profile',
                          style: h1,
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: screenHeight(30)),
                GetBuilder<StoreController>(
                  builder: (_dx) => _dx.userInfo != null && _dx.userInfo['profile_photo_url'] != null
                      ? Container(
                          height: screenWidth(90),
                          width: screenWidth(90),
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(screenWidth(90)),
                          ),
                          child: Center(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(screenWidth(90)),
                              child: Image.network(
                                _dx.userInfo['profile_photo_url'],
                                width: screenWidth(90),
                                height: screenWidth(90),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ))
                      : Container(),
                ),
                SizedBox(
                  height: screenHeight(30),
                ),
                GetBuilder<StoreController>(
                    builder: (_dx) => _dx.userInfo != null
                        ? Container(
                            width: screenActualWidth(),
                            padding: EdgeInsets.symmetric(vertical: screenHeight(15), horizontal: screenWidth(15)),
                            decoration: BoxDecoration(border: Border.all(width: 1, color: deactivateColor), borderRadius: BorderRadius.circular(5)),
                            child: Row(
                              children: [
                                Image.asset(userIcon, width: screenWidth(20), color: primaryDarkColor),
                                SizedBox(width: screenWidth(10)),
                                Text(
                                  _dx.userInfo['name'].toString(),
                                  style: bodyStyle5.copyWith(color: black22Color),
                                )
                              ],
                            ),
                          )
                        : Container()),
                SizedBox(
                  height: screenHeight(10),
                ),
                GetBuilder<StoreController>(
                    builder: (_dx) => _dx.userInfo != null
                        ? InkWell(
                            onTap: () {
                              final email = _dx.userInfo['email'].toString();
                              settingCtrl.openURL(email, 'email');
                            },
                            child: Container(
                              width: screenActualWidth(),
                              padding: EdgeInsets.symmetric(vertical: screenHeight(15), horizontal: screenWidth(15)),
                              decoration: BoxDecoration(border: Border.all(width: 1, color: deactivateColor), borderRadius: BorderRadius.circular(5)),
                              child: Row(
                                children: [
                                  Image.asset(
                                    emailIcon,
                                    width: screenWidth(20),
                                  ),
                                  SizedBox(width: screenWidth(10)),
                                  Text(
                                    _dx.userInfo['email'].toString(),
                                    style: bodyStyle5.copyWith(color: black22Color),
                                  )
                                ],
                              ),
                            ),
                          )
                        : Container()),
                SizedBox(
                  height: screenHeight(10),
                ),
                GetBuilder<StoreController>(
                    builder: (_dx) => _dx.userInfo != null
                        ? InkWell(
                            onTap: () {
                              final phone = _dx.userInfo['phone'].toString();
                              settingCtrl.openURL(phone, 'phone');
                            },
                            child: Container(
                              width: screenActualWidth(),
                              padding: EdgeInsets.symmetric(vertical: screenHeight(15), horizontal: screenWidth(15)),
                              decoration: BoxDecoration(border: Border.all(width: 1, color: deactivateColor), borderRadius: BorderRadius.circular(5)),
                              child: Row(
                                children: [
                                  Image.asset(
                                    phoneIcon,
                                    width: screenWidth(20),
                                  ),
                                  SizedBox(width: screenWidth(10)),
                                  Text(
                                    _dx.userInfo['phone'].toString(),
                                    style: bodyStyle5.copyWith(color: black22Color),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : Container()),
              ],
            ),
          ),
        ),
      ),
    );

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        //title: Text("Review"),
        //automaticallyImplyLeading: false,
        leading: InkWell(
            child: Icon(MdiIcons.arrowLeft, color: black22Color),
            onTap: () {
              Navigator.pop(context);
            }),
      ),
      body: LoadingComponent(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: screenWidth(20)),
          child: SingleChildScrollView(
            padding: EdgeInsets.only(bottom: screenWidth(20)),
            child: Column(
              children: [
                SizedBox(height: screenWidth(15)),
                Container(
                  width: screenActualWidth(),
                  padding: EdgeInsets.only(bottom: screenWidth(20)),
                  child: Container(
                    decoration: BoxDecoration(
                      // border: Border.all(color: Colors.grey[300]),
                      border: Border.all(
                        width: 1,
                        color: deactivateColor,
                      ),

                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    padding: EdgeInsets.all(screenWidth(15)),
                    child: Column(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (reviewSubmissionCtrl.userImage != null)
                          ClipRRect(
                            borderRadius: BorderRadius.circular(screenWidth(80)),
                            child: Image.network(
                              reviewSubmissionCtrl.userImage,
                              height: screenWidth(80),
                              width: screenWidth(80),
                              fit: BoxFit.cover,
                            ),
                          ),
                        SizedBox(height: screenWidth(15)),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              reviewSubmissionCtrl.name.toString(),
                              style: bodyStyle4.copyWith(color: black22Color),
                            ),
                            SizedBox(height: screenWidth(5)),
                            InkWell(
                                onTap: () {
                                  final phone = reviewSubmissionCtrl.phone.toString();
                                  reviewSubmissionCtrl.openURL(phone, 'phone');
                                },
                                child: Text(reviewSubmissionCtrl.phone.toString(), style: bodyStyle5)),
                            SizedBox(height: screenWidth(5)),
                            InkWell(
                                onTap: () {
                                  final email = reviewSubmissionCtrl.email.toString();
                                  reviewSubmissionCtrl.openURL(email, 'email');
                                },
                                child: Text(reviewSubmissionCtrl.email.toString(), style: bodyStyle5)),
                            SizedBox(height: screenWidth(5)),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.start,
                            //   children: [
                            //     Image.asset(
                            //       veryGoodEmoji,
                            //       height: screenWidth(20),
                            //     ),
                            //     SizedBox(width: screenWidth(5)),
                            //     Text(
                            //       '(5)',
                            //       style: bodyStyle5.copyWith(color: darkGreyColor),
                            //     ),
                            //     SizedBox(width: screenWidth(5)),
                            //     Text(
                            //       '89 ratings',
                            //       style: bodyStyle5.copyWith(color: darkGreyColor),
                            //     ),
                            //   ],
                            // )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: screenHeight(20)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
