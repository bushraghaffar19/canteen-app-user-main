import 'package:canteen_ordering_user/Constant/app_fonts.dart';
import 'package:canteen_ordering_user/Constant/constant.dart';
import 'package:canteen_ordering_user/view/dashboard/profile/orders/widgets/order_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Orders',
          style: AppFonts.kFont16ptBold,
        ),
      ),
      body: Obx(() =>
      orderController.allUserOrders.isNotEmpty ?
      AnimationLimiter(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: orderController.allUserOrders.length,
              itemBuilder: (context, index) => AnimationConfiguration.staggeredList(
                position: index,
                duration: const Duration(seconds: 2),
                child: SlideAnimation(
                  horizontalOffset: 50.0,
                  child: FadeInAnimation(
                    child: OrderContainer(
                      orders: orderController.allUserOrders[index],
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
