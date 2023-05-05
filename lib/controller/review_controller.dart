import 'package:canteen_ordering_user/Constant/constant.dart';
import 'package:canteen_ordering_user/model/product_model.dart';
import 'package:canteen_ordering_user/model/rating_model.dart';
import 'package:canteen_ordering_user/view/dashboard/home/rating_and_review/show_product_rating.dart';
import 'package:canteen_ordering_user/widgets/loading_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class ReviewController extends GetxController{
  static ReviewController instance = Get.find();

  CollectionReference reviewReference = FirebaseFirestore.instance.collection('Review');
  List<RatingModel> ratingListData = <RatingModel>[].obs;
  RxDouble ratingAverage = 0.0.obs;

  calculateRatingAverage(){
    double sumRating = 0;
    for(var item in reviewController.ratingListData){
      sumRating += item.rating ?? 0;
    }
    ratingAverage.value = sumRating / reviewController.ratingListData.length;
  }

  Future<void> getProductReview(BuildContext context,ProductModel productModel) async{
    ratingListData.clear();
    loadingDialogue(context: context);
    await reviewReference.where(RatingModel.productID , isEqualTo: productModel.id).orderBy('reviewer_date', descending: true).get().then((value) {
      for (var item in value.docs) {
        ratingListData.add(RatingModel.fromMap(item.data() as Map<String, dynamic>));
      }
      Navigator.of(context).pop();
      calculateRatingAverage();
      Get.to(
          ShowProductRating(itemModel: productModel),
          duration: const Duration(seconds: 2), //duration of transitions, default 1 sec
          transition: Transition.cupertinoDialog
      );
    }).catchError((e){
      Navigator.of(context).pop();
      Get.snackbar(
          "Something went wrong",
          e.toString(),
          colorText: Colors.black
      );
    });
  }

  Future<void> addProductReview(double rating, String description,BuildContext context,ProductModel productModel) async{
    loadingDialogue(context: context);
    String reviewId = reviewReference.doc().id;
    await reviewReference.doc(reviewId).set({
      RatingModel.reviewID: reviewId,
      RatingModel.userIdConst: userController.userData.value.uid,
      RatingModel.userName: userController.userData.value.name,
      RatingModel.userImage: userController.userData.value.profile ?? "https://www.pngall.com/wp-content/uploads/5/User-Profile-PNG-High-Quality-Image.png",
      RatingModel.ratingDATE:DateTime.now(),
      RatingModel.ratingPercent: rating,
      RatingModel.ratingDesc: description,
      RatingModel.productID: productModel.id
    }).then((value)  async{
      Get.snackbar(
          "Successfully",
          "Rating add successfully",
          colorText: Colors.black
      );
      getProductReview(context, productModel);
      Navigator.pop(context);
      Navigator.pop(context);
    }).catchError((e){
      Navigator.pop(context);
      Get.snackbar(
          "Something went wrong",
          e.toString(),
          colorText: Colors.black
      );
    });
  }
}