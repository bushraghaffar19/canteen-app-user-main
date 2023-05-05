import 'package:canteen_ordering_user/Constant/app_fonts.dart';
import 'package:canteen_ordering_user/Constant/constant.dart';
import 'package:canteen_ordering_user/model/order_model.dart';
import 'package:canteen_ordering_user/model/user_model.dart';
import 'package:canteen_ordering_user/view/dashboard/profile/orders/screens/order_detail_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderContainer extends StatefulWidget {
  const OrderContainer({super.key, required this.orders});

  final OrderModel orders;

  @override
  State<OrderContainer> createState() => _OrderContainerState();
}

class _OrderContainerState extends State<OrderContainer> {
  late UserModel user;
  @override
  void initState() {
    super.initState();
    user = userController.getCustomer(widget.orders.userId ??'');
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(26),
        color: Colors.grey.shade50,
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            spreadRadius: 3,
            blurRadius: 20,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                text:  TextSpan(
                  text: 'Order ID : ',
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
                    height: 10,
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
            'Order On',
            style: AppFonts.kFont14pt,
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            DateFormat('dd MMMM, yyyy - h:mm a').format(widget.orders.orderOn ?? DateTime.now()),
            style: AppFonts.kFont16ptBoldPrimary,
          ),
          const SizedBox(
            height: 16,
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
    );
  }
}
