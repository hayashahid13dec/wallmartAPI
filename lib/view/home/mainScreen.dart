import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wallmart/controller/mainScreenController.dart';
import 'package:wallmart/services/authServices.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final MainScreenController mainScreenController =
        Get.put(MainScreenController());
    return Scaffold(
      body: SafeArea(
        child: Obx(() {
          return SingleChildScrollView(
            child: mainScreenController.isLoading.value == true
                ? Center(child: const CircularProgressIndicator())
                : Column(
                    children: [
                      Text("MainScreen"),
                      InkWell(
                        onTap: () {
                          // AuthServices().getOrderList();
                          mainScreenController.getGroceryList();
                        },
                        child: Container(
                          height: 5.h,
                          width: 30.w,
                          decoration: const BoxDecoration(
                            color: Colors.redAccent,
                          ),
                        ),
                      ),
                      Text(mainScreenController.itemList.length.toString()),
                      ListView.builder(
                        itemCount: mainScreenController.itemList.length,
                        shrinkWrap: true,
                          itemBuilder: (context, index) {
                        return Container(
                          height: 5.h,
                          width: 90.w,
                          decoration: BoxDecoration(
                            color: Colors.black,
                          ),
                        );
                      })

                      // Visibility(
                      //   visible:  mainScreenController
                      //       .orderValue.value.list != null,
                      //   child: Text(
                      //     mainScreenController
                      //         .orderValue.value.list
                      //         .toString(),
                      //     style: TextStyle(color: Colors.black),
                      //   ),
                      // ),
                    ],
                  ),
          );
        }),
      ),
    );
  }
}
