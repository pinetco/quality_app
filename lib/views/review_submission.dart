import 'package:quality_app/controllers/bottom_navigation_controller.dart';
import 'package:quality_app/controllers/review_submission_controller.dart';
import 'package:quality_app/controllers/store_controller.dart';
import 'package:quality_app/packages/input_package.dart';
import 'package:flutter/material.dart';
import 'package:quality_app/packages/config_package.dart';
import 'package:intl/intl.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

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

  final items = List<String>.generate(10000, (i) => "Item $i");

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        //backgroundColor: Colors.transparent,
        //elevation: 0,
        title: Text("Review"),
        // automaticallyImplyLeading: false,
      ),
      body: LoadingComponent(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: screenWidth(20)),
          child: SingleChildScrollView(
            padding: EdgeInsets.only(bottom: screenWidth(20)),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: screenWidth(20)),
                  child: Container(
                    decoration: BoxDecoration(
                      // border: Border.all(color: Colors.grey[300]),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          blurRadius: 8.0,
                          spreadRadius: 1,
                          offset: Offset(
                            0, // Move to right 10  horizontally
                            7, // Move to bottom 10 Vertically
                          ),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                    padding: EdgeInsets.all(screenWidth(15)),
                    child: Row(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(screenWidth(12)),
                          child: Image.asset(
                            user1,
                            height: screenWidth(80),
                            width: screenWidth(80),
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: screenWidth(15)),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              reviewSubmissionCtrl.name.toString(),
                              style: h2.copyWith(color: textPrimaryColor),
                            ),
                            SizedBox(height: screenWidth(5)),
                            Text(reviewSubmissionCtrl.phone.toString(), style: bodyStyle4.copyWith(color: darkGreyColor)),
                            SizedBox(height: screenWidth(5)),
                            Text(reviewSubmissionCtrl.email.toString(), style: bodyStyle4.copyWith(color: darkGreyColor)),
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
                InkWell(
                  onTap: () async {
                    DateTime date = await showDatePicker(
                      context: context,
                      firstDate: DateTime(DateTime.now().year - 1),
                      lastDate: DateTime.now(),
                      initialDate: DateTime.now(),
                    );
                    reviewSubmissionCtrl.updateDate(date);
                  },
                  child: CustomTextFormField(
                    enabled: false,
                    container: reviewSubmissionCtrl.txtDateTime,
                    hintText: "Select Date Time",
                    prefixIcon: Icon(MdiIcons.calendar),
                    obscureText: false,
                    style: h3.merge(ls1),
                    keyboardType: TextInputType.text,
                    padding: 20,
                    validator: (val) {
                      if (val.isEmpty)
                        return 'Please enter some value';
                      else
                        return null;
                    },
                  ),
                ),
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
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              dynamic item = storeCtrl.questionList[index];
                              String title = item['title'] ?? '';
                              int id = item['id'] ?? '';
                              return Container(
                                padding: EdgeInsets.symmetric(vertical: screenWidth(10)),
                                decoration: BoxDecoration(border: Border(bottom: BorderSide(color: borderLineColor, width: 0.2))),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      child: Text(title, style: bodyStyle3.copyWith(color: Colors.black54)),
                                    ),
                                    SizedBox(height: screenHeight(10)),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            reviewSubmissionCtrl.selectedReview(5, 'Very Good', id);
                                          },
                                          child: Column(
                                            children: [
                                              !reviewSubmissionCtrl.getReviewEmoji(id, 5)
                                                  ? Image.asset(veryGoodEmoji, width: screenWidth(emojiWidth), color: Colors.grey)
                                                  : Image.asset(veryActiveGoodEmoji, width: screenWidth(emojiWidth)),
                                              SizedBox(height: screenWidth(5)),
                                              // Container(
                                              //   color: primaryColor,
                                              //   height: 3,
                                              //   width: screenWidth(30),
                                              // ),
                                            ],
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            reviewSubmissionCtrl.selectedReview(4, 'Good', id);
                                          },
                                          child: Column(
                                            children: [
                                              !reviewSubmissionCtrl.getReviewEmoji(id, 4)
                                                  ? Image.asset(goodEmoji, width: screenWidth(emojiWidth), color: Colors.grey)
                                                  : Image.asset(goodActiveEmoji, width: screenWidth(emojiWidth)),
                                              SizedBox(height: screenWidth(5)),
                                              // Container(
                                              //   color: primaryColor,
                                              //   height: 3,
                                              //   width: screenWidth(30),
                                              // ),
                                            ],
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            reviewSubmissionCtrl.selectedReview(3, 'Ok', id);
                                          },
                                          child: Column(
                                            children: [
                                              !reviewSubmissionCtrl.getReviewEmoji(id, 3)
                                                  ? Image.asset(okEmoji, width: screenWidth(emojiWidth), color: Colors.grey)
                                                  : Image.asset(okActiveEmoji, width: screenWidth(emojiWidth)),

                                              SizedBox(height: screenWidth(5)),
                                              // Container(
                                              //   color: primaryColor,
                                              //   height: 3,
                                              //   width: screenWidth(30),
                                              // ),
                                            ],
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            reviewSubmissionCtrl.selectedReview(2, 'Sad', id);
                                          },
                                          child: Column(
                                            children: [
                                              !reviewSubmissionCtrl.getReviewEmoji(id, 2)
                                                  ? Image.asset(sadEmoji, width: screenWidth(emojiWidth), color: Colors.grey)
                                                  : Image.asset(sadActiveEmoji, width: screenWidth(emojiWidth)),
                                              SizedBox(height: screenWidth(5)),
                                              // Container(
                                              //   color: primaryColor,
                                              //   height: 3,
                                              //   width: screenWidth(30),
                                              // ),
                                            ],
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            reviewSubmissionCtrl.selectedReview(1, 'Bad', id);
                                          },
                                          child: Column(
                                            children: [
                                              !reviewSubmissionCtrl.getReviewEmoji(id, 1)
                                                  ? Image.asset(badEmoji, width: screenWidth(emojiWidth), color: Colors.grey)
                                                  : Image.asset(badActiveEmoji, width: screenWidth(emojiWidth)),
                                              SizedBox(height: screenWidth(5)),
                                            ],
                                          ),
                                        ),
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
                    'Comment',
                    style: bodyStyle3.copyWith(color: Colors.black54),
                  ),
                ),
                SizedBox(height: screenHeight(10)),
                CustomTextFormField(
                  maxLines: 3,
                  container: reviewSubmissionCtrl.txtComment,
                  hintText: "Write comment here...",
                  // prefixIcon: Icon(MdiIcons.commentOutline),
                  obscureText: false,
                  style: bodyStyle3.merge(ls1),
                  keyboardType: TextInputType.multiline,
                  padding: screenWidth(20),
                ),
                SizedBox(height: screenHeight(30)),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Wish',
                    style: h3.copyWith(color: Colors.black54),
                  ),
                ),
                SizedBox(height: screenHeight(10)),
                CustomTextFormField(
                  maxLines: 3,
                  container: reviewSubmissionCtrl.txtWish,
                  hintText: "Write wish here...",
                  // prefixIcon: Icon(MdiIcons.commentOutline),
                  obscureText: false,
                  style: bodyStyle3.merge(ls1),
                  keyboardType: TextInputType.multiline,
                  padding: screenWidth(20),
                ),
                SizedBox(height: screenWidth(30)),
                CustomButton(
                  title: 'Save',
                  onTap: () {
                    reviewSubmissionCtrl.saveReview();
                  },
                ),
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
