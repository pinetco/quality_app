import 'package:quality_app/packages/config_package.dart';
import 'package:flash/flash.dart';
import 'package:flutter/material.dart';

errorDialog(String message, BuildContext context) {
  showFlash(
    context: context,
    duration: Duration(seconds: 3),
    builder: (context, controller) {
      return Flash(
        borderRadius: BorderRadius.circular(3.0),
        backgroundColor: Theme.of(context).errorColor,
        controller: controller,
        style: FlashStyle.floating,
        position: FlashPosition.top,
        horizontalDismissDirection: HorizontalDismissDirection.horizontal,
        child: FlashBar(
          icon: Icon(
            Icons.error,
            color: Colors.white,
          ),
          message: Text(
            message,
            style: _text16White,
          ),
        ),
      );
    },
  );
}

successDialog(String message, BuildContext context) {
  showFlash(
    context: context,
    duration: Duration(seconds: 3),
    builder: (context, controller) {
      return Flash(
        borderRadius: BorderRadius.circular(3.0),
        backgroundColor: Colors.green,
        controller: controller,
        style: FlashStyle.floating,
        position: FlashPosition.top,
        horizontalDismissDirection: HorizontalDismissDirection.horizontal,
        child: FlashBar(
          icon: Icon(
            Icons.check,
            color: Colors.white,
          ),
          title: Text("Success !", style: _text16SemiBoldWhite),
          message: Text(
            message,
            style: _text16White,
          ),
        ),
      );
    },
  );
}

alertDialog(String message, BuildContext context) {
  showFlash(
    context: context,
    duration: Duration(seconds: 3),
    builder: (context, controller) {
      return Flash(
        borderRadius: BorderRadius.circular(3.0),
        backgroundColor: Colors.yellow,
        controller: controller,
        style: FlashStyle.floating,
        position: FlashPosition.top,
        horizontalDismissDirection: HorizontalDismissDirection.horizontal,
        child: FlashBar(
          icon: Icon(
            Icons.warning,
            color: Colors.black,
          ),
          title: Text("Alert !", style: _text16SemiBold),
          message: Text(
            message,
            style: _text16,
          ),
        ),
      );
    },
  );
}

notificationDialog({String title, String message, BuildContext context}) {
  showFlash(
    context: context,
    duration: Duration(seconds: 5),
    builder: (context, controller) {
      return Flash(
        borderRadius: BorderRadius.circular(3.0),
        backgroundColor: Colors.black,
        controller: controller,
        style: FlashStyle.floating,
        position: FlashPosition.top,
        horizontalDismissDirection: HorizontalDismissDirection.horizontal,
        child: FlashBar(
          icon: Icon(
            Icons.notifications,
            color: Colors.white,
          ),
          title: Text(title, style: _text16SemiBoldWhite),
          message: Text(
            message,
            style: _text16White,
          ),
        ),
      );
    },
  );
}

void showBottomFlash({String title, String message, BuildContext context}) {
  showFlash(
    context: context,
    persistent: true,
    builder: (_, controller) {
      return Flash(
        controller: controller,
        margin: EdgeInsets.all(10),
        borderRadius: BorderRadius.circular(8.0),
        boxShadows: kElevationToShadow[8],
        backgroundGradient: RadialGradient(
          colors: [Colors.amber, Colors.black87],
          center: Alignment.topLeft,
          radius: 2,
        ),
        onTap: () => controller.dismiss(),
        forwardAnimationCurve: Curves.easeInCirc,
        reverseAnimationCurve: Curves.bounceIn,
        child: DefaultTextStyle(
          style: TextStyle(color: Colors.white),
          child: FlashBar(
            title: Text(title, style: _text16SemiBoldWhite),
            message: Text(message, style: _text16White),
            icon: Icon(Icons.notifications, color: Colors.white),
            actions: <Widget>[
              TextButton(
                onPressed: () => controller.dismiss(),
                child: Text(
                  'DISMISS',
                  style: _text14White,
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

//Style for local use

TextStyle _text16White = new TextStyle(
  fontWeight: FontWeight.w400,
  fontSize: fontSize(16),
  color: Colors.white,
);

TextStyle _text16 = new TextStyle(
  fontWeight: FontWeight.w400,
  fontSize: fontSize(16),
  color: Color(0xFF404040),
);

TextStyle _text14White = new TextStyle(
  fontWeight: FontWeight.w400,
  fontSize: fontSize(14),
  color: Colors.white,
);

TextStyle _text16SemiBoldWhite = new TextStyle(
  fontWeight: FontWeight.w600,
  fontSize: fontSize(16),
  color: Colors.white,
);

TextStyle _text16SemiBold = new TextStyle(
  fontWeight: FontWeight.w600,
  fontSize: fontSize(16),
  color: Color(0xFF404040),
);
