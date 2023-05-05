import 'dart:math';

import 'package:canteen_ordering_user/Constant/constant.dart';
import 'package:canteen_ordering_user/view/auth/login_screen.dart';
import 'package:canteen_ordering_user/view/auth/term_condition_screen.dart';
import 'package:canteen_ordering_user/view/dashboard/profile/edit_user_profile.dart';
import 'package:canteen_ordering_user/view/dashboard/profile/orders/screens/orders_screen.dart';
import 'package:canteen_ordering_user/view/dashboard/profile/widgets/profile_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../widgets/custom_dialogue.dart';

class ProfileMainPage extends StatefulWidget {
  const ProfileMainPage({Key? key}) : super(key: key);

  @override
  State<ProfileMainPage> createState() => _ProfileMainPageState();
}

class _ProfileMainPageState extends State<ProfileMainPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final h = size.height;
    final w = size.width;
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile",style: GoogleFonts.inter(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black
        ),),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: AnimationLimiter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 15,
                ),
                Obx(() => Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child:  Image(
                        image: NetworkImage(userController.userData.value.profile ?? "https://www.pngall.com/wp-content/uploads/5/User-Profile-PNG-High-Quality-Image.png"),
                        width: 60,
                        fit: BoxFit.cover,
                        height: 60,
                      ),
                    ),
                    const SizedBox(width: 15,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(userController.userData.value.name ?? "Your Name",style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black
                        ),),
                        const SizedBox(height: 5,),
                        Text(userController.userData.value.email ??"email@gmail.com",style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.black
                        ),),
                      ],
                    ),
                  ],
                )),
                const SizedBox(height: 30,),
                ProfileTileWidget(
                    onTap: (){
                      Get.to(() => const EditUserProfile(),
                          duration: const Duration(seconds: 2), //duration of transitions, default 1 sec
                          transition: Transition.cupertinoDialog
                      );
                    },
                    icon: Icons.person,
                    title: "Edit Profile"),
                ProfileTileWidget(
                    onTap: (){
                       Get.to(() => const OrdersScreen(),
                           duration: const Duration(seconds: 2), //duration of transitions, default 1 sec
                           transition: Transition.cupertinoDialog
                       );
                    },
                    icon: Icons.shopping_bag,
                    title: "My Orders"),
                Divider(thickness: 1.5,color: theme.dividerColor,),
                const SizedBox(height: 15,),
                Text("Settings", style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black
                ),),
                ProfileTileWidget(
                    onTap: (){
                      Get.to(() => const TermAndConditions(),
                          duration: const Duration(seconds: 2), //duration of transitions, default 1 sec
                          transition: Transition.cupertinoDialog
                      );
                    },
                    icon: Icons.help,
                    title: "Terms & Conditions"),
                // ProfileTileWidget(
                //     onTap: (){},
                //     icon: Icons.supervised_user_circle,
                //     title: "About Us"),
                ProfileTileWidget(
                    onTap: (){
                      confirmationDialogue(title: "Confirmation",
                          bodyText: "Are you sure you want to logout?",
                          function: (){
                            userController.signOut();
                          },
                          context: context
                      );
                    },
                    icon: Icons.logout,
                    title: "Logout"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}