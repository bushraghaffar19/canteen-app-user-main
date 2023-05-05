class CanteenModel{
  static const userName = "full_name";
  static const userEmail = "email";
  static const userMobile = "mobile";
  static const userId = "uid";
  static const canteenImage = "canteen_image";
  static const fcmToken = "Token";
  String? name;
  String? email;
  String? image;
  String? uid;
  String? mobile;
  String? token;
  CanteenModel({
    this.name,
    this.email,
    this.image,
    this.uid,
    this.mobile,
    this.token
  }
      );
  CanteenModel.fromMap(Map<String, dynamic> data){
    name = data[userName];
    email = data[userEmail];
    image = data[canteenImage];
    uid = data[userId];
    token = data[fcmToken];
    mobile = data[userMobile];
  }
  toJson() {
    return {
      userName:name,
      userEmail:email,
      canteenImage:image
    };
  }
}