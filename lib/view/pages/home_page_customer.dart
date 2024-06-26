// ignore_for_file: must_be_immutable, use_build_context_synchronously, avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:warehouse_manegment_system/controller/home_page_controller_customer.dart';
import 'package:warehouse_manegment_system/controller/profile_page_controller.dart';
import 'package:warehouse_manegment_system/controller/welcome_page_controller.dart';
import 'package:warehouse_manegment_system/model/models/sign_in_model.dart';

class HomePageCustomer extends StatelessWidget {
  const HomePageCustomer({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomePageControllerCustomer>(
      init: HomePageControllerCustomer(),
      builder: (controller) {
        return ModalProgressHUD(
          inAsyncCall: controller.isLoading,
          child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              actions: [
                IconButton(
                  onPressed: () async {
                    try {
                      await Get.toNamed(ProfilePageController.id);
                    } catch (e) {
                      controller.showSnackBar(context, e.toString());
                    }

                    // controller.loadingIndecatorTrue();
                    // try {
                    //   await controller.logOut();
                    //   print('succsess');
                    //   controller.loadingIndecatorFalse();
                    //   print('token=$token');

                    //   controller.showSnackBar(
                    //     context,
                    //     'Logout successful',
                    //   );
                    //   Get.offAllNamed(WelcomePageController.id);
                    // } catch (e) {
                    //   print(e.toString());
                    //   controller.showSnackBar(
                    //     context,
                    //     e.toString(),
                    //   );
                    // }
                    // controller.loadingIndecatorFalse();
                  },
                  icon: const Icon(Icons.supervised_user_circle_outlined),
                ),
                userToken != null
                    ? IconButton(
                        onPressed: () async {
                          controller.loadingIndecatorTrue();
                          try {
                            await controller.logOut();
                            // userId = null;
                            print('succsess');
                            controller.loadingIndecatorFalse();
                            // print('token=$token');
                            userToken = null;

                            controller.showSnackBar(
                              context,
                              'Logout successful',
                            );
                            Get.offAllNamed(WelcomePageController.id);
                          } catch (e) {
                            print(e.toString());
                            controller.showSnackBar(
                              context,
                              ' Authentication credentials were not provided.',
                            );
                          }
                          controller.loadingIndecatorFalse();
                        },
                        icon: const Icon(Icons.logout),
                      )
                    : IconButton(
                        onPressed: () {
                          Get.offAllNamed(WelcomePageController.id);
                        },
                        icon: const Icon(Icons.backspace_outlined),
                      )
              ],
            ),
            body: Center(
              child: sharedPreferences!.getString("token") != null
                  ? Text(
                      "Welcome Customer",
                      style: TextStyle(fontSize: 25),
                    )
                  : Text(
                      "Welcome Geust",
                      style: TextStyle(fontSize: 25),
                    ),
            ),
          ),
        );
      },
    );
  }
}
