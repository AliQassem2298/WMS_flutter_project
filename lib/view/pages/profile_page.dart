// // ignore_for_file: library_private_types_in_public_api, must_be_immutable, avoid_print

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:warehouse_manegment_system/controller/custom_row_controller.dart';
// import 'package:warehouse_manegment_system/controller/forget_password_page_controller.dart';
// import 'package:warehouse_manegment_system/controller/profile_page_controller.dart';
// import 'package:warehouse_manegment_system/controller/welcome_page_controller.dart';
// import 'package:warehouse_manegment_system/model/models/sign_in_model.dart';
// import 'package:warehouse_manegment_system/model/models/user_model.dart';
// import 'package:warehouse_manegment_system/model/services/get_user_details__by_id_service.dart';
// import 'package:warehouse_manegment_system/view/widgets/custom_button.dart';
// import 'package:warehouse_manegment_system/view/widgets/custom_row.dart';

// ignore_for_file: use_build_context_synchronously, avoid_print, must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:warehouse_manegment_system/constans.dart';
// import 'package:warehouse_manegment_system/constans.dart';
import 'package:warehouse_manegment_system/controller/change_password_page_controller.dart';
// import 'package:warehouse_manegment_system/controller/custom_row_controller.dart';
// import 'package:warehouse_manegment_system/controller/forget_password_page_controller.dart';
import 'package:warehouse_manegment_system/controller/profile_page_controller.dart';
import 'package:warehouse_manegment_system/controller/update_user_details_controller.dart';
// import 'package:warehouse_manegment_system/controller/welcome_page_controller.dart';
import 'package:warehouse_manegment_system/main.dart';
import 'package:warehouse_manegment_system/model/models/user_model.dart';
import 'package:warehouse_manegment_system/model/services/get_user_details__by_token_service.dart';
import 'package:warehouse_manegment_system/view/widgets/custom_button.dart';
import 'package:warehouse_manegment_system/view/widgets/custom_dialog.dart';
// import 'package:warehouse_manegment_system/view/widgets/custom_row.dart';
import 'package:flutter_svg/flutter_svg.dart';

