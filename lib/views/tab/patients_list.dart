import 'package:flutter/material.dart';
import 'package:quality_app/controllers/bottom_navigation_controller.dart';
import 'package:quality_app/controllers/home_employee_controller.dart';
import 'package:quality_app/controllers/patients_controller.dart';
import 'package:quality_app/global/packages/config_package.dart';
import 'package:quality_app/global/widgets/common/custom_button.dart';
import 'package:quality_app/global/widgets/common/custom_textformfield.dart';
import 'package:quality_app/global/widgets/notification_icon_header.dart';

class PatientsList extends StatefulWidget {
  @override
  _PatientsListState createState() => _PatientsListState();
}

class _PatientsListState extends State<PatientsList> with TickerProviderStateMixin {
  var bottomCtrl = Get.find<BottomNavigationController>();
  var patientsCtrl = Get.put(PatientsController());
  var homeEmpCtrl = Get.find<HomeEmpController>();

  Widget personDetailCard(item, index, status) {
    dynamic imageName = item['profile_photo_url'];
    String name = item['name'].toString();
    String date = helper.jsonGet(item, 'client_visit.date', '');

    return Padding(
      padding: EdgeInsets.symmetric(vertical: appScreenUtil.size(8), horizontal: appScreenUtil.size(20)),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: appScreenUtil.size(5.0)),
        decoration: BoxDecoration(border: Border.all(width: 1, color: appColor.deactivateColor), borderRadius: BorderRadius.circular(appScreenUtil.size(10))),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(vertical: appScreenUtil.size(8), horizontal: appScreenUtil.size(10)),
              child: InkWell(
                onTap: () {
                  homeEmpCtrl.navigateOtherProfile(item);
                },
                child: Container(width: appScreenUtil.size(60.0), height: appScreenUtil.size(60.0), decoration: new BoxDecoration(shape: BoxShape.circle, image: new DecorationImage(fit: BoxFit.cover, image: NetworkImage(imageName)))),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      homeEmpCtrl.navigateOtherProfile(item);
                    },
                    child: Text(
                      name,
                      style: appCss.bodyStyle5.copyWith(color: appColor.black22Color),
                    ),
                  ),
                  if (date != '')
                    Text(
                      date,
                      style: appCss.bodyStyle6.copyWith(color: appColor.grayColor),
                    ),
                ],
              ),
            ),
            checkActiveButton(item, index)
          ],
        ),
      ),
    );
  }

  Widget checkActiveButton(item, index) {
    int id = item['id'];
    dynamic isRunning = helper.jsonGet(item, 'client_visit.is_running', false);
    dynamic clientVisitId = helper.jsonGet(item, 'client_visit.id', null);

    if (clientVisitId != null && isRunning) {
      return Container(
        padding: EdgeInsets.only(right: appScreenUtil.size(10.0)),
        child: CustomButton(
            title: helper.trans('check_out'),
            width: appScreenUtil.size(100),
            padding: appScreenUtil.size(5),
            radius: appScreenUtil.size(5),
            style: appCss.bodyStyle6.copyWith(color: Colors.white),
            onTap: () async {
              await homeEmpCtrl.checkOut(clientVisitId);
              await Future.delayed(Duration(seconds: 3));
              patientsCtrl.getPatientsList(''); //TODO
            }),
      );
    } else if (clientVisitId != null && !isRunning) {
      return Container();
    } else if (clientVisitId == null) {
      return Container(
        padding: EdgeInsets.only(right: appScreenUtil.size(10.0)),
        child: CustomButton(
            title: helper.trans('check_in'),
            enable: !patientsCtrl.checkInDisabled,
            width: appScreenUtil.size(100),
            padding: appScreenUtil.size(5),
            radius: appScreenUtil.size(5),
            style: appCss.bodyStyle6.copyWith(color: Colors.white),
            onTap: () async {
              homeEmpCtrl.checkIn(id);
              await Future.delayed(Duration(seconds: 3));
              patientsCtrl.getPatientsList(''); //TODO
            }),
      );
    } else {
      return Container();
    }
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
                      padding: EdgeInsets.only(left: appScreenUtil.size(20), right: appScreenUtil.size(20)),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                helper.trans('patients'),
                                style: appCss.h1,
                              ),
                              Spacer(),
                              NotificationHeaderIcon(),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: appScreenUtil.size(20)),
                      child: Container(
                        decoration: BoxDecoration(border: Border.all(width: 1, color: appColor.deactivateColor), borderRadius: BorderRadius.circular(appScreenUtil.size(5))),
                        child: CustomTextFormField(
                          container: patientsCtrl.searchPatients,
                          hintText: helper.trans('what_search_patients'),
                          cursorColor: appColor.primaryColor,
                          prefixIcon: Icon(MdiIcons.magnify),
                          style: appCss.bodyStyle5.copyWith(color: appColor.black22Color),
                          keyboardType: TextInputType.multiline,
                          padding: appScreenUtil.size(13),
                          onChanged: (text) {
                            patientsCtrl.onChangeText(text);
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    GetBuilder<PatientsController>(
                      builder: (_dx) => Expanded(
                        child: RefreshIndicator(
                          key: patientsCtrl.refreshPatientsKey,
                          onRefresh: patientsCtrl.refreshList,
                          child: _dx.patientsList.length > 0
                              ? ListView.builder(
                                  itemCount: _dx.patientsList.length,
                                  itemBuilder: (context, index) {
                                    return personDetailCard(_dx.patientsList[index], index, 'pending');
                                  },
                                )
                              : Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(helper.trans('no_patients_found'), style: appCss.bodyStyle5),
                                      TextButton(
                                        onPressed: () {
                                          patientsCtrl.getPatientsList('');
                                        },
                                        child: Text(
                                          helper.trans('refresh'),
                                          style: appCss.bodyStyle5,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
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
