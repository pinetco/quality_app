import 'package:quality_app/controllers/rate_your_day_controller.dart';
import 'package:quality_app/controllers/home_client_controller.dart';
import 'package:quality_app/packages/input_package.dart';
import 'package:flutter/material.dart';
import 'package:quality_app/packages/config_package.dart';

class RateYourDay extends StatefulWidget {
  @override
  _RateYourDayState createState() => _RateYourDayState();
}

class _RateYourDayState extends State<RateYourDay> with TickerProviderStateMixin {
  var rateYourDayCtrl = Get.put(RateYourDayController());
  var storeCtrl = Get.find<HomeClientController>();

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
    if (count == 1) return bool ? badY : bad;
    if (count == 2) return bool ? sadY : sad;
    if (count == 3) return bool ? okY : ok;
    if (count == 4) return bool ? smileY : smile;
    if (count == 5) return bool ? happyY : happy;
  }

  manageReview(id, color, count) {
    dynamic rating = rateYourDayCtrl.ratingCount;
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
        backgroundColor: Colors.transparent,
        elevation: 0,
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
                Row(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Rate your Day',
                        style: h1,
                      ),
                    ),
                    SizedBox(width: 5),
                  ],
                ),
                SizedBox(height: screenWidth(15)),
                Container(
                  padding: EdgeInsets.symmetric(vertical: screenWidth(10)),
                  // decoration: BoxDecoration(border: Border(bottom: BorderSide(color: borderLineColor, width: 0.2))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Text('How was your day?', style: bodyStyle5.copyWith(color: black22Color)),
                      ),
                      SizedBox(height: screenHeight(10)),
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
                      }),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'What can we do for you to feel better?',
                    style: bodyStyle5.copyWith(color: black22Color),
                  ),
                ),
                SizedBox(height: screenHeight(10)),
                Container(
                  decoration: BoxDecoration(border: Border.all(width: 1, color: deactivateColor), borderRadius: BorderRadius.circular(screenWidth(5))),
                  child: CustomTextFormField(
                    maxLines: 3,
                    container: rateYourDayCtrl.txtComment,
                    hintText: "Write here...",
                    // prefixIcon: Icon(MdiIcons.commentOutline),
                    obscureText: false,
                    style: bodyStyle5.copyWith(color: black22Color),
                    keyboardType: TextInputType.multiline,
                    padding: screenWidth(20),
                  ),
                ),
                SizedBox(height: screenHeight(30)),
                GetBuilder<RateYourDayController>(
                    builder: (_) => InkWell(
                          onTap: () {
                            rateYourDayCtrl.anonymousFeedback();
                          },
                          child: Row(
                            children: [
                              Icon(
                                rateYourDayCtrl.anonymousUser ? MdiIcons.checkboxMarked : MdiIcons.checkboxBlankOutline,
                                color: rateYourDayCtrl.anonymousUser ? primaryColor : borderLineColor,
                              ),
                              Text('Send anonymous feedback', style: bodyStyle5),
                            ],
                          ),
                        )),
                SizedBox(height: screenWidth(30)),
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
