import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:wallmart/controller/mainScreenController.dart';
import 'package:wallmart/model/orderJsonModel.dart';
import 'package:wallmart/model/orderModel.dart';
import 'package:wallmart/model/tokenModel.dart';
import 'package:wallmart/services/endpoints/urlSchemes.dart';
import 'package:http/http.dart' as http;
import 'package:wallmart/services/localStorage/localStorage.dart';
import 'package:xml/xml.dart' as xml;
import 'package:xml2json/xml2json.dart';


class AuthServices {

  ///generation of token
  Future<TokenModel> generateToken() async {
    /// Url
    String url = UrlSchemes.baseUrl + UrlSchemes.token;
    var data = {
      "grant_type": "client_credentials",
    };

    var header = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Accept': 'application/json',
      'Authorization': 'Basic OWU5ZmQzZDQtYjkxMy00ZGZlLWJjNzQtMjZkNmEwZTNkYmUxOkFJSms0TF8zN0ZRNUFabW5jMGU5eGJyemJRbkdZc050eGlZOWdTeFktTHNDdEFOdzJTRGRtZ3JOaTNuTW9IekxOZzRWX1NvS2IyYWY5SDZlX1ljbVp1UQ==',
      'WM_SVC.NAME': 'Walmart Marketplace',
      'WM_QOS.CORRELATION_ID':'jkhfksdh1234',
    };

    /// Request
    var response = await http.post(
      headers: header,
      Uri.parse(url),
      body: data,
    );
    var resp = tokenModelFromJson(response.body);


    /// Save Login Token
    LocalStorage.writeString(
      key: LocalStorageKeys.accessToken,
      value: resp.accessToken,
    );

    /// this is called when we are debugging and this is not called when we
    /// make the release.
    if (kDebugMode) {
      print("Called API: $url");
      // print("PHONE: $phone");
      print("Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");
    }

    if (response.statusCode == 200 || response.statusCode == 201) {
      // Prompts.showSuccess("Congrats!", "Successfully Signed Up.");
      getOrderList();
      return tokenModelFromJson(response.body);
    }
    if (response.statusCode == 400) {
      // Prompts.showError("Oops",errorModelFromJson(response.body).error);
      // return errorModelFromJson(response.body);
      throw Exception('Error');

    }
    if (response.statusCode == 401) {
      throw Exception('Failed to send!');
    }
    if (response.statusCode == 500) {
      throw Exception('Internal Server Error!');
    } else {
      throw Exception('Something went wrong');
    }
  }


  ///get order list
  Future<Object> getOrderList() async {

    final MainScreenController mainScreenController =
    Get.put(MainScreenController());
    /// Url
    String url = UrlSchemes.baseUrl + UrlSchemes.orders;

    /// Get Login Token
    String generatedToken = LocalStorage.readString(
      key: LocalStorageKeys.accessToken,
    );

    var header = {
     'WM_SEC.ACCESS_TOKEN':generatedToken,
      'WM_QOS.CORRELATION_ID':'jkhfksdh1234',
      'WM_SVC.NAME':'Walmart Marketplace',
    };

    /// Request
    var response = await http.get(
      headers: header,
      Uri.parse(url),
    );



    /// this is called when we are debugging and this is not called when we
    /// make the release.
    if (kDebugMode) {
      print("Called API: $url");
      // print("PHONE: $phone");
      print("Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");
    }

    if (response.statusCode == 200 || response.statusCode == 201) {
      // Prompts.showSuccess("Congrats!", "Successfully Signed Up.");
      xml.XmlDocument xmlDocument = xml.XmlDocument.parse(response.toString());
      // String jsonString = convert.xmltoJson(xmlDocument.toXmlString());
      Xml2Json xml2json = Xml2Json();
      xml2json.parse(mainScreenController.object.value.toString());
      String jsonString = xml2json.toGData();
      // print(jsonString);
      mainScreenController.orderValue.value = orderModelFromJson(jsonString);
      print("The order value is"+mainScreenController.orderValue.value.toString());
      // return xml.XmlDocument.parse(response.body);
    }
    if (response.statusCode == 400) {
      // Prompts.showError("Oops",errorModelFromJson(response.body).error);
      // return errorModelFromJson(response.body);
      throw Exception('Error');

    }
    if (response.statusCode == 401) {
      generateToken();
      getOrderList();
    }
    if (response.statusCode == 500) {
      throw Exception('Internal Server Error!');
    } else {
      throw Exception('Something went wrong');
    }
  }


}