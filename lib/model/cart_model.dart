import 'package:canteen_ordering_user/model/product_model.dart';

class CartItemModel{
  static const costConst = "cost";
  static const constCanteenId = "canteen_id";
  static const productConst = "product";
  static const quantityConst = "quantity";

  ProductModel? product;
  double? cost;
  int? quantity;
  String? canteenId;
  CartItemModel({
    this.product,
    this.cost,
    this.canteenId,
    this.quantity
  });

  CartItemModel.fromMap(Map<String, dynamic> data){
    product = ProductModel.fromMap(data[productConst]);
    cost = data[costConst].toDouble();
    quantity = data[quantityConst];
    canteenId = data[constCanteenId];
  }

  Map toJson() => {
    quantityConst: quantity,
    productConst:product?.toJson(),
    constCanteenId:canteenId,
    costConst: (product?.price ??0) * quantity!,
  };


}