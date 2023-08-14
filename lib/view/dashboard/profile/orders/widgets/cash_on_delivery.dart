import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:canteen_ordering_user/model/order_model.dart';
import 'package:canteen_ordering_user/model/user_model.dart';

import 'package:canteen_ordering_user/view/dashboard/profile/orders/widgets/order_container.dart'; //import the OrderContainer widget
import 'package:canteen_ordering_user/controller/order_controller.dart';
import 'package:get/get.dart';

import 'package:canteen_ordering_user/Constant/app_fonts.dart';
import 'package:canteen_ordering_user/Constant/constant.dart';
import 'package:canteen_ordering_user/view/dashboard/profile/orders/screens/order_detail_screen.dart';

/*
class CashOnCounter extends StatefulWidget {
  @override
  _CashOnCounterState createState() => _CashOnCounterState();
}

class _CashOnCounterState extends State<CashOnCounter> {
  final OrderController orderController = Get.find();
  CollectionReference orderReference = FirebaseFirestore.instance.collection('user_order');
  //final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  //List<AuthModel> users = []; // List of approved users
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<OrderModel>(
      future: getUserOrders(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final <List<OrderModel>> getUserOrders(String userId) =>
        orderReference.where(OrderModel.userIdConst , isEqualTo: userId).orderBy('order_on', descending: true).snapshots().map((query) =>
        query.docs.map((item) => OrderModel.fromMap(item.data() as Map<String, dynamic>)).toList());


          return Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 30.0,
                  backgroundImage: NetworkImage(user.image ?? ''),
                ),
                SizedBox(height: 16.0),
                Text(
                  user.name ?? 'No Name',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                Text('Email: ${user.email ?? 'No Email'}'),
                Text('Mobile: ${user.mobile ?? 'No Mobile'}'),
                Text('Registered On: ${user.registerOn ?? 'Unknown'}'),
                SizedBox(height: 16.0),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        _updateStatus(user);
                      },
                      child: Text('Accept'),
                    ),
                    SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {
                        _rejectUser(user);
                      },
                      child: Text('Reject'),
                    ),
                  ],
                ),
              ],
            ),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }


  // To get the list of users
  Future<List<OrderModel>> getUserOrders() async {
    List<dynamic>? orderList = await OrderController.;
    if (userList != null) {
      List<AuthModel> approvedUsers = userList.map((data) {
        DateTime? registerOn;
        if (data['register_on'] != null) {
          Timestamp timestamp = data['register_on'];
          registerOn = timestamp.toDate();
        }

        return AuthModel(
          name: data['full_name'] ?? 'No Name',
          email: data['email'] ?? 'No Email',
          mobile: data['mobile'] ?? 'No Mobile',
          registerOn: registerOn,
          image: data['canteen_image'] ?? '',
          uid: data['uid' ?? ''],
          requestStatus: data['request_status'],
        );
      }).toList();
      return approvedUsers;
    } else {
      throw Exception('Failed to fetch approved users');
    }
  }

  // To remove the user from the database as well as from list shown on screen
  void _rejectUser(AuthModel user) async {
    try {
      // Remove the user from the Firestore collection
      await FirebaseFirestore.instance.collection('canteen_user').doc(user.uid).delete();

      // Remove the user from the list and animate its removal
      setState(() {
        users.remove(user);
      });

      // Show a success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('User rejected')),
      );
    } catch (e) {
      // Show an error message if the deletion fails
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to reject user')),
      );
    }
  }
  // To update the user and navigate to the confirmation page
  void _updateStatus(AuthModel user) async {
    try {
      // Remove the user from the Firestore collection
      await FirebaseFirestore.instance.collection('canteen_user').doc(user.uid).update({AuthModel.requestSTATUS: 'accepted'});

      // Remove the user from the list and animate its removal
      setState(() {
        users.remove(user);
      });

      // Show a success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('User accepted')),
      );
    } catch (e) {
      // Show an error message if the deletion fails
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to accept user')),
      );
    }
  }
}*/