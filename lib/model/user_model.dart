import 'cart_model.dart';

class UserModel{
  static const userName = "full_name";
  static const userEmail = "email";
  static const userMobile = "mobile";
  static const userId = "uid";
  static const userPassword = "password";
  static const userType = "user_type";
  static const userGender = "gender";
  static const teaId = "teacher_id";
  static const userProfile = "profile";
  static const fcmToken = "Token";
  static const userCart = "cart";
  static const userDept = "department";
  String? name;
  String? email;
  String? password;
  String? profile;
  String? department;
  String? uid;
  String? type;
  String? gender;
  String? mobile;
  String? teacherId;
  String? token;
  List<CartItemModel>? cart;
  UserModel({
    this.name,
    this.email,
    this.profile,
    this.password,
    this.department,
    this.uid,
    this.gender,
    this.teacherId,
    this.mobile,
    this.type,
    this.cart,
    this.token
  }
      );
  UserModel.fromMap(Map<String, dynamic> data){
    name = data[userName];
    email = data[userEmail];
    password = data[userPassword];
    profile = data[userProfile];
    uid = data[userId];
    token = data[fcmToken];
    type = data[userType];
    teacherId = data[teacherId];
    mobile = data[userMobile];
    gender = data[userGender];
    department = data[userDept];
    cart = _convertCartItems(data[userCart] ?? []);
  }
  toJson() {
    return {
      userName:name,
      userEmail:email,
      userProfile:profile
    };
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
