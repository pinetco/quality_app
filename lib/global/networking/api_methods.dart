class ApiMethods {
  final String loginAPI = "/auth/login";
  final String forgotPasswordAPI = "/auth/forgotPassword";
  final String clientHomeAPI = '/client-home'; //'/client-home';
  final String employeesAPI = "/employees";
  final String reviewsAPI = "/reviews";
  final String questionsAPI = "/questions";
  final String appInformationAPI = "/app-information";
  final String userAPI = "/user";
  String surveyQueAPI(id, page) => "/surveys/$id/survey-questions?page=$page";
  final String employeeHomeAPI = "/employee-home";
  final String checkInAPI = "/check-in";
  String checkOutAPI(id) => "/visits/$id/check-out";
  final String validationAPI = "/survey-answers/validation";
  final String surveyAnswerAPI = "/survey-answers";

  String visitDateAPI(id) => "/options/employees/$id/visit-dates";
  String reviewDateWise(id, date) => "/employees/$id/review?date=$date";

  String patientsAPI(name) => '/clients?search=$name';
  final String careGiverListAPI = '/employees';
  final String registerTokenAPI = '/devices';

  final String rateYourDayAPI = "/questions?type=rate_day";
  final String changePasswordAPI = "/change-password";
  final String createRequestAPI = "/requests";
  final String surveysAPI = "/surveys";
}
