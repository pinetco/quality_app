import 'package:quality_app/controllers/review_submission_controller.dart';
import 'package:quality_app/controllers/store_controller.dart';
import 'package:quality_app/packages/input_package.dart';
import 'package:flutter/material.dart';
import 'package:quality_app/packages/config_package.dart';

class ReviewSubmission extends StatefulWidget {
  @override
  _ReviewSubmissionState createState() => _ReviewSubmissionState();
}

class _ReviewSubmissionState extends State<ReviewSubmission> with TickerProviderStateMixin {
  var reviewSubmissionCtrl = Get.put(ReviewSubmissionController());
  var storeCtrl = Get.find<StoreController>();

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
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Rate your Caregiver',
                    style: h1,
                  ),
                ),
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
                      // boxShadow: [
                      //   BoxShadow(
                      //     color: Colors.grey.withOpacity(0.1),
                      //     blurRadius: 8.0,
                      //     spreadRadius: 1,
                      //     offset: Offset(
                      //       0, // Move to right 10  horizontally
                      //       7, // Move to bottom 10 Vertically
                      //     ),
                      //   ),
                      // ],
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
                            Text(reviewSubmissionCtrl.phone.toString(), style: bodyStyle5),
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
                GetBuilder<ReviewSubmissionController>(builder: (_) {
                  final dateList = reviewSubmissionCtrl.dateList;
                  return Column(
                    children: [
                      Align(
                          alignment: Alignment.topLeft,
                          child: Text(dateList.length > 0 ? 'Selecte Date' : 'Date', style: bodyStyle5.copyWith(color: black22Color))),
                      SizedBox(height: screenHeight(10)),
                      dateList.length == 0
                          ? Container(
                              width: screenActualWidth(),
                              padding: EdgeInsets.symmetric(vertical: screenHeight(15), horizontal: screenWidth(15)),
                              decoration: BoxDecoration(border: Border.all(width: 1, color: deactivateColor), borderRadius: BorderRadius.circular(5)),
                              child: Text(
                                reviewSubmissionCtrl.txtDateTime,
                                style: bodyStyle5.copyWith(color: black22Color),
                              ),
                            )
                          : Container(
                              width: screenActualWidth(),
                              height: screenHeight(50),
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: dateList.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    final item = dateList[index];
                                    final year = item['year'] ?? '';
                                    final month = item['month'] ?? '';
                                    final day = item['day'] ?? '';

                                    final date = year != null ? "$year-$month-$day" : null;
                                    return Padding(
                                      padding: EdgeInsets.only(right: screenWidth(10)),
                                      child: InkWell(
                                        onTap: () {
                                          reviewSubmissionCtrl.tapToSelectDate(date);
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(horizontal: screenWidth(15)),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(screenWidth(25)),
                                            color: reviewSubmissionCtrl.pickDate == date ? primaryDarkColor : Colors.grey[100],
                                          ),
                                          child: Center(
                                            child: Text(
                                              '$date',
                                              style: bodyStyle5.copyWith(color: reviewSubmissionCtrl.pickDate == date ? Colors.white : black22Color),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                            ),
                    ],
                  );
                }),

                /*  InkWell(
                  onTap: () async {
                    DateTime date = await showDatePicker(
                      context: context,
                      firstDate: DateTime.now().subtract(Duration(days: 365)),
                      lastDate: DateTime.now(),
                      initialDate: reviewSubmissionCtrl.selectedDate,
                    );

                    // DateTime date = await showDatePicker(
                    //   context: context,
                    //   firstDate: DateTime(DateTime.now().year - 1),
                    //   lastDate: DateTime.now(),
                    //   initialDate: DateTime.now(),
                    // );
                    print('datte: $date');
                    if (date != null) reviewSubmissionCtrl.updateDate(date);
                  },
                  child: CustomTextFormField(
                    enabled: false,
                    container: reviewSubmissionCtrl.txtDateTime,
                    hintText: "Select Date Time",
                    prefixIcon: Icon(MdiIcons.calendar),
                    obscureText: false,
                    style: bodyStyle3.merge(ls1),
                    keyboardType: TextInputType.text,
                    padding: 20,
                    validator: (val) {
                      if (val.isEmpty)
                        return 'Please enter some value';
                      else
                        return null;
                    },
                  ),
                ),*/
                SizedBox(height: screenHeight(20)),
                // Obx(() => Align(
                //     alignment: Alignment.topLeft,
                //     child: RichText(
                //       text: TextSpan(
                //         text: 'Give a rating :- ',
                //         style: h3.copyWith(color: Colors.black54),
                //         children: <TextSpan>[
                //           TextSpan(text: reviewSubmissionCtrl.isRatingText, style: TextStyle(color: primaryColor)),
                //         ],
                //       ),
                //     ))),
                // SizedBox(height: screenHeight(10)),
                if (storeCtrl.questionList.length > 0)
                  GetBuilder<ReviewSubmissionController>(
                      builder: (_) => ListView.builder(
                            itemCount: storeCtrl.questionList.length,
                            padding: EdgeInsets.all(0),
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              dynamic item = storeCtrl.questionList[index];
                              String title = item['title'] ?? '';

                              int id = item['id'] ?? '';
                              return Container(
                                padding: EdgeInsets.symmetric(vertical: screenWidth(10)),
                                // decoration: BoxDecoration(border: Border(bottom: BorderSide(color: borderLineColor, width: 0.2))),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      child: Text(title, style: bodyStyle5.copyWith(color: black22Color)),
                                    ),
                                    SizedBox(height: screenHeight(10)),
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
                          )),

                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Do you have any comments?',
                    style: bodyStyle5.copyWith(color: black22Color),
                  ),
                ),
                SizedBox(height: screenHeight(10)),
                Container(
                  decoration: BoxDecoration(border: Border.all(width: 1, color: deactivateColor), borderRadius: BorderRadius.circular(screenWidth(5))),
                  child: CustomTextFormField(
                    maxLines: 3,
                    container: reviewSubmissionCtrl.txtComment,
                    hintText: "Write comment here...",
                    // prefixIcon: Icon(MdiIcons.commentOutline),
                    obscureText: false,
                    style: bodyStyle5.copyWith(color: black22Color),
                    keyboardType: TextInputType.multiline,
                    padding: screenWidth(20),
                  ),
                ),
                SizedBox(height: screenHeight(30)),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Do you have any wishes?',
                    style: bodyStyle5.copyWith(color: black22Color),
                  ),
                ),
                SizedBox(height: screenHeight(10)),
                Container(
                  decoration: BoxDecoration(border: Border.all(width: 1, color: deactivateColor), borderRadius: BorderRadius.circular(screenWidth(5))),
                  child: CustomTextFormField(
                    maxLines: 3,
                    container: reviewSubmissionCtrl.txtWish,
                    hintText: "Write wish here...",
                    // prefixIcon: Icon(MdiIcons.commentOutline),
                    obscureText: false,
                    style: bodyStyle5.copyWith(color: black22Color),
                    keyboardType: TextInputType.multiline,
                    padding: screenWidth(20),
                  ),
                ),
                SizedBox(height: screenWidth(30)),
                GetBuilder<ReviewSubmissionController>(builder: (_) {
                  if (reviewSubmissionCtrl.existingReview == null || reviewSubmissionCtrl.questions.length == 0)
                    return CustomButton(
                      title: 'Submit',
                      onTap: () {
                        reviewSubmissionCtrl.saveReview(true);
                      },
                    );
                  return Container();
                }),
              ],
            ),
          ),
        ),
      ),
      // bottomNavigationBar: SafeArea(
      //   maintainBottomViewPadding: true,
      //   child: Padding(
      //     padding: EdgeInsets.symmetric(horizontal: screenWidth(20)),
      //     child: CustomButton(
      //       title: 'Save',
      //       onTap: () {
      //         reviewSubmissionCtrl.saveReview();
      //       },
      //     ),
      //   ),
      // ),
    );
  }
}
