import 'dart:io';
import 'package:quality_app/models/api_data_class.dart';
import 'package:quality_app/networking/server_config.dart';
import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
//app package
import 'package:quality_app/packages/config_package.dart';

Dio dio = new Dio();
ServerConfig _serverConfig = ServerConfig();

class Apis {
  //this is compulsory. do not delete
  Apis() {
    String authToken = helper.getStorage('authToken');
    print(authToken);
    //options
    dio.options
      ..baseUrl = _serverConfig.apiUrl
      ..validateStatus = (int status) {
        //this will always redirect to onResponse method
        return status > 0;
      }
      ..headers = {
        'Authorization': "Bearer $authToken",
        'Accept': 'application/json',
      };
    //interceptors
    /*dio.interceptors
      ..add(
        InterceptorsWrapper(onRequest: (options) {
          print("interceptors onRequest");
          print(options.uri);
          return options;
        }, onResponse: (response) {
          print("interceptors onResponse");
          print(response.statusCode);
          return response;
        }, onError: (error) {
          print("interceptors onError");
          print(error.toString());
        }),
      );*/
  }
  Future<APIDataClass> checkStatus(response) async {
    // print("statusCode : ${response.statusCode}");
    if (response.statusCode == 200 || response.statusCode == 201) {
      return APIDataClass(
        isSuccess: true,
        validation: false,
        message: 'Success',
        data: response.data,
      );
    } else if (response.statusCode == 422)
      return APIDataClass(
        isSuccess: false,
        validation: true,
        message: 'validation failed',
        data: response.data,
      );
    else if (response.statusCode == 401) {
      helper.errorMessage('Something went wrong. Try again after some time ${response.statusCode}');
      helper.removeSpecificKeyStorage(Session.authToken);
      Get.offAndToNamed(AppRouter.login);
      return APIDataClass(
        isSuccess: false,
        validation: false,
        message: response.statusMessage,
        data: null,
      );
    } else {
      apiFailedResponse(response);
      helper.errorMessage('Something went wrong. Try again after some time ${response.statusCode}');
      return APIDataClass(
        isSuccess: false,
        validation: false,
        message: response.statusMessage,
        data: null,
      );
    }
  }

  apiFailedResponse(response) {
    List apiFailedArr = [];
    dynamic getData = helper.getStorage(Session.queueApiFailed) ?? [];

    Map apiRequest = {
      'uri': '${response.request.uri}',
      'data': "${response.request.data ?? ''}",
      'method': "${response.request.method ?? ''}",
      'statusCode': "${response.statusCode ?? ''}",
    };
    if (getData.length > 0) {
      apiFailedArr = getData;
    }

    apiFailedArr.add(apiRequest);
    helper.writeStorage(Session.queueApiFailed, apiFailedArr);
  }

  //to get full path with paramiters
  static Future<String> getFullUrl(String apiName, List params) async {
    String _url = "";
    if (params.length > 0) {
      _url = apiName + "?";
      for (int i = 0; i < params.length; i++) {
        _url = _url + '${params[i]["key"]}=${params[i]["value"]}';
        if (i + 1 != params.length) _url = _url + "&";
      }
    } else
      _url = apiName;
    //String url = _serverConfig.apiUrl + '$_url';
    return _url;
  }

  // ignore: missing_return
  Future<APIDataClass> getApi(String apiName, List params) async {
    //default data to class
    APIDataClass apiData = new APIDataClass(message: 'No Data', isSuccess: false, validation: false, data: null, isInternetConnected: true);
    try {
      print("API : start"); //do not delete
      var connectivityResult = await Connectivity().checkConnectivity(); //Check For Wifi or Mobile data is ON/OFF
      if (connectivityResult == ConnectivityResult.none) {
        print("API : ${Session.noInternet}"); // do not delete
        // helper.alertMessage(Session.noInternet);
        apiData.isInternetConnected = false;
        print("No inter");
        return apiData;
      } else {
        final result = await InternetAddress.lookup('google.com'); //Check For Internet Connection
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          print("API : internet connected"); //do not delete
          String url = await getFullUrl(apiName, params);
          print("$apiName URL: " + url);

          String authToken = helper.getStorage('authToken');
          dio.options.headers["Authorization"] = "Bearer $authToken";

          final response = await dio.get(url); //dio request
          apiData = await checkStatus(response);
          // get data base on status code
          return apiData;
        } else {
          apiData.isInternetConnected = false;
          return apiData;
        }
      }
    } on SocketException catch (e) {
      print("API : SocketException - ${e.toString()}"); //do not delete
      helper.alertMessage(Session.noInternet);
      return apiData;
    } on Exception catch (e) {
      print("API : Exception - ${e.toString()}"); //do not delete
      helper.alertMessage(Session.wentWrong);
      return apiData;
    }
  }

  // ignore: missing_return
  Future<APIDataClass> postApi(String apiName, body) async {
    //default data to class
    APIDataClass apiData = new APIDataClass(message: 'No Data', isSuccess: false, validation: false, data: null);
    try {
      print("API : start"); //do not delete
      var connectivityResult = await Connectivity().checkConnectivity(); //Check For Wifi or Mobile data is ON/OFF
      if (connectivityResult == ConnectivityResult.none) {
        print("API : ${Session.noInternet}"); // do not delete
        // helper.alertMessage(Session.noInternet);
        apiData.isInternetConnected = false;
        return apiData;
      } else {
        final result = await InternetAddress.lookup('google.com'); //Check For Internet Connection
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          print("API : internet connected"); //do not delete

          String authToken = helper.getStorage('authToken');
          dio.options.headers["Authorization"] = "Bearer $authToken";
          print(apiName);
          print(body);
          final response = await dio.post(apiName, data: body); //dio request
          print(response);
          // print(json.decode(response.data));

          apiData = await checkStatus(response); // get data base on status code
          return apiData;
        }
      }
    } on SocketException catch (e) {
      print("API : SocketException - ${e.toString()}"); //do not delete
      helper.alertMessage(Session.noInternet);
      apiData.isInternetConnected = false;
      return apiData;
    } on Exception catch (e) {
      print("API : Exception - ${e.toString()}"); //do not delete
      helper.alertMessage('${Session.wentWrong} $apiName');
      return apiData;
    }
  }

  Future<APIDataClass> putApi(String apiName, body) async {
    //default data to class
    APIDataClass apiData = new APIDataClass(message: 'No Data', isSuccess: false, validation: false, data: null);
    try {
      print("API : start"); //do not delete
      var connectivityResult = await Connectivity().checkConnectivity(); //Check For Wifi or Mobile data is ON/OFF
      if (connectivityResult == ConnectivityResult.none) {
        print("API : ${Session.noInternet}"); // do not delete
        // helper.alertMessage(Session.noInternet);
        apiData.isInternetConnected = false;
        return apiData;
      } else {
        final result = await InternetAddress.lookup('google.com'); //Check For Internet Connection
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          print("API : internet connected"); //do not delete

          String authToken = helper.getStorage('authToken');
          dio.options.headers["Authorization"] = "Bearer $authToken";
          print(apiName);
          print(body);
          final response = await dio.put(apiName, data: body); //dio request

          apiData = await checkStatus(response); // get data base on status code
          return apiData;
        }
      }
    } on SocketException catch (e) {
      print("API : SocketException - ${e.toString()}"); //do not delete
      helper.alertMessage(Session.noInternet);
      apiData.isInternetConnected = false;
      return apiData;
    } on Exception catch (e) {
      print("API : Exception - ${e.toString()}"); //do not delete
      helper.alertMessage('${Session.wentWrong} $apiName');
      return apiData;
    }
  }
}
