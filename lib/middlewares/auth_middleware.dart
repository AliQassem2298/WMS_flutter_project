// ignore_for_file: body_might_complete_normally_nullable

import 'package:flutter/src/widgets/navigator.dart';
import 'package:get/get.dart';
import 'package:warehouse_manegment_system/controller/home_page_controller_customer.dart';
import 'package:warehouse_manegment_system/controller/home_page_controller_staff.dart';
import 'package:warehouse_manegment_system/main.dart';

class AuthMiddleare extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    if (sharedPreferences!.getString("token") != null) {
      if (sharedPreferences!.getString("role") == "staff") {
        return RouteSettings(name: HomePageControllerStaff.id);
      } else {
        return RouteSettings(name: HomePageControllerCustomer.id);
      }
    }
    // return RouteSettings(name: WelcomePageController.id);
  }
}
