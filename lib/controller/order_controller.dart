

import 'dart:math';

import 'package:canteen_ordering_user/model/canteen_model.dart';
import 'package:canteen_ordering_user/model/order_model.dart';
import 'package:canteen_ordering_user/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Constant/constant.dart';
import '../view/dashboard/checkout/place_order_successfully.dart';

class OrderController extends GetxController{
  static OrderController instance = Get.find();

  RxList<OrderModel> allUserOrders = RxList<OrderModel>([]);
  CollectionReference orderReference = FirebaseFirestore.instance.collection('user_order');
  CollectionReference userReference =
  FirebaseFirestore.instance.collection('canteen_user');

  bindingStream() {
    print(FirebaseAuth.instance.currentUser?.uid ??'');
    if (FirebaseAuth.instance.currentUser != null) {
      allUserOrders.bindStream(getUserOrders(FirebaseAuth.instance.currentUser?.uid ??''));
    }
  }
  String paymentStatus ='';
  String paymentMethod ='';
  String roomNo = '';
  String canteenId = '';

  Stream<List<OrderModel>> getUserOrders(String userId) =>
      orderReference.where(OrderModel.userIdConst , isEqualTo: userId).orderBy('order_on', descending: true).snapshots().map((query) =>
          query.docs.map((item) => OrderModel.fromMap(item.data() as Map<String, dynamic>)).toList());

  Future<void> placeOrder(context) async{
    var rng =  Random();
    var code = rng.nextInt(900000) + 100000;
    String orderId = orderReference.doc().id;
    await orderReference.doc(orderId).set({
      OrderModel.orderIdConst: orderId,
      "canteen_id": userController.userData.value.cart?.first.canteenId,
      OrderModel.userIdConst: userController.userData.value.uid,
      OrderModel.paymentSTATUS: paymentStatus,
      OrderModel.orderSTATUS: 'pending',
      OrderModel.paymentMETHOD: paymentMethod,
      OrderModel.userCart: userController.userData.value.cartItemsToJson(),
      OrderModel.roomNO: roomNo,
      OrderModel.amountConst: cartController.totalCartPrice.value.toStringAsFixed(2),
      OrderModel.orderON: DateTime.now(),
      OrderModel.orderCODE: code,
    }).then((value)  async{
      String token = '';
      await userReference.doc(userController.userData.value.cart?.first.canteenId).get().then((value) {
        token = value['Token'];
      });
      print(token);
      Navigator.pop(context);
      await userController.updateUserData({"cart": []});
      Get.offAll(() => const OrderPlaceSuccessfully(),
          duration: const Duration(seconds: 2), //duration of transitions, default 1 sec
          transition: Transition.cupertinoDialog
      );
      userController.sendNotification(
          "Order placed",
          "New order# $code placed from user. please visit the app to see the detail of order.",
          token);
    }).catchError((e){
      Navigator.pop(context);
      Get.snackbar(
          "Something went wrong",
          e.toString(),
        colorText: Colors.black
      );
    });
  }

  Future<void> updateOrderStatus(Map<String, dynamic> data,String orderId) async{
    await orderReference
        .doc(orderId)
        .update(data);
  }

  Future<void> deleteOrder(String orderId,context) async{
    await orderReference
        .doc(orderId)
        .delete().then((value) {
          Navigator.of(context).pop();
          Get.snackbar(
              "Delete successfully",
              "order delete successfully",
              colorText: Colors.black
          );
    });
  }

}