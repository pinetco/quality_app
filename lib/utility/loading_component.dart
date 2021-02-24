import 'package:quality_app/controllers/common/loader_controller.dart';
import 'package:flutter/material.dart';
import 'package:quality_app/packages/config_package.dart';

class LoadingComponent extends StatelessWidget {
  final Widget child;

  LoadingComponent({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Stack(
        children: [
          child,
          GetBuilder<LoaderController>(
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
                              valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
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
