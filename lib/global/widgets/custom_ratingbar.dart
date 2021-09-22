import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:quality_app/global/packages/config_package.dart';

class CustomRatingBar extends StatelessWidget {
  final double initialRating;
  final bool allowHalfRating;
  final ValueChanged<double> onRatingUpdate;
  final double itemSize;
  final double horizontalSpace;

  const CustomRatingBar({Key key, this.initialRating = 0, this.allowHalfRating = false, this.onRatingUpdate, this.itemSize = 20, this.horizontalSpace = 4}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      initialRating: initialRating,
      minRating: 1,
      itemCount: 5,
      itemSize: appScreenUtil.size(itemSize),
      direction: Axis.horizontal,
      allowHalfRating: allowHalfRating,
      itemPadding: EdgeInsets.symmetric(horizontal: appScreenUtil.size(horizontalSpace)),
      itemBuilder: (context, _) => Icon(
        Icons.star,
        color: Colors.amber,
      ),
      onRatingUpdate: onRatingUpdate,
    );
  }
}
