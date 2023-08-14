import 'package:canteen_ordering_user/controller/order_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:canteen_ordering_user/model/order_model.dart';
import 'package:canteen_ordering_user/model/user_model.dart';
import 'package:intl/intl.dart';


class OrderReceiptBottomSheet extends StatelessWidget {
  final String orderId;
  final String userName;
  final DateTime orderOn;
  final String totalAmount;

  const OrderReceiptBottomSheet({
    required this.orderId,
    required this.userName,
    required this.orderOn,
    required this.totalAmount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Order Receipt',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          Text('Order ID: $orderId'),
          Text('User Name: $userName'),
          Text('Order On: ${DateFormat('dd MMMM, yyyy - h:mm a').format(orderOn)}'),
          Text('Total Amount: Rs. $totalAmount'),
        ],
      ),
    );
  }
}