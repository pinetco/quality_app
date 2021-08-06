const String apiUrl = "https://quality.libu.app/api";
// const String apiUrl = "https://7d056c71ef47.ngrok.io/api"; //"https://fast-peak-27095.herokuapp.com/appv1/";
const String baseUrl = "https://quality.libu.app/";
const String loginToken = ""; //8525fae1448f2c134325bd7f550029e0

const String api_Version = "v2";

//Methods
// const String loginAPI = "/auth/login";
const String loginAPI = "/auth/login";
const String clientHomeAPI = '/new-client-home'; //'/client-home';
const String employeesAPI = "/employees";
const String reviewsAPI = "/reviews";
const String questionsAPI = "/questions";
const String appInformationAPI = "/app-information";
const String userAPI = "/user";
String surveyQueAPI(page) => "/survey-questions?page=$page";
const String employeeHomeAPI = "/employee-home";
const String checkInAPI = "/check-in";
String checkOutAPI(id) => "/visits/$id/check-out";
const String validationAPI = "/survey-answers/validation";
const String surveyAnswerAPI = "/survey-answers";

String visitDateAPI(id) => "/options/employees/$id/visit-dates";
String reviewDateWise(id, date) => "/employees/$id/review?date=$date";

const String patientsAPI = '/clients';
const String careGiverListAPI = '/employees';
const String registerTokenAPI = '/devices';

const int successCode = 200;
const int authorizationCode = 401;
const int internalServerError = 500;
const int userCreated = 201;

// Last include
const String careGiversSearchAPI = '/employees';
const String patientsSearchAPI = '/employees';
