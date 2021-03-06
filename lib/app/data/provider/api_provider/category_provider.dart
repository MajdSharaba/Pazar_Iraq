
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:connectivity/connectivity.dart';
import 'package:http/http.dart' as http;
import 'package:pazar_iraq/app/core/constants.dart';
import 'package:pazar_iraq/app/data/provider/db_provider/language_provider.dart';
import 'package:pazar_iraq/app/model/category.dart';
import 'package:pazar_iraq/app/modules/view/widgets/snackbar.dart';


class CategoryProveder{



  static var client = http.Client();


  static Future<Category> fetchCategories() async {
    print(language);
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult != ConnectivityResult.none) {
      try {

    var response = await client.get(Uri.parse(
        'http://184.168.97.161/public/api/category/allcategory'),
      headers: {
      HttpHeaders.acceptLanguageHeader: "ar",
      },).timeout(const Duration(seconds: 15));
    if (response.statusCode >= 200 || response.statusCode < 299) {
      var jsonString = response.body;

      print(jsonString);
      return categoryFromJson(jsonString);
    } else  {
      print('getCategory error 401 ');
      Get.snackbar("Error", "فشل الاتصال",
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.red,
      colorText: Colors.white);
      showSnackBar("فشل الاتصال");
      return new Category();
    }

  }
      catch (e) {
        // print('getCategory error 401 ');
        // Get.snackbar("Error", "فشل الاتصال",
        //     snackPosition: SnackPosition.TOP,
        //     backgroundColor: Colors.red,
        //     colorText: Colors.white);

        return new Category();
      }
      }
    else{
      print('getCategory error 401 ');
      Get.snackbar("Error", "فشل الاتصال",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white);

      return new Category();

    }
  }
}