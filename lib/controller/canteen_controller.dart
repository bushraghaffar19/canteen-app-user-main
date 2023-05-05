

import 'package:canteen_ordering_user/model/canteen_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class CanteenController extends GetxController{
  static CanteenController instance = Get.find();
  RxList<CanteenModel> canteens = RxList<CanteenModel>([]);
  CollectionReference canteenReference = FirebaseFirestore.instance.collection('canteen_user');

  bindingStream() {
    if (FirebaseAuth.instance.currentUser != null) {
      canteens.bindStream(getAllCanteen());
    }
  }

  Stream<List<CanteenModel>> getAllCanteen() =>
      canteenReference.snapshots().map((query) =>
          query.docs.map((item) => CanteenModel.fromMap(item.data() as Map<String, dynamic>)).toList());

}