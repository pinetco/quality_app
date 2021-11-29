import 'package:flutter/material.dart';
import 'package:quality_app/controllers/rate_your_day_controller.dart';
import 'package:quality_app/global/packages/config_package.dart';
import 'package:quality_app/global/widgets/common/custom_button.dart';
import 'package:quality_app/global/widgets/common/custom_textformfield.dart';

class RateYourDay extends StatefulWidget {
  @override
  _RateYourDayState createState() => _RateYourDayState();
}

class _RateYourDayState extends State<RateYourDay> with TickerProviderStateMixin {
  var rateYourDayCtrl = Get.put(RateYourDayController());

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

  mangeImage(count, bool) {
    if (count == 1) return bool ? imageAssets.badY : imageAssets.bad;
    if (count == 2) return bool ? imageAssets.sadY : imageAssets.sad;
    if (count == 3) return bool ? imageAssets.okY : imageAssets.ok;
    if (count == 4) return bool ? imageAssets.smileY : imageAssets.smile;
    if (count == 5) return bool ? imageAssets.happyY : imageAssets.happy;
  }

  manageReview(id, color, count) {
    dynamic rating = rateYourDayCtrl.getReviewEmoji(id, count);
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
          rateYourDayCtrl.selectedReview(ratingCount, 'Good', id);
        },
        child: manageReview(id, color, ratingCount),
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
                        'Rate your Day',
                        style: appCss.h1,
                      ),
                    ),
                    // SizedBox(width: 5),
                  ],
                ),
                // SizedBox(height: appScreenUtil.size(15)),
                Container(
                  padding: EdgeInsets.symmetric(vertical: appScreenUtil.size(10)),
                  // decoration: BoxDecoration(border: Border(bottom: BorderSide(color: borderLineColor, width: 0.2))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GetBuilder<RateYourDayController>(builder: (_) {
                        if (rateYourDayCtrl.questionListRateYourDay.length == 0) return Container();
                        return ListView.builder(
                          itemCount: _.questionListRateYourDay.length,
                          padding: EdgeInsets.all(0),
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            dynamic item = _.questionListRateYourDay[index];
                            print('item, $item');
                            String title = item['title'] ?? '';

                            int id = item['id'] ?? '';
                            return Container(
                              padding: EdgeInsets.symmetric(vertical: appScreenUtil.size(10)),
                              // decoration: BoxDecoration(border: Border(bottom: BorderSide(color: borderLineColor, width: 0.2))),
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
                        );
                      }),
                      /*Container(
                        child: Text('How was your day?', style: appCss.bodyStyle5.copyWith(color: appColor.black22Color)),
                      ),
                      SizedBox(height: appScreenUtil.size(10)),
                      GetBuilder<RateYourDayController>(builder: (_) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ratingWidget(Icons.sentiment_very_dissatisfied, 1, 1, Colors.red),
                            ratingWidget(Icons.sentiment_dissatisfied, 1, 2, Colors.red[500]),
                            ratingWidget(Icons.sentiment_neutral, 1, 3, Color(0XFFFFD70D)),
                            ratingWidget(Icons.sentiment_satisfied, 1, 4, Colors.green[500]),
                            ratingWidget(Icons.sentiment_very_satisfied, 1, 5, Colors.green),
                          ],
                        );
                      }),*/
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'What can we do for you to feel better?',
                    style: appCss.bodyStyle5.copyWith(color: appColor.black22Color),
                  ),
                ),
                SizedBox(height: appScreenUtil.size(10)),
                Container(
                  decoration: BoxDecoration(border: Border.all(width: 1, color: appColor.deactivateColor), borderRadius: BorderRadius.circular(appScreenUtil.size(5))),
                  child: CustomTextFormField(
                    maxLines: 3,
                    container: rateYourDayCtrl.txtSuggestion,
                    cursorColor: appColor.primaryColor,
                    hintText: "Write here...",
                    // prefixIcon: Icon(MdiIcons.commentOutline),
                    obscureText: false,
                    style: appCss.bodyStyle5.copyWith(color: appColor.black22Color),
                    keyboardType: TextInputType.multiline,
                    padding: appScreenUtil.size(20),
                  ),
                ),
                SizedBox(height: appScreenUtil.size(30)),
                GetBuilder<RateYourDayController>(
                    builder: (_) => InkWell(
                          onTap: () {
                            rateYourDayCtrl.anonymousFeedback();
                          },
                          child: Row(
                            children: [
                              Icon(
                                rateYourDayCtrl.anonymousUser ? MdiIcons.checkboxMarked : MdiIcons.checkboxBlankOutline,
                                color: rateYourDayCtrl.anonymousUser ? appColor.primaryColor : appColor.borderLineColor,
                              ),
                              Text('Send anonymous feedback', style: appCss.bodyStyle5),
                            ],
                          ),
                        )),
                SizedBox(height: appScreenUtil.size(30)),
                GetBuilder<RateYourDayController>(builder: (_) {
                  return CustomButton(
                    title: 'Submit',
                    onTap: () {
                      rateYourDayCtrl.saveReview(true);
                    },
                  );
                  // return Container();
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
