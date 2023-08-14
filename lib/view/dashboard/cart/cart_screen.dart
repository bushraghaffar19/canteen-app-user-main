import 'package:canteen_ordering_user/Constant/constant.dart';
import 'package:canteen_ordering_user/model/cart_model.dart';
import 'package:canteen_ordering_user/view/dashboard/cart/widgets/cart_show_widget.dart';
import 'package:canteen_ordering_user/view/dashboard/checkout/checkout_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:canteen_ordering_user/model/order_model.dart';
import 'package:canteen_ordering_user/model/user_model.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final h = size.height;
    final w = size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Cart",
          style: GoogleFonts.inter(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
            child: IconButton(
              icon: const Icon(
                CupertinoIcons.delete,
                size: 25,
              ),
              onPressed: () {
                userController.updateUserData({"cart": []});
              },
            ),
          )
        ],
      ),
      body: Obx(
            () {
          final cart = userController.userData.value.cart;

          if (cart != null && cart.length != 0) {
            return Column(
              children: [
                Expanded(
                  child: AnimationLimiter(
                    child: ListView.builder(
                      itemCount: cart.length,
                      shrinkWrap: true,
                      itemBuilder: (context, i) {
                        return AnimationConfiguration.staggeredList(
                          position: i,
                          duration: const Duration(seconds: 1),
                          child: SlideAnimation(
                            horizontalOffset: 50.0,
                            child: FadeInAnimation(
                              child: ShowCartWidget(
                                cartItemModel: cart[i],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Container(
                  width: w,
                  height: 150,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        offset: Offset(
                          5.0,
                          5.0,
                        ),
                        blurRadius: 30.0,
                        spreadRadius: 5.0,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Total Price :",
                            style: GoogleFonts.inter(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: kLightGreyColor,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            "RS.${cartController.totalCartPrice.value}",
                            style: GoogleFonts.inter(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: kButtonColor,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20,),
                      GestureDetector(
                        onTap: () {
                          Get.to(
                                () => const CheckoutScreen(),
                            duration: const Duration(seconds: 2),
                            transition: Transition.cupertinoDialog,
                          );
                        },
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                          height: 60,
                          decoration: BoxDecoration(
                            color: kButtonColor,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Row(
                            children: [
                              Text(
                                "Proceed to checkout",
                                style: GoogleFonts.inter(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                              const Spacer(),
                              Card(
                                elevation: 10,
                                color: kLightTextColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Icon(
                                    CupertinoIcons.arrow_right,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else {
            return const Center(
              child: Text("Cart Data is empty"),
            );
          }
        },
      ),
    );
  }
}
