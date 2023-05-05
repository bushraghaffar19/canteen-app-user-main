import 'package:flutter/material.dart';
import 'package:canteen_ordering_user/model/order_model.dart';
import 'package:canteen_ordering_user/model/user_model.dart';

import 'package:canteen_ordering_user/view/dashboard/profile/orders/widgets/order_container.dart'; //import the OrderContainer widget
import 'package:canteen_ordering_user/controller/order_controller.dart';
import 'package:get/get.dart';

import 'package:canteen_ordering_user/Constant/app_fonts.dart';
import 'package:canteen_ordering_user/Constant/constant.dart';
import 'package:canteen_ordering_user/view/dashboard/profile/orders/screens/order_detail_screen.dart';



class OrderBottomSheet extends StatefulWidget {
  const OrderBottomSheet({Key? key, required this.orders}) : super(key: key);

  final OrderModel orders;

  @override
  State<OrderBottomSheet> createState() => _OrderBottomSheetState();
}

class _OrderBottomSheetState extends State<OrderBottomSheet> {

  late UserModel user;
  @override
  void initState() {
    super.initState();
    user = userController.getCustomer(widget.orders.userId ??'');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 10),
            height: 4,
            width: 80,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Colors.grey,
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Center(
                    child: Text(
                      'Foodie',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: Text(
                      'Online Food Ordering System',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                        text:  TextSpan(
                          text: 'Order# ',
                          style: AppFonts.kFont14pt,
                          children: <InlineSpan>[
                            TextSpan(
                                text: widget.orders.orderCode.toString() ??'', style: AppFonts.kFont16ptBoldPrimary),
                          ],
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            Get.to(OrderDetailScreen(orderModel: widget.orders),
                                duration: const Duration(seconds: 2), //duration of transitions, default 1 sec
                                transition: Transition.cupertinoDialog
                            );
                          },
                          icon: const Icon(
                            Icons.arrow_forward_ios,
                            size: 20,
                          ))
                    ],
                  ),
                  const Divider(),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:  [
                          const Text(
                            'Ordered By',
                            style: AppFonts.kFont14pt,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            user.name ??'',
                            style: AppFonts.kFont16ptBoldPrimary,
                          ),
                          const Divider(),
                          const SizedBox(
                            height: 16,
                          ),
                        ],
                      ),
                      Visibility(
                        visible: widget.orders.roomNo == '' ? false:true,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Deliver to',
                              style: AppFonts.kFont14pt,
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              'Room 150',
                              style: AppFonts.kFont16ptBoldPrimary,
                            ),
                            Divider(),
                            SizedBox(
                              height: 16,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Text(
                    'Total Amount',
                    style: AppFonts.kFont14pt,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    'Rs. ${widget.orders.totalAmount}',
                    style: AppFonts.kFont16ptBoldPrimary,
                  ),
                  const Divider(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}