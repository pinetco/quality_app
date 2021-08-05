class ApiMethods {
  final String loginAPI = "/auth/login";
  final String clientHomeAPI = '/new-client-home'; //'/client-home';
  final String employeesAPI = "/employees";
  final String reviewsAPI = "/reviews";
  final String questionsAPI = "/questions";
  final String appInformationAPI = "/app-information";
  final String userAPI = "/user";
  String surveyQueAPI(page) => "/survey-questions?page=$page";
  final String employeeHomeAPI = "/employee-home";
  final String checkInAPI = "/check-in";
  String checkOutAPI(id) => "/visits/$id/check-out";
  final String validationAPI = "/survey-answers/validation";
  final String surveyAnswerAPI = "/survey-answers";

  String visitDateAPI(id) => "/options/employees/$id/visit-dates";
  String reviewDateWise(id, date) => "/employees/$id/review?date=$date";

  final String patientsAPI = '/clients';
  final String careGiverListAPI = '/employees';
  final String registerTokenAPI = '/devices';
}