// import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfilePageController>(
      init: ProfilePageController(),
      builder: (controller) {
        return ModalProgressHUD(
          inAsyncCall: controller.isLoading,
          child: Scaffold(
            body: Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerRight,
                      end: Alignment.centerLeft,
                      colors: [
                        kFirstColor,
                        kFirstColor2,
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25, top: 50, right: 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Welcome',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 32,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              // Get.toNamed(HomePageController.id);
                              Get.back();
                            },
                            icon: const Icon(
                              Icons.password,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      const Text(
                        'Profile Page',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 700),
                    height: controller.containerHeight,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(45),
                      ),
                      color: Colors.white,
                    ),
                    child: FutureBuilder<UserModel>(
                      future: sharedPreferences!.getString("token") != null
                          ? GetUserDetailsByTokenService()
                              .getUserDetailsByToken()
                          : Future.error(
                              'You are guest 😒😅 \n you don\'t have an account',
                            ),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (snapshot.hasError) {
                          return Center(
                            child: Text(
                              snapshot.error.toString(),
                              style: const TextStyle(fontSize: 18),
                            ),
                          );
                        } else if (snapshot.hasData &&
                            sharedPreferences!.getString("token") != null) {
                          controller.userModel = snapshot.data!;

                          return ListView(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 25,
                              vertical: 25,
                            ),
                            children: [
                              const SizedBox(height: 70),
                              Column(
                                children: [
                                  Text(
                                    controller.userModel!.username,
                                    style: const TextStyle(
                                      fontSize: 23,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    controller.userModel!.email,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 50,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomRowWidget(
                                    text: controller.userModel!.firstName,
                                    icon: Icons.person,
                                  ),
                                  CustomRowWidget(
                                    text: controller.userModel!.lastName,
                                    icon: Icons.person,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomRowWidget(
                                    text: controller.userModel!.role,
                                    icon: 'assets/Role.svg',
                                  ),
                                  CustomRowWidget(
                                    text:
                                        '${controller.userModel!.dateJoined.year}-${controller.userModel!.dateJoined.month}-${controller.userModel!.dateJoined.day}',
                                    icon: Icons.calendar_month_rounded,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 35),
                              InkWell(
                                child: const Row(
                                  children: [
                                    Text(
                                      'Change Password',
                                      style: TextStyle(
                                        color: Color(0xff2B1836),
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Icon(Icons.edit_outlined)
                                  ],
                                ),
                                onTap: () {
                                  Get.toNamed(
                                    ChangePasswordPageController.id,
                                  );
                                },
                              ),
                              const SizedBox(height: 35),
                              CustomButton(
                                onPressed: () {
                                  Get.toNamed(
                                    UpdateUserDetailsController.id,
                                    arguments: controller.userModel,
                                  );
                                },
                                gradient: const LinearGradient(
                                  begin: Alignment.centerRight,
                                  end: Alignment.centerLeft,
                                  colors: [
                                    // Color(0xff2B1836),
                                    // Color(0xff591C3C),
                                    // Color(0xff911C3A),
                                    // Color(0xffBB1636),
                                    kFirstColor,
                                    kFirstColor2,
                                  ],
                                ),
                                text: 'Edit Profile',
                              ).paddingSymmetric(horizontal: 50),
                              const SizedBox(height: 10),
                              CustomButton(
                                gradient: const LinearGradient(
                                  begin: Alignment.centerRight,
                                  end: Alignment.centerLeft,
                                  colors: [
                                    // Color(0xff2B1836),
                                    // Color(0xff591C3C),
                                    // Color(0xff911C3A),
                                    // Color(0xffBB1636),
                                    kFirstColor,
                                    kFirstColor2,
                                  ],
                                ),
                                hasBorder: true,
                                onPressed: () {
                                  //   controller.loadingIndecatorTrue();

                                  //   controller.loadingIndecatorFalse();
                                  Get.to(
                                    () => MyDialog(
                                      dialogTitle: 'Disable Account',
                                      hintText: 'Enter your password',
                                    ),
                                  );
                                },
                                text: 'Disable Account',
                                textColor: kWhiteColor,
                              ).paddingSymmetric(horizontal: 50),
                            ],
                          );
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    ),
                  ),
                ),
                Positioned(
                  top: 175,
                  left: 110,
                  child: AnimatedOpacity(
                    opacity: controller.isVisible ? 1.0 : 0.0,
                    duration: Duration(milliseconds: 1020),
                    child: ClipRRect(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color.fromARGB(137, 68, 68, 68),
                          borderRadius: BorderRadius.circular(100),
                          border:
                              Border.all(width: 1, color: Color(0xFF444444)),
                        ),
                        width: 175,
                        height: 175,
                        child: Icon(
                          CupertinoIcons.person_solid,
                          color: Color.fromARGB(255, 0, 0, 0),
                          size: 100,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 300,
                  right: 85,
                  child: AnimatedOpacity(
                    opacity: controller.isVisible ? 1.0 : 0.0,
                    duration: Duration(milliseconds: 1020),
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.camera_alt_rounded,
                        size: 25,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class CustomRowWidget extends StatelessWidget {
  CustomRowWidget({
    super.key,
    required this.text,
    required this.icon,
  });
  String text;
  dynamic icon;
  @override
  Widget build(BuildContext context) {
    Widget iconWidget;
    if (icon is String) {
      iconWidget = SvgPicture.asset(
        icon,
        width: 24,
        height: 24,
        // colorFilter: ColorFilter.mode(Colors.red, BlendMode.srcIn),
      );
    } else if (icon is IconData) {
      iconWidget = Icon(icon);
    } else {
      iconWidget = Container();
    }
    return Container(
      width: 150,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.black,
            width: 1.0,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: const TextStyle(
              color: kFirstColor2,
              fontSize: 18,
            ),
          ),
          iconWidget,
        ],
      ),
    );
  }
}
//             body: GetBuilder<ProfilePageController>(
//               init: ProfilePageController(),
//               builder: (controller) {
//                 return Container(
//                   decoration: const BoxDecoration(
//                     gradient: LinearGradient(
//                       begin: Alignment.centerRight,
//                       end: Alignment.centerLeft,
//                       colors: [
//                         Color(0xff2B1836),
//                         Color(0xff591C3C),
//                         Color(0xff911C3A),
//                         Color(0xffBB1636)
//                       ],
//                     ),
//                   ),
//                   child: Stack(
//                     children: [
//                       Container(
//                         decoration: const BoxDecoration(
//                           gradient: LinearGradient(
//                             begin: Alignment.centerRight,
//                             end: Alignment.centerLeft,
//                             colors: [
//                               kFirstColor,
//                               kFirstColor2,
//                             ],
//                           ),
//                         ),
//                       ),
//                       Padding(
//                         padding:
//                             const EdgeInsets.only(left: 25, top: 50, right: 25),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 const Text(
//                                   'Welcome',
//                                   style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 32,
//                                     fontWeight: FontWeight.w500,
//                                   ),
//                                 ),
//                                 IconButton(
//                                   onPressed: () {
//                                     Get.back();
//                                   },
//                                   icon: const Icon(
//                                     Icons.password,
//                                     color: Colors.white,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             const Text(
//                               'Profile Page',
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 32,
//                                 fontWeight: FontWeight.w500,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       Align(
//                         alignment: Alignment.bottomCenter,
//                         child: AnimatedContainer(
//                           duration: const Duration(milliseconds: 700),
//                           height: controller.containerHeight,
//                           width: double.infinity,
//                           decoration: const BoxDecoration(
//                             borderRadius: BorderRadius.vertical(
//                               top: Radius.circular(45),
//                             ),
//                             color: Colors.white,
//                           ),
//                           child: GetBuilder<CustomRowController>(
//                             init: CustomRowController(),
//                             builder: (controller) {
//                               return FutureBuilder<UserModel>(
//                                 future: sharedPreferences!.getString("token") !=
//                                         null
//                                     ? GetUserDetailsByTokenService()
//                                         .getUserDetailsByToken()
//                                     : Future.error(
//                                         'You are gest 😒😅 \n you don\'t have an account',
//                                       ),
//                                 builder: (context, snapshot) {
//                                   try {
//                                     if (snapshot.connectionState ==
//                                         ConnectionState.waiting) {
//                                       return const Center(
//                                         child: CircularProgressIndicator(),
//                                       );
//                                     } else if (snapshot.hasError) {
//                                       return Center(
//                                         child: Text(
//                                           snapshot.error.toString(),
//                                           style: const TextStyle(fontSize: 18),
//                                         ),
//                                       );
//                                     } else if (snapshot.hasData) {
//                                       UserModel userModel = snapshot.data!;
//                                       return ListView(
//                                         padding: const EdgeInsets.symmetric(
//                                           horizontal: 25,
//                                           vertical: 25,
//                                         ),
//                                         children: [
//                                           CustomRow(
//                                             text: userModel.firstName,
//                                             hintText: 'Enter Your First Name',
//                                             userModel: userModel,
//                                           ),
//                                           CustomRow(
//                                             text: userModel.lastName,
//                                             hintText: 'Enter Your Last Name',
//                                             userModel: userModel,
//                                           ),
//                                           CustomRow(
//                                             text: userModel.email,
//                                             hintText: 'Enter Email',
//                                             userModel: userModel,
//                                           ),
//                                           CustomRow(
//                                             text: userModel.username,
//                                             hintText: 'Enter User Name',
//                                             userModel: userModel,
//                                           ),
//                                           CustomRow(
//                                             text: userModel.role,
//                                             hintText: 'Enter Your Role',
//                                             userModel: userModel,
//                                           ),
//                                           Padding(
//                                             padding:
//                                                 const EdgeInsets.only(top: 25),
//                                             child: Row(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment
//                                                       .spaceBetween,
//                                               children: [
//                                                 InkWell(
//                                                   onTap: () {
//                                                     Get.toNamed(
//                                                         ForgetPasswordPageController
//                                                             .id);
//                                                   },
//                                                   child: const Text(
//                                                     'Change Your Password',
//                                                     style: TextStyle(
//                                                       fontWeight:
//                                                           FontWeight.w500,
//                                                       color: kFirstColor2,
//                                                     ),
//                                                   ),
//                                                 ),
//                                                 // const CustomButton(
//                                                 //   text: 'Edit',
//                                                 //   gradient: LinearGradient(
//                                                 //     colors: [
//                                                 //       Color(0xff2B1836),
//                                                 //       Color(0xff591C3C),
//                                                 //       Color(0xff911C3A),
//                                                 //       Color(0xffBB1636)
//                                                 //     ],
//                                                 //     begin: Alignment.centerRight,
//                                                 //     end: Alignment.centerLeft,
//                                                 //   ),
//                                                 // ),
//                                                 IconButton(
//                                                   onPressed:
//                                                       controller.toggleEditing,
//                                                   icon: controller.isEditing
//                                                       ? const Icon(
//                                                           Icons.done,
//                                                           color:
//                                                               kFirstColor
//                                                         )
//                                                       : const Icon(
//                                                           Icons
//                                                               .auto_fix_high_outlined,
//                                                           color:
//                                                               kFirstColor,
//                                                         ),
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                           Padding(
//                                             padding: const EdgeInsets.only(
//                                               right: 150,
//                                             ),
//                                             child: CustomButton(
//                                               routeName:
//                                                   WelcomePageController.id,
//                                               text: 'Delete Account',
//                                               hasBorder: true,
//                                               textColor: kFirstColor2,
//                                               dialogTitle: 'Account Deleted',
//                                               dialogContent: 'Successfully',
//                                               dialogButtonText: 'OK',
//                                               gradient: const LinearGradient(
//                                                 colors: [
//                                                   Colors.white,
//                                                   Colors.white,
//                                                 ],
//                                                 begin: Alignment.centerRight,
//                                                 end: Alignment.centerLeft,
//                                               ),
//                                             ),
//                                           ),
//                                           const Padding(
//                                             padding: EdgeInsets.symmetric(
//                                               horizontal: 15,
//                                               vertical: 25,
//                                             ),
//                                             child: CustomButton(
//                                               text: 'Save Changes',
//                                               hasBorder: true,
//                                               borderColor: Colors.white,
//                                               textColor: Colors.white,
//                                               gradient: LinearGradient(
//                                                 colors: [
//                                                   kFirstColor,
//                                                   kFirstColor2,
//                                                 ],
//                                                 begin: Alignment.centerRight,
//                                                 end: Alignment.centerLeft,
//                                               ),
//                                             ),
//                                           ),
//                                         ],
//                                       );
//                                     } else {
//                                       return const Center(
//                                         child: Text('No data available'),
//                                       );
//                                     }
//                                   } catch (e) {
//                                     // Handle any other errors
//                                     print('Error: $e');
//                                     return const Center(
//                                       child: Text(
//                                         'An error occurred. Please try again later.',
//                                       ),
//                                     );
//                                   }
//                                 },
//                               );
//                             },
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
