import 'package:flutter/material.dart';
import 'package:quality_app/controllers/bottom_navigation_controller.dart';
import 'package:quality_app/controllers/patients_controller.dart';
import 'package:quality_app/global/packages/config_package.dart';
import 'package:quality_app/global/widgets/notification_icon_header.dart';

class PatientsList extends StatefulWidget {
  @override
  _PatientsListState createState() => _PatientsListState();
}

class _PatientsListState extends State<PatientsList> with TickerProviderStateMixin {
  var bottomCtrl = Get.put(BottomNavigationController());
  var patientsCtrl = Get.put(PatientsController());

  Widget personDetailCard(item, index) {
    dynamic email = item['email'];
    dynamic imageName = item['profile_photo_url'];
    String name = item['name'].toString();
    String phone = item['phone'].toString();
    int id = item['id'];
    return InkWell(
      onTap: () {
        patientsCtrl.navigateOtherProfile(item);
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: appScreenUtil.size(8), horizontal: appScreenUtil.size(20)),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: appScreenUtil.size(5.0)),
          decoration: BoxDecoration(border: Border.all(width: 1, color: appColor.deactivateColor), borderRadius: BorderRadius.circular(appScreenUtil.size(10))),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(vertical: appScreenUtil.size(8), horizontal: appScreenUtil.size(10)),
                child: Container(
                    width: appScreenUtil.size(60.0),
                    height: appScreenUtil.size(60.0),
                    decoration: new BoxDecoration(shape: BoxShape.circle, image: new DecorationImage(fit: BoxFit.cover, image: NetworkImage(imageName)))),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Text(
                      name,
                      style: appCss.bodyStyle5.copyWith(color: appColor.black22Color),
                    ),
                    // Text(
                    //   phone,
                    //   style: bodyStyle6.copyWith(color: grayColor),
                    // ),
                  ],
                ),
              ),
              // Container(
              //   padding: EdgeInsets.only(right: appScreenUtil.size(10.0)),
              //   child: CustomButton(
              //     title: 'Profile',
              //     width: appScreenUtil.size(80),
              //     padding: appScreenUtil.size(5),
              //     radius: appScreenUtil.size(5),
              //     style: bodyStyle6.copyWith(color: Colors.white),
              //   ),
              // ),
              // Container(
              //     padding: EdgeInsets.only(right: appScreenUtil.size(10.0)),
              //     child: Icon(
              //       MdiIcons.chevronRight,
              //       size: appScreenUtil.size(30),
              //       color: grayColor,
              //     )),
            ],
          ),
        ),
      ),
    );
  }

  void navigateReviewScreen(empId, name, email, phone, userImage) {
    Get.toNamed(routeName.careGiverProfile, arguments: {'id': empId, 'name': name, 'email': email, 'phone': phone, 'userImage': userImage});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: LoadingComponent(
          child: Container(
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Padding(
                      padding: EdgeInsets.only(left: appScreenUtil.size(20), right: appScreenUtil.size(10)),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                'Patients',
                                style: appCss.h1,
                              ),
                              Spacer(),
                              NotificationHeaderIcon(),
                              SizedBox(
                                width: appScreenUtil.size(15),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    GetBuilder<PatientsController>(
                      builder: (_dx) => Expanded(
                        child: RefreshIndicator(
                          key: patientsCtrl.refreshKey,
                          onRefresh: patientsCtrl.refreshList,
                          child: _dx.patientsList.length > 0
                              ? ListView.builder(
                                  itemCount: _dx.patientsList.length,
                                  itemBuilder: (context, index) {
                                    return personDetailCard(_dx.patientsList[index], index);
                                  },
                                )
                              : Center(
                                  child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('No Patients Found.', style: appCss.bodyStyle5),
                                    TextButton(
                                        onPressed: () {
                                          patientsCtrl.getPatientsList();
                                        },
                                        child: Text(
                                          'Refresh',
                                          style: appCss.bodyStyle5,
                                        ))
                                  ],
                                )),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
