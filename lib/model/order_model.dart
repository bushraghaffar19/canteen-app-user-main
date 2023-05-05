import 'cart_model.dart';

class OrderModel {
  static const orderIdConst = "order_id";
  static const userIdConst = "user_id";
  static const amountConst = "total_amount";
  static const paymentSTATUS = "payment_status";
  static const canteenIdConst = "canteen_id";
  static const orderSTATUS = "order_status";
  static const paymentMETHOD = "payment_method";
  static const orderON = "order_on";
  static const orderCODE = "order_code";
  static const roomNO = "room_no";
  static const userCart = "cart";

  String? orderId;
  String? totalAmount;
  String? orderStatus;
  String? paymentStatus;
  String? canteenId;
  String? paymentMethod;
  String? userId;
  DateTime? orderOn;
  String? roomNo;
  int? orderCode;
  List<CartItemModel>? cart;

  OrderModel({this.orderId,
    this.totalAmount,
    this.orderStatus,
    this.paymentStatus,
    this.canteenId,
    this.userId,
    this.orderCode,
    this.roomNo,
    this.paymentMethod,
    this.orderOn,
    this.cart,
  });

  OrderModel.fromMap(Map data){
    orderId = data[orderIdConst];
    userId = data[userIdConst];
    orderOn = data[orderON].toDate();
    orderStatus = data[orderSTATUS];
    paymentStatus = data[paymentSTATUS];
    paymentMethod = data[paymentMETHOD];
    totalAmount = data[amountConst];
    orderCode = data[orderCODE];
    roomNo = data[roomNO];
    canteenId = data[canteenIdConst];
    cart = _convertCartItems(data[userCart] ?? []);
  }

  List<CartItemModel> _convertCartItems(List cartFromDB){
    List<CartItemModel> cart = [];

    if(cartFromDB.isNotEmpty){
      for (var element in cartFromDB) {
        cart.add(CartItemModel.fromMap(element));
      }
    }
    return cart;
  }
  List cartItemsToJson() => cart?.map((item) => item.toJson()).toList() ??[];
}