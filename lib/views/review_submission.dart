import 'package:flutter/material.dart';
import 'package:quality_app/controllers/bottom_navigation_controller.dart';
import 'package:quality_app/controllers/home_client_controller.dart';
import 'package:quality_app/controllers/review_submission_controller.dart';
import 'package:quality_app/global/packages/config_package.dart';
import 'package:quality_app/global/widgets/common/custom_button.dart';
import 'package:quality_app/global/widgets/common/custom_textformfield.dart';

class ReviewSubmission extends StatefulWidget {
  @override
  _ReviewSubmissionState createState() => _ReviewSubmissionState();
}

class _ReviewSubmissionState extends State<ReviewSubmission> with TickerProviderStateMixin {
  var reviewSubmissionCtrl = Get.put(ReviewSubmissionController());
  var bottomCtrl = Get.find<BottomNavigationController>();
  var homeClientCtrl = Get.find<HomeClientController>();

  AnimationController? _animationController;
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
    _animationController!.dispose();
    super.dispose();
  }

  // Do Not Remove
  // manageColor(id, color, count) {
  //   dynamic rating = reviewSubmissionCtrl.getReviewEmoji(id, count);
  //   if (rating >= count) {
  //     return color;
  //   }
  //   return color.withOpacity(0.4);
  // }

  mangeImage(count, bool) {
    if (count == 1) return bool ? imageAssets.badY : imageAssets.bad;
    if (count == 2) return bool ? imageAssets.sadY : imageAssets.sad;
    if (count == 3) return bool ? imageAssets.okY : imageAssets.ok;
    if (count == 4) return bool ? imageAssets.smileY : imageAssets.smile;
    if (count == 5) return bool ? imageAssets.happyY : imageAssets.happy;
  }

  manageReview(id, color, count) {
    dynamic rating = reviewSubmissionCtrl.getReviewEmoji(id, count);
    if (rating >= count) {
      return Image.asset(
        mangeImage(count, true),
        width: appScreenUtil.size(28),
      );
    }
    return Image.asset(
      mangeImage(count, false),
      width: appScreenUtil.size(28),
    );
  }

  Widget ratingWidget(icon, id, ratingCount, color) {
    return Padding(
      padding: EdgeInsets.only(right: appScreenUtil.size(13)),
      child: InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () {
          reviewSubmissionCtrl.selectedReview(ratingCount, 'Good', id);
        },
        child: manageReview(id, color, ratingCount),

        // Do Not Remove
        // Icon(
        //   icon,
        //   size: appScreenUtil.size(size)(40),
        //   color: manageColor(id, color, ratingCount),
        // ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: InkWell(
            child: Icon(MdiIcons.arrowLeft, color: appColor.black22Color),
            onTap: () {
              Navigator.pop(context);
            }),
      ),
      body: LoadingComponent(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: appScreenUtil.size(20)),
          child: SingleChildScrollView(
            padding: EdgeInsets.only(bottom: appScreenUtil.size(20)),
            child: Column(
              children: [
                Row(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        helper.trans('rate_the_visit'),
                        style: appCss.h1,
                      ),
                    ),
                    SizedBox(width: 5),
                    if (reviewSubmissionCtrl.date != null)
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          '(${reviewSubmissionCtrl.date})',
                          style: appCss.bodyStyle6.copyWith(color: appColor.grayColor),
                        ),
                      ),
                  ],
                ),
                SizedBox(height: appScreenUtil.size(15)),
                Container(
                  width: appScreenUtil.screenActualWidth(),
                  padding: EdgeInsets.only(bottom: appScreenUtil.size(20)),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: appColor.deactivateColor,
                      ),
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    padding: EdgeInsets.all(appScreenUtil.size(15)),
                    child: Column(
                      children: [
                        if (reviewSubmissionCtrl.userImage != null)
                          ClipRRect(
                            borderRadius: BorderRadius.circular(appScreenUtil.size(80)),
                            child: Image.network(
                              reviewSubmissionCtrl.userImage!,
                              height: appScreenUtil.size(80),
                              width: appScreenUtil.size(80),
                              fit: BoxFit.cover,
                            ),
                          ),
                        SizedBox(height: appScreenUtil.size(15)),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              reviewSubmissionCtrl.name.toString(),
                              style: appCss.bodyStyle4.copyWith(color: appColor.black22Color),
                            ),
                            SizedBox(height: appScreenUtil.size(5)),
                            Text(reviewSubmissionCtrl.phone.toString(), style: appCss.bodyStyle5),
                            SizedBox(height: appScreenUtil.size(5)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                if (homeClientCtrl.questionList.length > 0)
                  GetBuilder<ReviewSubmissionController>(
                    builder: (_) => ListView.builder(
                      itemCount: homeClientCtrl.questionList.length,
                      padding: EdgeInsets.all(0),
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        dynamic item = homeClientCtrl.questionList[index];
                        String title = item['title'] ?? '';

                        int id = item['id'] ?? '';
                        return Container(
                          padding: EdgeInsets.symmetric(vertical: appScreenUtil.size(10)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: Text(title, style: appCss.bodyStyle5.copyWith(color: appColor.black22Color)),
                              ),
                              SizedBox(height: appScreenUtil.size(10)),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  ratingWidget(Icons.sentiment_very_dissatisfied, id, 1, Colors.red),
                                  ratingWidget(Icons.sentiment_dissatisfied, id, 2, Colors.red[500]),
                                  ratingWidget(Icons.sentiment_neutral, id, 3, Color(0XFFFFD70D)),
                                  ratingWidget(Icons.sentiment_satisfied, id, 4, Colors.green[500]),
                                  ratingWidget(Icons.sentiment_very_satisfied, id, 5, Colors.green),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    helper.trans('do_you_have_any_comments'),
                    style: appCss.bodyStyle5.copyWith(color: appColor.black22Color),
                  ),
                ),
                SizedBox(height: appScreenUtil.size(10)),
                Container(
                  decoration: BoxDecoration(border: Border.all(width: 1, color: appColor.deactivateColor), borderRadius: BorderRadius.circular(appScreenUtil.size(5))),
                  child: CustomTextFormField(
                    maxLines: 3,
                    container: reviewSubmissionCtrl.txtComment,
                    hintText: helper.trans('write_comment_here'),
                    cursorColor: appColor.primaryColor,
                    obscureText: false,
                    style: appCss.bodyStyle5.copyWith(color: appColor.black22Color),
                    keyboardType: TextInputType.multiline,
                    padding: appScreenUtil.size(20),
                  ),
                ),
                SizedBox(height: appScreenUtil.size(30)),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    helper.trans('do_you_have_any_wishes'),
                    style: appCss.bodyStyle5.copyWith(color: appColor.black22Color),
                  ),
                ),
                SizedBox(height: appScreenUtil.size(10)),
                Container(
                  decoration: BoxDecoration(border: Border.all(width: 1, color: appColor.deactivateColor), borderRadius: BorderRadius.circular(appScreenUtil.size(5))),
                  child: CustomTextFormField(
                    maxLines: 3,
                    container: reviewSubmissionCtrl.txtWish,
                    cursorColor: appColor.primaryColor,
                    hintText: helper.trans('write_wish_here'),
                    obscureText: false,
                    style: appCss.bodyStyle5.copyWith(color: appColor.black22Color),
                    keyboardType: TextInputType.multiline,
                    padding: appScreenUtil.size(20),
                  ),
                ),
                SizedBox(height: appScreenUtil.size(30)),
                GetBuilder<ReviewSubmissionController>(builder: (_) {
                  return CustomButton(
                    title: helper.trans('submit'),
                    onTap: () {
                      reviewSubmissionCtrl.saveReview(true);
                    },
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
