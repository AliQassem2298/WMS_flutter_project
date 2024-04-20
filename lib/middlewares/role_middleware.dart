// import 'package:flutter/src/widgets/navigator.dart';
// import 'package:get/get.dart';
// import 'package:warehouse_manegment_system/controller/home_page_controller_customer.dart';
// import 'package:warehouse_manegment_system/controller/home_page_controller_staff.dart';
// import 'package:warehouse_manegment_system/main.dart';

// class RoleMiddleare extends GetMiddleware {
//   @override
//   int? get priority => 2;

//   @override
//   RouteSettings? redirect(String? route) {
//     //   if (sharedPreferences!.getString("role") == "staff") {
//     //   } else if (sharedPreferences!.getString("role") == "customer") {
//     //     RouteSettings(name: HomePageControllerCustomer.id);
//     //   }
//     // }
//     // return RouteSettings(name: HomePageControllerCustomer.id);

//     if (sharedPreferences!.getString("role") == "staff")
//       return RouteSettings(name: HomePageControllerStaff.id);
//     if (sharedPreferences!.getString("role") == "customer")
//       return RouteSettings(name: HomePageControllerCustomer.id);
//     return null;
//   }
// }
