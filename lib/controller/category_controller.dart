import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../model/category_model.dart';

class CategoryController extends GetxController{
  static CategoryController instance = Get.find();
  RxList<CategoryModel> category = RxList<CategoryModel>([]);
  CollectionReference categoryReference = FirebaseFirestore.instance.collection('category');

  bindingStream() {
    if (FirebaseAuth.instance.currentUser != null) {
      category.bindStream(getAllCategory());
    }
  }

  Stream<List<CategoryModel>> getAllCategory() =>
      categoryReference.orderBy('Publish Date', descending: true).snapshots().map((query) =>
          query.docs.map((item) => CategoryModel.fromMap(item.data() as Map<String, dynamic>)).toList());

  RxList<CategoryModel> getCanteenCategory(String userId){
    RxList<CategoryModel> canteenCategory = RxList<CategoryModel>([]);
    if(category.isNotEmpty){
      canteenCategory.addAll(category.where((value) => value.userId == userId));
    }

    return canteenCategory;
  }

}