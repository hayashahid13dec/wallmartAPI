import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:wallmart/model/orderJsonModel.dart';
import 'package:wallmart/model/orderModel.dart';
import 'package:wallmart/services/authServices.dart';
import 'package:xml/xml.dart' as xml;
import 'package:xml2json/xml2json.dart';
// import 'package:convert/convert.dart' as convert;

class MainScreenController extends GetxController{


 RxBool isLoading = false.obs;
 var object = Object().obs;
 var orderValue = OrderModel().obs;


 @override
  void onInit() {
    // TODO: implement onInit
   isLoading.value=true;
   AuthServices().generateToken();
   // Future.delayed(Duration(seconds: 3),(){
   //  getOrderList();
   // });
   isLoading.value=false;
   // getOrderList();
    super.onInit();
  }

 Future<Object?> getOrderList() async {
  try {
   isLoading.value = true;
   var result = await AuthServices().getOrderList();
   if (kDebugMode) {
    print("Result: $result");
   }
   // completeData.value = result;
   object.value = result;
   // xml.XmlDocument xmlDocument = xml.XmlDocument.parse(object.value.toString());
   // // String jsonString = convert.xmltoJson(xmlDocument.toXmlString());
   // Xml2Json xml2json = Xml2Json();
   // xml2json.parse(xmlDocument.toXmlString());
   // String jsonString = xml2json.toGData();
   final Xml2Json xml2Json = Xml2Json();
   xml2Json.parse("<root><item>1</item><item>2</item><item>three</item></root>");
   String jsonString = xml2Json.toParker();
   print(jsonString);
   // print(jsonString);
   orderValue.value = orderModelFromJson(jsonString);
   print("The order value is"+orderValue.value.toString());


   isLoading.value = false;
   return result;
  } on SocketException {
   isLoading.value = false;
   // Prompts.showDialog(
   //     middleText: "Internet connection failure!", title: 'Oops');
  } on Exception {
   isLoading.value = false;
   // Prompts.showDialog(middleText: "No data found!", title: 'Oops');
  } catch (e) {
   isLoading.value = false;
   // Prompts.showDialog(middleText: "No data found!", title: 'Oops');
  }
  return null;
 }
}