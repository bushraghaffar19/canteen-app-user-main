import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel{
  static const prodName = "product_name";
  static const prodId = "product_id";
  static const prodImage = "product_Image";
  static const prodPrice = "product_price";
  static const cateId = "category_id";
  static const uId = "user_id";
  static const prodDescription = "product_description";
  static const prodIsStock = "is_stock";
  static const prodIsFav = "is_favourite";


  String? name,image,id,description,categoryId;
  double? price;
  String? userId;
  bool? isFav;
  bool? isProductAvailable;
  DocumentSnapshot? maindata;
  ProductModel({
    this.name,
    this.image,
    this.id,
    this.description,
    this.categoryId,
    this.price,
    this.userId,
    this.isProductAvailable
  });

  ProductModel.fromMap(Map<String, dynamic> data){
    name = data[prodName];
    id = data[prodId];
    image = data[prodImage];
    price = data[prodPrice]?.toDouble();
    categoryId = data[cateId];
    description = data[prodDescription];
    isProductAvailable = data[prodIsStock];
    userId = data[uId];
    isFav = data[prodIsFav];
  }
  toJson() {
    return {
      prodName : name,
      prodId : id,
      prodImage:  image,
      prodPrice:price,
      cateId : categoryId,
      prodDescription:description,
      prodIsStock:isProductAvailable,
      uId:userId,
      prodIsFav:isFav

    };
  }
}