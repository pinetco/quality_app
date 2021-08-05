import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quality_app/controllers/common/loading_controller.dart';
import 'package:quality_app/global/packages/config_package.dart';

class LoadingComponent extends StatelessWidget {
  final Widget child;
  LoadingComponent({key, this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    //GestureDetector is for unFocus text controller when click on screen
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Stack(
        children: [
          child,
          GetBuilder<LoadingController>(
            builder: (ctrl) {
              return ctrl.isLoading == true
                  ? Center(
                      child: Material(
                        elevation: 3,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(60)),
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(appColor.primaryColor),
                              strokeWidth: 3,
                            ),
                          ),
                        ),
                      ),
                    )
                  : Container();
            },
          ),
        ],
      ),
    );
  }
}
