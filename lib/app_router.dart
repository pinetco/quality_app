import 'package:get/get.dart';
import 'package:quality_app/controllers/bindings/getbuilder_bind.dart';
import 'package:quality_app/packages/screen_package.dart'; //all views list

class AppRouter {
  static const login = '/login';
  static const forgotPassword = '/forgotPassword';

  static const home = '/home';
  static const discount = '/discount';
  static const profile = '/profile';

  static const stylingScreen = '/stylingScreen';
  static const pagingScreen = '/pagingScreen';
  static const controllerScreen = '/controllerScreen';
  static const page1 = '/page1';
  static const getBuilderScreen = '/getBuilderScreen';
  static const obxGtxScreen = '/obxGtxScreen';
  static const language = '/language';
  static const bottomNavigationScreen = '/bottomNavigationScreen';
  static const cart = '/cart';
  static const contractDetails = '/contractDetails';
  static const reviewSubmission = '/reviewSubmission';
  static const surveyInfo = '/surveyInfo';
  static const surveyStep = '/surveyStep';
  static const careGiversList = '/careGiversList';
  static const careGiverProfile = '/careGiverProfile';
  static const contactInfo = '/contactInfo';
  static const wishMessage = '/wishMessage';
  static const notification = '/notification';
  static const employeeHome = '/employeeHome';
  static const patientsList = '/patientsList';
  static const loginTest = '/loginTest';
  static const rateYourDay = '/rateYourDay';

  static List<GetPage> getPages = [
    GetPage(name: login, page: () => Login()),
    GetPage(name: forgotPassword, page: () => ForgotPassword()),
    GetPage(name: home, page: () => Home()),
    GetPage(name: careGiversList, page: () => CareGiversList()),
    GetPage(name: careGiverProfile, page: () => CareGiverProfile()),
    GetPage(name: contactInfo, page: () => ContactInfo()),
    GetPage(name: wishMessage, page: () => WishMessage()),
    GetPage(name: reviewSubmission, page: () => ReviewSubmission()),
    GetPage(name: notification, page: () => Notification()),
    GetPage(name: employeeHome, page: () => EmployeeHome()),
    GetPage(name: surveyInfo, page: () => SurveyInfo()),
    GetPage(name: surveyStep, page: () => SurveyStep()),
    GetPage(name: discount, page: () => Discount()),
    GetPage(name: profile, page: () => Profile()),
    GetPage(name: stylingScreen, page: () => StylingScreen()),
    GetPage(name: pagingScreen, page: () => PagingScreen()),
    GetPage(name: controllerScreen, page: () => ControllerScreen()),
    GetPage(name: page1, page: () => Page1()),
    GetPage(name: getBuilderScreen, page: () => GetBuilderScreen(), binding: GetBuildBind()),
    GetPage(name: obxGtxScreen, page: () => ObxGtxScreen()),
    GetPage(name: language, page: () => Language()),
    GetPage(name: bottomNavigationScreen, page: () => BottomNavigation()),
    GetPage(name: patientsList, page: () => PatientsList()),
    GetPage(name: loginTest, page: () => LoginTest()),
    GetPage(name: rateYourDay, page: () => RateYourDay()),
  ];
}
