class ApiMethods {
  final String loginAPI = "/auth/login";
  final String forgotPasswordAPI = "/auth/token";
  final String clientHomeAPI = '/client-home'; //'/client-home';
  final String employeesAPI = "/employees";
  final String reviewsAPI = "/reviews";
  final String rateDaysAPI = "/rate-days";
  final String questionsAPI = "/questions?type=review";
  final String appInformationAPI = "/app-information";
  final String userAPI = "/user";
  String surveyQueAPI(page, id) => "/surveys/$id/survey-questions?page=$page";
  final String employeeHomeAPI = "/employee-home";
  final String checkInAPI = "/check-in";
  String checkOutAPI(id) => "/visits/$id/check-out";
  final String validationAPI = "/validate/survey-answers";
  final String surveyAnswerAPI = "/survey-answers";

  String visitDateAPI(id) => "/options/employees/$id/visit-dates";
  String reviewDateWise(id, date) => "/employees/$id/review?date=$date";

  String patientsAPI(name) => '/clients?search=$name';
  String careGiverListAPI(name) => '/employees?search=$name';
  final String registerTokenAPI = '/devices';

  final String rateYourDayAPI = "/questions?type=rate_day";
  final String changePasswordAPI = "/change-password";
  final String createRequestAPI = "/requests";
  final String surveysAPI = "/surveys";
  final String loginWithTokenAPI = "/auth/login/token";
  final String notificationsAPI = "/notifications";
  final String updateProfileAPI = '/profile';
  final String settingsAPI = "/settings";

  String acceptedRequestAPI(id) => "/request/$id/accept";
}
