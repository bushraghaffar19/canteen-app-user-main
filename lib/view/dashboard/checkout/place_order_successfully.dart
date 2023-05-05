import 'package:canteen_ordering_user/model/order_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../../../Constant/constant.dart';
import '../../../widgets/custom_button.dart';
import '../widgets/bottom_navigation_widgets.dart';

import 'package:canteen_ordering_user/Constant/constant.dart';
import 'package:canteen_ordering_user/model/order_model.dart';
import 'package:canteen_ordering_user/model/user_model.dart';
import 'package:canteen_ordering_user/view/dashboard/profile/orders/screens/orders_screen.dart';
import 'package:get/get.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class OrderPlaceSuccessfully extends StatefulWidget {
  const OrderPlaceSuccessfully({Key? key}) : super(key: key);

  @override
  State<OrderPlaceSuccessfully> createState() => _OrderPlaceSuccessfullyState();
}

class _OrderPlaceSuccessfullyState extends State<OrderPlaceSuccessfully> with TickerProviderStateMixin{
  late final AnimationController animationControllerForSignUpCompleting;

  @override
  void initState() {
    super.initState();
    animationControllerForSignUpCompleting = AnimationController(vsync: this);
  }
  @override
  void dispose() {
    animationControllerForSignUpCompleting.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Order Placed",style: GoogleFonts.inter(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Colors.black
      ),),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 70,),
            SizedBox(
              width: 220,
              height: 220,
              child: Lottie.asset(
                'assets/images/done.json',
                options: LottieOptions(enableMergePaths: true),
                fit: BoxFit.fill,
                controller: animationControllerForSignUpCompleting,
                onWarning: (warning) {
                  debugPrint("🔴 Lottie warning $warning");
                },
                onLoaded: (composition) {
                  Future.delayed(const Duration(microseconds: 900),
                          () {
                        animationControllerForSignUpCompleting
                          ..duration = composition.duration
                          ..forward();
                      });
                },
                //repeat: true,
              ),
            ),
            Text("Order Placed Successfully",style: GoogleFonts.inter(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.black
            ),),
            const SizedBox(height: 70,),
            CustomButton(
              title: 'Order Receipt',
              function: (){
                Get.to(() => const OrdersScreen(),
                    duration: const Duration(seconds: 2), //duration of transitions, default 1 sec
                    transition: Transition.cupertinoDialog
                );
              },
              buttonColor: kButtonColor,
              textColor: kButtonTextColor,
            ),
            const Divider(),
            const SizedBox(height: 15,),
            CustomButton(
              title: 'Continue Shopping',
              function: (){
                Get.offAll(() => const BottomNavScreen(),
                    duration: const Duration(seconds: 2), //duration of transitions, default 1 sec
                    transition: Transition.cupertinoDialog
                );
              },
              buttonColor: kButtonColor,
              textColor: kButtonTextColor,
            ),
            // CustomButton(title: "Home", clickFuction: (){
            //   Navigator.pushAndRemoveUntil(
            //     context,
            //     MaterialPageRoute(
            //       maintainState: true,
            //       builder: (BuildContext context) => const HomeScreen(),
            //     ),
            //         (Route<dynamic> route) => false,
            //   );
            // })
          ],
        ),
      ),
    );
  }

}
