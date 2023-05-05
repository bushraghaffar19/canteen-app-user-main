import 'package:canteen_ordering_user/Constant/constant.dart';
import 'package:canteen_ordering_user/model/cart_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../model/product_model.dart';
import '../model/user_model.dart';

class CartController extends GetxController {
  static CartController instance = Get.find();
  CollectionReference userCartReference =
  FirebaseFirestore.instance.collection('user cart');
  RxDouble totalCartPrice = 0.0.obs;
  @override
  void onReady() {
    super.onReady();
    ever(userController.userData, updateCartItem);
  }

  void addProductToCart(ProductModel product) {
    if (_isItemAlreadyAdded(product)) {
      Get.snackbar("Check your cart",
          "${product.name} is already added",
          colorText: Colors.black
      );
    }
    else if (_isItemFromDifferentCanteen(product) == true) {
      Get.snackbar("Check your item",
          "You can add item to cart from only one canteen at a time",
          colorText: Colors.black
      );
    }
    else {
      try {
        userController.updateUserData({
          "cart": FieldValue.arrayUnion([
            {
              CartItemModel.costConst: product.price,
              CartItemModel.constCanteenId: product.userId ??'',
              CartItemModel.quantityConst: 1,
              "product" : product.toJson(),
            }
          ])
        },
        );
        Get.snackbar(
            "Item added",
            "${product.name} is added to your cart",
            colorText: Colors.black
        );

      } catch (e) {
        Get.snackbar("Error", "Cannot add this item");
        debugPrint(e.toString());
      }
    }

  }

  void removeCartItem(CartItemModel cartItem) {
    try {
      userController.updateUserData({
        "cart": FieldValue.arrayRemove([cartItem.toJson()])
      },
      );
    } catch (e) {
      Get.snackbar("Error", "Cannot remove this item");
      debugPrint(e.toString());
    }
  }

  updateCartItem(UserModel userModel) {
    totalCartPrice.value = 0.0;
    if (userModel.cart != null) {
      userModel.cart?.forEach((cartItem) {
        totalCartPrice.value += cartItem.cost ??0;
      });
    }
  }

  bool _isItemAlreadyAdded(ProductModel product) =>
      userController.userData.value.cart!.where((item) => item.product?.id == product.id)
          .isNotEmpty;

  bool? _isItemFromDifferentCanteen(ProductModel product) {
    if(userController.userData.value.cart!.isNotEmpty){
      if(userController.userData.value.cart?.first.product?.userId == product.userId){
        return false;
      }
      else {
        return true;
      }
    }
    return null;
  }

  void decreaseQuantity(CartItemModel item){
    if(item.quantity == 1){
      removeCartItem(item);
    }else{
      removeCartItem(item);
      item.quantity = item.quantity! - 1;
      userController.updateUserData({
        "cart": FieldValue.arrayUnion([item.toJson()])
      });
    }
  }

  void increaseQuantity(CartItemModel item){
    removeCartItem(item);
    item.quantity = item.quantity! + 1;
    userController.updateUserData({
      "cart": FieldValue.arrayUnion([item.toJson()])
    });
  }
}