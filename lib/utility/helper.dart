import 'dart:convert';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';

final _storage = GetStorage();

class Helper {
  dynamic getStorage(String name) {
    dynamic info = _storage.read(name) ?? '';
    return info != '' ? json.decode(info) : info;
  }

  dynamic writeStorage(String key, dynamic value) {
    dynamic object = value != null ? json.encode(value) : value;
    return _storage.write(key, object);
  }

  dynamic removeSpecificKeyStorage(String key) {
    _storage.remove(key);
  }

  clearStorage() {
    _storage.erase();
  }

  successMessage(message) => Get.snackbar('Success', message, backgroundColor: Colors.green, colorText: Colors.white);
  errorMessage(message) => Get.snackbar('Error', message, backgroundColor: Colors.red, colorText: Colors.white);
  alertMessage(message) => Get.snackbar('Alert', message, backgroundColor: Colors.yellow, colorText: Colors.black);

  jsonGet(json, String path, defaultValue) {
    try {
      List pathSplitter = path.split(".");

      /// <String,dynamic> || String
      var returnValue;
      json.forEach((key, value) {
        var currentPatten = pathSplitter[0];
        int index = 0;
        if (currentPatten.contains('[') && currentPatten.contains(']')) {
          int index1 = currentPatten.indexOf('[');
          int index2 = currentPatten.indexOf(']');
          index = int.parse(currentPatten.substring(index1 + 1, index2));
          currentPatten = currentPatten.substring(0, index1);
        }
        if (key == currentPatten) {
          if (pathSplitter.length == 1) {
            returnValue = value;
            return;
          }
          pathSplitter.remove(pathSplitter[0]);
          if (value == null) {
            returnValue = defaultValue;
            return;
          }
          try {
            try {
              value = value.toJson();
            } catch (error) {
              // handle error
            }
            try {
              if (value is List) {
                value = value[index];
              }
            } catch (error) {
              // handle error
            }
            returnValue = jsonGet(value, pathSplitter.join("."), defaultValue);
          } catch (error) {
            returnValue = defaultValue;
          }
          return;
        }
      });
      return returnValue != null ? returnValue : defaultValue;
    } on Exception catch (e) {
      print(e);
      // TODO
      return defaultValue;
    }
  }

  bool isNullOrBlank(dynamic val) {
    if (val is List) {
      if (val == null || val.isEmpty || val.length == 0)
        return true;
      else
        return false;
    } else {
      if (val == null || val == '' || val.toString().isEmpty || val.toString().isBlank)
        return true;
      else
        return false;
    }
  }

  Future<bool> isConnected() async {
    var connectivityResult = await Connectivity().checkConnectivity(); //Check For Wifi or Mobile data is ON/OFF
    if (connectivityResult == ConnectivityResult.none) {
      return false;
    }
    return true;
  }
}
