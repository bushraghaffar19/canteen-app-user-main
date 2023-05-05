import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';


import '../model/product_model.dart';

class ProductController extends GetxController{
  static ProductController instance = Get.find();
  RxList<ProductModel> products = RxList<ProductModel>([]);
  RxList<ProductModel> favProducts = RxList<ProductModel>([]);
  RxList<ProductModel> favCanteenProducts = RxList<ProductModel>([]);
  RxList<ProductModel> categoryWiseProductProduct = RxList<ProductModel>([]);
  CollectionReference productReference = FirebaseFirestore.instance.collection('product');

  bindingStream() {
    if (FirebaseAuth.instance.currentUser != null) {
      products.bindStream(getAllProduct());
      favProducts.bindStream(getFavouriteProduct());
    }
  }

  Stream<List<ProductModel>> getAllProduct() =>
      productReference.orderBy('Publish Date', descending: true).snapshots().map((query) =>
          query.docs.map((item) => ProductModel.fromMap(item.data() as Map<String, dynamic>)).toList());

  Stream<List<ProductModel>> getFavouriteProduct() =>
      productReference.orderBy('Publish Date', descending: true).where("is_favourite" ,isEqualTo: true).snapshots().map((query) =>
          query.docs.map((item) => ProductModel.fromMap(item.data() as Map<String, dynamic>)).toList());

  RxList<ProductModel> getCanteenProduct(String userId){
    RxList<ProductModel> canteenProduct = RxList<ProductModel>([]);
    if(products.isNotEmpty){
      canteenProduct.addAll(products.where((value) => value.userId == userId));
    }
    return canteenProduct;
  }


 getCategoryWiseProduct(String categoryId , List<ProductModel> product){
    categoryWiseProductProduct.clear();
    if(product.isNotEmpty){
      categoryWiseProductProduct.addAll(product.where((value) => value.categoryId == categoryId));
    }
  }

  getFavouriteCanteenProduct(String canteenId){
    print(canteenId);
    favCanteenProducts.clear();
    if(favProducts.isNotEmpty){
      favCanteenProducts.addAll(favProducts.where((value) => value.userId == canteenId));
    }
  }

  removeFavourite(String orderId){
    if(favProducts.isNotEmpty){
      favCanteenProducts.removeWhere((element) => element.id == orderId);
    }
  }

  Future<void> updateProductFav(String productId,bool isFav) async{
    await productReference.doc(productId).update({
      "is_favourite": isFav
    });
  }

}