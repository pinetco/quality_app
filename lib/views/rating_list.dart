import 'package:flutter/material.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:quality_app/controllers/rating_list_controller.dart';
import 'package:quality_app/global/packages/config_package.dart';
import 'package:quality_app/global/widgets/custom_ratingbar.dart';

class RatingList extends StatelessWidget {
  var ratingListCtrl = Get.put(RatingListController());

  Widget ratingListCard(item, index) {
    dynamic comment = helper.jsonGet(item, 'comment', '');
    String date = item['date'];
    int ratings = item['ratings'];
    return Padding(
      padding: EdgeInsets.symmetric(vertical: appScreenUtil.size(8), horizontal: appScreenUtil.size(0)),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: appScreenUtil.size(5)),
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: appColor.deactivateColor),
          borderRadius: BorderRadius.circular(
            appScreenUtil.size(10),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              // if (date != '')
              if (!helper.isNullOrBlank(comment)) SizedBox(height: 10),
              Text(
                comment,
                style: appCss.bodyStyle5.copyWith(color: appColor.black22Color),
              ),
              if (!helper.isNullOrBlank(comment)) SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomRatingBar(
                    initialRating: helper.toDouble(ratings),
                    itemSize: 20,
                    horizontalSpace: 0,
                    allowHalfRating: true,
                    ignoreGestures: true,
                    onRatingUpdate: (val) {},
                  ),
                  Text(
                    date,
                    style: appCss.bodyStyle6.copyWith(color: appColor.grayColor),
                  ),
                ],
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        automaticallyImplyLeading: false,
        actions: [
          Center(
            child: InkWell(
              highlightColor: Colors.white,
              splashColor: Colors.transparent,
              onTap: () {
                Get.back();
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
            height: double.infinity,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: appScreenUtil.size(20)),
              child: Column(
                children: [
                  SizedBox(height: 0),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          helper.trans('rating_list_view'),
                          style: appCss.h1,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: appScreenUtil.size(15),
                  ),
                  Expanded(
                    child: SizedBox(
                      child: SingleChildScrollView(
                        physics: AlwaysScrollableScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GetBuilder<RatingListController>(
                              builder: (_) {
                                return ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: ratingListCtrl.ratingList.length,
                                  itemBuilder: (context, index) {
                                    return ratingListCard(ratingListCtrl.ratingList[index], index);
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
