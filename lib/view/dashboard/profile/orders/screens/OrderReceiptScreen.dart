import 'package:canteen_ordering_user/view/dashboard/profile/orders/widgets/order_container.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';

import 'package:canteen_ordering_user/view/dashboard/checkout/place_order_successfully.dart';
import '../../../../../Constant/app_fonts.dart';
import '../../../../../Constant/constant.dart';

class OrderReceiptScreen extends StatelessWidget {

  const OrderReceiptScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Orders Receipt',
          style: AppFonts.kFont16ptBold,
        ),
      ),
      body: Obx(() =>
      orderController.allUserOrders.isNotEmpty ?
      AnimationLimiter(
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          itemCount: 1,
          itemBuilder: (context, index) => AnimationConfiguration.staggeredList(
            position: index,
            duration: const Duration(seconds: 2),
            child: SlideAnimation(
              horizontalOffset: 50.0,
              child: FadeInAnimation(
                child: OrderContainer(
                  orders: orderController.allUserOrders[0],
                ),
              ),
            ),
          ),
        ),
      ):const Center(
        child: Text("Order data is empty"),
      ),
      ),
    );
  }
}
