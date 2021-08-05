import 'package:get/get.dart';
import 'package:quality_app/global/route/route_list.dart';
// import 'package:quality_app/views/no_internet.dart';

//app file
import 'route_name.dart';

RouteName _routeName = RouteName();

class AppRoute {
  final List<GetPage> getPages = [
    GetPage(name: _routeName.login, page: () => Login()),
    GetPage(name: _routeName.forgotPassword, page: () => ForgotPassword()),
    GetPage(name: _routeName.home, page: () => Home()),
    GetPage(name: _routeName.careGiversList, page: () => CareGiversList()),
    GetPage(name: _routeName.careGiverProfile, page: () => CareGiverProfile()),
    GetPage(name: _routeName.contactInfo, page: () => ContactInfo()),
    GetPage(name: _routeName.wishMessage, page: () => WishMessage()),
    GetPage(name: _routeName.reviewSubmission, page: () => ReviewSubmission()),
    GetPage(name: _routeName.notification, page: () => Notification()),
    GetPage(name: _routeName.employeeHome, page: () => EmployeeHome()),
    GetPage(name: _routeName.surveyInfo, page: () => SurveyInfo()),
    GetPage(name: _routeName.surveyStep, page: () => SurveyStep()),
    // GetPage(name: _routeName.discount, page: () => Discount()),
    GetPage(name: _routeName.profile, page: () => Profile()),
    // GetPage(name: _routeName.stylingScreen, page: () => StylingScreen()),
    // GetPage(name: _routeName.pagingScreen, page: () => PagingScreen()),
    // GetPage(name: _routeName.controllerScreen, page: () => ControllerScreen()),
    // GetPage(name: _routeName.page1, page: () => Page1()),
    // GetPage(name: _routeName.getBuilderScreen, page: () => GetBuilderScreen(), binding: GetBuildBind()),
    // GetPage(name: _routeName.obxGtxScreen, page: () => ObxGtxScreen()),
    // GetPage(name: _routeName.language, page: () => Language()),
    GetPage(name: _routeName.bottomNavigationScreen, page: () => BottomNavigation()),
    GetPage(name: _routeName.patientsList, page: () => PatientsList()),
    GetPage(name: _routeName.loginTest, page: () => LoginTest()),
    GetPage(name: _routeName.rateYourDay, page: () => RateYourDay()),
  ];
}
