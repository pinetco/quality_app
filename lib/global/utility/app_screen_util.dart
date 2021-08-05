import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppScreenUtil {
  double fontSize(num size) {
    return ScreenUtil().setSp(size);
  }

  double borderRadius(num size) {
    return ScreenUtil().radius(size);
  }

  double screenActualWidth() {
    return ScreenUtil().screenWidth;
  }

  double screenActualHeight() {
    return ScreenUtil().screenHeight;
  }

  double size(size) {
    double width = ScreenUtil().screenWidth;
    double height = ScreenUtil().screenHeight;
    return width < height ? ScreenUtil().setWidth(size) : ScreenUtil().setHeight(size);
  }
}
