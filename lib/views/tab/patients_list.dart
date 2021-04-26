import 'package:quality_app/controllers/bottom_navigation_controller.dart';
import 'package:quality_app/controllers/care_giver_controller.dart';
import 'package:quality_app/controllers/patients_controller.dart';
import 'package:quality_app/packages/input_package.dart';
import 'package:flutter/material.dart';
import 'package:quality_app/packages/config_package.dart';
import 'package:quality_app/controllers/home_client_controller.dart';

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
        padding: EdgeInsets.symmetric(vertical: screenWidth(8), horizontal: screenWidth(20)),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: screenWidth(5.0)),
          decoration: BoxDecoration(border: Border.all(width: 1, color: deactivateColor), borderRadius: BorderRadius.circular(screenWidth(10))),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(vertical: screenWidth(8), horizontal: screenWidth(10)),
                child: Container(
                    width: screenWidth(60.0),
                    height: screenWidth(60.0),
                    decoration: new BoxDecoration(shape: BoxShape.circle, image: new DecorationImage(fit: BoxFit.cover, image: NetworkImage(imageName)))),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Text(
                      name,
                      style: bodyStyle5.copyWith(color: black22Color),
                    ),
                    // Text(
                    //   phone,
                    //   style: bodyStyle6.copyWith(color: grayColor),
                    // ),
                  ],
                ),
              ),
              // Container(
              //   padding: EdgeInsets.only(right: screenWidth(10.0)),
              //   child: CustomButton(
              //     title: 'Profile',
              //     width: screenWidth(80),
              //     padding: screenWidth(5),
              //     radius: screenWidth(5),
              //     style: bodyStyle6.copyWith(color: Colors.white),
              //   ),
              // ),
              // Container(
              //     padding: EdgeInsets.only(right: screenWidth(10.0)),
              //     child: Icon(
              //       MdiIcons.chevronRight,
              //       size: screenHeight(30),
              //       color: grayColor,
              //     )),
            ],
          ),
        ),
      ),
    );
  }

  void navigateReviewScreen(empId, name, email, phone, userImage) {
    Get.toNamed(AppRouter.careGiverProfile, arguments: {'id': empId, 'name': name, 'email': email, 'phone': phone, 'userImage': userImage});
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
                      padding: EdgeInsets.only(left: screenWidth(20), right: screenWidth(10)),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                'Patients',
                                style: h1,
                              ),
                              Spacer(),
                              NotificationHeaderIcon(),
                              SizedBox(
                                width: screenWidth(15),
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
                                    Text('No Patients Found.', style: bodyStyle5),
                                    TextButton(
                                        onPressed: () {
                                          patientsCtrl.getPatientsList();
                                        },
                                        child: Text(
                                          'Refresh',
                                          style: bodyStyle5,
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
