import 'package:flutter_screenutil/flutter_screenutil.dart';

double fontSize(num size) {
  return ScreenUtil().setSp(size, allowFontScalingSelf: false);
}

double screenWidth(num size) {
  return ScreenUtil().setWidth(size);
}

double screenHeight(num size) {
  return ScreenUtil().setHeight(size);
}

double borderRadius(num size) {
  return ScreenUtil().radius(size);
}

double screenActualWidth() {
  return ScreenUtil().appScreenUtil.size;
}

double screenActualHeight() {
  return ScreenUtil().screenHeight;
}
