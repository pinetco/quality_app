import 'dart:io';

import 'package:dio/dio.dart';
//app package
import 'package:quality_app/global/packages/config_package.dart';
import 'package:quality_app/modal/api_data_class.dart';

import 'server_config.dart';

Dio dio = new Dio();
ServerConfig _serverConfig = ServerConfig();

bool isApiLoading = false;

class Apis {
  //this is compulsory. do not delete
  Apis() {
    //options
    dio.options
      ..baseUrl = _serverConfig.apiUrl
      ..validateStatus = (int status) {
        return status > 0; //this will always redirect to onResponse method
      }
      ..headers = {
        'Accept': 'application/json',
        'content-type': 'application/json',
      };
    //interceptors
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        print("interceptors onRequest : ${options.uri}");
        return handler.next(options);
      },
      onResponse: (response, handler) {
        print("interceptors onResponse : ${response.statusCode}");
        return handler.next(response);
      },
      onError: (DioError e, handler) {
        print("interceptors onError : ${e.toString()}");
        return handler.next(e);
      },
    ));
  }

  // ignore: missing_return
  Future<APIDataClass> call(String apiName, body, type, [onSendProgress]) async {
    //default data to class
    APIDataClass apiData = new APIDataClass(message: 'No Data', isSuccess: false, validation: false, data: null);
    try {
      bool isInternet = await helper.isNetworkConnection();
      if (isInternet) {
        String authToken = helper.getStorage(session.authToken);
        dio.options.headers["Authorization"] = "Bearer $authToken";
        print('authToken : $authToken');
        dynamic response;
        print('apiName : $apiName');

        switch (type) {
          case 'get':
            response = await dio.get(apiName, queryParameters: body); //dio request
            break;
          case 'post':
            response = await dio.post(apiName, data: body, onSendProgress: onSendProgress);
            break;
          case 'delete':
            response = await dio.delete(apiName, data: body);
            break;
          case 'put':
            response = await dio.put(apiName, data: body);
            break;
        }

        apiData = await checkStatus(response);

        return apiData;
      } else {
        helper.goToNoInternetScreen();
      }
    } on SocketException catch (e) {
      onSocketException(e);
      return apiData;
    } catch (e) {
      onException(e);
      return apiData;
    }
  }

  //#region functions
  Future<APIDataClass> checkStatus(response) async {
    print("response : ${response.toString()}");
    print("statusCode : ${response.statusCode}");

    if (response.statusCode == 200 || response.statusCode == 201)
      return APIDataClass(
        isSuccess: true,
        validation: false,
        message: 'Success',
        data: response.data,
      );
    else if (response.statusCode == 422)
      return APIDataClass(
        isSuccess: false,
        validation: true,
        message: 'validation failed',
        data: response.data,
      );
    else if (response.statusCode == 401) {
      helper.snackBar('unauthorized access please login');
      helper.removeSpecificKeyStorage(session.authToken);
      Get.offAllNamed(routeName.login);

      return APIDataClass(
        isSuccess: false,
        validation: true,
        message: 'validation failed',
        data: response.data,
      );
    } else {
      return APIDataClass(
        isSuccess: false,
        validation: false,
        message: response.statusMessage,
        data: null,
      );
    }
  }

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

  onSocketException(e) {
    print("API : SocketException - ${e.toString()}"); //do not delete
    helper.snackBar(constValue.noInternet.tr);
  }

  onException(e) {
    print("API : Exception - ${e.toString()}"); //do not delete
    helper.snackBar(constValue.wentWrong.tr);
  }
//#endregion
}
